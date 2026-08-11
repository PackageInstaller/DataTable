using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class GuildInfoViewModel : OptionBase
{
	private GuildDefinition.GuildPositions myPosition;

	private GuildDefinition.Flag flag;

	private string flagIcon = "";

	private string guildName;

	private string guildLevel;

	private string guildDescription;

	private string masterName;

	private string memberCount;

	private int activePoint;

	private long fund;

	private long uid;

	private string buffName;

	private string buffDetail;

	private List<string> dynamics;

	private MyGuildData myData;

	private SimpleCommand<Vector3> openReportCmd;

	private SimpleCommand openFlagChangeCmd;

	private SimpleCommand openNameChangeCmd;

	private SimpleCommand openRankCmd;

	private SimpleCommand openBuildCmd;

	private SimpleCommand openEventCmd;

	private InteractionRequest onEventMsgChanged = new InteractionRequest();

	private ISubscription<GuildMessage> onGuildMessage;

	private bool changeDescEnabled = true;

	public SimpleCommand<Vector3> OpenReportCmd => openReportCmd;

	public GuildDefinition.GuildPositions MyPosition
	{
		get
		{
			return myPosition;
		}
		private set
		{
			Set(ref myPosition, value, "MyPosition");
		}
	}

	public string FlagIcon
	{
		get
		{
			return flagIcon;
		}
		private set
		{
			Set(ref flagIcon, value, "FlagIcon");
		}
	}

	public string GuildName
	{
		get
		{
			return guildName;
		}
		private set
		{
			Set(ref guildName, value, "GuildName");
		}
	}

	public string GuildLevel
	{
		get
		{
			return guildLevel;
		}
		private set
		{
			Set(ref guildLevel, value, "GuildLevel");
		}
	}

	public string GuildDescription
	{
		get
		{
			return guildDescription;
		}
		private set
		{
			Set(ref guildDescription, value, "GuildDescription");
		}
	}

	public string MasterName
	{
		get
		{
			return masterName;
		}
		private set
		{
			Set(ref masterName, value, "MasterName");
		}
	}

	public string MemberCount
	{
		get
		{
			return memberCount;
		}
		private set
		{
			Set(ref memberCount, value, "MemberCount");
		}
	}

	public int ActivePoint
	{
		get
		{
			return activePoint;
		}
		private set
		{
			Set(ref activePoint, value, "ActivePoint");
		}
	}

	public long Fund
	{
		get
		{
			return fund;
		}
		private set
		{
			Set(ref fund, value, "Fund");
		}
	}

	public long Uid
	{
		get
		{
			return uid;
		}
		private set
		{
			Set(ref uid, value, "Uid");
		}
	}

	public string BuffName
	{
		get
		{
			return buffName;
		}
		set
		{
			Set(ref buffName, value, "BuffName");
		}
	}

	public string BuffDetail
	{
		get
		{
			return buffDetail;
		}
		set
		{
			Set(ref buffDetail, value, "BuffDetail");
		}
	}

	public List<string> Dynamics => dynamics;

	public SimpleCommand OpenFlagChangeCmd => openFlagChangeCmd;

	public SimpleCommand OpenNameChangeCmd => openNameChangeCmd;

	public SimpleCommand OpenRankCmd => openRankCmd;

	public SimpleCommand OpenBuildCmd => openBuildCmd;

	public InteractionRequest OnEventMsgChanged => onEventMsgChanged;

	public bool ChangeDescEnabled => changeDescEnabled;

	public GuildInfoViewModel()
	{
	}

	public GuildInfoViewModel(OptionBase parent)
	{
		base.parent = parent;
		openReportCmd = new SimpleCommand<Vector3>(OpenReportPopupWindow);
		openFlagChangeCmd = new SimpleCommand(OpenFlagChangeWindow);
		openNameChangeCmd = new SimpleCommand(OpenNameChangeWindow);
		openRankCmd = new SimpleCommand(OpenRankWindow);
		openBuildCmd = new SimpleCommand(OpenGuildBuildWindow);
		openEventCmd = new SimpleCommand(OpenEventMsgWindow);
		onGuildMessage = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<GuildMessage>(OnGuildMessageReceived);
		RefreshData();
		int guildBaseBuffId = GuildDefinition.GetGuildBaseBuffId();
		if (guildBaseBuffId > 0)
		{
			DRBuff dataRow = GameEntry.DataTable.GetDataRow<DRBuff>(guildBaseBuffId);
			if (dataRow != null)
			{
				BuffName = dataRow.Name;
				BuffDetail = dataRow.Desc;
			}
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is GuildEventMsgItemData)
		{
			openEventCmd.Execute(null);
		}
	}

	private void OnGuildMessageReceived(GuildMessage message)
	{
		if (message.Type == GuildMessageEnum.GuildEventNotify)
		{
			onEventMsgChanged.Raise();
		}
		else if (message.Type == GuildMessageEnum.GuildPermissionChange)
		{
			RefreshData();
		}
		else if (message.Type == GuildMessageEnum.GuildInfoChanged)
		{
			RefreshData();
		}
	}

	public void RefreshData()
	{
		MyGuildData myGuildData = Singleton<ServiceSystem>.Instance.GetService<IGuildService>().GetMyGuildData();
		if (myGuildData != null)
		{
			myData = myGuildData;
			flag = myGuildData.Flag;
			MyPosition = myGuildData.Position;
			FlagIcon = myGuildData.FlagIcon;
			GuildName = myGuildData.Name;
			GuildLevel = $"Lv{myGuildData.Level}";
			GuildDescription = myGuildData.Description;
			MasterName = myGuildData.Master?.Name ?? "";
			MemberCount = $"{myGuildData.MemberCount}/{myGuildData.MaxMemberCount}";
			ActivePoint = myGuildData.ActivePoint;
			Fund = myGuildData.Funds;
			Uid = myGuildData.Uid;
		}
	}

	public async Task TryChangeGuildDesc(string content)
	{
		changeDescEnabled = false;
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestChangeGuildDesc(content);
		loading?.Dispose();
		if (num)
		{
			Toast.ShowInfo("修改成功");
			GuildDescription = Singleton<ServiceSystem>.Instance.GetService<IGuildService>().GetMyGuildData().Description;
		}
		changeDescEnabled = true;
	}

	private void OpenReportPopupWindow(Vector3 worldPosition)
	{
		openReportCmd.Enabled = false;
		parent?.ItemOnClick(new OpenViewArg(typeof(ReportPopupWindow), new ReportPopupViewModel(parent, worldPosition, ReportTypeEnum.Guild, GuildName, Uid), "GuildInfo", isOpenWindow: true, "DEFAULT", delegate
		{
			openReportCmd.Enabled = true;
		}));
	}

	private void OpenFlagChangeWindow()
	{
		openFlagChangeCmd.Enabled = false;
		parent?.ItemOnClick(new OpenViewArg(typeof(GuildFlagChangeWindow), new GuildFlagChangeViewModel(parent, flag), "GuildInfo", isOpenWindow: true, "DEFAULT", delegate
		{
			RefreshData();
			openFlagChangeCmd.Enabled = true;
		}));
	}

	private void OpenNameChangeWindow()
	{
		openNameChangeCmd.Enabled = false;
		InputConfirmViewModel vm = new InputConfirmViewModel(parent);
		vm.Title = "公会改名";
		vm.PlaceholderText = "请输入公会名字";
		vm.CharacterLimit = 12;
		vm.SetConfirmCallback(delegate(string content)
		{
			if (!GuildDefinition.GuildNameValidityChecking(content))
			{
				Toast.ShowInfo("该名称不符合规范");
			}
			else
			{
				TryChangeGuildName(content);
				vm.Close();
			}
		});
		parent?.ItemOnClick(new OpenViewArg(typeof(InputConfirmWindow), vm, "GuildInfo", isOpenWindow: true, "DEFAULT", delegate
		{
			openNameChangeCmd.Enabled = true;
		}));
	}

	private async void OpenRankWindow()
	{
		openRankCmd.Enabled = false;
		RankViewModel rankVm = new RankViewModel(this, RankDefinition.GetGuildActiveRankTypeId());
		await rankVm.RequestHeroChallengeData();
		parent?.ItemOnClick(new OpenViewArg(typeof(RankWindow), rankVm, "GuildInfo", isOpenWindow: true, "DEFAULT", delegate
		{
			openRankCmd.Enabled = true;
		}));
	}

	private void OpenGuildBuildWindow()
	{
		openBuildCmd.Enabled = false;
		GuildBuildViewModel userData = new GuildBuildViewModel(parent, myData.Level);
		parent?.ItemOnClick(new OpenViewArg(typeof(GuildBuildWindow), userData, "GuildInfo", isOpenWindow: true, "DEFAULT", delegate
		{
			openBuildCmd.Enabled = true;
		}));
	}

	private void OpenEventMsgWindow()
	{
		openEventCmd.Enabled = false;
		parent?.ItemOnClick(new OpenViewArg(typeof(GuildEventMsgWindow), new GuildEventMsgViewModel(parent), "GuildInfo", isOpenWindow: true, "DEFAULT", delegate
		{
			openEventCmd.Enabled = true;
		}));
	}

	private async void TryChangeGuildName(string content)
	{
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestChangeGuildName(content);
		loading?.Dispose();
		if (num)
		{
			Toast.ShowInfo("修改成功");
			RefreshData();
		}
	}
}
