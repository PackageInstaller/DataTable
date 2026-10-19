using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Model;
using ACT.Model.Jump;
using ACT.UI.Interface;
using ACT.UI.ShopSubView;
using ACT.UI.ShopViewInputController;
using ACT.Utility;
using Fundamental;
using Runtime.UI.CommonComponent.CommonTimer;
using Runtime.WaitSort;
using UnityEngine;

namespace ACT.UI;

public class ShopView : BaseUIView<ACT.UI.ShopViewInputController.ShopViewInputController>
{
	private const int TotalRechargeActivityJumpId = 2207;

	[SerializeField]
	public CommonTabListComponent tabListComponent;

	[SerializeField]
	private GameObject tabTemplate;

	[Header("页签面板")]
	[SerializeField]
	private RecommendView recommendView;

	[SerializeField]
	private GiftCenterView giftCenterView;

	[SerializeField]
	private SkinView skinShopView;

	[SerializeField]
	private CrystalShopView crystalShopView;

	[SerializeField]
	private ExchangeShopView exchangeShopView;

	[Header("GamePad提示")]
	public GamePadTipsComp gamePadTipsComp;

	[SerializeField]
	private ExchangeShopView featureShopView;

	[Header("累计充值活动入口")]
	[SerializeField]
	private ActButton totalRechargeActivityBtn;

	[SerializeField]
	private CommonTimerComponent totalRechargeActivityTimer;

	[SerializeField]
	private RedDotItem totalRechargeActivityRedDot;

	private Dictionary<int, GameObject> _tabs;

	private readonly List<CommonTabListComponent> _trackedSecondTabListComponents = new List<CommonTabListComponent>();

	private int _trackedSubShopId;

	private bool _trackTabEventsRegistered;

	private ActivityCenterData _totalRechargeActivityData;

	private ShopViewData m_data => uiViewData as ShopViewData;

	public int TargetSecondTabID => m_data?.SecondTabID ?? 0;

	private void Awake()
	{
		_tabs = DictionaryPool<int, GameObject>.Get();
		foreach (KeyValuePair<int, ShopData> shopData in RuntimeConfigs.data.shopDatas)
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(tabTemplate, tabListComponent.TabRoot, worldPositionStays: false);
			BaseTabToggle component = gameObject.GetComponent<BaseTabToggle>();
			gameObject.gameObject.name = $"ShopFirstTab_{shopData.Key}";
			component.TabIdentify = shopData.Key;
			_tabs.Add(shopData.Key, gameObject);
		}
		CommonTabListComponent commonTabListComponent = tabListComponent;
		commonTabListComponent.OnTabActive = (Action<ITabItem>)Delegate.Combine(commonTabListComponent.OnTabActive, new Action<ITabItem>(EnsureFocus));
		totalRechargeActivityBtn?.SetBtnClick(OnClickTotalRechargeActivity);
	}

	private void OnDestroy()
	{
		UnRegisterShopTrackEvents();
		_tabs.Clear();
		DictionaryPool<int, GameObject>.Release(_tabs);
		_tabs = null;
		CommonTabListComponent commonTabListComponent = tabListComponent;
		commonTabListComponent.OnTabActive = (Action<ITabItem>)Delegate.Remove(commonTabListComponent.OnTabActive, new Action<ITabItem>(EnsureFocus));
	}

	protected override void AddEventListener()
	{
		base.AddEventListener();
		ShopModel shopModel = Model<ShopModel>.Interface;
		shopModel.OnCommodityDataUpdate = (Action)Delegate.Combine(shopModel.OnCommodityDataUpdate, new Action(OnCommodityDataUpdate));
		ShopModel shopModel2 = Model<ShopModel>.Interface;
		shopModel2.OnShopDataUpdate = (Action)Delegate.Combine(shopModel2.OnShopDataUpdate, new Action(OnCommodityDataUpdate));
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_RefreshActivityCenter, OnRefreshActivityCenter);
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
		ShopModel shopModel = Model<ShopModel>.Interface;
		shopModel.OnCommodityDataUpdate = (Action)Delegate.Remove(shopModel.OnCommodityDataUpdate, new Action(OnCommodityDataUpdate));
		ShopModel shopModel2 = Model<ShopModel>.Interface;
		shopModel2.OnShopDataUpdate = (Action)Delegate.Remove(shopModel2.OnShopDataUpdate, new Action(OnCommodityDataUpdate));
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_RefreshActivityCenter, OnRefreshActivityCenter);
	}

	protected override void Init()
	{
		base.Init();
		tabListComponent.TabItems.Clear();
		foreach (KeyValuePair<int, GameObject> tab in _tabs)
		{
			GameObject value = tab.Value;
			ShopFirstTab component = value.GetComponent<ShopFirstTab>();
			value.SetActive(value: true);
			switch (tab.Key)
			{
			case 1:
				component.Content = recommendView;
				break;
			case 2:
				component.Content = giftCenterView;
				break;
			case 3:
				component.Content = skinShopView;
				break;
			case 4:
				component.Content = exchangeShopView;
				break;
			case 5:
				component.Content = crystalShopView;
				break;
			case 6:
				component.Content = featureShopView;
				break;
			}
			tabListComponent.TabItems.Add(component);
			component.Station = Station;
			component.UpdateTabStyle();
		}
		RegisterShopTrackEvents();
		if (m_data == null || m_data.FirstTabID == 0)
		{
			tabListComponent.ActiveTab = tabListComponent.TabItems.FirstOrDefault((ITabItem x) => x.CanActive());
		}
		else
		{
			ITabItem tabItem = tabListComponent.TabItems.FirstOrDefault((ITabItem x) => x.TabIdentify == m_data.FirstTabID && x.CanActive());
			tabListComponent.ActiveTab = tabItem ?? tabListComponent.TabItems.FirstOrDefault((ITabItem x) => x.CanActive());
		}
		PlayFirstTabAnimation();
		tabListComponent.FocusIn();
		RefreshTotalRechargeActivityEntry();
		totalRechargeActivityRedDot?.InitRedDot(RedDotPathDefine.Activity_TotalRecharge);
	}

	protected override void ReInit()
	{
		base.ReInit();
		Init();
	}

	private void CloseActiveTabsBeforeReInit()
	{
		foreach (CommonTabListComponent trackedSecondTabListComponent in _trackedSecondTabListComponents)
		{
			trackedSecondTabListComponent?.Group?.SetAllToggleOff(ignoreClickInterval: true);
		}
		tabListComponent.Group?.SetAllToggleOff(ignoreClickInterval: true);
	}

	protected override void UnInit()
	{
		base.UnInit();
		TrackCloseCurrentSubShop();
		tabListComponent.Group.SetAllToggleOff();
		tabListComponent.FocusOut();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation?.GetSequence("Show")?.OnComplete((AnimationBuilder x) =>
		{
			CommonTabListComponent commonTabListComponent = tabListComponent;
			commonTabListComponent.OnTabActive = (Action<ITabItem>)Delegate.Combine(commonTabListComponent.OnTabActive, new Action<ITabItem>(PlayTabShowAnimation));
		}).Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation?.GetSequence("Hide")?.Play();
		CommonTabListComponent commonTabListComponent = tabListComponent;
		commonTabListComponent.OnTabActive = (Action<ITabItem>)Delegate.Remove(commonTabListComponent.OnTabActive, new Action<ITabItem>(PlayTabShowAnimation));
	}

	private void PlayFirstTabAnimation()
	{
		foreach (ITabItem tabItem in tabListComponent.TabItems)
		{
			if (tabItem is ShopFirstTab { Animation: { } animation } shopFirstTab)
			{
				animation.GetSequence(shopFirstTab.IsOn ? "SelectedShow" : "NormalShow")?.Play();
			}
		}
	}

	private void PlayTabShowAnimation(ITabItem tabItem)
	{
		betterAnimation?.GetSequence("TabShow")?.Play();
	}

	private void EnsureFocus(ITabItem tabItem)
	{
		tabListComponent.FocusIn();
	}

	private void OnRefreshActivityCenter(BaseEventContent content)
	{
		RefreshTotalRechargeActivityEntry();
	}

	private void RefreshTotalRechargeActivityEntry()
	{
		_totalRechargeActivityData = Model<ActivityCenterModel>.Interface.GetOpeningActivitys().FirstOrDefault((ActivityCenterData x) =>
		{
			ActivityData staticActivityData = x.StaticActivityData;
			return staticActivityData != null && staticActivityData.activityType == 10;
		});
		if (totalRechargeActivityBtn == null)
		{
			return;
		}
		if (_totalRechargeActivityData == null)
		{
			totalRechargeActivityBtn.gameObject.SetActive(value: false);
			return;
		}
		long remainingTime = _totalRechargeActivityData.GetRemainingTime();
		if (remainingTime <= 0)
		{
			_totalRechargeActivityData = null;
			totalRechargeActivityBtn.gameObject.SetActive(value: false);
			return;
		}
		totalRechargeActivityBtn.gameObject.SetActive(value: true);
		if (!(totalRechargeActivityTimer == null))
		{
			long num = _totalRechargeActivityData.ServerActivityData.EndTime - _totalRechargeActivityData.ServerActivityData.StartTime;
			if (num * 10000 >= 3153600000000000L)
			{
				totalRechargeActivityTimer.IsCountDown = false;
				CommonTimerComponent commonTimerComponent = totalRechargeActivityTimer;
				System.DateTime minValue = System.DateTime.MinValue;
				commonTimerComponent.Time = minValue.Add(TimeSpan.FromMilliseconds(num));
			}
			else
			{
				totalRechargeActivityTimer.IsCountDown = true;
				CommonTimerComponent commonTimerComponent2 = totalRechargeActivityTimer;
				System.DateTime minValue = System.DateTime.MinValue;
				commonTimerComponent2.Time = minValue.Add(TimeSpan.FromMilliseconds(remainingTime));
			}
		}
	}

	private void OnClickTotalRechargeActivity()
	{
		if (_totalRechargeActivityData != null)
		{
			RuntimeJumpData runTimeJumpData = ItemJumpHelper.GetRunTimeJumpData(2207);
			JumpResult jumpResult = Model<JumpModel>.Interface.CanJump(runTimeJumpData);
			if (jumpResult.ShowType == JumpResult.JumpShowType.CanJump)
			{
				runTimeJumpData.FromSystem = SystemType.Shop;
				Model<JumpModel>.Interface.JumpTo(runTimeJumpData);
			}
			jumpResult.Release();
		}
	}

	public void OnGamepadOpenTotalRechargeActivity()
	{
		if (!(totalRechargeActivityBtn == null) && totalRechargeActivityBtn.gameObject.activeInHierarchy)
		{
			OnClickTotalRechargeActivity();
		}
	}

	private void RegisterShopTrackEvents()
	{
		UnRegisterShopTrackEvents();
		CommonTabListComponent commonTabListComponent = tabListComponent;
		commonTabListComponent.OnTabActive = (Action<ITabItem>)Delegate.Combine(commonTabListComponent.OnTabActive, new Action<ITabItem>(OnFirstTabActiveForTrack));
		CommonTabListComponent commonTabListComponent2 = tabListComponent;
		commonTabListComponent2.OnTabDeActive = (Action<ITabItem>)Delegate.Combine(commonTabListComponent2.OnTabDeActive, new Action<ITabItem>(OnFirstTabDeActiveForTrack));
		_trackTabEventsRegistered = true;
		foreach (ITabItem tabItem in tabListComponent.TabItems)
		{
			if (tabItem?.Content is IShopFirstSubView shopFirstSubView && !(shopFirstSubView.TabListComponent == null))
			{
				CommonTabListComponent commonTabListComponent3 = shopFirstSubView.TabListComponent;
				commonTabListComponent3.OnTabActive = (Action<ITabItem>)Delegate.Combine(commonTabListComponent3.OnTabActive, new Action<ITabItem>(OnSecondTabActiveForTrack));
				CommonTabListComponent commonTabListComponent4 = shopFirstSubView.TabListComponent;
				commonTabListComponent4.OnTabDeActive = (Action<ITabItem>)Delegate.Combine(commonTabListComponent4.OnTabDeActive, new Action<ITabItem>(OnSecondTabDeActiveForTrack));
				_trackedSecondTabListComponents.Add(shopFirstSubView.TabListComponent);
			}
		}
	}

	private void UnRegisterShopTrackEvents()
	{
		if (_trackTabEventsRegistered)
		{
			CommonTabListComponent commonTabListComponent = tabListComponent;
			commonTabListComponent.OnTabActive = (Action<ITabItem>)Delegate.Remove(commonTabListComponent.OnTabActive, new Action<ITabItem>(OnFirstTabActiveForTrack));
			CommonTabListComponent commonTabListComponent2 = tabListComponent;
			commonTabListComponent2.OnTabDeActive = (Action<ITabItem>)Delegate.Remove(commonTabListComponent2.OnTabDeActive, new Action<ITabItem>(OnFirstTabDeActiveForTrack));
			_trackTabEventsRegistered = false;
		}
		foreach (CommonTabListComponent trackedSecondTabListComponent in _trackedSecondTabListComponents)
		{
			if (!(trackedSecondTabListComponent == null))
			{
				trackedSecondTabListComponent.OnTabActive = (Action<ITabItem>)Delegate.Remove(trackedSecondTabListComponent.OnTabActive, new Action<ITabItem>(OnSecondTabActiveForTrack));
				trackedSecondTabListComponent.OnTabDeActive = (Action<ITabItem>)Delegate.Remove(trackedSecondTabListComponent.OnTabDeActive, new Action<ITabItem>(OnSecondTabDeActiveForTrack));
			}
		}
		_trackedSecondTabListComponents.Clear();
	}

	private void OnFirstTabActiveForTrack(ITabItem tabItem)
	{
		if (tabItem is ShopFirstTab shopFirstTab)
		{
			TrackOpenSubShop(GetActiveSubShopId(shopFirstTab));
		}
	}

	private void OnFirstTabDeActiveForTrack(ITabItem tabItem)
	{
		TrackCloseCurrentSubShop();
	}

	private void OnSecondTabActiveForTrack(ITabItem tabItem)
	{
		if (tabItem is ShopSecondTab shopSecondTab)
		{
			TrackOpenSubShop(shopSecondTab.TabIdentify);
		}
	}

	private void OnSecondTabDeActiveForTrack(ITabItem tabItem)
	{
		if (tabItem is ShopSecondTab shopSecondTab && _trackedSubShopId == shopSecondTab.TabIdentify)
		{
			TrackCloseCurrentSubShop();
		}
	}

	private int GetActiveSubShopId(ShopFirstTab shopFirstTab)
	{
		if (shopFirstTab.Content is IShopFirstSubView { TabListComponent: var commonTabListComponent } && commonTabListComponent?.ActiveTab is ShopSecondTab shopSecondTab)
		{
			return shopSecondTab.TabIdentify;
		}
		if (shopFirstTab.ShopData?.subshopIds == null)
		{
			return 0;
		}
		int[] subshopIds = shopFirstTab.ShopData.subshopIds;
		foreach (int num in subshopIds)
		{
			if (!Singleton<SystemBlockManager>.instance.IsBlocked(SystemType.Shop, num))
			{
				return num;
			}
		}
		return 0;
	}

	private void TrackOpenSubShop(int subShopId)
	{
		if (subShopId != 0 && _trackedSubShopId != subShopId)
		{
			TrackCloseCurrentSubShop();
			_trackedSubShopId = subShopId;
			ShopEventTrackHelper.Dispatch(subShopId, 1);
		}
	}

	private void TrackCloseCurrentSubShop()
	{
		if (_trackedSubShopId != 0)
		{
			ShopEventTrackHelper.Dispatch(_trackedSubShopId, 2);
			_trackedSubShopId = 0;
		}
	}

	private void OnCommodityDataUpdate()
	{
		if (tabListComponent.ActiveTab is ShopFirstTab { TabIdentify: var tabIdentify } shopFirstTab)
		{
			if (!IsActiveSubShopUnavailable(shopFirstTab))
			{
				ShopViewData shopViewData = m_data ?? new ShopViewData();
				shopViewData.FirstTabID = tabIdentify;
				shopViewData.SecondTabID = GetActiveSubShopId(shopFirstTab);
				uiViewData = shopViewData;
			}
			else
			{
				CloseActiveTabsBeforeReInit();
				uiViewData = null;
			}
			ReInit();
		}
	}

	private bool IsActiveSubShopUnavailable(ShopFirstTab activeFirstTab)
	{
		if (!(activeFirstTab.Content is IShopFirstSubView { TabListComponent: var commonTabListComponent }) || !(commonTabListComponent?.ActiveTab is ShopSecondTab { CanActive: var canActive }))
		{
			Func<bool> canActive2 = activeFirstTab.CanActive;
			if (canActive2 == null)
			{
				return true;
			}
			return !canActive2();
		}
		if (canActive == null)
		{
			return true;
		}
		return !canActive();
	}
}
