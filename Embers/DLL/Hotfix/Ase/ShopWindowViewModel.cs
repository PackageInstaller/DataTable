using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public class ShopWindowViewModel : OptionBase
{
	public const int PayTabIndex = 999;

	public const int CashPayTabIndex = 998;

	public const int HeroSkinTabIndex = 997;

	private int curTabIndex;

	private TabItemData curTabItemData;

	private int curSubTabIndex;

	private InteractionRequest refreshTabsRst = new InteractionRequest();

	private ShopViewData shopViewData;

	private InteractionRequest changeViewRst = new InteractionRequest();

	private PropExchangeViewModel exchangeViewModel;

	private PropExchangeViewModel exchangeWeaponViewModel;

	private PropExchangeViewModel exchangePackViewModel;

	private bool isPaying;

	private ISubscription<UserPayNotify> userPayNotify;

	private PropExchangeViewModel cachePropExchangeViewModel;

	private SimpleCommand<JumpWindowParams> _jumpWindowCmd;

	private ShopExcData curOpeExcData;

	private int curOpeUseCount;

	private HeroSkinShopViewModel heroSkinShopViewModel;

	public ShopViewData ShopViewData => shopViewData;

	public HeroSkinShopViewModel HeroSkinShopViewModel => heroSkinShopViewModel;

	public int CurTabIndex
	{
		get
		{
			return curTabIndex;
		}
		set
		{
			Set(ref curTabIndex, value, "CurTabIndex");
			if (!CheckSpecialTab(value))
			{
				shopViewData.CurTabIndex = value;
			}
		}
	}

	public int CurSubTabIndex
	{
		get
		{
			return curSubTabIndex;
		}
		set
		{
			Set(ref curSubTabIndex, value, "CurSubTabIndex");
			shopViewData.CurSubTabIndex = value;
		}
	}

	public InteractionRequest RefreshTabsRst => refreshTabsRst;

	public InteractionRequest ChangeViewRst => changeViewRst;

	public SimpleCommand<JumpWindowParams> JumpWindowCmd => _jumpWindowCmd;

	public ShopWindowViewModel()
	{
	}

	public ShopWindowViewModel(OptionBase parent, int tabIndex = 999, int subTabIndex = 0)
	{
		base.parent = parent;
		_jumpWindowCmd = new SimpleCommand<JumpWindowParams>(JumpWindow);
		shopViewData = new ShopViewData(this);
		heroSkinShopViewModel = new HeroSkinShopViewModel(this, (tabIndex == 997) ? subTabIndex : 0);
		CurTabIndex = tabIndex;
		CurSubTabIndex = subTabIndex;
		userPayNotify = Singleton<NetworkSystem>.Instance.Subscribe<UserPayNotify>(OnUserPayNotify);
		Singleton<ServiceSystem>.Instance.GetService<IShopService>().BindShopNotify(OnShopNotify);
		exchangeViewModel = new PropExchangeViewModel(this);
		AddChild(exchangeViewModel);
		exchangeWeaponViewModel = new PropExchangeViewModel(this);
		AddChild(exchangeWeaponViewModel);
		exchangePackViewModel = new PropExchangeViewModel(this);
		AddChild(exchangePackViewModel);
	}

	public override async void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is TabItemData tabSelected)
		{
			SetTabSelected(tabSelected);
		}
		else if (obj is ShopGoodItemData goodItemData)
		{
			OnGoodItemClick(goodItemData);
		}
		else if (obj is PropGetViewModel userData)
		{
			openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), userData));
		}
		else if (obj is OptionArg optionArg)
		{
			if ("OnConfirmExc".Equals(optionArg.OptionName))
			{
				await OnConfirmExc(optionArg);
			}
			else if ("OnHeroSkinExchangeSucceed".Equals(optionArg.OptionName) && optionArg.Obj is HeroSkinExchangeViewModel excVm)
			{
				heroSkinShopViewModel?.OnHeroSkinExchangeSucceed(excVm);
			}
		}
	}

	public override bool CheckOpen(OptionBase optionBase, JumpWindowParams jumpParams)
	{
		if (jumpParams.WindowName.Equals("ShopWindow"))
		{
			List<int> list = new List<int>();
			if (jumpParams.Args != null)
			{
				foreach (object arg in jumpParams.Args)
				{
					list.Add((int)arg);
				}
			}
			int num = ((list.Count > 0) ? list[0] : 0);
			int num2 = ((list.Count > 1) ? list[1] : 0);
			CurTabIndex = num;
			CurSubTabIndex = num2;
			exchangePackViewModel?.Hide();
			optionBase.Close();
			RefreshTabsRst.Raise();
			return false;
		}
		return true;
	}

	private void OnShopNotify(ShopRefreshNotify notify)
	{
		RefreshTabsRst.Raise();
	}

	public void SetTabSelected(TabItemData tabItemData)
	{
		if (curTabItemData != null)
		{
			curTabItemData.IsSelected = false;
		}
		tabItemData.IsSelected = true;
		curTabItemData = tabItemData;
		CurTabIndex = tabItemData.TabIndex;
		if (CheckSpecialTab(CurTabIndex))
		{
			ChangeViewRst.Raise();
			return;
		}
		ChangeViewRst.Raise();
		shopViewData.RequestData();
	}

	private async Task OnGoodItemClick(ShopGoodItemData goodItemData)
	{
		curOpeExcData = goodItemData.ExcData;
		ShopDefinition.OnShopGoodItemClick(goodItemData.ExcData, GetExchangeViewModel, this, "Shop");
	}

	private PropExchangeViewModel GetExchangeViewModel(ShopExcData excData)
	{
		return excData.Prop.PropTypeEnum switch
		{
			PropTypeEnum.GiftPack => exchangePackViewModel, 
			PropTypeEnum.Weapon => exchangeWeaponViewModel, 
			_ => exchangeViewModel, 
		};
	}

	private async Task OnConfirmExc(OptionArg optionArg)
	{
		if (optionArg.Obj is PropExchangeViewModel propExchangeViewModel)
		{
			curOpeUseCount = propExchangeViewModel.UseCount;
			await ShopDefinition.OnExchangeConfirm(this, propExchangeViewModel, shopViewData, OpenSDKPay);
		}
	}

	private void OnExchangeSucceed(int mainShopId, int shopId, int excId, int useCount)
	{
		shopViewData?.OnExchangeSucceed(mainShopId, shopId, excId, useCount);
	}

	private void OpenSDKPay(int payAmount, int productId, string productName)
	{
		if (!isPaying)
		{
			isPaying = true;
			IRoleService service = Singleton<ServiceSystem>.Instance.GetService<IRoleService>();
			if (service != null)
			{
				RoleViewModel roleData = service.GetRoleData();
				PlayerData playerInfo = roleData.PlayerInfo;
				MyGuildData myGuildData = Singleton<ServiceSystem>.Instance.GetService<IGuildService>()?.GetMyGuildData();
				roleData.GetMoneyData();
				PyParams pyParams = new PyParams();
				pyParams.game_Role_Id = playerInfo.Uid.ToString();
				pyParams.amount = payAmount.ToString();
				pyParams.role_name = playerInfo.Name;
				pyParams.product_Id = productId;
				pyParams.sid = Singleton<NetworkSystem>.Instance.IP;
				pyParams.serverName = Singleton<NetworkSystem>.Instance.ServerName;
				pyParams.product_name = productName;
				pyParams.vipLevel = playerInfo.Vip.ToString();
				pyParams.roleLevel = playerInfo.Level.ToString();
				pyParams.UnionName = myGuildData?.Name ?? "";
				pyParams.app_Ext1 = MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Voucher).ToString();
				Singleton<ServiceSystem>.Instance.GetService<ISDKService>().Pay(pyParams);
				isPaying = false;
			}
		}
	}

	private void OnUserPayNotify(UserPayNotify notify)
	{
		if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(notify.Error, "", showToast: false))
		{
			RefreshData();
		}
	}

	private async void RefreshData()
	{
		if (curOpeExcData != null)
		{
			OnExchangeSucceed(curOpeExcData.MainShopId, curOpeExcData.ShopId, curOpeExcData.ExcId, curOpeUseCount);
			PropExchangeViewModel propExchangeViewModel = GetExchangeViewModel(curOpeExcData);
			if (propExchangeViewModel != null)
			{
				propExchangeViewModel.SetData(curOpeExcData);
				showViewRequest.Raise(new ShowViewArg(propExchangeViewModel, isShow: false));
				propExchangeViewModel.OnEnable();
			}
		}
		shopViewData?.RefreshData();
	}

	public bool CheckSpecialTab(int tabIndex)
	{
		if (tabIndex != 999 && tabIndex != 998)
		{
			return tabIndex == 997;
		}
		return true;
	}

	public async void JumpWindow(JumpWindowParams param)
	{
		if (_jumpWindowCmd.Enabled && !string.IsNullOrEmpty(param.WindowName) && CheckOpen(this, param))
		{
			OpenViewArg openViewArg = await new UIJumpHelper().CreateViewJumpData(param, this, "ShopWindow", delegate
			{
				_jumpWindowCmd.Enabled = true;
			});
			if (openViewArg != null)
			{
				_jumpWindowCmd.Enabled = false;
				ItemOnClick(openViewArg);
			}
		}
	}

	public override void Dispose()
	{
		Singleton<ServiceSystem>.Instance.GetService<IShopService>().RemoveBindShopNotify(OnShopNotify);
		base.Dispose();
	}
}
