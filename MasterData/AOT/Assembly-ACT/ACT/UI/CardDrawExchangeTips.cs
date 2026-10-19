using System;
using ACT.Game;
using ACT.Game.Data;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class CardDrawExchangeTips : MonoBehaviour
{
	public LocalizeStringEvent Title;

	public LocalizeStringEvent Dec;

	public TextMeshProUGUI ExpendCount;

	public TextMeshProUGUI TargetCount;

	public TextMeshProUGUI GetCount;

	public Button AddBtn;

	public Button MinusBtn;

	public GameObject GoMax;

	public Button ConfirmBtn;

	public ItemUIComponent ExpendItemUI;

	public ItemUIComponent TargetItemUI;

	public TextMeshProUGUI MaxCount;

	public TextMeshProUGUI MinCount;

	public LimitedSlider CountSlider;

	private int maxCount;

	private int m_Num = 1;

	private int singleTargetItemPrice = 160;

	public void Init(Item ExpendItem, Item TargetItem)
	{
		CountSlider.value = 1f;
		int countById = G.localPlayer.GetCountById(ExpendItem.Id);
		maxCount = Math.Max(countById / singleTargetItemPrice, 1);
		ExpendItemUI.BagItemInit(ExpendItem);
		ExpendItemUI.BagItemInit(TargetItem);
		SetNumValue(1);
		SettSlider(maxCount);
	}

	public void SetCountSlider()
	{
		SetNumValue((int)CountSlider.value);
	}

	private void SetNumValue(int value)
	{
		m_Num = value;
		TargetCount.SetText("{0:0}", m_Num);
		RefreshBtn();
	}

	private void SettSlider(int maxnum)
	{
		MaxCount.SetText("{0:0}", maxnum);
		CountSlider.maxValue = maxnum;
		CountSlider.limit = maxnum;
		CountSlider.minValue = 1f;
	}

	public void ClickAddBtn()
	{
		m_Num++;
		CountSlider.value = m_Num;
		RefreshBtn();
	}

	public void ClickMinusBtn()
	{
		m_Num--;
		CountSlider.value = m_Num;
		RefreshBtn();
	}

	private void RefreshBtn()
	{
		AddBtn.interactable = m_Num < maxCount;
		MinusBtn.interactable = m_Num >= 1;
		ConfirmBtn.interactable = m_Num >= 1;
		GoMax.SetActive(m_Num >= maxCount);
		RefreshCost();
	}

	public void Hide()
	{
		gameObject.SetActive(value: false);
	}

	private void RefreshCost()
	{
		TargetCount.SetText("{0:0}", m_Num);
		ExpendCount.SetText("{0:0}", m_Num * singleTargetItemPrice);
		GetCount.SetText("{0:0}", m_Num);
	}
}
