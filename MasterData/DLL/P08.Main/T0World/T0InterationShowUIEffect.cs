using System;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0InterationShowUIEffect : T0InterationBaseData
{
	private GameObject uiEffectObj;

	public string uiEffectPath;

	public Vector3 offset;

	private const string baseUIEffectPath = "Widget/System/Main_T0SceneGame/{0}/{1}";

	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Other;
	}

	private string GetUIEffectPath()
	{
		return $"Widget/System/Main_T0SceneGame/{T0WorldScene.Scene.characterID}/{uiEffectPath}";
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		if (uiEffectObj == null)
		{
			uiEffectObj = Asset.Instantiate(GetUIEffectPath());
		}
		LuaHelper.CallFunction("T0WorldEmitterEvent", "T0_WORLD_SHOW_EFFECT", uiEffectObj);
		uiEffectObj.transform.localPosition = offset;
	}

	public override void DisposeEvent()
	{
		DisposeUIEffectObj();
	}

	private void DisposeUIEffectObj()
	{
		if (uiEffectObj != null)
		{
			UnityEngine.Object.Destroy(uiEffectObj);
			uiEffectObj = null;
		}
	}
}
