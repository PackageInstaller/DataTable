using System;
using System.Collections.Generic;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.CommonComponent;
using ACT.UI.DataProxy;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class BattlePassBuyPremiumView : BaseUIView<BattlePassBuyPremiumViewInputController>
{
	private enum PayFocusTarget
	{
		Low,
		DiskGroup,
		High
	}

	private BattlePassBuyPremiumViewData m_data;

	private const string Show = "Show";

	[SerializeField]
	private ActButton _closeBtn;

	[SerializeField]
	private ActButton _buyPremiumBtn;

	[SerializeField]
	private ActButton _buyPremiumPlusBtn;

	[SerializeField]
	private ActButton _lowDiamondBtn;

	[SerializeField]
	private ActButton _highDiamondBtn;

	[SerializeField]
	private CommonPriceComponent _premiumCommonPriceComponent;

	[SerializeField]
	private CommonPriceComponent _premiumPlusCommonPriceComponent;

	[SerializeField]
	private ItemUIComponentBase[] _premiumRewardItemCells;

	[SerializeField]
	private ItemUIComponentBase[] _premiumPlusLevelRewardItemCells;

	[SerializeField]
	private ItemUIComponentBase[] _premiumPlusRewardItemCells;

	[SerializeField]
	private TextMeshProUGUI _premiumDiamondText;

	[SerializeField]
	private TextMeshProUGUI _premiumPlusDiamondText;

	[SerializeField]
	private LocalizeStringEvent _premiumBundleName;

	[SerializeField]
	private LocalizeStringEvent _premiumPlusBundleName;

	[SerializeField]
	private LocalizeStringEvent _premiumBundleDetailName;

	[SerializeField]
	private LocalizeStringEvent _premiumPlusBundleDetailName;

	[SerializeField]
	private CanvasGroup _premiumBundleOff;

	[SerializeField]
	private CanvasGroup _premiumPlusBundleOff;

	[SerializeField]
	private CanvasGroup _premiumBoughtCanvasGroup;

	[SerializeField]
	private CanvasGroup _premiumPlusBoughtCanvasGroup;

	[SerializeField]
	[Header("手柄提示组件")]
	private GamePadTipsComp _gamePadTipsComp;

	[SerializeField]
	[Header("切换大小BPLayer")]
	private ViewControlLayer _payLowHightLayer;

	[SerializeField]
	[Header("小BP奖励切换Layer")]
	private ViewControlLayer _LowRewardLayer;

	[SerializeField]
	[Header("大BP奖励切换Layer")]
	private ViewControlLayer _HighRewardLayer;

	[SerializeField]
	[Header("小BP聚焦SelectableEx")]
	private ACT.ViewControl.SelectableEx _premiumSelectableEx;

	[SerializeField]
	[Header("大BP聚焦SelectableEx")]
	private ACT.ViewControl.SelectableEx _premiumPlusSelectableEx;

	[SerializeField]
	[Header("磁盘组入口")]
	private ACT.ViewControl.SelectableEx _diskGroupSelectable;

	[SerializeField]
	[Header("购买小BP按钮手柄提示")]
	private OperateBtnPrompt _buyPremiumPrompt;

	[SerializeField]
	[Header("购买大BP按钮手柄提示")]
	private OperateBtnPrompt _buyPremiumPlusPrompt;

	[SerializeField]
	[Header("磁盘展示层")]
	private ViewControlLayer _diskShowLayer;

	[SerializeField]
	[Header("磁盘按钮，顺序为 Disk1 到 Disk5")]
	private ActButton[] _diskButtons;

	[SerializeField]
	private LocalizeStringEvent _diskShowText;

	private StringBuilder _premiumBundleOffSb;

	private StringBuilder _premiumPlusBundleOffSb;

	private readonly List<GamePadTipsAction> _gamePadTipsActions = new List<GamePadTipsAction>();

	private BattlePassBuyPremiumSubController _curSubControllerType;

	private PayFocusTarget _payFocusTarget;

	private const int DiskSlotCount = 5;

	private readonly int[] _diskItemIds = new int[5];

	private readonly BImage[] _diskIcons = new BImage[5];

	private const int FreeDiamond = 97;

	private const int DiskShowLocalized = 41000257;

	private void Awake()
	{
		_premiumBundleOffSb = new StringBuilder();
		_premiumPlusBundleOffSb = new StringBuilder();
		_closeBtn.SetBtnClick(Close);
		_buyPremiumBtn.SetBtnClick(BuyPremium);
		_buyPremiumPlusBtn.SetBtnClick(BuyPremiumPlus);
		_lowDiamondBtn.SetBtnClick(ShowLowFreeDiamondDetail);
		_highDiamondBtn.SetBtnClick(ShowHighFreeDiamondDetail);
		BindDiskButtons();
	}

	private void OnDestroy()
	{
		_closeBtn.OnClick.RemoveAllListeners();
		_buyPremiumBtn.OnClick.RemoveAllListeners();
		_buyPremiumPlusBtn.OnClick.RemoveAllListeners();
		_lowDiamondBtn.OnClick.RemoveAllListeners();
		_highDiamondBtn.OnClick.RemoveAllListeners();
		UnbindDiskButtons();
		PayModel payModel = Model<PayModel>.Interface;
		payModel.OnPaySuccess = (Action<string>)Delegate.Remove(payModel.OnPaySuccess, new Action<string>(BuyPremiumSuccessAction));
	}

	private void ShowLowFreeDiamondDetail()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, new Item
		{
			Id = 97,
			Count = Model<BattlePassModel>.Interface.PremiumBundleItem
		});
	}

	private void ShowHighFreeDiamondDetail()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, new Item
		{
			Id = 97,
			Count = Model<BattlePassModel>.Interface.PremiumPlusBundleItem
		});
	}

	private void BuyPremium()
	{
		if (Model<BattlePassModel>.Interface.BattlePassPayLevel == BattlePassPayLevel.BattlePassPayNull)
		{
			Model<PayModel>.Interface.SendOrder(8001001, 0);
		}
	}

	private void BuyPremiumPlus()
	{
		if (Model<BattlePassModel>.Interface.BattlePassPayLevel != BattlePassPayLevel.BattlePassPayHigh)
		{
			int commodityId = ((Model<BattlePassModel>.Interface.BattlePassPayLevel == BattlePassPayLevel.BattlePassPayLow) ? 8001002 : 8001003);
			Model<PayModel>.Interface.SendOrder(commodityId, 0);
		}
	}

	protected override void Init()
	{
		base.Init();
		for (int i = 0; i < Model<BattlePassModel>.Interface.PayItems.Count; i++)
		{
			ItemKv itemKv = Model<BattlePassModel>.Interface.PayItems[i];
			LiteItemUIComponent liteItemUIComponent = _premiumRewardItemCells[i] as LiteItemUIComponent;
			LiteItemUIComponent liteItemUIComponent2 = _premiumPlusRewardItemCells[i] as LiteItemUIComponent;
			ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(itemKv.id, itemKv.count);
			if (liteItemUIComponent != null)
			{
				liteItemUIComponent.SetData(item, long.MinValue, ItemUIComponentBase.InitType.RewardItem, ItemUIComponentBase.ItemCountShowType.OneSide);
				liteItemUIComponent.UpdatePerformance();
			}
			if (liteItemUIComponent2 != null)
			{
				liteItemUIComponent2.SetData(item, long.MinValue, ItemUIComponentBase.InitType.RewardItem, ItemUIComponentBase.ItemCountShowType.OneSide);
				liteItemUIComponent2.UpdatePerformance();
			}
		}
		for (int j = 0; j < Model<BattlePassModel>.Interface.PayUpItems.Count; j++)
		{
			ItemKv itemKv2 = Model<BattlePassModel>.Interface.PayUpItems[j];
			LiteItemUIComponent liteItemUIComponent3 = _premiumPlusLevelRewardItemCells[j] as LiteItemUIComponent;
			ItemUnifierProxy item2 = ItemUnifierProxy.ItemUnifierPool.Get<Item>(itemKv2.id, itemKv2.count);
			if (liteItemUIComponent3 != null)
			{
				liteItemUIComponent3.SetData(item2, long.MinValue, ItemUIComponentBase.InitType.RewardItem, ItemUIComponentBase.ItemCountShowType.OneSide);
				liteItemUIComponent3.UpdatePerformance();
			}
		}
		_premiumBundleName.SetTable("shortcommon");
		_premiumBundleName.StringReference.TableEntryReference = Model<BattlePassModel>.Interface.PremiumBundleName;
		_premiumPlusBundleName.SetTable("shortcommon");
		_premiumPlusBundleName.StringReference.TableEntryReference = Model<BattlePassModel>.Interface.PremiumPlusBundleName;
		_premiumBundleDetailName.SetTable("longcommon");
		_premiumBundleDetailName.StringReference.TableEntryReference = Model<BattlePassModel>.Interface.PremiumBundleDetailName;
		_premiumPlusBundleDetailName.SetTable("longcommon");
		_premiumPlusBundleDetailName.StringReference.TableEntryReference = Model<BattlePassModel>.Interface.PremiumPlusBundleDetailName;
		UpdateBundleOff();
		UpdateBoughtText();
		UpdateBuyBtnInteract();
		UpdateDiscount();
		_premiumDiamondText.SetText("{0:0}", Model<BattlePassModel>.Interface.PremiumBundleItem);
		_premiumPlusDiamondText.SetText("{0:0}", Model<BattlePassModel>.Interface.PremiumPlusBundleItem);
		RefreshDiskItems();
		_curSubControllerType = BattlePassBuyPremiumSubController.PayLowHigh;
		ChangeSubControllerType(BattlePassBuyPremiumSubController.PayLowHigh);
		RefreshGamePadTipsStatus(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
		_diskShowText.SetTable("Common");
		_diskShowText.StringReference.TableEntryReference = 41000257L;
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		RefreshGamePadTipsStatus(type == DeviceInputMode.Gamepad);
		RefreshBuyPromptVisibility();
		if (type == DeviceInputMode.Gamepad)
		{
			GetControlLayer(_curSubControllerType)?.Focus();
		}
	}

	private void RefreshGamePadTipsStatus(bool isGamePad)
	{
		if (!(_gamePadTipsComp == null))
		{
			_gamePadTipsComp.gameObject.SetActive(isGamePad);
		}
	}

	private void RefreshGamePadTips()
	{
		if (_gamePadTipsComp == null)
		{
			return;
		}
		_gamePadTipsComp.ClearAllPrompts();
		_gamePadTipsActions.Clear();
		_gamePadTipsActions.Add(new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeKey = 606,
			localizeTable = "Common"
		});
		if (_curSubControllerType == BattlePassBuyPremiumSubController.PayLowHigh)
		{
			if (_payFocusTarget == PayFocusTarget.DiskGroup)
			{
				_gamePadTipsActions.Add(new GamePadTipsAction
				{
					inputAction = "UI/SelectItemCell",
					localizeKey = 774,
					localizeTable = "Common"
				});
			}
			else
			{
				_gamePadTipsActions.Add(new GamePadTipsAction
				{
					inputAction = "UI/UISpecial5",
					localizeKey = 2164,
					localizeTable = "Common"
				});
			}
		}
		else if (_curSubControllerType == BattlePassBuyPremiumSubController.Disk)
		{
			_gamePadTipsActions.Add(new GamePadTipsAction
			{
				inputAction = "UI/Confirm",
				localizeKey = 2164,
				localizeTable = "Common"
			});
		}
		_gamePadTipsComp.RegisterInputActions(_gamePadTipsActions);
	}

	private void BuyPremiumSuccessAction(string orderId)
	{
		UpdateBundleOff();
		UpdateBoughtText();
		UpdateBuyBtnInteract();
		UpdateDiscount();
	}

	private void UpdateBundleOff()
	{
		if (Model<BattlePassModel>.Interface.BattlePassPayLevel == BattlePassPayLevel.BattlePassPayNull)
		{
			TextMeshProUGUI componentInChildren = _premiumBundleOff.GetComponentInChildren<TextMeshProUGUI>();
			_premiumBundleOffSb.Clear();
			componentInChildren.text = _premiumBundleOffSb.Append(Model<BattlePassModel>.Interface.PremiumBundleOff).Append("%").ToString();
			TextMeshProUGUI componentInChildren2 = _premiumPlusBundleOff.GetComponentInChildren<TextMeshProUGUI>();
			_premiumPlusBundleOffSb.Clear();
			componentInChildren2.text = _premiumPlusBundleOffSb.Append(Model<BattlePassModel>.Interface.PremiumPlusBundleOff).Append("%").ToString();
		}
		_premiumBundleOff.alpha = ((Model<BattlePassModel>.Interface.BattlePassPayLevel == BattlePassPayLevel.BattlePassPayNull) ? 1 : 0);
		_premiumPlusBundleOff.alpha = ((Model<BattlePassModel>.Interface.BattlePassPayLevel == BattlePassPayLevel.BattlePassPayNull) ? 1 : 0);
	}

	private void UpdateBoughtText()
	{
		_premiumBoughtCanvasGroup.alpha = ((Model<BattlePassModel>.Interface.BattlePassPayLevel != BattlePassPayLevel.BattlePassPayNull) ? 1 : 0);
		_premiumPlusBoughtCanvasGroup.alpha = ((Model<BattlePassModel>.Interface.BattlePassPayLevel == BattlePassPayLevel.BattlePassPayHigh) ? 1 : 0);
	}

	private void UpdateBuyBtnInteract()
	{
		_buyPremiumBtn.Interactable(Model<BattlePassModel>.Interface.BattlePassPayLevel == BattlePassPayLevel.BattlePassPayNull);
		_buyPremiumPlusBtn.Interactable(Model<BattlePassModel>.Interface.BattlePassPayLevel != BattlePassPayLevel.BattlePassPayHigh);
	}

	private void UpdateDiscount()
	{
		_premiumCommonPriceComponent.gameObject.SetActive(Model<BattlePassModel>.Interface.BattlePassPayLevel == BattlePassPayLevel.BattlePassPayNull);
		_premiumCommonPriceComponent.Init(Model<PayModel>.Interface.GetPrice(8001001));
		_premiumPlusCommonPriceComponent.gameObject.SetActive(Model<BattlePassModel>.Interface.BattlePassPayLevel != BattlePassPayLevel.BattlePassPayHigh);
		if (Model<BattlePassModel>.Interface.BattlePassPayLevel == BattlePassPayLevel.BattlePassPayNull)
		{
			int preprice = CoreUtils.GetData(8001003, RuntimeConfigs.data.battlepayPasss).preprice;
			_premiumPlusCommonPriceComponent.Init(Model<PayModel>.Interface.GetPrice(8001003), preprice.FastToString());
		}
		else if (Model<BattlePassModel>.Interface.BattlePassPayLevel == BattlePassPayLevel.BattlePassPayLow)
		{
			_premiumPlusCommonPriceComponent.Init(Model<PayModel>.Interface.GetPrice(8001002));
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	internal void ChangeSubControllerType(BattlePassBuyPremiumSubController subControllerType)
	{
		BattlePassBuyPremiumSubController curSubControllerType = _curSubControllerType;
		_curSubControllerType = subControllerType;
		GetController()?.SetSubControllerType(subControllerType);
		if (MonoECS.instance.InputMode != DeviceInputMode.TouchScreen)
		{
			RefreshControlLayerDefaultSelect(subControllerType, curSubControllerType);
			RefreshBuyPromptVisibility();
			RefreshGamePadTips();
			GetControlLayer(subControllerType)?.Focus();
		}
	}

	internal void EnterRewardForCurrentFocus()
	{
		if (IsPayTierFocused())
		{
			if (_payFocusTarget == PayFocusTarget.High)
			{
				ChangeSubControllerType(BattlePassBuyPremiumSubController.HighReward);
			}
			else
			{
				ChangeSubControllerType(BattlePassBuyPremiumSubController.LowReward);
			}
		}
	}

	private void RefreshControlLayerDefaultSelect(BattlePassBuyPremiumSubController current, BattlePassBuyPremiumSubController previous)
	{
		if (current == BattlePassBuyPremiumSubController.PayLowHigh)
		{
			RefreshPayLowHighDefaultSelect(previous);
		}
	}

	private void RefreshPayLowHighDefaultSelect(BattlePassBuyPremiumSubController previousType)
	{
		if (!(_payLowHightLayer == null))
		{
			ACT.ViewControl.SelectableEx selectableEx = previousType switch
			{
				BattlePassBuyPremiumSubController.LowReward => _premiumSelectableEx, 
				BattlePassBuyPremiumSubController.HighReward => _premiumPlusSelectableEx, 
				BattlePassBuyPremiumSubController.Disk => GetVisibleDiskGroupSelectable() ?? GetInitialPayFocusSelectable(), 
				_ => GetInitialPayFocusSelectable(), 
			};
			ApplyPayFocusTarget(selectableEx);
			if (selectableEx != null)
			{
				_payLowHightLayer.SetDefaultSelect(selectableEx);
			}
		}
	}

	private ACT.ViewControl.SelectableEx GetInitialPayFocusSelectable()
	{
		if (Model<BattlePassModel>.Interface.BattlePassPayLevel == BattlePassPayLevel.BattlePassPayLow)
		{
			return _premiumPlusSelectableEx;
		}
		return _premiumSelectableEx;
	}

	private bool RefreshRewardDefaultSelect(ViewControlLayer layer, ItemUIComponentBase[] items)
	{
		if (layer == null || items == null || items.Length == 0)
		{
			return false;
		}
		for (int i = 0; i < items.Length; i++)
		{
			if (!(items[i] == null))
			{
				ACT.ViewControl.SelectableEx componentInChildren = items[i].GetComponentInChildren<ACT.ViewControl.SelectableEx>(includeInactive: true);
				if (componentInChildren != null)
				{
					layer.SetDefaultSelect(componentInChildren);
					return true;
				}
			}
		}
		return false;
	}

	public void OnConfirmBuyBtn()
	{
		if (_payFocusTarget == PayFocusTarget.Low)
		{
			BuyPremium();
		}
		else if (_payFocusTarget == PayFocusTarget.High)
		{
			BuyPremiumPlus();
		}
	}

	private ViewControlLayer GetControlLayer(BattlePassBuyPremiumSubController subControllerType)
	{
		return subControllerType switch
		{
			BattlePassBuyPremiumSubController.LowReward => _LowRewardLayer, 
			BattlePassBuyPremiumSubController.HighReward => _HighRewardLayer, 
			BattlePassBuyPremiumSubController.Disk => _diskShowLayer, 
			_ => _payLowHightLayer, 
		};
	}

	internal void OnPayLayerFocusChanged()
	{
		if (_curSubControllerType == BattlePassBuyPremiumSubController.PayLowHigh)
		{
			ACT.ViewControl.SelectableEx selectableEx = _payLowHightLayer?.LastSelect;
			if (selectableEx == _premiumSelectableEx || selectableEx == _premiumPlusSelectableEx || selectableEx == _diskGroupSelectable)
			{
				ApplyPayFocusTarget(selectableEx);
			}
			RefreshBuyPromptVisibility();
			RefreshGamePadTips();
		}
	}

	private void RefreshBuyPromptVisibility()
	{
		bool flag = _curSubControllerType == BattlePassBuyPremiumSubController.PayLowHigh && MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
		_buyPremiumPrompt?.SetVisible(flag && _payFocusTarget == PayFocusTarget.Low && _buyPremiumBtn.interactable);
		_buyPremiumPlusPrompt?.SetVisible(flag && _payFocusTarget == PayFocusTarget.High && _buyPremiumPlusBtn.interactable);
	}

	internal bool IsPayTierFocused()
	{
		if (_payFocusTarget != PayFocusTarget.Low)
		{
			return _payFocusTarget == PayFocusTarget.High;
		}
		return true;
	}

	internal bool TryMovePayFocus(MoveDirection dir)
	{
		if (_curSubControllerType != BattlePassBuyPremiumSubController.PayLowHigh || _payLowHightLayer == null)
		{
			return false;
		}
		if (dir != MoveDirection.Left && dir != MoveDirection.Right)
		{
			return false;
		}
		ACT.ViewControl.SelectableEx selectableEx = _payLowHightLayer.LastSelect ?? GetPaySelectable(_payFocusTarget);
		bool flag = dir == MoveDirection.Right;
		ACT.ViewControl.SelectableEx selectableEx2 = null;
		if (selectableEx == _premiumSelectableEx)
		{
			selectableEx2 = (flag ? (GetVisibleDiskGroupSelectable() ?? _premiumPlusSelectableEx) : null);
		}
		else if (selectableEx == _diskGroupSelectable)
		{
			selectableEx2 = (flag ? _premiumPlusSelectableEx : _premiumSelectableEx);
		}
		else
		{
			if (!(selectableEx == _premiumPlusSelectableEx))
			{
				return false;
			}
			selectableEx2 = (flag ? null : (GetVisibleDiskGroupSelectable() ?? _premiumSelectableEx));
		}
		if (selectableEx2 == null || selectableEx2 == selectableEx)
		{
			return true;
		}
		FocusPaySelectable(selectableEx2);
		return true;
	}

	internal bool TryEnterDiskLayer()
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.TouchScreen)
		{
			return false;
		}
		if (_curSubControllerType != BattlePassBuyPremiumSubController.PayLowHigh || _payFocusTarget != PayFocusTarget.DiskGroup || !HasVisibleDisk())
		{
			return false;
		}
		ChangeSubControllerType(BattlePassBuyPremiumSubController.Disk);
		return true;
	}

	private void FocusPaySelectable(ACT.ViewControl.SelectableEx selectable)
	{
		if (!(selectable == null) && !(_payLowHightLayer == null))
		{
			ApplyPayFocusTarget(selectable);
			_payLowHightLayer.SetDefaultSelect(selectable);
			if (MonoECS.instance.InputMode != DeviceInputMode.TouchScreen)
			{
				_payLowHightLayer.Focus();
			}
			RefreshBuyPromptVisibility();
			RefreshGamePadTips();
		}
	}

	private ACT.ViewControl.SelectableEx GetPaySelectable(PayFocusTarget target)
	{
		return target switch
		{
			PayFocusTarget.High => _premiumPlusSelectableEx, 
			PayFocusTarget.DiskGroup => _diskGroupSelectable, 
			_ => _premiumSelectableEx, 
		};
	}

	private void ApplyPayFocusTarget(ACT.ViewControl.SelectableEx selectable)
	{
		if (selectable == _premiumPlusSelectableEx)
		{
			_payFocusTarget = PayFocusTarget.High;
		}
		else if (selectable != null && selectable == _diskGroupSelectable)
		{
			_payFocusTarget = PayFocusTarget.DiskGroup;
		}
		else
		{
			_payFocusTarget = PayFocusTarget.Low;
		}
	}

	private ACT.ViewControl.SelectableEx GetVisibleDiskGroupSelectable()
	{
		if (_diskGroupSelectable == null || !_diskGroupSelectable.gameObject.activeSelf || !HasVisibleDisk())
		{
			return null;
		}
		return _diskGroupSelectable;
	}

	private void BindDiskButtons()
	{
		if (_diskButtons == null)
		{
			return;
		}
		for (int i = 0; i < _diskButtons.Length && i < 5; i++)
		{
			ActButton actButton = _diskButtons[i];
			if (!(actButton == null))
			{
				int index = i;
				actButton.SetBtnClick(() =>
				{
					ShowDiskItemDetail(index);
				});
			}
		}
	}

	private void UnbindDiskButtons()
	{
		if (_diskButtons == null)
		{
			return;
		}
		for (int i = 0; i < _diskButtons.Length; i++)
		{
			if (_diskButtons[i] != null)
			{
				_diskButtons[i].OnClick.RemoveAllListeners();
			}
		}
	}

	private void RefreshDiskItems()
	{
		int[] gemItems = Model<BattlePassModel>.Interface.GemItems;
		for (int i = 0; i < 5; i++)
		{
			ActButton diskButton = GetDiskButton(i);
			int num = ((gemItems != null && i < gemItems.Length) ? gemItems[i] : 0);
			ItemData itemData = ((num > 0) ? CoreUtils.GetData(num, RuntimeConfigs.data.itemDatas) : null);
			bool flag = diskButton != null && itemData != null && itemData.iconAddress > 0;
			_diskItemIds[i] = (flag ? num : 0);
			if (diskButton == null)
			{
				continue;
			}
			diskButton.gameObject.SetActive(flag);
			if (flag)
			{
				BImage diskIcon = GetDiskIcon(i, diskButton);
				if (diskIcon?.icon == null)
				{
					_diskItemIds[i] = 0;
					diskButton.gameObject.SetActive(value: false);
				}
				else
				{
					Station?.LoadImage(253, num, diskIcon);
				}
			}
		}
		RefreshDiskGroupHandle();
		RefreshDiskDefaultSelect();
	}

	private void RefreshDiskGroupHandle()
	{
		if (!(_diskGroupSelectable == null))
		{
			_diskGroupSelectable.gameObject.SetActive(HasVisibleDisk());
		}
	}

	private ActButton GetDiskButton(int index)
	{
		if (_diskButtons == null || index < 0 || index >= _diskButtons.Length)
		{
			return null;
		}
		return _diskButtons[index];
	}

	private BImage GetDiskIcon(int index, ActButton button)
	{
		if (_diskIcons[index] != null)
		{
			return _diskIcons[index];
		}
		Image component = button.GetComponent<Image>();
		if (component == null)
		{
			return null;
		}
		_diskIcons[index] = new BImage
		{
			icon = component
		};
		return _diskIcons[index];
	}

	private void RefreshDiskDefaultSelect()
	{
		ACT.ViewControl.SelectableEx diskSelectable = GetDiskSelectable(0, 1);
		if (diskSelectable != null)
		{
			_diskShowLayer?.SetDefaultSelect(diskSelectable);
		}
	}

	internal bool TryMoveDiskFocus(MoveDirection dir)
	{
		if (_curSubControllerType != BattlePassBuyPremiumSubController.Disk || _diskShowLayer == null)
		{
			return false;
		}
		if (dir != MoveDirection.Up && dir != MoveDirection.Down)
		{
			return false;
		}
		int num = ((dir == MoveDirection.Down) ? 1 : (-1));
		int currentDiskIndex = GetCurrentDiskIndex();
		int num2;
		if (currentDiskIndex >= 0)
		{
			num2 = currentDiskIndex;
		}
		else
		{
			num2 = ((num > 0) ? (-1) : 5);
		}
		ACT.ViewControl.SelectableEx diskSelectable = GetDiskSelectable(num2 + num, num);
		if (diskSelectable == null)
		{
			return true;
		}
		_diskShowLayer.SetDefaultSelect(diskSelectable);
		if (MonoECS.instance.InputMode != DeviceInputMode.TouchScreen)
		{
			_diskShowLayer.Focus();
		}
		return true;
	}

	private int GetCurrentDiskIndex()
	{
		ACT.ViewControl.SelectableEx selectableEx = ((_diskShowLayer != null) ? _diskShowLayer.LastSelect : null);
		if (selectableEx == null)
		{
			return -1;
		}
		for (int i = 0; i < 5; i++)
		{
			if (GetDiskButton(i)?.GetComponent<ACT.ViewControl.SelectableEx>() == selectableEx)
			{
				return i;
			}
		}
		return -1;
	}

	private ACT.ViewControl.SelectableEx GetDiskSelectable(int start, int step)
	{
		if (step == 0)
		{
			return null;
		}
		for (int i = start; i >= 0 && i < 5; i += step)
		{
			if (_diskItemIds[i] > 0)
			{
				ACT.ViewControl.SelectableEx selectableEx = GetDiskButton(i)?.GetComponent<ACT.ViewControl.SelectableEx>();
				if (selectableEx != null && selectableEx.IsValid())
				{
					return selectableEx;
				}
			}
		}
		return null;
	}

	internal bool HasVisibleDisk()
	{
		for (int i = 0; i < _diskItemIds.Length; i++)
		{
			if (_diskItemIds[i] > 0)
			{
				return true;
			}
		}
		return false;
	}

	private void ShowDiskItemDetail(int index)
	{
		if ((uint)index < (uint)_diskItemIds.Length)
		{
			int num = _diskItemIds[index];
			if (num > 0)
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, new Item
				{
					Id = num,
					Count = 1
				});
			}
		}
	}

	protected override void AddEventListener()
	{
		base.AddEventListener();
		PayModel payModel = Model<PayModel>.Interface;
		payModel.OnPaySuccess = (Action<string>)Delegate.Combine(payModel.OnPaySuccess, new Action<string>(BuyPremiumSuccessAction));
	}

	protected override void RemoveEventListener()
	{
		PayModel payModel = Model<PayModel>.Interface;
		payModel.OnPaySuccess = (Action<string>)Delegate.Remove(payModel.OnPaySuccess, new Action<string>(BuyPremiumSuccessAction));
		base.RemoveEventListener();
	}
}
