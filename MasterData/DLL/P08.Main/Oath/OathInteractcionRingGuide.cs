using System;
using UnityEngine;

namespace Oath;

[Serializable]
public class OathInteractcionRingGuide : OathInteractionNode
{
	private GameObject ringGuideEffectObj;

	public Vector3 offset;

	private string GetGuideEffectPath()
	{
		return OathConst.GetRingGuideEffectPath(OathSceneLoader.Scene.context.characterID);
	}

	public override void StartEvent()
	{
		if (ringGuideEffectObj == null)
		{
			ringGuideEffectObj = Asset.Instantiate(GetGuideEffectPath());
		}
		LuaHelper.CallFunction("OathToLuaBridge.OathEmitterEvent", "OATH_SCENE_LOAD_EFFECT", ringGuideEffectObj);
		ringGuideEffectObj.transform.localPosition = offset;
	}

	public override void DisposeEvent()
	{
		if (ringGuideEffectObj != null)
		{
			UnityEngine.Object.Destroy(ringGuideEffectObj);
			ringGuideEffectObj = null;
		}
	}
}
