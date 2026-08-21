using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class GuildBuildViewModel : OptionBase
{
	private DRGuildLev curLevelData;

	private DRGuildLev nextLevelData;

	private string curLevel;

	private string nextLevel;

	private int curMemberLimit;

	private int nextMemberLimit;

	private int curFundLimit;

	private int nextFundLimit;

	private int curActiveCost;

	private int nextActiveCost;

	private List<string> nextEffects = new List<string>();

	private KnapsackItemViewModel consumePropData;

	private int consumeFundCount;

	private string consumeFundText;

	private bool showConsume;

	private string btnText;

	private bool showBtnMask;

	private bool showUpgradeInfo;

	private SimpleCommand upgradeCmd;

	private ISubscription<GuildMessage> onGuildMessage;

	public string CurLevel
	{
		get
		{
			return curLevel;
		}
		set
		{
			Set(ref curLevel, value, "CurLevel");
		}
	}

	public string NextLevel
	{
		get
		{
			return nextLevel;
		}
		set
		{
			Set(ref nextLevel, value, "NextLevel");
		}
	}

	public int CurMemberLimit
	{
		get
		{
			return curMemberLimit;
		}
		set
		{
			Set(ref curMemberLimit, value, "CurMemberLimit");
		}
	}

	public int NextMemberLimit
	{
		get
		{
			return nextMemberLimit;
		}
		set
		{
			Set(ref nextMemberLimit, value, "NextMemberLimit");
		}
	}

	public int CurFundLimit
	{
		get
		{
			return curFundLimit;
		}
		set
		{
			Set(ref curFundLimit, value, "CurFundLimit");
		}
	}

	public int NextFundLimit
	{
		get
		{
			return nextFundLimit;
		}
		set
		{
			Set(ref nextFundLimit, value, "NextFundLimit");
		}
	}

	public int CurActiveCost
	{
		get
		{
			return curActiveCost;
		}
		set
		{
			Set(ref curActiveCost, value, "CurActiveCost");
		}
	}

	public int NextActiveCost
	{
		get
		{
			return nextActiveCost;
		}
		set
		{
			Set(ref nextActiveCost, value, "NextActiveCost");
		}
	}

	public KnapsackItemViewModel ConsumePropData => consumePropData;

	public int ConsumeFundCount
	{
		get
		{
			return consumeFundCount;
		}
		set
		{
			Set(ref consumeFundCount, value, "ConsumeFundCount");
		}
	}

	public string ConsumeFundText
	{
		get
		{
			return consumeFundText;
		}
		set
		{
			Set(ref consumeFundText, value, "ConsumeFundText");
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

	public bool ShowConsume
	{
		get
		{
			return showConsume;
		}
		set
		{
			Set(ref showConsume, value, "ShowConsume");
		}
	}

	public bool ShowBtnMask
	{
		get
		{
			return showBtnMask;
		}
		set
		{
			Set(ref showBtnMask, value, "ShowBtnMask");
		}
	}

	public bool ShowUpgradeInfo
	{
		get
		{
			return showUpgradeInfo;
		}
		set
		{
			Set(ref showUpgradeInfo, value, "ShowUpgradeInfo");
		}
	}

	public List<string> NextEffects => nextEffects;

	public SimpleCommand UpgradeCmd => upgradeCmd;

	public GuildBuildViewModel()
	{
	}

	public GuildBuildViewModel(OptionBase parent, int curGuildLevel)
	{
		base.parent = parent;
		onGuildMessage = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<GuildMessage>(OnGuildMessageReceived);
		upgradeCmd = new SimpleCommand(TryUpgradeGuild);
		curLevelData = GameEntry.DataTable.GetDataRow((DRGuildLev p) => p.GuildLv == curGuildLevel);
		nextLevelData = GameEntry.DataTable.GetDataRow((DRGuildLev p) => p.GuildLv == curGuildLevel + 1);
		if (curLevelData != null)
		{
			CurLevel = $"Lv{curGuildLevel}";
			CurMemberLimit = curLevelData.MemberLimit;
			CurFundLimit = curLevelData.FundLimit;
			CurActiveCost = curLevelData.ActiveCost;
			if (nextLevelData == null)
			{
				ShowConsume = false;
				BtnText = "已达版本上限";
				ShowBtnMask = true;
				ShowUpgradeInfo = false;
				return;
			}
			NextLevel = $"Lv{nextLevelData.GuildLv}";
			NextMemberLimit = nextLevelData.MemberLimit;
			NextFundLimit = nextLevelData.FundLimit;
			NextActiveCost = nextLevelData.ActiveCost;
			nextEffects = nextLevelData.ExtraEffect;
			DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(GuildDefinition.GetGuildFundPropId());
			ConsumeFundCount = nextLevelData.GuildFund;
			consumePropData = new KnapsackItemViewModel(this, new PropData(dataRow, ConsumeFundCount));
			ShowConsume = true;
			ShowUpgradeInfo = true;
			ConsumeFundText = (((Singleton<ServiceSystem>.Instance.GetService<IGuildService>().GetMyGuildData()?.Funds ?? 0) < ConsumeFundCount) ? $"<color=red>{ConsumeFundCount}</color>" : ConsumeFundCount.ToString());
			BtnText = "升级";
			ShowBtnMask = false;
		}
	}

	private void OnGuildMessageReceived(GuildMessage message)
	{
		if (message.Type == GuildMessageEnum.GuildPermissionChange)
		{
			MyGuildData myGuildData = Singleton<ServiceSystem>.Instance.GetService<IGuildService>()?.GetMyGuildData();
			if (myGuildData == null || !GuildDefinition.CheckGuildMemberPermission(myGuildData.Position, GuildDefinition.GuildPermissions.GuildBuild))
			{
				Close();
			}
		}
	}

	private async void TryUpgradeGuild()
	{
		if (Singleton<ServiceSystem>.Instance.GetService<IGuildService>().GetMyGuildData().Funds < ConsumeFundCount)
		{
			Toast.ShowInfo("公会资金不足");
			return;
		}
		upgradeCmd.Enabled = false;
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestBuildGuild();
		loading?.Dispose();
		if (num)
		{
			Toast.ShowInfo("公会升级成功");
			Close();
		}
		else
		{
			upgradeCmd.Enabled = true;
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			OpenViewArg openViewArg = knapsackItemViewModel.OpenPopupWindow(this);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
	}

	protected override void Dispose(bool disposing)
	{
		onGuildMessage?.Dispose();
		onGuildMessage = null;
		base.Dispose(disposing);
	}
}
