using System;
using UnityEngine;
using UnityEngine.UI;

public class UIHelper
{
	public static GameObject SetUIActive(string path, bool value)
	{
		GameObject gameObject = GameObject.Find(path);
		if (gameObject == null)
		{
			return null;
		}
		gameObject.SetActive(value);
		return gameObject;
	}

	public static void PlayMovieBlackBorderPanelAnim(bool isReverse = false, bool toHide = false)
	{
		GameObject panel = GameObject.Find("UICamera/Canvas/UIMain/MovieBlackBorder");
		if (!(panel != null))
		{
			return;
		}
		if (!panel.activeSelf)
		{
			panel.SetActive(value: true);
		}
		UILeanTweenMove[] componentsInChildren = panel.GetComponentsInChildren<UILeanTweenMove>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			if (!isReverse)
			{
				componentsInChildren[i].Play(setToStart: true, null, delegate
				{
					SetUIActive("UICamera/Canvas/UIMain/MovieBlackBorder/JumpBtn", value: true);
				});
			}
			else if (!toHide)
			{
				componentsInChildren[i].ReversePlay(setToStart: true, delegate
				{
					SetUIActive("UICamera/Canvas/UIMain/MovieBlackBorder/JumpBtn", value: false);
				});
			}
			else
			{
				componentsInChildren[i].ReversePlay(setToStart: true, delegate
				{
					panel.SetActive(value: false);
				});
			}
		}
	}

	public static void StopMovieBlackBorderPanelAnim()
	{
		GameObject gameObject = GameObject.Find("UICamera/Canvas/UIMain/MovieBlackBorder");
		if (gameObject != null)
		{
			if (!gameObject.activeSelf)
			{
				gameObject.SetActive(value: true);
			}
			UILeanTweenMove[] componentsInChildren = gameObject.GetComponentsInChildren<UILeanTweenMove>();
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				componentsInChildren[i].Stop();
				componentsInChildren[i].SetToStartPos();
			}
		}
	}

	public static void SetOnClickJumpMovie(Action callFunc)
	{
		GameObject gameObject = GameObject.Find("UICamera/Canvas/UIMain/MovieBlackBorder");
		if (!(gameObject != null))
		{
			return;
		}
		Transform transform = gameObject.transform.Find("JumpBtn");
		transform.gameObject.SetActive(value: true);
		if (!(transform != null))
		{
			return;
		}
		Button jumpBtnCom = transform.GetComponent<Button>();
		if (!(jumpBtnCom != null))
		{
			return;
		}
		if (callFunc == null)
		{
			jumpBtnCom.onClick.RemoveAllListeners();
			return;
		}
		jumpBtnCom.onClick.AddListener(delegate
		{
			if (callFunc != null)
			{
				callFunc();
			}
			jumpBtnCom.onClick.RemoveAllListeners();
		});
	}

	public static void ShowRoleTalkContent(int roleID, string content, long milliTime)
	{
		GameObject gameObject = GameObject.Find("UICamera/Canvas/UIMain/BattlePanel/ScreenAdjustContainer/TeamPanel");
		if (!(gameObject == null))
		{
			BattleTalkPanel component = gameObject.GetComponent<BattleTalkPanel>();
			if (component != null)
			{
				component.ShowRoleTalk(roleID, content, milliTime);
			}
		}
	}
}
