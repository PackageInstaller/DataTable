using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ShopWindow : UGuiWindowBase
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private MoneyView moneyView;

	[SerializeField]
	private RectTransform tabRoot;

	[SerializeField]
	private TabItem tabTpl;

	[SerializeField]
	private TabItem tabPay;

	[SerializeField]
	private TabItem tabCashPay;

	[SerializeField]
	private TabItem tabHeroSkin;

	[SerializeField]
	private ShopView shopView;

	[SerializeField]
	private List<int> payMoneyIds;

	[SerializeField]
	private PayView payView;

	[SerializeField]
	private List<int> cashPaymentMoneyIds;

	[SerializeField]
	private CashPaymentView cashPaymentView;

	[SerializeField]
	private HeroSkinShopView heroSkinShopView;

	[SerializeField]
	private Button btnJumpOther;

	[SerializeField]
	private string jumpWindow;

	[SerializeField]
	private List<int> jumpParams;

	private GameObjectPool tabItemPool;

	private ShopWindowViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		tabItemPool = new GameObjectPool(tabTpl.gameObject, tabRoot);
		base.OnCreate(bundle);
		_viewModel = GetData<ShopWindowViewModel>();
		BindingSet<ShopWindow, ShopWindowViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((ShopWindow v) => v.OpenUguiWindow).To((ShopWindowViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind().For((ShopWindow v) => v.SetChildViewVisibility).To((ShopWindowViewModel vm) => vm.ShowViewRequest);
		bindingSet.Bind(this).For((ShopWindow v) => v.OnDismissRequest).To((ShopWindowViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((ShopWindowViewModel vm) => vm.Close);
		bindingSet.Bind().For((ShopWindow v) => v.RefreshTabs).To((ShopWindowViewModel vm) => vm.RefreshTabsRst);
		bindingSet.Bind().For((ShopWindow v) => v.ChangeView).To((ShopWindowViewModel vm) => vm.ChangeViewRst);
		if (btnJumpOther != null)
		{
			JumpWindowParams jumpWindowParams = new JumpWindowParams(jumpWindow, jumpParams);
			bindingSet.Bind(btnJumpOther).For((Button v) => v.onClick).To((ShopWindowViewModel vm) => vm.JumpWindowCmd)
				.CommandParameter(jumpWindowParams);
		}
		bindingSet.Build();
		Init();
	}

	private void Init()
	{
		InitTabUnlockState();
		moneyView.Init(new MoneyViewModel(_viewModel));
		shopView.Init(_viewModel.ShopViewData);
		payView.Init(new PayViewModel(_viewModel));
		cashPaymentView.Init(new CashPaymentViewModel(_viewModel));
		heroSkinShopView.Init(_viewModel.HeroSkinShopViewModel);
		tabPay.Init(new TabItemData(_viewModel, 999));
		if (_viewModel.CurTabIndex == 999)
		{
			if (tabPay.gameObject.activeSelf)
			{
				_viewModel.SetTabSelected(tabPay.ViewModel);
			}
			else
			{
				_viewModel.CurTabIndex = 0;
			}
		}
		tabCashPay.Init(new TabItemData(_viewModel, 998));
		if (_viewModel.CurTabIndex == 998)
		{
			if (tabCashPay.gameObject.activeSelf)
			{
				_viewModel.SetTabSelected(tabCashPay.ViewModel);
			}
			else
			{
				_viewModel.CurTabIndex = 0;
			}
		}
		tabHeroSkin.Init(new TabItemData(_viewModel, 997));
		if (_viewModel.CurTabIndex == 997)
		{
			if (tabHeroSkin.gameObject.activeSelf)
			{
				_viewModel.SetTabSelected(tabHeroSkin.ViewModel);
			}
			else
			{
				_viewModel.CurTabIndex = 0;
			}
		}
		RefreshTabs();
		ChangeView();
	}

	private void InitTabUnlockState()
	{
		Dictionary<int, Dictionary<int, ShopInfoData>> mainShopDatas = Singleton<ServiceSystem>.Instance.GetService<IShopService>().GetData().GetMainShopDatas(ShopGoodItemData.ShopPosition.HeroSkinShop);
		if (GameEntry.BuiltinData.OpenTestFlight)
		{
			tabPay.gameObject.SetActive(value: false);
			tabCashPay.gameObject.SetActive(value: false);
			tabHeroSkin.gameObject.SetActive(value: false);
		}
		else
		{
			tabHeroSkin.gameObject.SetActive(mainShopDatas != null && mainShopDatas.Count > 0);
			heroSkinShopView.gameObject.SetActive(mainShopDatas != null && mainShopDatas.Count > 0);
		}
	}

	private void RefreshTabs(object sender = null, InteractionEventArgs e = null)
	{
		tabItemPool.RecycleAll();
		List<int> list = Singleton<ServiceSystem>.Instance.GetService<IShopService>().GetData().GetMainShopDatas(ShopGoodItemData.ShopPosition.Shop)
			.Keys.ToList();
		List<DRMainShopList> list2 = new List<DRMainShopList>();
		if (list != null)
		{
			foreach (int item in list)
			{
				DRMainShopList dataRow = GameEntry.DataTable.GetDataRow<DRMainShopList>(item);
				if (dataRow != null)
				{
					list2.Add(dataRow);
				}
			}
		}
		list2.Sort((DRMainShopList a, DRMainShopList b) => 10 * a.Sort.CompareTo(b.Sort) + a.Id.CompareTo(b.Id));
		for (int num = 0; num < list2.Count; num++)
		{
			TabItemData tabItemData = new TabItemData(_viewModel, list2[num].Id)
			{
				TextNormal = list2[num].ShopName,
				IconNormal = list2[num].TabIcon,
				TextSelected = list2[num].ShopName,
				IconSelected = list2[num].TabIconSelected,
				EnglishSelected = list2[num].TabEnglish
			};
			if ((_viewModel.CurTabIndex == 0 && num == 0) || _viewModel.CurTabIndex == list2[num].Id)
			{
				_viewModel.SetTabSelected(tabItemData);
			}
			TabItem component = tabItemPool.Allocate(out var newCreate).GetComponent<TabItem>();
			if (newCreate)
			{
				component.Init(tabItemData);
			}
			else
			{
				component.SetDataContext(tabItemData);
			}
			component.transform.SetSiblingIndex(tabRoot.childCount - 3);
			component.GetComponent<UIRedPoint>()?.Dispose();
			component.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.ShopRed).SetFuncOnMessage((RedPointMessage message) => ((RedPointService)Singleton<ServiceSystem>.Instance.GetService<IRedPointService>()).MainShopReds.Contains(tabItemData.TabIndex))
				.Invoke();
		}
	}

	private async void ChangeView(object sender = null, InteractionEventArgs e = null)
	{
		List<int> moneyIds = new List<int>();
		bool shopVisible = !_viewModel.CheckSpecialTab(_viewModel.CurTabIndex);
		if (shopVisible)
		{
			await _viewModel.ShopViewData.OnOpen();
		}
		shopView.CanvasGroup.alpha = (shopVisible ? 1 : 0);
		shopView.CanvasGroup.blocksRaycasts = shopVisible;
		payView.gameObject.SetActive(_viewModel.CurTabIndex == 999);
		cashPaymentView.gameObject.SetActive(_viewModel.CurTabIndex == 998);
		heroSkinShopView.CanvasGroup.alpha = ((_viewModel.CurTabIndex == 997) ? 1 : 0);
		heroSkinShopView.CanvasGroup.blocksRaycasts = _viewModel.CurTabIndex == 997;
		if (_viewModel.CurTabIndex == 999)
		{
			moneyIds = payMoneyIds;
		}
		else if (_viewModel.CurTabIndex == 998)
		{
			moneyIds = cashPaymentMoneyIds;
		}
		moneyView.HideAll();
		if (moneyIds == null || moneyIds.Count <= 0)
		{
			return;
		}
		foreach (int item in moneyIds)
		{
			moneyView.SetShow(item);
		}
	}

	protected override void OnDestroy()
	{
		tabItemPool?.Dispose();
		tabItemPool = null;
		base.OnDestroy();
	}
}
