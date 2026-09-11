using System;
using UnityEngine;
using UnityEngine.EventSystems;

namespace RogueCard;

public class RogueCommonCard : MonoBehaviour, IPointerClickHandler, IEventSystemHandler
{
	public RogueCardCommonView view;

	private RogueCardData cardData;

	private Action<RogueCardData, IRogueCardNeedTip> pointerFunc;

	private Coroutine flyNumCorotine;

	public void SetData(RogueCardData cardData, int index, bool pure = false, int pureID = 0)
	{
		view.SetData(cardData, index, pure, pureID);
		this.cardData = cardData;
	}

	public void SetData(RogueCardItemCfg wuChangCfg, int index)
	{
		view.SetData(wuChangCfg, index);
	}

	public void RefreshUI()
	{
		view.RefreshUI();
	}

	public void SetSelect(bool isSelect)
	{
		view.SetSelect(isSelect);
	}

	public void SetActive(bool isActive)
	{
		base.gameObject.SetActive(isActive);
	}

	public void SetSpecialPointEvent(Action<RogueCardData, IRogueCardNeedTip> pointFunc)
	{
		pointerFunc = pointFunc;
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		if (RogueCardGameMain.CheckDisableInput())
		{
			return;
		}
		if (view.index == -1)
		{
			if (view.isWuChang)
			{
				RogueCardGameMain.Instance.ShowTips(view.ItemCfg.id, view);
			}
			if (pointerFunc != null && cardData != null)
			{
				pointerFunc(cardData, view);
			}
		}
		else if (view.isWuChang)
		{
			RogueCardGameMain.Instance.WuChangSelectWuChang(view.index);
			RogueCardGameMain.Instance.ShowTips(view.ItemCfg.id, view);
		}
		else
		{
			RogueCardGameMain.Instance.WuChangSelectCard(view.index);
		}
	}

	public void PlayFlyNum(string text, FlyNumberType type, bool speed = false)
	{
		if (flyNumCorotine != null)
		{
			StopCoroutine(flyNumCorotine);
		}
		view.flyNumber.HideText();
		flyNumCorotine = StartCoroutine(view.PlayFlyNum(text, type, speed));
	}

	public void PlayAnimation(string name, float speed = 1f)
	{
		view.PlayAnimation(name, speed);
	}
}
