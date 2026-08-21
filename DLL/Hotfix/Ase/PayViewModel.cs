using System.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public class PayViewModel : OptionBase
{
	private DRMonthlyCard configData;

	private string rewardIcon = "";

	private int rewardCount;

	private string dailyRewardIcon = "";

	private int dailyRewardCount;

	private string btnText;

	private bool buyed;

	private int leftRewardDay;

	private bool todayAlreadyGet;

	private SimpleCommand buyCmd;

	private ISubscription<UserPayNotify> userPayNotify;

	public bool Buyed
	{
		get
		{
			return buyed;
		}
		set
		{
			Set(ref buyed, value, "Buyed");
		}
	}

	public int LeftRewardDay
	{
		get
		{
			return leftRewardDay;
		}
		set
		{
			Set(ref leftRewardDay, value, "LeftRewardDay");
		}
	}

	public bool TodayAlreadyGet
	{
		get
		{
			return todayAlreadyGet;
		}
		set
		{
			Set(ref todayAlreadyGet, value, "TodayAlreadyGet");
		}
	}

	public string RewardIcon
	{
		get
		{
			return rewardIcon;
		}
		private set
		{
			Set(ref rewardIcon, value, "RewardIcon");
		}
	}

	public int RewardCount
	{
		get
		{
			return rewardCount;
		}
		private set
		{
			Set(ref rewardCount, value, "RewardCount");
		}
	}

	public string DailyRewardIcon
	{
		get
		{
			return dailyRewardIcon;
		}
		private set
		{
			Set(ref dailyRewardIcon, value, "DailyRewardIcon");
		}
	}

	public int DailyRewardCount
	{
		get
		{
			return dailyRewardCount;
		}
		private set
		{
			Set(ref dailyRewardCount, value, "DailyRewardCount");
		}
	}

	public string BtnText
	{
		get
		{
			return btnText;
		}
		set
		{
			Set(ref btnText, value, "BtnText");
		}
	}

	public SimpleCommand BuyCmd => buyCmd;

	public PayViewModel()
	{
	}

	public PayViewModel(OptionBase parent)
	{
		base.parent = parent;
		buyCmd = new SimpleCommand(TryBuy);
		userPayNotify = Singleton<NetworkSystem>.Instance.Subscribe<UserPayNotify>(OnUserPayNotify);
		Refresh();
	}

	private void Refresh()
	{
		DRMonthlyCard[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRMonthlyCard>();
		if (allDataRow != null && allDataRow.Length != 0)
		{
			configData = allDataRow[0];
			int monthlyCardLeftDay = Singleton<ServiceSystem>.Instance.GetService<IShopService>().GetMonthlyCardLeftDay();
			bool monthlyCardTodayGot = Singleton<ServiceSystem>.Instance.GetService<IShopService>().GetMonthlyCardTodayGot();
			Buyed = monthlyCardLeftDay >= 0;
			LeftRewardDay = monthlyCardLeftDay;
			TodayAlreadyGet = monthlyCardTodayGot;
			DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(configData.BuyRewardID);
			if (dataRow != null)
			{
				RewardIcon = dataRow.Icon;
			}
			DRProp dataRow2 = GameEntry.DataTable.GetDataRow<DRProp>(configData.DailyRewardID);
			if (dataRow2 != null)
			{
				DailyRewardIcon = dataRow2.Icon;
			}
			RewardCount = configData.BuyRewardNum;
			DailyRewardCount = configData.DailyRewardNum;
			BtnText = (Buyed ? ("续订" + configData.UIPrice) : ("购买" + configData.UIPrice));
		}
	}

	private async void TryBuy()
	{
		if (configData == null)
		{
			Toast.ShowInfo("配置异常");
			return;
		}
		buyCmd.Enabled = false;
		Loading loading = await Loading.Show();
		bool num = await GetBuyEnable();
		loading?.Dispose();
		if (num)
		{
			OpenSDKPay(configData.Price, 99999999, "提灯养护卡");
		}
		buyCmd.Enabled = true;
	}

	private async Task<bool> GetBuyEnable()
	{
		return await Singleton<ServiceSystem>.Instance.GetService<IShopService>().RequestBuyMonthlyCard();
	}

	private void OnUserPayNotify(UserPayNotify notify)
	{
		if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(notify.Error, "提灯养护卡购买失败"))
		{
			RequestMonthlyCardInfo();
		}
	}

	private async void RequestMonthlyCardInfo()
	{
		Loading loading = await Loading.Show();
		await Singleton<ServiceSystem>.Instance.GetService<IShopService>().RequestGetMonthlyCardInfo();
		loading?.Dispose();
		Refresh();
	}

	private void OpenSDKPay(int payAmount, int productId, string productName)
	{
		ShopDefinition.OpenSDKPay(payAmount, productId, productName);
	}

	protected override void Dispose(bool disposing)
	{
		userPayNotify?.Dispose();
		userPayNotify = null;
		base.Dispose(disposing);
	}
}
