using System;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Runtime.Model.PowerModel;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class ExchangeItemTab : ActToggle
{
	[Serializable]
	public struct Style
	{
		public GameObject root;

		public LocalizeStringEvent itemName;

		public TMP_Text itemCount;
	}

	public Style normalPart;

	public Style selectPart;

	public BImage icon;

	public GameObject exchangeRatioText;

	public TMP_Text exchangeRatio;

	[Header("锁定遮罩")]
	public GameObject lockStyleRoot;

	private int _exchangeItemID;

	private ExchangeItem _exchangeItemData;

	private ItemData _itemData;

	private ImageAssetStation _imageStation;

	private bool _isLocked;

	public BetterAnimation Animation => _animation;

	public int ExchangeItemID
	{
		get
		{
			return _exchangeItemID;
		}
		set
		{
			_exchangeItemID = value;
			_exchangeItemData = CoreUtils.GetData(_exchangeItemID, RuntimeConfigs.data.ExchangeItems);
			_itemData = CoreUtils.GetData(_exchangeItemData.itemId, RuntimeConfigs.data.itemDatas);
			UpdateStyle();
		}
	}

	protected override void AwakeImply()
	{
		base.AwakeImply();
		onValueChanged.AddListener(OnToggleValueChanged);
		RefreshStyleRoots(IsOn);
	}

	protected override void OnDestroyImp()
	{
		base.OnDestroyImp();
		onValueChanged.RemoveListener(OnToggleValueChanged);
	}

	private void UpdateStyle()
	{
		if (_exchangeItemData != null && _itemData != null)
		{
			if (_imageStation == null)
			{
				_imageStation = this.GetImageStation();
			}
			_imageStation?.LoadItemIconAsync(_itemData.iconAddress, icon);
			SetStyle(normalPart);
			SetStyle(selectPart);
			RefreshCountAndRatio();
			RefreshStyleRoots(IsOn);
		}
	}

	private void SetStyle(Style targetStyle)
	{
		if (!(targetStyle.itemName == null))
		{
			targetStyle.itemName.SetTable(LocalizeTable.ShortCommon);
			targetStyle.itemName.StringReference.TableEntryReference = _itemData.nameLocal;
		}
	}

	public void RefreshCountAndRatio()
	{
		if (_exchangeItemData == null)
		{
			return;
		}
		string sourceText = G.localPlayer.Inventory.GetItemCount(_exchangeItemData.itemId).FastToString();
		if (normalPart.itemCount != null)
		{
			normalPart.itemCount.SetText(sourceText);
		}
		if (selectPart.itemCount != null)
		{
			selectPart.itemCount.SetText(sourceText);
		}
		_isLocked = !Model<HandBookModel>.Interface.IsPowerExchangeTabUnlock(_exchangeItemID);
		if (_isLocked)
		{
			lockStyleRoot.SetActive(value: true);
			exchangeRatioText.SetActive(value: false);
			exchangeRatio.gameObject.SetActive(value: false);
			return;
		}
		lockStyleRoot.SetActive(value: false);
		exchangeRatioText.SetActive(value: true);
		exchangeRatio.gameObject.SetActive(value: true);
		if (PowerModel.PowerExchangeAttributeIds.TryGetValue(_exchangeItemID, out var value))
		{
			exchangeRatio.SetText(Model<PowerModel>.Interface.GetPowerConvertRate(value) + "%");
		}
	}

	private void RefreshStyleRoots(bool isOn)
	{
		if (normalPart.root != null)
		{
			normalPart.root.SetActive(!isOn);
		}
		if (selectPart.root != null)
		{
			selectPart.root.SetActive(isOn);
		}
	}

	private void OnToggleValueChanged(bool isOn)
	{
		RefreshStyleRoots(isOn);
	}
}
