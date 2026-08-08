using System;
using UnityEngine;
using UnityEngine.Playables;

namespace T0World;

[Serializable]
public class T0InterationWrestlingGame : T0InterationBaseData
{
	public string idleAnimName;

	public string startAnimName;

	public string wrestlingUIPrefabPath = "Widget/System/Main_T0SceneGame/104402/104402_WrestlingModule";

	private GameObject wrestlingUIGo;

	private T0WrestlingGame wrestlingGameComp;

	private T0WorldInteractionBehavior runBehaviour;

	public override bool isNeedSDK => true;

	public override void SendSDK(T0WorldInteractionBehavior behaviour)
	{
		string select_param = "{" + idleAnimName + "," + startAnimName + "}";
		T0SDKData baseSDKData = GetBaseSDKData();
		baseSDKData.select_param = select_param;
		T0SDKSystem.SendSDKData(behaviour, baseSDKData);
	}

	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Other;
	}

	private void LoadWrestlingGame()
	{
		if (wrestlingUIGo == null)
		{
			wrestlingUIGo = Asset.Instantiate(wrestlingUIPrefabPath);
			T0WorldUI t0WorldUI = T0WorldScene.Scene.mWorldUI as T0WorldUI;
			RectTransform component = wrestlingUIGo.GetComponent<RectTransform>();
			component.SetParent(t0WorldUI.GetForeverShowContentNode());
			component.localPosition = Vector3.zero;
			component.localScale = Vector3.one;
			component.offsetMin = Vector2.zero;
			component.offsetMax = Vector2.zero;
			wrestlingGameComp = wrestlingUIGo.GetComponent<T0WrestlingGame>();
			LuaHelper.CallFunction("T0WorldEmitterEvent", "T0_WORLD_SET_HELP_KEY", "t0_world_horus_desc2");
		}
		wrestlingGameComp.InitData();
		wrestlingGameComp.OnPressStateChangeCallback.AddListener(delegate(bool isPressing)
		{
			ChangeWrestlingState(isPressing);
		});
		wrestlingGameComp.OnFinishCallback.AddListener(delegate
		{
			base.IsFinish = true;
		});
	}

	private void ChangeWrestlingState(bool isPressing)
	{
		PlayableDirector playable;
		GameObject timelineGo;
		if (isPressing)
		{
			runBehaviour.PlayTimeline(startAnimName, out playable, out timelineGo, DirectorWrapMode.Loop);
		}
		else
		{
			runBehaviour.PlayTimeline(idleAnimName, out playable, out timelineGo, DirectorWrapMode.Loop);
		}
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		runBehaviour = behaviour;
		behaviour.PlayTimeline(idleAnimName, out var _, out var _, DirectorWrapMode.Loop);
		LoadWrestlingGame();
	}

	public override void FinishEvent(T0WorldInteractionBehavior behaviour)
	{
		DisposeContent();
	}

	public override void UpdateEvent(T0WorldInteractionBehavior behaviour)
	{
	}

	public override void DisposeEvent()
	{
		DisposeContent();
	}

	public void DisposeContent()
	{
		if (wrestlingGameComp != null)
		{
			wrestlingGameComp = null;
		}
		if (wrestlingUIGo != null)
		{
			UnityEngine.Object.Destroy(wrestlingUIGo);
			wrestlingUIGo = null;
		}
		LuaHelper.CallFunction("T0WorldEmitterEvent", "T0_WORLD_SET_HELP_KEY", null);
	}
}
