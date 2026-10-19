using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using ACT.Battle;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.UI.CommonComponent;
using Runtime.UI.CommonComponent.CommonScrollBag;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.Pool;
using UnityEngine.UI;

namespace ACT.UI;

public class PopUpBattlePassBuyLevelView : BaseUIView<BattlePassBuyLevelViewInputController>
{
	[Serializable]
	private class SubControllerOperatePromptHideConfig
	{
		public BattlePassBuyLevelViewSubControllerType subControllerType;

		public List<OperateBtnPrompt> operateBtnPrompts;
	}

	private PopUpBattlePassBuyLevelViewData m_data;

	[SerializeField]
	[Header("通用底板动画")]
	private BetterAnimation _commonBgAnimation;

	[SerializeField]
	[Header("右上角钻石显示组件")]
	private CommonCoinComponent _rightTopcoinComponent;

	[SerializeField]
	[Header("奖励滚动列表")]
	private CommonScrollBagComponent _scrollBagComponent;

	[SerializeField]
	[Header("关闭按钮")]
	private ActButton _closeBtn;

	[SerializeField]
	[Header("增加减少数量按钮")]
	private ActButton _reduceBtn;

	[SerializeField]
	[Header("增加数量按钮")]
	private ActButton _addBtn;

	[SerializeField]
	[Header("MAX按钮")]
	private ActButton _maxBtn;

	[SerializeField]
	[Header("确认按钮")]
	private ActButton _confirmBtn;

	[SerializeField]
	[Header("取消按钮")]
	private ActButton _cancelBtn;

	[SerializeField]
	[Header("滑动条")]
	private LimitedSlider _limitedSlider;

	[SerializeField]
	[Header("购买等级文本本地化")]
	private LocalizeStringEvent _buyLocalizeString;

	[SerializeField]
	[Header("购买等级文本")]
	private TextMeshProUGUI _buyCountText;

	[SerializeField]
	[Header("消耗钻石显示组件")]
	private CommonCoinComponent _coinComponent;

	[SerializeField]
	[Header("可购买等级最小值文本")]
	private TextMeshProUGUI _minValueText;

	[SerializeField]
	[Header("可购买等级最大值文本")]
	private TextMeshProUGUI _maxValueText;

	[SerializeField]
	private RectTransform _rewardCell;

	[SerializeField]
	private RectTransform _scrollView;

	[SerializeField]
	private RectTransform _content;

	[SerializeField]
	private ViewControlLayer _mainViewControlLayer;

	[SerializeField]
	private ViewControlLayer _rewardViewControlLayer;

	[SerializeField]
	private List<SubControllerOperatePromptHideConfig> _subControllerOperatePromptHideConfigs = new List<SubControllerOperatePromptHideConfig>();

	[SerializeField]
	private List<GameObject> _hideInGamePadModeObjects = new List<GameObject>();

	private float _scrollViewMaxWitch;

	private const int MinValue = 1;

	private const int FreeDiamond = 97;

	private const string Show = "Show";

	private const string Hide = "Hide";

	private int _buyCount;

	private BattlePassBuyLevelViewSubControllerType _curSubControllerType;

	private List<ItemUnifierProxy> _previewRewardList;

	public ViewControlLayer ViewControlLayer => _mainViewControlLayer;

	public ViewControlLayer RewardViewControlLayer => _rewardViewControlLayer;

	public int BuyCount
	{
		get
		{
			return _buyCount;
		}
		set
		{
			if (_buyCount != value)
			{
				_buyCount = value;
				OnRefresh(value);
			}
		}
	}

	private void Awake()
	{
		_scrollViewMaxWitch = _scrollView.sizeDelta.x;
	}

	protected override void AddEventListener()
	{
		base.AddEventListener();
		_closeBtn.SetBtnClick(CloseViewAction);
		_cancelBtn.SetBtnClick(CancelAction);
		_confirmBtn.SetBtnClick(ConfirmAction);
		_reduceBtn.SetBtnClick(ReduceAction);
		_addBtn.SetBtnClick(AddAction);
		_maxBtn.SetBtnClick(MaxAction);
		_limitedSlider.onValueChanged.AddListener(OnSliderValueChanged);
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
		_closeBtn.OnClick.RemoveAllListeners();
		_cancelBtn.OnClick.RemoveAllListeners();
		_confirmBtn.OnClick.RemoveAllListeners();
		_reduceBtn.OnClick.RemoveAllListeners();
		_addBtn.OnClick.RemoveAllListeners();
		_maxBtn.OnClick.RemoveAllListeners();
		_limitedSlider.onValueChanged.RemoveAllListeners();
	}

	private void CloseViewAction()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Return_Click");
		Close();
	}

	private void CancelAction()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Button_Click");
		Close();
	}

	private void ConfirmAction()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Button_Click");
		int itemCount = G.localPlayer.Inventory.GetItemCount(97);
		int num = _buyCount * Model<BattlePassModel>.Interface.ExpBuyCount;
		if (itemCount >= num)
		{
			Model<BattlePassModel>.Interface.BuyLevelReq(_buyCount, (bool b) =>
			{
				Close();
			});
		}
		else
		{
			Model<PayModel>.Interface.JumpToExchangeFreeDiamond(num - itemCount);
			Close();
		}
	}

	private void ReduceAction()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Store/Number");
		if (_buyCount > 1)
		{
			BuyCount--;
		}
	}

	private void AddAction()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Store/Number");
		if (_buyCount < Model<BattlePassModel>.Interface.CanBuyMaxLevel)
		{
			BuyCount++;
		}
	}

	private void MaxAction()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Store/Number");
		BuyCount = Model<BattlePassModel>.Interface.CanBuyMaxLevel;
	}

	internal void SetBuyCountToMaxByGamePad()
	{
		MaxAction();
	}

	internal void AddBuyCountByGamePad()
	{
		AddAction();
	}

	internal void ReduceBuyCountByGamePad()
	{
		ReduceAction();
	}

	private void OnSliderValueChanged(float value)
	{
		BuyCount = (int)value;
	}

	private void OnRefresh(int buyCount)
	{
		int costNum = buyCount * Model<BattlePassModel>.Interface.ExpBuyCount;
		_limitedSlider.SetValueWithoutNotify(buyCount);
		_minValueText.SetText("{0:0}", 1f);
		_maxValueText.SetText("{0:0}", Model<BattlePassModel>.Interface.CanBuyMaxLevel);
		_buyCountText.SetText("{0:0}", buyCount);
		_addBtn.Interactable(buyCount < Model<BattlePassModel>.Interface.CanBuyMaxLevel);
		_reduceBtn.Interactable(buyCount > 1);
		_maxBtn.Interactable(buyCount != Model<BattlePassModel>.Interface.CanBuyMaxLevel);
		int value = Model<BattlePassModel>.Interface.CurrentLevel + buyCount;
		_buyLocalizeString.StringReference.GetVariable<int>(0.ToString()).Value = value;
		_coinComponent.Init(costNum);
		CollectPreviewRewards();
	}

	private void CollectPreviewRewards()
	{
		ItemUnifierProxy.ItemUnifierPool.Release(_previewRewardList);
		_previewRewardList.Clear();
		BattlePassModel battlePassModel = Model<BattlePassModel>.Interface;
		int currentLevel = battlePassModel.CurrentLevel;
		int num = currentLevel + _buyCount;
		Dictionary<int, long> dictionary = CollectionPool<Dictionary<int, long>, KeyValuePair<int, long>>.Get();
		for (int i = currentLevel + 1; i <= num; i++)
		{
			BattlePassReward freeReward = battlePassModel.GetFreeReward(i);
			if (freeReward != null)
			{
				foreach (var (key, num2) in freeReward.RewardItems)
				{
					if (dictionary.TryGetValue(key, out var value))
					{
						dictionary[key] = value + num2;
					}
					else
					{
						dictionary[key] = num2;
					}
				}
			}
			if (battlePassModel.BattlePassPayLevel == BattlePassPayLevel.BattlePassPayNull)
			{
				continue;
			}
			BattlePassReward premiumReward = battlePassModel.GetPremiumReward(i);
			if (premiumReward == null)
			{
				continue;
			}
			foreach (var (key2, num3) in premiumReward.RewardItems)
			{
				if (dictionary.TryGetValue(key2, out var value2))
				{
					dictionary[key2] = value2 + num3;
				}
				else
				{
					dictionary[key2] = num3;
				}
			}
		}
		foreach (var (id, count) in dictionary)
		{
			ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(id, count);
			_previewRewardList.Add(item);
		}
		CollectionPool<Dictionary<int, long>, KeyValuePair<int, long>>.Release(dictionary);
		_previewRewardList.Sort((ItemUnifierProxy left, ItemUnifierProxy right) => right.Quality.CompareTo(left.Quality));
		_scrollBagComponent.ItemSource = _previewRewardList;
		float num6 = _rewardCell.rect.width;
		LayoutElement component = _rewardCell.GetComponent<LayoutElement>();
		if (component != null)
		{
			num6 = component.preferredWidth;
		}
		int num7 = _scrollBagComponent.ItemSource.Count();
		HorizontalLayoutGroup component2 = _content.GetComponent<HorizontalLayoutGroup>();
		float a = (float)num7 * num6 + (float)(num7 - 1) * component2.spacing + (float)component2.padding.left + (float)component2.padding.right;
		_scrollView.sizeDelta = new Vector2(Mathf.Min(a, _scrollViewMaxWitch), _scrollView.sizeDelta.y);
		_scrollBagComponent.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
		_scrollBagComponent.ForceUpdatePerformance();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		_previewRewardList = CollectionPool<List<ItemUnifierProxy>, ItemUnifierProxy>.Get();
		_limitedSlider.minValue = 1f;
		int canBuyMaxLevel = Model<BattlePassModel>.Interface.CanBuyMaxLevel;
		_limitedSlider.maxValue = canBuyMaxLevel;
		_limitedSlider.limit = canBuyMaxLevel;
		_buyCount = 1;
		ChangeSubControllerType(BattlePassBuyLevelViewSubControllerType.Main);
		RefreshGamePadModeHiddenObjects(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
	}

	protected override void Init()
	{
		base.Init();
		OnRefresh(_buyCount);
	}

	internal void OpenSupplementView()
	{
		_rightTopcoinComponent.supplementBtn.OnClick?.Invoke();
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		RefreshGamePadModeHiddenObjects(type == DeviceInputMode.Gamepad);
	}

	internal void ChangeSubControllerType(BattlePassBuyLevelViewSubControllerType subControllerType)
	{
		_curSubControllerType = subControllerType;
		GetController()?.SetBattlePassBuyLevelViewSubControllerType(subControllerType);
		if (MonoECS.instance.InputMode != DeviceInputMode.TouchScreen)
		{
			RefreshSubControllerOperateBtnPrompts(subControllerType);
			RefreshControlLayerDefaultSelect(subControllerType);
			GetControlLayer(subControllerType)?.Focus();
		}
	}

	private void RefreshControlLayerDefaultSelect(BattlePassBuyLevelViewSubControllerType subControllerType)
	{
		if (subControllerType == BattlePassBuyLevelViewSubControllerType.Main)
		{
			RefreshMainControlLayerDefaultSelect();
		}
		else
		{
			RefreshRewardControlLayerDefaultSelect();
		}
	}

	private void RefreshMainControlLayerDefaultSelect()
	{
		if (!(_mainViewControlLayer == null))
		{
			ACT.ViewControl.SelectableEx selectableEx = ((_confirmBtn != null) ? _confirmBtn.GetComponentInChildren<ACT.ViewControl.SelectableEx>(includeInactive: true) : null);
			if (selectableEx != null)
			{
				_mainViewControlLayer.SetDefaultSelect(selectableEx);
			}
		}
	}

	private void RefreshRewardControlLayerDefaultSelect()
	{
		if (_rewardViewControlLayer == null)
		{
			return;
		}
		List<ItemUnifierProxy> list = _scrollBagComponent?.ItemSource?.ToList();
		if (list == null || list.Count == 0)
		{
			return;
		}
		SelectRewardAtIndex(0, list);
		if (list[0].Context is ItemUIComponentBase itemUIComponentBase)
		{
			ACT.ViewControl.SelectableEx componentInChildren = itemUIComponentBase.GetComponentInChildren<ACT.ViewControl.SelectableEx>(includeInactive: true);
			if (componentInChildren != null)
			{
				_rewardViewControlLayer.SetDefaultSelect(componentInChildren);
			}
		}
	}

	private void RefreshSubControllerOperateBtnPrompts(BattlePassBuyLevelViewSubControllerType subControllerType)
	{
		if (_subControllerOperatePromptHideConfigs == null || _subControllerOperatePromptHideConfigs.Count == 0)
		{
			return;
		}
		HashSet<OperateBtnPrompt> hashSet = new HashSet<OperateBtnPrompt>();
		HashSet<OperateBtnPrompt> hashSet2 = new HashSet<OperateBtnPrompt>();
		foreach (SubControllerOperatePromptHideConfig subControllerOperatePromptHideConfig in _subControllerOperatePromptHideConfigs)
		{
			if (subControllerOperatePromptHideConfig?.operateBtnPrompts == null)
			{
				continue;
			}
			foreach (OperateBtnPrompt operateBtnPrompt in subControllerOperatePromptHideConfig.operateBtnPrompts)
			{
				if (!(operateBtnPrompt == null))
				{
					hashSet.Add(operateBtnPrompt);
					if (subControllerOperatePromptHideConfig.subControllerType == subControllerType)
					{
						hashSet2.Add(operateBtnPrompt);
					}
				}
			}
		}
		foreach (OperateBtnPrompt item in hashSet)
		{
			item.SetVisible(!hashSet2.Contains(item));
		}
	}

	private void RefreshGamePadModeHiddenObjects(bool isGamePadMode)
	{
		if (_hideInGamePadModeObjects == null)
		{
			return;
		}
		foreach (GameObject hideInGamePadModeObject in _hideInGamePadModeObjects)
		{
			if (!(hideInGamePadModeObject == null))
			{
				hideInGamePadModeObject.SetActive(!isGamePadMode);
			}
		}
	}

	internal void SelectRewardByGamePad(int offset)
	{
		if (_scrollBagComponent?.ItemSource != null)
		{
			List<ItemUnifierProxy> list = _scrollBagComponent.ItemSource.ToList();
			if (list.Count != 0)
			{
				int index = Mathf.Clamp(GetCurrentRewardIndex() + offset, 0, list.Count - 1);
				SelectRewardAtIndex(index, list);
			}
		}
	}

	internal void OpenSelectedRewardItemDetail()
	{
		ItemUnifierProxy currentRewardItemUnifier = GetCurrentRewardItemUnifier();
		if (currentRewardItemUnifier?.Source != null && !ItemUnifierProxy.Empty.Equals(currentRewardItemUnifier))
		{
			ItemUnifierProxy uiData = ItemUnifierProxy.ItemUnifierPool.Get<Item>(currentRewardItemUnifier.Id, G.localPlayer.Inventory.GetItemCount(currentRewardItemUnifier.Id));
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, uiData);
		}
	}

	private int GetCurrentRewardIndex()
	{
		List<ItemUnifierProxy> list = _scrollBagComponent?.ItemSource?.ToList();
		if (list == null || list.Count == 0)
		{
			return 0;
		}
		ItemUnifierProxy currentRewardItemUnifier = GetCurrentRewardItemUnifier();
		int num = ((currentRewardItemUnifier != null) ? list.IndexOf(currentRewardItemUnifier) : (-1));
		if (num >= 0)
		{
			return num;
		}
		return 0;
	}

	private ItemUnifierProxy GetCurrentRewardItemUnifier()
	{
		ObservableCollection<ItemUnifierProxy> observableCollection = _scrollBagComponent?.SelectedModels;
		if (observableCollection != null && observableCollection.Count > 0)
		{
			return _scrollBagComponent.SelectedModels[0];
		}
		return (EventSystemHelper.CurrentSelected?.GetComponent<ItemUIComponentBase>())?.ItemUnifier;
	}

	private void SelectRewardAtIndex(int index)
	{
		List<ItemUnifierProxy> itemList = _scrollBagComponent?.ItemSource?.ToList();
		SelectRewardAtIndex(index, itemList);
	}

	private void SelectRewardAtIndex(int index, List<ItemUnifierProxy> itemList)
	{
		if (!(_scrollBagComponent == null) && itemList != null && index >= 0 && index < itemList.Count && itemList[index].Context is ItemUIComponentBase itemUIComponentBase)
		{
			EventSystemHelper.SetSelectedGameObject(itemUIComponentBase.gameObject);
		}
	}

	private ViewControlLayer GetControlLayer(BattlePassBuyLevelViewSubControllerType subControllerType)
	{
		if (subControllerType == BattlePassBuyLevelViewSubControllerType.Reward)
		{
			return _rewardViewControlLayer;
		}
		return _mainViewControlLayer;
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		_commonBgAnimation.GetSequence("Show").Play();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		ItemUnifierProxy.ItemUnifierPool.Release(_previewRewardList);
		_previewRewardList.Clear();
		CollectionPool<List<ItemUnifierProxy>, ItemUnifierProxy>.Release(_previewRewardList);
		_previewRewardList = null;
		base.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		_commonBgAnimation.GetSequence("Hide").Play();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}
}
