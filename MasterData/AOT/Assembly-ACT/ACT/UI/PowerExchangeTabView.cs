using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.RichText;
using ACT.UI.DataProxy;
using ACT.UI.Interface;
using ACT.Utility;
using Fundamental;
using Google.Protobuf.Collections;
using Runtime.Model.PowerModel;
using TMPro;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class PowerExchangeTabView : BaseTabContent
{
	private const int ExchangeStep = 10;

	[Header("左侧目录部分")]
	public ExchangeItemTab exchangeItemTabTemplate;

	public Transform exchangeItemTabContainer;

	[Header("兑换部分")]
	public LocalizeStringEvent exchangeRatioText;

	public TMP_Text exchangeRatio;

	public ActButton helpButton;

	public TMP_Text powerCountText;

	public Color redColor;

	public ItemUIComponentBase exchangeItemCell;

	[Header("额外奖励部分")]
	public ItemUIComponentBase extraItemCell;

	[Header("控制部分")]
	public GameObject controlPartRoot;

	public LimitedSlider limitedSliderSlider;

	public ActButton addBtn;

	public ActButton minusBtn;

	public ActButton maxBtn;

	public TMP_Text useCount;

	public TMP_Text minCount;

	public TMP_Text maxCount;

	public ActButton confirmButton;

	public ActButton lackPowerButton;

	[Header("解锁条件提示部分")]
	public GameObject tipRoot;

	public TMP_Text tipText;

	[Header("道具溢出提示部分")]
	public GameObject overflowTipRoot;

	public TMP_Text overflowTipText;

	private ExchangeItem _selectedExchangeItem;

	private int _exchangeCount = 1;

	private int _maxExchangeCount = 1;

	private ItemUnifierProxy _exchangeItem;

	private ItemUnifierProxy _extraItem;

	private bool _isTabActive;

	private bool _isLocked;

	private readonly Dictionary<int, ExchangeItemTab> _exchangeItemTabs = new Dictionary<int, ExchangeItemTab>();

	private MonoHandbookView _handbookView;

	public void SetView(MonoHandbookView handbookView)
	{
		_handbookView = handbookView;
	}

	public void OpenSelectedItemDetail()
	{
		if (_selectedExchangeItem != null)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, new Item
			{
				Id = _selectedExchangeItem.itemId,
				Count = G.localPlayer.Inventory.GetItemCount(_selectedExchangeItem.itemId)
			});
		}
	}

	public void OpenSystemHelp()
	{
		ClickHelpBtn();
	}

	private void Awake()
	{
		GenerateExchangeItemTab();
		overflowTipRoot?.SetActive(value: false);
		PowerModel powerModel = Model<PowerModel>.Interface;
		powerModel.OnPowerChanged = (Action)Delegate.Combine(powerModel.OnPowerChanged, new Action(OnPowerChanged));
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BagItemChange, OnBagItemChanged);
		limitedSliderSlider.onValueChanged.AddListener(SetNumValue);
		if (addBtn != null)
		{
			addBtn.SetBtnClick(ClickAddBtn);
		}
		if (minusBtn != null)
		{
			minusBtn.SetBtnClick(ClickMinusBtn);
		}
		if (maxBtn != null)
		{
			maxBtn.SetBtnClick(ClickMaxBtn);
		}
		if (confirmButton != null)
		{
			confirmButton.SetBtnClick(ClickConfirmBtn);
		}
		if (helpButton != null)
		{
			helpButton.SetBtnClick(ClickHelpBtn);
		}
	}

	protected override void OnUnityDestroy()
	{
		PowerModel powerModel = Model<PowerModel>.Interface;
		powerModel.OnPowerChanged = (Action)Delegate.Remove(powerModel.OnPowerChanged, new Action(OnPowerChanged));
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BagItemChange, OnBagItemChanged);
		ReleaseItemCellData();
		base.OnUnityDestroy();
	}

	private void ClickConfirmBtn()
	{
		if (_selectedExchangeItem == null || IsSelectedExchangeItemLocked() || Model<PowerModel>.Interface.PowerCount < _exchangeCount)
		{
			return;
		}
		G.service.PowerExchangeItem(_selectedExchangeItem.itemId, _exchangeCount, (bool success, RepeatedField<UniversalItem> items) =>
		{
			if (success)
			{
				CalculateMaxExchangeCount();
				SetNumValue(limitedSliderSlider.value);
				RefreshExchangeItemTabCountAndRatio();
				GameUtility.OpenPopReward(items);
			}
		});
	}

	private void ClickHelpBtn()
	{
		HandBookTab handBookTab = Tab as HandBookTab;
		if (!(handBookTab == null))
		{
			HandBookMain data = CoreUtils.GetData(handBookTab.TabIdentify, RuntimeConfigs.data.handBookMains);
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ACTIVITYDESC, new ActivityDescViewData
			{
				titleTextId = data.contentLv1name,
				localizedStringType = "Common",
				descTextId = 2815,
				iconId = 1008
			});
		}
	}

	private void GenerateExchangeItemTab()
	{
		foreach (KeyValuePair<int, ExchangeItem> kv in RuntimeConfigs.data.ExchangeItems)
		{
			ExchangeItemTab exchangeItemTab = UnityEngine.Object.Instantiate(exchangeItemTabTemplate, exchangeItemTabContainer);
			exchangeItemTab.gameObject.SetActive(value: true);
			exchangeItemTab.ExchangeItemID = kv.Key;
			exchangeItemTab.onToggleOn.AddListener(() =>
			{
				SelectExchangeItem(kv.Key);
			});
			_exchangeItemTabs.Add(kv.Key, exchangeItemTab);
		}
	}

	private void SelectExchangeItem(int exchangeItemId)
	{
		if (!_exchangeItemTabs.TryGetValue(exchangeItemId, out var value))
		{
			return;
		}
		if (!value.IsOn)
		{
			value.SetIsOn(val: true);
			return;
		}
		_selectedExchangeItem = CoreUtils.GetData(exchangeItemId, RuntimeConfigs.data.ExchangeItems);
		if (_selectedExchangeItem != null)
		{
			RefreshUnlockState();
			RefreshExchangeRatio();
			CalculateMaxExchangeCount();
			int num = ((_maxExchangeCount > 0) ? 1 : 0);
			SetNumValue(num);
			limitedSliderSlider.value = num;
		}
	}

	private bool IsSelectedExchangeItemLocked()
	{
		if (_selectedExchangeItem != null)
		{
			return !Model<HandBookModel>.Interface.IsPowerExchangeTabUnlock(_selectedExchangeItem.id);
		}
		return true;
	}

	private void RefreshUnlockState()
	{
		_isLocked = IsSelectedExchangeItemLocked();
		tipRoot?.SetActive(_isLocked);
		controlPartRoot?.SetActive(!_isLocked);
		exchangeRatioText.SetTable(LocalizeTable.Common);
		exchangeRatioText.StringReference.TableEntryReference = (_isLocked ? LocalizationCommonData.CommonString.NotLockYet : LocalizationCommonData.CommonString.ExchangeRatio);
		if (!_isLocked)
		{
			return;
		}
		tipText?.SetText(string.Empty);
		if (!RuntimeConfigs.data.raidEntranceDatas.TryGetValue(_selectedExchangeItem.raidEntranceId, out var value))
		{
			return;
		}
		int unlockCondition = value.unlockCondition;
		if (unlockCondition > 0 && RuntimeConfigs.data.missionGroups.TryGetValue(unlockCondition, out var value2))
		{
			int[] missionId = value2.missionId;
			if (missionId != null && missionId.Length > 0 && RuntimeConfigs.data.missions.TryGetValue(value2.missionId[0], out var value3))
			{
				tipText?.SetText(CustomTagParser.ReplacePreconditionText(value3, value3.number, value3.param));
			}
		}
	}

	private void RefreshExchangeItemTabOrder()
	{
		List<int> list = ListPool<int>.Get();
		try
		{
			foreach (KeyValuePair<int, ExchangeItemTab> exchangeItemTab in _exchangeItemTabs)
			{
				bool flag = !Model<HandBookModel>.Interface.IsPowerExchangeTabUnlock(exchangeItemTab.Key);
				int index = list.Count;
				for (int i = 0; i < list.Count; i++)
				{
					int num = list[i];
					bool flag2 = !Model<HandBookModel>.Interface.IsPowerExchangeTabUnlock(num);
					if ((!flag & flag2) || (flag == flag2 && exchangeItemTab.Key < num))
					{
						index = i;
						break;
					}
				}
				list.Insert(index, exchangeItemTab.Key);
			}
			for (int j = 0; j < list.Count; j++)
			{
				_exchangeItemTabs[list[j]].transform.SetAsLastSibling();
			}
		}
		finally
		{
			ListPool<int>.Release(list);
		}
	}

	private int GetFirstExchangeItemTabId()
	{
		int result = 0;
		int num = int.MaxValue;
		foreach (KeyValuePair<int, ExchangeItemTab> exchangeItemTab in _exchangeItemTabs)
		{
			int siblingIndex = exchangeItemTab.Value.transform.GetSiblingIndex();
			if (siblingIndex < num)
			{
				num = siblingIndex;
				result = exchangeItemTab.Key;
			}
		}
		return result;
	}

	private void RefreshExchangeItemTabCountAndRatio()
	{
		foreach (KeyValuePair<int, ExchangeItemTab> exchangeItemTab in _exchangeItemTabs)
		{
			exchangeItemTab.Value.RefreshCountAndRatio();
		}
	}

	private void OnBagItemChanged(BaseEventContent evt)
	{
		if (_isTabActive)
		{
			RefreshExchangeItemTabCountAndRatio();
		}
	}

	private void RefreshExchangeRatio()
	{
		if (!(exchangeRatio == null))
		{
			if (_isLocked)
			{
				exchangeRatio.SetText(string.Empty);
				return;
			}
			PowerModel.PowerExchangeAttributeIds.TryGetValue(_selectedExchangeItem.id, out var value);
			exchangeRatio.SetText(Model<PowerModel>.Interface.GetPowerConvertRate(value) + "%");
		}
	}

	private void CalculateMaxExchangeCount()
	{
		int num = Mathf.Max(Model<PowerModel>.Interface.PowerCount / 10 * 10, 10);
		_maxExchangeCount = GetMaxExchangeCountByItemLimit(num);
		int num2 = _maxExchangeCount / 10;
		bool flag = _maxExchangeCount < num;
		overflowTipRoot?.SetActive(flag);
		RefreshOverflowTip(flag);
		limitedSliderSlider.maxValue = num2;
		limitedSliderSlider.limit = num2;
		limitedSliderSlider.minValue = ((num2 > 0) ? 1 : 0);
		minCount?.SetText(10.ToString());
		maxCount?.SetText(_maxExchangeCount.ToString());
	}

	private void RefreshOverflowTip(bool isItemLimitRestrictsExchange)
	{
		if (overflowTipText == null)
		{
			return;
		}
		if (!isItemLimitRestrictsExchange || _selectedExchangeItem == null)
		{
			overflowTipText.SetText(string.Empty);
			return;
		}
		GameUtility.CheckItemQuantityOwnedIsValid(_selectedExchangeItem.itemId, 0, out var result);
		ItemData data = CoreUtils.GetData(_selectedExchangeItem.itemId, RuntimeConfigs.data.itemDatas);
		string item = ((data != null) ? LocalizationUtility.GetLocalizeString("shortcommon", data.nameLocal) : string.Empty);
		if (result.leftCount <= 0)
		{
			overflowTipText.SetText(LocalizationUtility.GetLocalizeString("Common", 2528, new List<object> { item }));
		}
		else
		{
			overflowTipText.SetText(LocalizationUtility.GetLocalizeString("Common", 2836, new List<object> { item, result.leftCount }));
		}
	}

	private int GetMaxExchangeCountByItemLimit(int maxExchangeCount)
	{
		if (_selectedExchangeItem == null || maxExchangeCount <= 0)
		{
			return 0;
		}
		int num = 0;
		int num2 = maxExchangeCount / 10;
		while (num < num2)
		{
			int num3 = num + (num2 - num + 1) / 2;
			long powerExchangeItemCount = Model<PowerModel>.Interface.GetPowerExchangeItemCount(_selectedExchangeItem.itemId, num3 * 10);
			if (powerExchangeItemCount > int.MaxValue || !GameUtility.CheckItemQuantityOwnedIsValid(_selectedExchangeItem.itemId, (int)powerExchangeItemCount, out var _))
			{
				num2 = num3 - 1;
			}
			else
			{
				num = num3;
			}
		}
		return num * 10;
	}

	private void OnPowerChanged()
	{
		if (_selectedExchangeItem != null)
		{
			CalculateMaxExchangeCount();
			SetNumValue(limitedSliderSlider.value);
		}
	}

	public void SetCountSlider()
	{
		SetNumValue(limitedSliderSlider.value);
	}

	private void SetNumValue(float value)
	{
		int num = _maxExchangeCount / 10;
		int num2 = Mathf.Clamp(Mathf.RoundToInt(value), (num > 0) ? 1 : 0, num);
		_exchangeCount = num2 * 10;
		if (!Mathf.Approximately(limitedSliderSlider.value, num2))
		{
			limitedSliderSlider.value = num2;
		}
		useCount?.SetText(_exchangeCount.ToString());
		RefreshBtn();
		if (_isTabActive)
		{
			RefreshItemCells();
		}
	}

	private void RefreshBtn()
	{
		addBtn?.Interactable(_exchangeCount < _maxExchangeCount);
		maxBtn?.Interactable(_exchangeCount < _maxExchangeCount);
		minusBtn?.Interactable(_exchangeCount > 10);
		bool flag = _exchangeCount > 0 && Model<PowerModel>.Interface.PowerCount >= _exchangeCount;
		confirmButton?.gameObject.SetActive(flag);
		lackPowerButton?.gameObject.SetActive(!flag);
	}

	private void RefreshItemCells()
	{
		if (_selectedExchangeItem != null)
		{
			ReleaseItemCellData();
			int powerCount = Model<PowerModel>.Interface.PowerCount;
			int exchangeCount = _exchangeCount;
			long powerExchangeItemCount = Model<PowerModel>.Interface.GetPowerExchangeItemCount(_selectedExchangeItem.itemId, exchangeCount);
			powerCountText?.SetText($"{exchangeCount}");
			if (powerCountText != null)
			{
				powerCountText.color = ((powerCount < exchangeCount) ? redColor : Color.white);
			}
			_exchangeItem = ItemUnifierProxy.ItemUnifierPool.Get<Item>(_selectedExchangeItem.itemId, powerExchangeItemCount);
			exchangeItemCell.SetData(_exchangeItem, long.MinValue, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.OneSide);
			exchangeItemCell.UpdatePerformance();
			int id = 93;
			long num = (long)exchangeCount * 5L;
			if (SystemUnlockManager.playerLevel >= RuntimeConfigs.data.game.playerMaxLevel)
			{
				id = 2;
				num *= RuntimeConfigs.data.game.playerMaxLevelEachExpToGold;
			}
			_extraItem = ItemUnifierProxy.ItemUnifierPool.Get<Item>(id, num);
			extraItemCell.SetData(_extraItem, long.MinValue, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.OneSide);
			extraItemCell.UpdatePerformance();
		}
	}

	private void ReleaseItemCellData()
	{
		exchangeItemCell?.Release();
		extraItemCell?.Release();
		ItemUnifierProxy.ItemUnifierPool.Release(ref _exchangeItem);
		ItemUnifierProxy.ItemUnifierPool.Release(ref _extraItem);
	}

	public void ClickAddBtn()
	{
		if (!(addBtn != null) || addBtn.IsInteractable())
		{
			limitedSliderSlider.value++;
		}
	}

	public void ClickMinusBtn()
	{
		if (!(minusBtn != null) || minusBtn.IsInteractable())
		{
			limitedSliderSlider.value--;
		}
	}

	public void ClickMaxBtn()
	{
		if (!(maxBtn != null) || maxBtn.IsInteractable())
		{
			limitedSliderSlider.value = _maxExchangeCount / 10;
		}
	}

	protected override void OnTabActive(ITabItem tabItem)
	{
		base.OnTabActive(tabItem);
		_isTabActive = true;
		_handbookView?.ChangeToGamePadInputState(HandBookSubController.powerExchangeContent);
		RefreshExchangeItemTabOrder();
		RefreshExchangeItemTabCountAndRatio();
		int num = 0;
		if (tabItem is HandBookTab { Context: HandBookViewParam context })
		{
			num = context.PowerExchangeId;
		}
		if (num <= 0 || !_exchangeItemTabs.ContainsKey(num))
		{
			num = GetFirstExchangeItemTabId();
		}
		SelectExchangeItem(num);
		PlayShowAnimation();
	}

	protected override void OnTabDeActive(ITabItem tabItem)
	{
		base.OnTabDeActive(tabItem);
		_isTabActive = false;
		ReleaseItemCellData();
	}

	private void PlayShowAnimation()
	{
		int childCount = exchangeItemTabContainer.childCount;
		for (int i = 0; i < childCount; i++)
		{
			ExchangeItemTab component = exchangeItemTabContainer.GetChild(i).GetComponent<ExchangeItemTab>();
			if ((bool)component)
			{
				component.Animation?.GetSequence(component.IsOn ? "SelectedShow" : "NormalShow")?.Goto(0f).SetDelay((float)i * 0.05f).Play();
			}
		}
	}
}
