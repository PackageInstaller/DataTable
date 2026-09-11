using System;
using UnityEngine;

namespace Oath;

[Serializable]
public class OathInteractionTalk : OathInteractionNode
{
	public string voiceName;

	public int talkLabelDelay;

	public override void StartEvent()
	{
		Action callback = delegate
		{
			base.IsFinish = true;
			callback = null;
		};
		GameObject model = OathSceneLoader.Scene.context.interationManager.character.GetModel();
		LuaHelper.CallFunction("OathToLuaBridge.OathEmitterEvent", "OATH_SCENE_TALK", model.transform, voiceName, talkLabelDelay, callback);
	}
}
