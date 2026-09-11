using System;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0InterationCookEnter : T0InterationBaseData
{
	public string cookGameSceneRes = "Widget/System/Main_T0SceneGame/104402/104402_CookingPopUI";

	public bool isLoad = true;

	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Other;
	}

	private void LoadCookGame()
	{
		GameObject gameObject = Asset.Instantiate(cookGameSceneRes);
		T0WorldUI t0WorldUI = T0WorldScene.Scene.mWorldUI as T0WorldUI;
		RectTransform component = gameObject.GetComponent<RectTransform>();
		component.SetParent(t0WorldUI.GetForeverShowContentNode());
		component.localPosition = Vector3.zero;
		component.localScale = Vector3.one;
		component.offsetMin = Vector2.zero;
		component.offsetMax = Vector2.zero;
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		if (isLoad)
		{
			if (T0CookSelectView.cookGame == null)
			{
				LoadCookGame();
			}
			T0WorldScene.Scene.ChangeSwitchCursor(value: true);
		}
		else
		{
			if (T0CookSelectView.cookGame != null)
			{
				T0CookSelectView.cookGame.Dispose();
			}
			if ((T0WorldScene.Scene.mWorldUI as T0WorldUI).IsHideUI)
			{
				T0WorldScene.Scene.ChangeSwitchCursor(value: false);
			}
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
