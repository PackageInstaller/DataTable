using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Net;
using ACT.UI.DataProxy;
using ACT.UI.InputController.QuickPowerExchangeItemViewController;
using ACT.Utility;
using ACT.ViewControl;
using Fundamental;
using Google.Protobuf.Collections;
using Runtime.Model.PowerModel;
using Runtime.UI.CommonComponent;
using UnityEngine;

namespace ACT.UI;

public class QuickPowerExchangeItemView : BaseUIView<QuickPowerExchangeItemViewInputController>
{
	public PowerExchangeStyle exchangeStyle;

	public ItemUIComponentBase extraItemCell;

	public CommonCoinComponent needItemCountCell;

	public ActButton confirmButton;

	public ActButton cancelButton;

	public PowerBar powerBar;

	[Header("输入相关")]
	public ViewControlRoot viewControlRoot;

	public ViewControlLayer rewardViewControlLayer;

	public OperateBtnPrompt rewardBtnPrompt;

	public ViewControlLayer btnViewControlLayer;

	public GamePadTipsComp gamePadTipsComp;

	private QuickPowerExchangeItemViewData m_data;

	private ItemUnifierProxy _powerItem;

	private ItemUnifierProxy _exchangeItem;

	private ItemUnifierProxy _extraItem;

	private int _itemId;

	private long _powerCost;

	private bool _isExchanging;

	protected override void AddEventListener()
	{
		base.AddEventListener();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_PlayerAttribute_Refresh, OnPlayerAttributeChanged);
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_PlayerAttribute_Refresh, OnPlayerAttributeChanged);
	}

	protected override void Init()
	{
		base.Init();
		m_data = uiViewData as QuickPowerExchangeItemViewData;
		confirmButton?.SetBtnClick(ClickConfirmBtn);
		cancelButton?.SetBtnClick(ClickCancelBtn);
		RefreshExchangeItems();
	}

	protected override void ReInit()
	{
		base.ReInit();
		m_data = uiViewData as QuickPowerExchangeItemViewData;
		RefreshExchangeItems();
	}

	protected override void OnMoveToHide()
	{
		base.OnMoveToHide();
		Close();
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

	protected override void OnUnityDestroy()
	{
		ReleaseItemCellData();
		base.OnUnityDestroy();
	}

	private void OnPlayerAttributeChanged(BaseEventContent evt)
	{
		if (gameObject.activeInHierarchy && evt is PlayerAttributeChangeEvt { id: 96 } && _powerItem != null)
		{
			(exchangeStyle.powerItemCell?.NumberComponent)?.UpdateNumber(_powerItem.Count, Model<PowerModel>.Interface.PowerCount);
		}
	}

	private void RefreshExchangeItems()
	{
		ReleaseItemCellData();
		_itemId = 0;
		_powerCost = 0L;
		if (m_data != null && RefreshExchangeStyle(exchangeStyle, m_data.NeedItemId, m_data.NeedItemCount, ref _powerItem, ref _exchangeItem, out var powerCost))
		{
			_itemId = m_data.NeedItemId;
			_powerCost = powerCost;
		}
		if ((bool)needItemCountCell)
		{
			needItemCountCell.itemId = (PlayerAttribute)(m_data?.NeedItemId ?? 0);
			needItemCountCell.Init(m_data?.NeedItemCount ?? 0);
		}
		RefreshExtraItem(_powerCost);
		RefreshButtonState();
	}

	private bool RefreshExchangeStyle(PowerExchangeStyle itemViewStyle, int itemId, int itemCount, ref ItemUnifierProxy powerItem, ref ItemUnifierProxy exchangeItem, out long powerCost)
	{
		if (!Model<PowerModel>.Interface.TryGetPowerExchangePreview(itemId, itemCount, out var powerConvertItemId, out var _, out powerCost, out var exchangeCount))
		{
			return false;
		}
		powerItem = ItemUnifierProxy.ItemUnifierPool.Get<Item>(96, powerCost);
		itemViewStyle.powerItemCell?.SetData(powerItem, long.MinValue, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.OneSide);
		itemViewStyle.powerItemCell?.UpdatePerformance();
		itemViewStyle.powerItemCell?.NumberComponent.UpdateNumber(powerItem.Count, Model<PowerModel>.Interface.PowerCount);
		exchangeItem = ItemUnifierProxy.ItemUnifierPool.Get<Item>(itemId, exchangeCount);
		itemViewStyle.exchangeItemCell?.SetData(exchangeItem, long.MinValue, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.OneSide);
		itemViewStyle.exchangeItemCell?.UpdatePerformance();
		itemViewStyle.exchangeRatio?.SetText(Model<PowerModel>.Interface.GetPowerConvertRate(powerConvertItemId) + "%");
		return true;
	}

	private void RefreshExtraItem(long powerCost)
	{
		if (extraItemCell == null)
		{
			return;
		}
		extraItemCell.gameObject.SetActive(powerCost > 0);
		if (powerCost > 0)
		{
			int id = 93;
			long num = powerCost * 5;
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
		exchangeStyle.powerItemCell?.Release();
		exchangeStyle.exchangeItemCell?.Release();
		extraItemCell?.Release();
		ItemUnifierProxy.ItemUnifierPool.Release(ref _powerItem);
		ItemUnifierProxy.ItemUnifierPool.Release(ref _exchangeItem);
		ItemUnifierProxy.ItemUnifierPool.Release(ref _extraItem);
	}

	private void ClickConfirmBtn()
	{
		if (!_isExchanging && _powerCost > 0 && _powerCost <= int.MaxValue)
		{
			if (_powerCost > Model<PowerModel>.Interface.PowerCount)
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ADDPOWER, new TextPanel.Param());
				return;
			}
			_isExchanging = true;
			RefreshButtonState();
			RepeatedField<UniversalItem> rewards = new RepeatedField<UniversalItem>();
			ExchangeItem(rewards);
		}
	}

	private void ClickCancelBtn()
	{
		if (!_isExchanging)
		{
			Singleton<NewUIManager>.instance.CloseUI(UI_TYPE.UI_QUICKPOWEREXCHANGEITEM);
		}
	}

	private void ExchangeItem(RepeatedField<UniversalItem> rewards)
	{
		G.service.PowerExchangeItem(_itemId, (int)_powerCost, (bool success, RepeatedField<UniversalItem> items) =>
		{
			if (success && items != null)
			{
				rewards.Add(items);
			}
			FinishExchange(success, rewards);
		});
	}

	private void FinishExchange(bool isSuccess, RepeatedField<UniversalItem> rewards)
	{
		_isExchanging = false;
		RefreshExchangeItems();
		if (isSuccess)
		{
			Singleton<NewUIManager>.instance.CloseUI(UI_TYPE.UI_QUICKPOWEREXCHANGEITEM);
		}
		if (rewards.Count > 0)
		{
			GameUtility.OpenPopReward(rewards);
		}
	}

	private void RefreshButtonState()
	{
		bool active = !_isExchanging && _powerCost > 0 && _powerCost <= int.MaxValue;
		confirmButton?.Interactable(active);
		cancelButton?.Interactable(!_isExchanging);
	}
}
