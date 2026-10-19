using System;
using System.Collections.Generic;
using System.Linq;
using ACT.UI.CommonComponent.CoinComponent;
using ACT.UI.Interface;
using ACT.ViewControl;
using Fundamental;
using UnityEngine;

namespace ACT.UI.ShopSubView;

public abstract class BaseShopFirstSubView : BaseShopFirstSubView<BaseShopFirstSubViewInputController>
{
}
public abstract class BaseShopFirstSubView<T> : BaseTabContent<T>, IShopFirstSubView where T : class, ISubInputController, new()
{
	[SerializeField]
	public CommonTabListComponent tabListComponent;

	[SerializeField]
	private GameObject tabTemplate;

	protected Dictionary<int, GameObject> _tabs;

	protected ShopFirstTab _shopFirstTab;

	protected CommonCoinGroup _coinGroup;

	protected ViewControlLayer _coinViewLayer;

	protected List<GamePadTipsAction> _gamePadTipsActionsSnap;

	private bool _isInited;

	public ShopView ShopView => ParentUIView as ShopView;

	public CommonTabListComponent TabListComponent => tabListComponent;

	public CommonCoinGroup CoinGroup => _coinGroup;

	protected virtual void Awake()
	{
		_gamePadTipsActionsSnap = ListPool<GamePadTipsAction>.Get();
		_coinGroup = GetComponentInChildren<CommonCoinGroup>(includeInactive: true);
		_coinViewLayer = _coinGroup.GetComponent<ViewControlLayer>();
		_coinViewLayer?.OnFocusChanged.AddListener(OnCoinFocusChanged);
	}

	protected override void OnUnityDestroy()
	{
		base.OnUnityDestroy();
		CleanSecondTabs();
		if (_tabs != null)
		{
			DictionaryPool<int, GameObject>.Release(_tabs);
			_tabs = null;
		}
		_coinViewLayer?.OnFocusChanged.RemoveListener(OnCoinFocusChanged);
		ListPool<GamePadTipsAction>.Release(_gamePadTipsActionsSnap);
		_gamePadTipsActionsSnap = null;
	}

	private void OnCoinFocusChanged(bool arg0)
	{
		if (arg0)
		{
			_gamePadTipsActionsSnap.Clear();
			_gamePadTipsActionsSnap.AddRange(ShopView.gamePadTipsComp.GamePadTipsActions);
			ShopView.gamePadTipsComp.RegisterInputActions(GamePadTipHelper.ConfirmAction, GamePadTipHelper.BackAction);
			ShopView.tabListComponent.FocusOut();
			tabListComponent?.FocusOut();
			tabListComponent?.ActiveTab.Content.FocusOut();
			FocusOut();
		}
		else
		{
			FocusIn();
			ShopView.tabListComponent.FocusIn();
			tabListComponent?.FocusIn();
			tabListComponent?.ActiveTab.Content.FocusIn();
			ShopView.gamePadTipsComp.ClearAllPrompts();
			ShopView.gamePadTipsComp.RegisterInputActions(_gamePadTipsActionsSnap);
			_gamePadTipsActionsSnap.Clear();
		}
	}

	private void GenSecondTabs()
	{
		if (_tabs == null)
		{
			_tabs = DictionaryPool<int, GameObject>.Get();
		}
		int[] subshopIds = _shopFirstTab.ShopData.subshopIds;
		if (subshopIds != null && subshopIds.Length > 1)
		{
			subshopIds = _shopFirstTab.ShopData.subshopIds;
			foreach (int num in subshopIds)
			{
				GameObject gameObject = UnityEngine.Object.Instantiate(tabTemplate, tabListComponent.transform);
				ShopSecondTab component = gameObject.GetComponent<ShopSecondTab>();
				gameObject.gameObject.name = $"ShopSecondTab_{num}";
				component.TabIdentify = num;
				component.ParentTab = Tab as ShopFirstTab;
				_tabs.Add(num, gameObject);
			}
		}
	}

	private void CleanSecondTabs()
	{
		if (_tabs == null)
		{
			return;
		}
		foreach (KeyValuePair<int, GameObject> tab in _tabs)
		{
			UnityEngine.Object.Destroy(tab.Value);
		}
		_tabs.Clear();
	}

	protected override void OnBindTabChanged(ITabItem oldTab, ITabItem newTab)
	{
		base.OnBindTabChanged(oldTab, newTab);
		if (Tab is ShopFirstTab shopFirstTab)
		{
			_shopFirstTab = shopFirstTab;
			CleanSecondTabs();
			GenSecondTabs();
		}
	}

	protected ITabItem GetDefaultSecondTab()
	{
		int targetSecondTabId = ShopView?.TargetSecondTabID ?? 0;
		if (targetSecondTabId != 0)
		{
			ITabItem tabItem = tabListComponent.TabItems.FirstOrDefault((ITabItem x) => x.TabIdentify == targetSecondTabId && x.CanActive());
			if (tabItem != null)
			{
				return tabItem;
			}
		}
		return tabListComponent.TabItems.FirstOrDefault((ITabItem x) => x.CanActive());
	}

	protected int GetTargetOrDefaultSubShopId()
	{
		int[] array = _shopFirstTab?.ShopData?.subshopIds;
		if (array == null || array.Length == 0)
		{
			return 0;
		}
		int num = ShopView?.TargetSecondTabID ?? 0;
		if (num != 0 && array.Contains(num))
		{
			return num;
		}
		return array.FirstOrDefault();
	}

	protected override void OnTabActive(ITabItem tabItem)
	{
		base.OnTabActive(tabItem);
		tabListComponent?.FocusIn();
		_coinGroup?.FocusIn();
		FocusIn();
	}

	protected override void OnTabDeActive(ITabItem tabItem)
	{
		base.OnTabDeActive(tabItem);
		tabListComponent?.FocusOut();
		tabListComponent?.ActiveTab?.Content?.FocusOut();
		_coinGroup?.FocusOut();
		FocusOut();
	}

	public override void PlayOpenAnim()
	{
		ResetTabListContentPosition();
		if (anim != null)
		{
			anim.GetSequence("TabShow")?.Play();
		}
	}

	private void ResetTabListContentPosition()
	{
		if (tabListComponent?.transform is RectTransform rectTransform)
		{
			rectTransform.anchoredPosition = Vector2.zero;
		}
	}

	public override void PlayCloseAnim(Action onComplete = null)
	{
		if (anim != null)
		{
			anim.GetSequence("TabHide").OnComplete((AnimationBuilder _) =>
			{
				onComplete?.Invoke();
			}).Play();
		}
		else
		{
			onComplete?.Invoke();
		}
	}

	protected void PlayFirstTabAnimation()
	{
		if (tabListComponent == null)
		{
			return;
		}
		foreach (ITabItem tabItem in tabListComponent.TabItems)
		{
			if (tabItem is ShopSecondTab { Animation: { } animation } shopSecondTab)
			{
				animation.GetSequence(shopSecondTab.IsOn ? "SelectedShow" : "NormalShow")?.Play();
			}
		}
	}
}
