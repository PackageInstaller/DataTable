using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.RichText;
using ACT.UI.DataProxy;
using ACT.UI.InputController.BuyItemInputController;
using ACT.Utility;
using Bamboo.NumberString;
using Fundamental;
using Pb;
using Runtime.UI.CommonComponent;
using TMPro;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class ShopBuyPanel : BaseUIView<ShopBuyPanelInputController>
{
	public GamePadTipsComp gamePadTipsComp;

	public ItemUIComponentBase itemUI;

	public GameObject limitTextRoot;

	public TMP_Text boughtCount;

	public TMP_Text limitCount;

	public CommonCoinComponent costItem;

	public LocalizeStringEvent itemName;

	public LocalizeStringEvent describe;

	public TextMeshProUGUI useCount;

	public ActButton addBtn;

	public ActButton minusBtn;

	public ActButton confirmBtn;

	public ActButton cancelBtn;

	public ActButton maxBtn;

	public TextMeshProUGUI maxCount;

	public TextMeshProUGUI minCount;

	public LimitedSlider countSlider;

	[Header("道具溢出提示部分")]
	public GameObject overflowTipRoot;

	public TMP_Text overflowTipText;

	private int _boughtCount;

	private int _maxCount;

	private int _mNum = 1;

	private ACT.Config.ExchangeShop _exchangeShopData;

	private ItemUnifierProxy _item;

	private ShopBuyPanelData Data => uiViewData as ShopBuyPanelData;

	private void Awake()
	{
		confirmBtn.SetBtnClick(OnBuy);
		addBtn.SetBtnClick(ClickAddBtn);
		minusBtn.SetBtnClick(ClickMinusBtn);
		maxBtn.SetBtnClick(ClickMaxBtn);
		cancelBtn.SetBtnClick(ClickCancelBtn);
		overflowTipRoot?.SetActive(value: false);
		countSlider.onValueChanged.AddListener((float value) =>
		{
			SetNumValue((int)value);
		});
	}

	protected override void Init()
	{
		base.Init();
		int saleId = Data.SaleId;
		_exchangeShopData = CoreUtils.GetData(saleId, RuntimeConfigs.data.exchangeShops);
		ItemData itemData = RuntimeConfigs.data.itemDatas[_exchangeShopData.itemId];
		itemName.SetTable(LocalizeTable.ShortCommon);
		itemName.StringReference.TableEntryReference = itemData.nameLocal;
		describe.StringReference.TableEntryReference = 0L;
		if (itemData.type == 16)
		{
			int id = RuntimeConfigs.data.potionAdditivess.FirstOrDefault((KeyValuePair<int, PotionAdditives> x) => x.Value.itemId == _exchangeShopData.itemId).Value.id;
			describe.OnUpdateString.Invoke(Singleton<BloodBottleBuffHandler>.instance.GetBottleMatNameByUid(id, isDetailDesc: true));
		}
		else if (itemData.type == 15)
		{
			BloodBottleData bloodBottleByItemId = Model<BloodBottleModel>.Interface.GetBloodBottleByItemId(itemData.id);
			if (bloodBottleByItemId != null)
			{
				StringBuilder sb = new StringBuilder();
				describe.OnUpdateString.Invoke(Singleton<BloodBottleBuffHandler>.instance.GetSpecifyLevelBottleSkillDes(bloodBottleByItemId, sb, bloodBottleByItemId.curLevel, detailDesc: true));
			}
		}
		else if (itemData.type == 18)
		{
			EquipGemData data = CoreUtils.GetData(itemData.id, RuntimeConfigs.data.equipGemDatas);
			StringBuilder stringBuilder = new StringBuilder();
			if (data?.equipFeature != null)
			{
				for (int num = 0; num < data.equipFeature.Count; num++)
				{
					ItemKv itemKv = data.equipFeature[num];
					EquipFeatureData data2 = CoreUtils.GetData(itemKv.id, RuntimeConfigs.data.equipFeatureDatas);
					if (data2 == null)
					{
						continue;
					}
					int num2 = ((data2.maxLv <= 0) ? 1 : Mathf.Clamp(itemKv.count, 1, data2.maxLv));
					SkillGroupLevelData skillGroupLevelData = TableRule.GetSkillGroupLevelData(data2.skillGroupData, num2);
					int[] array = skillGroupLevelData?.skillDes;
					if (array != null && array.Length > 0)
					{
						if (stringBuilder.Length > 0)
						{
							stringBuilder.Append('\n');
						}
						stringBuilder.Append(CustomTagParser.ReplaceSkillMessageText(skillGroupLevelData.skillDes[0], "longcommon", isBrief: true, num2));
					}
				}
			}
			describe.OnUpdateString.Invoke(stringBuilder.ToString());
		}
		else
		{
			describe.SetTable(LocalizeTable.LongCommon);
			describe.StringReference.TableEntryReference = itemData.descLocal;
		}
		if (_item != null)
		{
			ItemUnifierProxy.ItemUnifierPool.Release(ref _item);
		}
		_item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(_exchangeShopData.itemId, _exchangeShopData.itemCount);
		itemUI.SetData(_item, long.MinValue, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.OneSide);
		itemUI.UpdatePerformance();
		RefreshBoughtCount();
		DataClear();
		CalculateCost();
		CalculateMaxCount();
		SetNumValue(1);
		UpdateCountText();
		RefreshBtn();
		UpdateGamePadTips();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation?.GetSequence("Show")?.Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation?.GetSequence("Hide")?.Play();
	}

	private void CalculateMaxCount()
	{
		int num = CalculateAffordableMaxCount();
		if (_exchangeShopData.limitCount > 0)
		{
			num = Math.Min(num, Math.Max(_exchangeShopData.limitCount - _boughtCount, 1));
		}
		_maxCount = GetMaxCountByItemLimit(num);
		bool flag = _maxCount < num;
		overflowTipRoot?.SetActive(flag);
		RefreshOverflowTip(flag);
		minCount.text = 1.FastToString();
		maxCount.text = _maxCount.FastToString();
		countSlider.maxValue = _maxCount;
		countSlider.limit = _maxCount;
		countSlider.minValue = ((_maxCount > 0) ? 1 : 0);
	}

	private int CalculateAffordableMaxCount()
	{
		int num = int.MaxValue;
		foreach (ItemKv item in _exchangeShopData.itemNeed)
		{
			if (item.count > 0)
			{
				long num2 = GetHaveCount(item.id) / item.count;
				num = Math.Min(num, (int)((num2 > int.MaxValue) ? int.MaxValue : num2));
			}
		}
		return Math.Max((num == int.MaxValue) ? 1 : num, 1);
	}

	private long GetHaveCount(int itemId)
	{
		if (RuntimeConfigs.data.itemDatas[itemId].type == 999)
		{
			if (!G.detailUserInfo.Attributes.TryGetValue(itemId, out var value))
			{
				return 0L;
			}
			return value;
		}
		return G.localPlayer.Inventory.GetItemInfo(itemId)?.Count ?? 0;
	}

	private void CalculateCost()
	{
		ItemKv itemKv = _exchangeShopData.itemNeed.FirstOrDefault();
		if (itemKv != null)
		{
			ItemKv item = new ItemKv(itemKv.id, itemKv.count * _mNum);
			costItem.gameObject.SetActive(value: true);
			costItem.Refresh(item);
		}
	}

	private void UpdateCountText()
	{
		limitTextRoot.SetActive(_exchangeShopData.limitCount != 0);
		limitCount.text = Math.Max(_exchangeShopData.limitCount - _boughtCount, 0).FastToString();
	}

	private void RefreshBoughtCount()
	{
		_boughtCount = 0;
		if (_exchangeShopData != null && _exchangeShopData.limitCount != 0 && Data != null && G.localPlayer.ShopInfos.TryGetValue(Data.ShopId, out var value) && value != null && value.SubShops.TryGetValue(Data.SubShopId, out var value2) && value2 != null && value2.Commodities.TryGetValue(Data.SaleId, out var value3) && value3 != null)
		{
			_boughtCount = value3.BoughtNum;
		}
	}

	private void RefreshOverflowTip(bool isItemLimitRestrictsPurchase)
	{
		if (overflowTipText == null)
		{
			return;
		}
		if (!isItemLimitRestrictsPurchase || _exchangeShopData == null)
		{
			overflowTipText.SetText(string.Empty);
			return;
		}
		GameUtility.CheckItemQuantityOwnedIsValid(_exchangeShopData.itemId, 0, out var result);
		ItemData data = CoreUtils.GetData(_exchangeShopData.itemId, RuntimeConfigs.data.itemDatas);
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

	private int GetMaxCountByItemLimit(int maxCount)
	{
		if (_exchangeShopData == null || maxCount <= 0)
		{
			return 0;
		}
		int num = 0;
		int num2 = maxCount;
		while (num < num2)
		{
			int num3 = num + (num2 - num + 1) / 2;
			long num4 = (long)_exchangeShopData.itemCount * (long)num3;
			if (num4 > int.MaxValue || !GameUtility.CheckItemQuantityOwnedIsValid(_exchangeShopData.itemId, (int)num4, out var _))
			{
				num2 = num3 - 1;
			}
			else
			{
				num = num3;
			}
		}
		return num;
	}

	public void RefreshBtn()
	{
		CalculateCost();
		addBtn.Interactable(_mNum < _maxCount);
		maxBtn.Interactable(_mNum < _maxCount);
		minusBtn.Interactable(_mNum > 1);
		confirmBtn.Interactable(_mNum > 0 && (Check(_mNum) || CanJumpToDiamondExchange(_mNum)));
	}

	private void UpdateGamePadTips()
	{
		if (!(gamePadTipsComp == null))
		{
			if (CanScrollDescription())
			{
				gamePadTipsComp.RegisterInputActions(GamePadTipHelper.BackAction, GamePadTipHelper.ScrollAction);
			}
			else
			{
				gamePadTipsComp.RegisterInputActions(GamePadTipHelper.BackAction);
			}
		}
	}

	private bool CanScrollDescription()
	{
		RightStickScrollSupport componentInChildren = GetComponentInChildren<RightStickScrollSupport>(includeInactive: true);
		ScrollRect scrollRect = componentInChildren?.GetComponentInChildren<ScrollRect>(includeInactive: true) ?? GetComponentInChildren<ScrollRect>(includeInactive: true);
		if (scrollRect?.content == null || scrollRect.viewport == null)
		{
			return false;
		}
		Canvas.ForceUpdateCanvases();
		LayoutRebuilder.ForceRebuildLayoutImmediate(scrollRect.content);
		bool flag = scrollRect.content.rect.height > scrollRect.viewport.rect.height + 0.001f;
		componentInChildren?.SetForbidScroll(!flag);
		return flag;
	}

	public void SetCountSlider()
	{
		SetNumValue((int)countSlider.value);
	}

	public void SetNumValue(int value)
	{
		_mNum = Mathf.Clamp(value, (_maxCount > 0) ? 1 : 0, _maxCount);
		if (!Mathf.Approximately(countSlider.value, _mNum))
		{
			countSlider.value = _mNum;
		}
		useCount.SetText("{0:0}", _mNum);
		RefreshBtn();
	}

	protected override void CloseEffectCallback()
	{
		DataClear();
	}

	public void ClickCancelBtn()
	{
		ShopEventTrackHelper.Dispatch(Data.SubShopId, 5, _item.Id, _mNum);
		Close();
	}

	public void ClickAddBtn()
	{
		if (addBtn.IsInteractable())
		{
			_mNum++;
			useCount.SetText("{0:0}", _mNum);
			countSlider.value = _mNum;
			RefreshBtn();
		}
	}

	public void ClickMinusBtn()
	{
		if (minusBtn.IsInteractable())
		{
			_mNum--;
			useCount.SetText("{0:0}", _mNum);
			countSlider.value = _mNum;
			RefreshBtn();
		}
	}

	public void ClickMaxBtn()
	{
		if (maxBtn.IsInteractable())
		{
			_mNum = _maxCount;
			useCount.SetText("{0:0}", _mNum);
			countSlider.value = _mNum;
			RefreshBtn();
		}
	}

	public void DataClear()
	{
		_mNum = 1;
		useCount.SetText("{0:0}", _mNum);
		countSlider.value = _mNum;
		RefreshBtn();
	}

	public void OnBuy()
	{
		if (!confirmBtn.IsInteractable())
		{
			return;
		}
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Store/Buy");
		ShopEventTrackHelper.Dispatch(Data.SubShopId, 4, _item.Id, _mNum);
		if (Check(_mNum))
		{
			G.service.ShopBuy(Data.ShopId, Data.SubShopId, Data.SaleId, _mNum, (ShopBuyCommodityAck ok) =>
			{
				if (ok != null)
				{
					_boughtCount += _mNum;
					UpdateCountText();
					Singleton<EventManager>.instance.EventDispatch(ClientEvent.ExchangeShopSuccess, null);
					ShopEventTrackHelper.Dispatch(Data.SubShopId, 6, _item.Id, _mNum);
					GameUtility.OpenPopReward(ok.GotItems);
					Close();
				}
				else
				{
					GameUtility.OpenToolTip(LocalizationCommonData.CommonString.LackMaterial);
				}
			});
		}
		else
		{
			ShopEventTrackHelper.Dispatch(Data.SubShopId, 5, _item.Id, _mNum);
			JumpToDiamondExchange(_mNum);
		}
	}

	private bool CanJumpToDiamondExchange(int num)
	{
		bool result = false;
		foreach (ItemKv item in _exchangeShopData.itemNeed)
		{
			if (GetHaveCount(item.id) < item.count * num)
			{
				if (item.id != 97 && item.id != 98)
				{
					return false;
				}
				result = true;
			}
		}
		return result;
	}

	private void JumpToDiamondExchange(int num)
	{
		foreach (ItemKv item in _exchangeShopData.itemNeed)
		{
			int num2 = item.count * num;
			long haveCount = GetHaveCount(item.id);
			if (haveCount < num2)
			{
				if (item.id == 97)
				{
					long num3 = Math.Min(num2 - haveCount, 2147483647L);
					Model<PayModel>.Interface.JumpToExchangeFreeDiamond((int)num3);
					break;
				}
				if (item.id == 98)
				{
					Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_JUMPTOCOSTDIAMOND);
					break;
				}
			}
		}
	}

	private bool Check(int num)
	{
		foreach (ItemKv item in _exchangeShopData.itemNeed)
		{
			if (RuntimeConfigs.data.itemDatas[item.id].type == 999)
			{
				if (G.detailUserInfo.Attributes.TryGetValue(item.id, out var value))
				{
					if (value < item.count * num)
					{
						return false;
					}
					continue;
				}
				return false;
			}
			Item itemInfo = G.localPlayer.Inventory.GetItemInfo(item.id);
			if (itemInfo != null)
			{
				if (itemInfo.Count < item.count * num)
				{
					return false;
				}
				continue;
			}
			return false;
		}
		return true;
	}
}
