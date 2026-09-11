using System;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0InterationCrocodileLoad : T0InterationBaseData
{
	public string crocodileGameRes = "Widget/System/Main_T0SceneGame/104402/104402_CrocodileModule";

	public bool isLoad = true;

	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Other;
	}

	private void LoadCrocodileGame()
	{
		GameObject gameObject = Asset.Instantiate(crocodileGameRes);
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
			if (T0CrocodileGame.crocodileGame == null)
			{
				LoadCrocodileGame();
			}
			T0CrocodileGame.crocodileGame.Init();
		}
		else if (T0CrocodileGame.crocodileGame != null)
		{
			T0CrocodileGame.crocodileGame.Dispose();
		}
		base.IsFinish = true;
	}
}
