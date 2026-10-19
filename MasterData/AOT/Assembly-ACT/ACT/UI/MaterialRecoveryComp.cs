using System.Collections.Generic;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.Utility;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class MaterialRecoveryComp : RecoveryCompBase
{
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
	[Header("最大值文本")]
	private TextMeshProUGUI _plusText;

	private int _materialCount;

	private const int MinValue = 1;

	private ItemUnifierProxy _curSelectedItem;

	public int MaterialCount
	{
		get
		{
			return _materialCount;
		}
		set
		{
			_materialCount = value;
			UpdateSlider();
		}
	}

	public override void Init(MonoInventoryView monoInventoryView)
	{
		base.Init(monoInventoryView);
		_minsBtn.SetBtnClick(Mins);
		_plusBtn.SetBtnClick(Plus);
		_slider.onValueChanged.RemoveAllListeners();
		_slider.onValueChanged.AddListener(OnSliderValueChanged);
	}

	private void Awake()
	{
		Model<InventoryModel>.Interface.ItemSelectedChange += InterfaceOnItemSelectedChange;
	}

	private void OnDestroy()
	{
		Model<InventoryModel>.Interface.ItemSelectedChange -= InterfaceOnItemSelectedChange;
	}

	private void InterfaceOnItemSelectedChange(ItemUIComponentBase item, bool selected)
	{
		if (selected)
		{
			_curSelectedItem = item.ItemUnifier;
			bool flag = !item.IsDisabled;
			_sliderRoot.alpha = (flag ? 1 : 0);
			if (flag)
			{
				MaterialCount = 1;
				_slider.minValue = 1f;
				long count = item.ItemUnifier.Count;
				_slider.limit = count;
				_slider.maxValue = count;
				_minsText.SetText("{0:0}", 1f);
				_plusText.SetText("{0:0}", count);
			}
		}
		else
		{
			_curSelectedItem = null;
			_sliderRoot.alpha = 0f;
		}
	}

	public override void Show()
	{
		base.Show();
		_sliderRoot.alpha = 0f;
	}

	private void UpdateSlider()
	{
		_slider.value = _materialCount;
		_minsBtn.Interactable(_materialCount > 1);
		_plusBtn.Interactable(_materialCount < _curSelectedItem.Count);
		ItemUnifierProxy itemUnifierProxy = unifierProxies.Find((ItemUnifierProxy x) => x == _curSelectedItem);
		if (itemUnifierProxy != null)
		{
			itemUnifierProxy.Count = _materialCount;
		}
	}

	public override void OnRecoveryItemChange(List<ItemUnifierProxy> items)
	{
		base.OnRecoveryItemChange(items);
		ItemUnifierProxy itemUnifierProxy = unifierProxies.Find((ItemUnifierProxy x) => x == _curSelectedItem);
		if (itemUnifierProxy != null)
		{
			itemUnifierProxy.Count = _materialCount;
		}
	}

	private void OnSliderValueChanged(float value)
	{
		MaterialCount = (int)value;
	}

	private void Mins()
	{
		if (_materialCount > 1)
		{
			MaterialCount--;
		}
	}

	private void Plus()
	{
		if (_materialCount < _curSelectedItem.Count)
		{
			MaterialCount++;
		}
	}
}
