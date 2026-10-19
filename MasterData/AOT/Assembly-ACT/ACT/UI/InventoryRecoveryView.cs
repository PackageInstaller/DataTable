using System.Collections.Generic;
using ACT.Battle;
using ACT.Core;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.Utility;
using Fundamental;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class InventoryRecoveryView : BaseUIComponent
{
	[SerializeField]
	[Header("关闭按钮")]
	private ActButton _closeBtn;

	[SerializeField]
	[Header("过滤按钮")]
	private ActButton _filterBtn;

	[SerializeField]
	[Header("排序按钮")]
	private ActButton _sortBtn;

	[SerializeField]
	[Header("倒序按钮")]
	private ActButton _reverseBtn;

	[SerializeField]
	[Header("快速放入按钮")]
	private ActButton _quickFillBtn;

	[SerializeField]
	[Header("滑动条组件根节点")]
	private CanvasGroup _sliderRoot;

	[SerializeField]
	[Header("滑动条")]
	private LimitedSlider _slider;

	[SerializeField]
	[Header("减少按钮")]
	private ActButton _minsBtn;

	[SerializeField]
	[Header("增加按钮")]
	private ActButton _plusBtn;

	[SerializeField]
	[Header("最小值文本")]
	private TextMeshProUGUI _minsText;

	[SerializeField]
	[Header("当前值文本")]
	private TextMeshProUGUI _curValueText;

	[SerializeField]
	[Header("最大值文本")]
	private TextMeshProUGUI _plusText;

	[SerializeField]
	[Header("数量组件")]
	private CommonNumberComponent _selectNumber;

	[SerializeField]
	[Header("一键放入过期道具按钮")]
	private ActButton _quickFillDisuseBtn;

	[SerializeField]
	[Header("回收按钮")]
	private ActButton _recoveryBtn;

	[SerializeField]
	[Header("LT")]
	private GameObject LTPrompt;

	[SerializeField]
	[Header("RT")]
	private GameObject RTPrompt;

	[SerializeField]
	[Header("Y")]
	private GameObject Prompt_Y;

	private MonoInventoryView _monoInventoryView;

	private List<ItemUnifierProxy> _unifierProxies = new List<ItemUnifierProxy>();

	private ItemUnifierProxy _curSelectedItem;

	private int _curSelectItemCount;

	private const int MIN_COUNT = 1;

	public int CurSelectCount
	{
		get
		{
			return _curSelectItemCount;
		}
		set
		{
			_curSelectItemCount = value;
			UpdateSlider();
		}
	}

	private void Awake()
	{
		Model<InventoryModel>.Interface.ItemSelectedChange += InterfaceOnItemSelectedChange;
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChange);
	}

	protected override void OnUnityDestroy()
	{
		Model<InventoryModel>.Interface.ItemSelectedChange -= InterfaceOnItemSelectedChange;
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChange);
	}

	public void RefreshUI(MonoInventoryView monoInventoryView)
	{
		_monoInventoryView = monoInventoryView;
		_closeBtn.SetBtnClick(OnClickCloseRecoveryBtnHandle, "event:/UI/Common/Popup_Close");
		_filterBtn.SetBtnClick(monoInventoryView.OnClickFilterBtnHandle, "event:/UI/Interface/Bag/Below_Click");
		_sortBtn.SetBtnClick(monoInventoryView.OnClickSortBtnHandle, "event:/UI/Interface/Bag/Below_Click");
		_quickFillBtn.SetBtnClick(OnClickQuickFillBtnHandle, "event:/UI/Interface/Bag/Below_Click");
		_reverseBtn.SetBtnClick(OnClickReverseBtnHandle, "event:/UI/Interface/Bag/Below_Click");
		_recoveryBtn.SetBtnClick(OnClickRecoveryBtnHandle, "event:/UI/Interface/Bag/Delete_Click");
		_minsBtn.SetBtnClick(Mins, "event:/UI/Interface/Bag/Below_Click");
		_plusBtn.SetBtnClick(Plus, "event:/UI/Interface/Bag/Below_Click");
		_slider.onValueChanged.RemoveAllListeners();
		_slider.onValueChanged.AddListener(OnSliderValueChanged);
		_quickFillDisuseBtn.SetBtnClick(OnClickQuickFillDisuseBtnHandle, "event:/UI/Interface/Bag/Below_Click");
		_quickFillDisuseBtn.gameObject.SetActive(_monoInventoryView.GetIsHasFillDisuse());
		RefreshSelectCount(0);
		OnChangeInventoryTab(monoInventoryView.GetCurrentTab());
		OnInputModeChange(MonoECS.instance.InputMode);
	}

	public void OnChangeInventoryTab(InventoryTab inventoryTab)
	{
		_filterBtn.gameObject.SetActive(inventoryTab == InventoryTab.Equip || inventoryTab == InventoryTab.Disk);
		_sortBtn.gameObject.SetActive(inventoryTab == InventoryTab.Equip);
		_reverseBtn.gameObject.SetActive(inventoryTab == InventoryTab.Disk);
		_quickFillBtn.gameObject.SetActive(value: true);
		_sliderRoot.alpha = 0f;
		_quickFillDisuseBtn.gameObject.SetActive(_monoInventoryView.GetIsHasFillDisuse());
	}

	public void OnRecoveryItemChange(List<ItemUnifierProxy> items)
	{
		List<ItemUnifierProxy> list = new List<ItemUnifierProxy>();
		foreach (ItemUnifierProxy item in items)
		{
			ItemUnifierProxy newItem = ItemUnifierProxy.ItemUnifierPool.Get(item.Source);
			ItemUnifierProxy itemUnifierProxy = _unifierProxies.Find((ItemUnifierProxy x) => x.Id == newItem.Id);
			if (itemUnifierProxy != null)
			{
				newItem.Count = itemUnifierProxy.Count;
			}
			list.Add(newItem);
		}
		_unifierProxies = list;
		RefreshSelectCount(_unifierProxies.Count);
		if (_unifierProxies.Find((ItemUnifierProxy x) => _curSelectedItem != null && x.Id == _curSelectedItem.Id) != null)
		{
			CurSelectCount = 1;
		}
	}

	private void RefreshSelectCount(int number)
	{
		_selectNumber.UpdateNumber(number, RuntimeConfigs.data.game.BagRecycleLimit);
		_recoveryBtn.Interactable(number > 0);
		Prompt_Y.SetActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad && _recoveryBtn.IsInteractable());
	}

	public void OnClickQuickFillBtnHandle()
	{
		if (_quickFillBtn.gameObject.activeSelf)
		{
			_monoInventoryView.OnQuickFill();
		}
	}

	public void OnClickReverseBtnHandle()
	{
		if (_reverseBtn.gameObject.activeSelf)
		{
			_monoInventoryView.OnClickReverseBtnHandle();
		}
	}

	public void OnClickRecoveryBtnHandle()
	{
		if (_recoveryBtn.gameObject.activeSelf && _recoveryBtn.IsInteractable())
		{
			_sliderRoot.alpha = 0f;
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_RECOVERYITEM, new RecoveryItemViewData
			{
				RecoveryItems = _unifierProxies,
				OnRecovery = OnRecovery
			});
		}
	}

	private void OnRecovery()
	{
		_unifierProxies.Clear();
		RefreshSelectCount(0);
		_monoInventoryView.OnRecovery();
	}

	public void OnClickCloseRecoveryBtnHandle()
	{
		_unifierProxies.Clear();
		_monoInventoryView.OnCloseRecovery();
	}

	private void OnClickQuickFillDisuseBtnHandle()
	{
		if (_quickFillDisuseBtn.gameObject.activeSelf)
		{
			_monoInventoryView.OnQuickFillDisuse();
		}
	}

	private void InterfaceOnItemSelectedChange(ItemUIComponentBase item, bool selected)
	{
		_curSelectedItem = null;
		_sliderRoot.alpha = 0f;
		if (!item.IsDisabled && selected && item.ItemUnifier.ItemData.stackLimit > 1)
		{
			_sliderRoot.alpha = 1f;
			_curSelectedItem = item.ItemUnifier;
			_slider.minValue = 1f;
			long count = item.ItemUnifier.Count;
			_slider.limit = count;
			_slider.maxValue = count;
			_minsText.SetText("{0:0}", 1f);
			_plusText.SetText("{0:0}", count);
			ItemUnifierProxy itemUnifierProxy = _unifierProxies.Find((ItemUnifierProxy x) => x.Id == _curSelectedItem.Id);
			CurSelectCount = (int)((itemUnifierProxy == null) ? 1 : itemUnifierProxy.Count);
		}
	}

	private void UpdateSlider()
	{
		_slider.value = _curSelectItemCount;
		_minsBtn.Interactable(_curSelectItemCount > 1);
		_plusBtn.Interactable(_curSelectItemCount < _curSelectedItem.Count);
		ItemUnifierProxy itemUnifierProxy = _unifierProxies.Find((ItemUnifierProxy x) => x.Id == _curSelectedItem.Id);
		if (itemUnifierProxy != null)
		{
			itemUnifierProxy.Count = _curSelectItemCount;
		}
		_curValueText.SetText("{0:0}", _curSelectItemCount);
	}

	private void OnSliderValueChanged(float value)
	{
		CurSelectCount = (int)value;
	}

	public void Mins()
	{
		if (_curSelectItemCount > 1)
		{
			CurSelectCount--;
		}
	}

	public void Plus()
	{
		if (_curSelectItemCount < _curSelectedItem.Count)
		{
			CurSelectCount++;
		}
	}

	public bool IsMins()
	{
		if (_sliderRoot.alpha > 0f)
		{
			return _minsBtn.IsInteractable();
		}
		return false;
	}

	public bool IsPlus()
	{
		if (_sliderRoot.alpha > 0f)
		{
			return _plusBtn.IsInteractable();
		}
		return false;
	}

	private void OnInputModeChange(DeviceInputMode deviceInputMode)
	{
		LTPrompt.SetActive(deviceInputMode == DeviceInputMode.Gamepad);
		RTPrompt.SetActive(deviceInputMode == DeviceInputMode.Gamepad);
		_minsBtn.gameObject.SetActive(deviceInputMode != DeviceInputMode.Gamepad);
		_plusBtn.gameObject.SetActive(deviceInputMode != DeviceInputMode.Gamepad);
	}
}
