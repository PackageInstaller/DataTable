using System;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0InterationBedEnter : T0InterationBaseData
{
	public string bedGameSceneRes = "Widget/System/Main_T0SceneGame/104402/104402_BedModule";

	public bool isEnter = true;

	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Other;
	}

	private void LoadBedGame()
	{
		GameObject gameObject = Asset.Instantiate(bedGameSceneRes);
		T0WorldUI t0WorldUI = T0WorldScene.Scene.mWorldUI as T0WorldUI;
		RectTransform component = gameObject.GetComponent<RectTransform>();
		component.SetParent(t0WorldUI.GetForeverShowContentNode());
		component.localPosition = Vector3.zero;
		component.localScale = Vector3.one;
		component.offsetMin = Vector2.zero;
		component.offsetMax = Vector2.zero;
		LuaHelper.CallFunction("T0WorldEmitterEvent", "T0_WORLD_SET_HELP_KEY", "t0_world_horus_desc2");
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		if (isEnter)
		{
			if (T0BedGame.bedGame == null)
			{
				LoadBedGame();
			}
			T0BedGame.bedGame.InitData();
			T0WorldScene.Scene.ChangeSwitchCursor(value: true);
		}
		else
		{
			if (T0BedGame.bedGame != null)
			{
				T0BedGame.bedGame.Dispose();
				LuaHelper.CallFunction("T0WorldEmitterEvent", "T0_WORLD_SET_HELP_KEY", null);
			}
			T0WorldScene.Scene.player.SetDefaultSlowFlowTarget();
			T0WorldUI obj = T0WorldScene.Scene.mWorldUI as T0WorldUI;
			obj.ChangeGrahiceRaycastTarget(isTarget: true);
			if (obj.IsHideUI)
			{
				T0WorldScene.Scene.ChangeSwitchCursor(value: false);
			}
			T0CharacterIkBehavior ikBehavior = T0WorldScene.Scene.agentManager.CharacteraAgent.CharacterBoard.ikBehavior;
			ikBehavior.bipedIk.solvers.leftFoot.target = ikBehavior.IKFootGoalL;
			ikBehavior.bipedIk.solvers.rightFoot.target = ikBehavior.IKFootGoalR;
		}
		base.IsFinish = true;
	}

	public override void FinishEvent(T0WorldInteractionBehavior behaviour)
	{
	}

	public override void UpdateEvent(T0WorldInteractionBehavior behaviour)
	{
	}

	public override void DisposeEvent()
	{
	}
}
