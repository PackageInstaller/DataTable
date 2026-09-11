using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace RogueCard;

public class RogueCardJokerPackageUI : MonoBehaviour
{
	public GameObject obj;

	public Transform trs;

	public List<JokerCommonCard> list = new List<JokerCommonCard>();

	public void Init()
	{
	}

	private void ResetRuntimeCards()
	{
		for (int num = list.Count - 1; num >= 0; num--)
		{
			if (list[num] != null)
			{
				Object.Destroy(list[num].gameObject);
			}
		}
		list.Clear();
	}

	public void Show(bool isShow)
	{
		base.gameObject.SetActive(isShow);
	}

	public void OnEnter()
	{
		ResetRuntimeCards();
		RogueCardGameMain.GameContext.RefreshJokerPackage();
		RefreshCards();
		LayoutRebuilder.ForceRebuildLayoutImmediate(trs as RectTransform);
		Canvas.ForceUpdateCanvases();
		RogueCardGameMain.Instance.saveSystem.SaveGameData();
	}

	public void RefreshCards()
	{
		foreach (JokerCommonCard item in list)
		{
			item.gameObject.SetActive(value: false);
		}
		for (int i = 0; i < RogueCardGameMain.GameContext.packageJoker.Count; i++)
		{
			JokerCommonCard component;
			if (i >= list.Count)
			{
				component = Object.Instantiate(obj, trs).GetComponent<JokerCommonCard>();
				list.Add(component);
			}
			component = list[i];
			component.gameObject.SetActive(value: true);
			component.SetData(RogueCardGameMain.GameContext.packageJoker[i], i);
			component.SetNew(RogueCardGameMain.Instance.CheckIsNew(1, RogueCardGameMain.GameContext.packageJoker[i]) || RogueCardGameMain.Instance.CheckIsNew(2, RogueCardGameMain.GameContext.GetPackageJokerVersion(i)));
			component.SetVersion(RogueCardGameMain.GameContext.packageJokerVersion[i]);
		}
	}

	public void RefreshUI()
	{
		for (int i = 0; i < list.Count; i++)
		{
			list[i].SetSelect(RogueCardGameMain.GameContext.packageJokerIndex == i);
		}
	}
}
