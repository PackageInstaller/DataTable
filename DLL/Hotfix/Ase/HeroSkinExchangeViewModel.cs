using GameFramework.Runtime;

namespace Ase;

public class HeroSkinExchangeViewModel : OptionBase
{
	private ShopExcData _shopInfoData;

	private int _heroSkinId;

	private string _skinIcon = "";

	private string _skinName;

	private string _heroName;

	private string _skinDesc;

	private string _quota;

	private string _priceIcon = "";

	private string _priceCount;

	private bool _confirmEnabled;

	private string _confirmText;

	public int HeroSkinId => _heroSkinId;

	public string SkinIcon
	{
		get
		{
			return _skinIcon;
		}
		set
		{
			Set(ref _skinIcon, value, "SkinIcon");
		}
	}

	public string SkinName
	{
		get
		{
			return _skinName;
		}
		set
		{
			Set(ref _skinName, value, "SkinName");
		}
	}

	public string HeroName
	{
		get
		{
			return _heroName;
		}
		set
		{
			Set(ref _heroName, value, "HeroName");
		}
	}

	public string SkinDesc
	{
		get
		{
			return _skinDesc;
		}
		set
		{
			Set(ref _skinDesc, value, "SkinDesc");
		}
	}

	public string Quota
	{
		get
		{
			return _quota;
		}
		set
		{
			Set(ref _quota, value, "Quota");
		}
	}

	public string PriceIcon
	{
		get
		{
			return _priceIcon;
		}
		set
		{
			Set(ref _priceIcon, value, "PriceIcon");
		}
	}

	public string PriceCount
	{
		get
		{
			return _priceCount;
		}
		set
		{
			Set(ref _priceCount, value, "PriceCount");
		}
	}

	public bool ConfirmEnabled
	{
		get
		{
			return _confirmEnabled;
		}
		set
		{
			Set(ref _confirmEnabled, value, "ConfirmEnabled");
		}
	}

	public string ConfirmText
	{
		get
		{
			return _confirmText;
		}
		set
		{
			Set(ref _confirmText, value, "ConfirmText");
		}
	}

	public SimpleCommand ConfirmCmd { get; }

	public HeroSkinExchangeViewModel()
	{
	}

	public HeroSkinExchangeViewModel(OptionBase parent)
	{
		base.parent = parent;
		ConfirmCmd = new SimpleCommand(Confirm);
	}

	public void RefreshData(ShopExcData shopExcData)
	{
		if (shopExcData?.Prop == null || shopExcData.Prop.Empty)
		{
			return;
		}
		int id = shopExcData.Prop.Id;
		DRUIHeroSkin dataRow = GameEntry.DataTable.GetDataRow<DRUIHeroSkin>(id);
		if (dataRow != null)
		{
			DRHeroInfo dataRow2 = GameEntry.DataTable.GetDataRow<DRHeroInfo>(dataRow.HeroID);
			_heroSkinId = id;
			_shopInfoData = shopExcData;
			SkinIcon = StreamerMode.GetHeroSkinIcon(dataRow);
			SkinName = dataRow.SkinName;
			HeroName = ((dataRow2 != null) ? (dataRow2.Name + "可适用") : "");
			SkinDesc = dataRow.SkinDesc;
			bool heroSkinOwnerShopSituation = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroSkinOwnerShopSituation(id);
			if (shopExcData.ConsumeSchemes.Count > 0 && shopExcData.ConsumeSchemes[0].Count > 0)
			{
				PropDataBase propDataBase = shopExcData.ConsumeSchemes[0][0];
				PriceIcon = propDataBase.Icon;
				PriceCount = $"{propDataBase.Amount}";
				ConfirmEnabled = !heroSkinOwnerShopSituation && PropHelper.CheckPropEnough(propDataBase.Id, propDataBase.Amount);
			}
			else
			{
				ConfirmEnabled = false;
			}
			Quota = (heroSkinOwnerShopSituation ? "已拥有" : "限购:1/1");
			ConfirmText = "确认";
		}
	}

	private async void Confirm()
	{
		if (_heroSkinId > 0 && !Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroSkinOwnerShopSituation(_heroSkinId))
		{
			ConfirmCmd.Enabled = false;
			Loading loading = await Loading.Show();
			RewardGetData rewardGetData = await Singleton<ServiceSystem>.Instance.GetService<IShopService>().RequestShopExchange(_shopInfoData.MainShopId, _shopInfoData.ShopId, _shopInfoData.ExcId, 1, 0);
			loading?.Dispose();
			if (rewardGetData != null && rewardGetData.HeroSkinList.Count > 0)
			{
				parent?.ItemOnClick(new OptionArg(this, "OnHeroSkinExchangeSucceed"));
			}
			ConfirmCmd.Enabled = true;
		}
	}
}
