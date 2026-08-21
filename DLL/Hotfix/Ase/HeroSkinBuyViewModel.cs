using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class HeroSkinBuyViewModel : OptionBase
{
	private List<HeroSkinShopItemData> _allSkinShopItemDatas = new List<HeroSkinShopItemData>();

	private HeroSkinShopItemData _curShopItemData;

	private SimpleCommand _buyCmd;

	private InteractionRequest _refreshSkinSpineRst = new InteractionRequest();

	private string _skinSpinePath;

	private int _maxIndex;

	private int _curIndex;

	private HeroSkinExchangeViewModel heroSkinExcViewModel;

	public InteractionRequest RefreshSkinSpineRst => _refreshSkinSpineRst;

	public string SkinSpinePath
	{
		get
		{
			return _skinSpinePath;
		}
		set
		{
			Set(ref _skinSpinePath, value, "SkinSpinePath");
		}
	}

	public SimpleCommand BuyCmd => _buyCmd;

	public List<HeroSkinShopItemData> AllSkinShopItemDatas => _allSkinShopItemDatas;

	public HeroSkinShopItemData CurShopItemData
	{
		get
		{
			return _curShopItemData;
		}
		set
		{
			Set(ref _curShopItemData, value, "CurShopItemData");
		}
	}

	public int MaxIndex
	{
		get
		{
			return _maxIndex;
		}
		set
		{
			Set(ref _maxIndex, value, "MaxIndex");
		}
	}

	public int CurIndex
	{
		get
		{
			return _curIndex;
		}
		set
		{
			if (MaxIndex <= 0)
			{
				value = 0;
			}
			else if (value < 0)
			{
				value = MaxIndex;
			}
			else if (value > MaxIndex)
			{
				value = 0;
			}
			Set(ref _curIndex, value, "CurIndex");
		}
	}

	public HeroSkinBuyViewModel()
	{
	}

	public HeroSkinBuyViewModel(OptionBase parent, List<HeroSkinShopItemData> shopItemDatas, HeroSkinShopItemData selectData = null)
	{
		base.parent = parent;
		_buyCmd = new SimpleCommand(TryBuy);
		_allSkinShopItemDatas = shopItemDatas;
		List<HeroSkinShopItemData> allSkinShopItemDatas = _allSkinShopItemDatas;
		MaxIndex = ((allSkinShopItemDatas != null) ? (allSkinShopItemDatas.Count - 1) : 0);
		if (_allSkinShopItemDatas == null || _allSkinShopItemDatas.Count <= 0 || selectData == null)
		{
			CurIndex = 0;
			CurShopItemData = new HeroSkinShopItemData();
		}
		else
		{
			int num = _allSkinShopItemDatas.FindIndex((HeroSkinShopItemData p) => p.ExcData.ExcId == selectData.ExcData.ExcId);
			CurIndex = ((num >= 0) ? num : 0);
			CurShopItemData = _allSkinShopItemDatas[CurIndex];
		}
		RefreshData();
	}

	private void RefreshData()
	{
		if (CurShopItemData.ExcData != null)
		{
			DRUIHeroSkin dataRow = GameEntry.DataTable.GetDataRow<DRUIHeroSkin>(CurShopItemData.ExcData.Prop.Id);
			if (dataRow != null)
			{
				SkinSpinePath = HeroDefinition.GetHeroOriginalPath(dataRow.HeroID, dataRow.Suffix);
				_refreshSkinSpineRst.Raise();
			}
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is OptionArg optionArg && "OnHeroSkinExchangeSucceed".Equals(optionArg.OptionName) && optionArg.Obj is HeroSkinExchangeViewModel exchangeVm)
		{
			OnHeroSkinExchangeSucceed(exchangeVm);
		}
	}

	public void SwitchPre()
	{
		CurIndex--;
		HeroSkinShopItemData curShopItemData = CurShopItemData;
		CurShopItemData = _allSkinShopItemDatas[CurIndex];
		if (curShopItemData == null || curShopItemData.ExcData.ExcId != CurShopItemData.ExcData.ExcId)
		{
			RefreshData();
		}
	}

	public void SwitchNext()
	{
		CurIndex++;
		HeroSkinShopItemData curShopItemData = CurShopItemData;
		CurShopItemData = _allSkinShopItemDatas[CurIndex];
		if (curShopItemData == null || curShopItemData.ExcData.ExcId != CurShopItemData.ExcData.ExcId)
		{
			RefreshData();
		}
	}

	private void TryBuy()
	{
		if (CurShopItemData?.ExcData == null)
		{
			return;
		}
		ShopExcData excData = CurShopItemData.ExcData;
		List<List<PropDataBase>> consumeSchemes = excData.ConsumeSchemes;
		if (consumeSchemes.Count > 0 && consumeSchemes[0].Count > 0)
		{
			int id = excData.ConsumeSchemes[0][0].Id;
			int amount = excData.ConsumeSchemes[0][0].Amount;
			if (!ShopDefinition.GoodSpecialPriceEnoughCheck(id, amount, out var leftNeedCount))
			{
				ShopDefinition.OpenSpConsumeExcDialog(id, leftNeedCount, this);
				return;
			}
		}
		if (excData.CashPriceCount > 0 || excData.CashPriceOriginalCount > 0)
		{
			OpenSDKPay(excData.CashPriceCount, excData.ExcId, "烬天使皮肤购买");
		}
		else if (heroSkinExcViewModel == null)
		{
			heroSkinExcViewModel = new HeroSkinExchangeViewModel(this);
			AddChild(heroSkinExcViewModel);
			heroSkinExcViewModel.RefreshData(excData);
			openWindowRequest.Raise(new OpenViewArg(typeof(HeroSkinExchangeView), heroSkinExcViewModel, "Shop", isOpenWindow: false));
		}
		else
		{
			heroSkinExcViewModel.RefreshData(excData);
			showViewRequest.Raise(new ShowViewArg(heroSkinExcViewModel, isShow: true));
		}
	}

	private void OnHeroSkinExchangeSucceed(HeroSkinExchangeViewModel exchangeVm)
	{
		parent?.ItemOnClick(new OptionArg(exchangeVm, "OnHeroSkinExchangeSucceed"));
		DRUIHeroSkin dataRow = GameEntry.DataTable.GetDataRow<DRUIHeroSkin>(exchangeVm.HeroSkinId);
		if (dataRow != null)
		{
			openWindowRequest.Raise(new OpenViewArg(typeof(HeroSkinGetWindow), new HeroSkinGetViewModel(this, dataRow)));
		}
		showViewRequest.Raise(new ShowViewArg(heroSkinExcViewModel, isShow: false));
	}

	private void OpenSDKPay(int payAmount, int productId, string productName)
	{
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
		}
	}
}
