using System;
using UnityEngine;
using UnityEngine.Playables;

namespace Oath;

[Serializable]
public class OathInteractionAnimation : OathInteractionNode
{
	public string animName;

	public OathInterationConditionTypeEnum conditionType = OathInterationConditionTypeEnum.None;

	public OathExtrapolationMode showExtrapolationMode;

	[HideInInspector]
	public DirectorWrapMode extrapolationMode = DirectorWrapMode.None;

	public string voiceName;

	public int talkLabelDelay;

	private void GetExtrapolationMode()
	{
		if (showExtrapolationMode == OathExtrapolationMode.none)
		{
			extrapolationMode = DirectorWrapMode.None;
		}
		else if (showExtrapolationMode == OathExtrapolationMode.Loop)
		{
			extrapolationMode = DirectorWrapMode.Loop;
		}
		else if (showExtrapolationMode == OathExtrapolationMode.Hold)
		{
			extrapolationMode = DirectorWrapMode.Hold;
		}
	}

	public override void StartEvent()
	{
		GetExtrapolationMode();
		OathSceneLoader.Scene.context.interationManager.character.timelineBehavior.PlayTimeline(animName, out var playable, extrapolationMode);
		playable.stopped += delegate
		{
			base.IsFinish = true;
		};
		if (!string.IsNullOrEmpty(voiceName))
		{
			Action callback = delegate
			{
				callback = null;
			};
			GameObject model = OathSceneLoader.Scene.context.interationManager.character.GetModel();
			LuaHelper.CallFunction("OathToLuaBridge.OathEmitterEvent", "OATH_SCENE_TALK", model.transform, voiceName, talkLabelDelay, callback);
		}
	}

	public override void UpdateEvent()
	{
		if (conditionType == OathInterationConditionTypeEnum.None)
		{
			base.IsFinish = true;
		}
	}
}
