using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public class GuildRecommendViewModel : OptionBase
{
	private List<GuildData> recommendGuilds = new List<GuildData>();

	private List<GuildData> displayGuilds = new List<GuildData>();

	private GuildItemData selectItem;

	private GuildData selectGuild;

	private string headFrameIcon = "";

	private string headIcon = "";

	private string masterName;

	private string masterLevel;

	private string guildDesc;

	private string applyLevelThreshold;

	private string auditType;

	private string guildUid;

	private bool showInfo;

	private string noTips = string.Empty;

	private bool isSearching;

	private bool showBtnApplyMask;

	private SimpleCommand requestRecommendGuild;

	private SimpleCommand<string> requestSearchGuild;

	private SimpleCommand requestFastJoinCmd;

	private SimpleCommand requestJoinInGuildCmd;

	private InteractionRequest refreshDisplayGuilds = new InteractionRequest();

	public List<GuildData> DisplayGuilds => displayGuilds;

	public GuildData SelectGuild
	{
		get
		{
			return selectGuild;
		}
		private set
		{
			Set(ref selectGuild, value, "SelectGuild");
		}
	}

	public string HeadFrameIcon
	{
		get
		{
			return headFrameIcon;
		}
		set
		{
			Set(ref headFrameIcon, value, "HeadFrameIcon");
		}
	}

	public string HeadIcon
	{
		get
		{
			return headIcon;
		}
		set
		{
			Set(ref headIcon, value, "HeadIcon");
		}
	}

	public string MasterName
	{
		get
		{
			return masterName;
		}
		set
		{
			Set(ref masterName, value, "MasterName");
		}
	}

	public string MasterLevel
	{
		get
		{
			return masterLevel;
		}
		set
		{
			Set(ref masterLevel, value, "MasterLevel");
		}
	}

	public string GuildDesc
	{
		get
		{
			return guildDesc;
		}
		set
		{
			Set(ref guildDesc, value, "GuildDesc");
		}
	}

	public string ApplyLevelThreshold
	{
		get
		{
			return applyLevelThreshold;
		}
		set
		{
			Set(ref applyLevelThreshold, value, "ApplyLevelThreshold");
		}
	}

	public string AuditType
	{
		get
		{
			return auditType;
		}
		set
		{
			Set(ref auditType, value, "AuditType");
		}
	}

	public string GuildUid
	{
		get
		{
			return guildUid;
		}
		set
		{
			Set(ref guildUid, value, "GuildUid");
		}
	}

	public string NoTips
	{
		get
		{
			return noTips;
		}
		set
		{
			Set(ref noTips, value, "NoTips");
		}
	}

	public bool IsSearching
	{
		get
		{
			return isSearching;
		}
		set
		{
			Set(ref isSearching, value, "IsSearching");
		}
	}

	public bool ShowBtnApplyMask
	{
		get
		{
			return showBtnApplyMask;
		}
		set
		{
			Set(ref showBtnApplyMask, value, "ShowBtnApplyMask");
		}
	}

	public bool ShowInfo
	{
		get
		{
			return showInfo;
		}
		set
		{
			Set(ref showInfo, value, "ShowInfo");
		}
	}

	public SimpleCommand RequestRecommendGuild => requestRecommendGuild;

	public SimpleCommand RequestFastJoinCmd => requestFastJoinCmd;

	public SimpleCommand RequestJoinInGuildCmd => requestJoinInGuildCmd;

	public InteractionRequest RefreshDisplayGuilds => refreshDisplayGuilds;

	public GuildRecommendViewModel()
	{
	}

	public GuildRecommendViewModel(OptionBase parent)
	{
		base.parent = parent;
		requestRecommendGuild = new SimpleCommand(RefreshRecommendDatas);
		requestSearchGuild = new SimpleCommand<string>(RequestSearchGuild);
		requestFastJoinCmd = new SimpleCommand(RequestFastJoinGuild);
		requestJoinInGuildCmd = new SimpleCommand(RequestJoinInGuild);
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is GuildItemData guildItemData)
		{
			SetSelectGuild(guildItemData);
		}
		else if (obj is OptionArg { OptionName: "OpenReport" } optionArg)
		{
			parent?.ItemOnClick(optionArg);
		}
	}

	private void SetSelectGuild(GuildItemData itemData)
	{
		if (selectItem != null)
		{
			selectItem.Selected = false;
		}
		selectItem = itemData;
		selectItem.Selected = true;
		SelectGuild = itemData.GuildData;
		if (SelectGuild == null)
		{
			ShowInfo = false;
			return;
		}
		ShowInfo = true;
		GuildDesc = SelectGuild.Description;
		ApplyLevelThreshold = $"可申请等级：{SelectGuild.ApplyLevelThreshold}";
		AuditType = "审核类型：" + SelectGuild.AuditType.GetDescription();
		GuildUid = $"公会编号：{SelectGuild.Uid}";
		GuildMemberData master = SelectGuild.Master;
		HeadFrameIcon = $"HeadAdorn{master.IconFrame}";
		HeadIcon = master.Icon;
		MasterName = master.Name;
		MasterLevel = $"Lv.{master.Level}";
		Singleton<ServiceSystem>.Instance.GetService<IGuildService>().GetGuildApplicationState(SelectGuild.Uid, out var isCooling, out var _);
		ShowBtnApplyMask = isCooling;
	}

	private void RefreshDisplay(bool isSearching, GuildData searchGuild = null)
	{
		SelectGuild = null;
		IsSearching = isSearching;
		if (isSearching)
		{
			displayGuilds = new List<GuildData>();
			if (searchGuild != null)
			{
				displayGuilds.Add(searchGuild);
			}
			List<GuildData> list = displayGuilds;
			NoTips = ((list != null && list.Count > 0) ? string.Empty : "未搜索到结果");
		}
		else
		{
			displayGuilds = recommendGuilds;
			List<GuildData> list2 = displayGuilds;
			NoTips = ((list2 != null && list2.Count > 0) ? string.Empty : "暂无公会");
		}
		List<GuildData> list3 = displayGuilds;
		ShowInfo = list3 != null && list3.Count > 0;
		refreshDisplayGuilds.Raise();
	}

	public void OnInputFieldEndEdit(string content)
	{
		if (string.IsNullOrEmpty(content))
		{
			RefreshDisplay(isSearching: false);
		}
		else
		{
			requestSearchGuild.Execute(content);
		}
	}

	private async void RefreshRecommendDatas()
	{
		requestRecommendGuild.Enabled = false;
		Loading loading = await Loading.Show();
		List<GuildData> list = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RefreshRecommendGuildData();
		loading?.Dispose();
		recommendGuilds.Clear();
		if (list != null)
		{
			recommendGuilds = list;
		}
		RefreshDisplay(isSearching: false);
		requestRecommendGuild.Enabled = true;
	}

	public async Task RequestRecommendDatas(int type)
	{
		Loading loading = await Loading.Show();
		List<GuildData> list = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestRecommendGuildData(type);
		loading?.Dispose();
		recommendGuilds.Clear();
		if (list != null)
		{
			recommendGuilds = list;
		}
		RefreshDisplay(isSearching: false);
	}

	private async void RequestSearchGuild(string content)
	{
		requestSearchGuild.Enabled = false;
		Loading loading = await Loading.Show();
		GuildData searchGuild = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestSearchGuild(content);
		loading?.Dispose();
		RefreshDisplay(isSearching: true, searchGuild);
		requestSearchGuild.Enabled = true;
	}

	private async void RequestFastJoinGuild()
	{
		requestFastJoinCmd.Enabled = false;
		Loading loading = await Loading.Show();
		MyGuildData obj = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestJoinInGuildFast();
		loading?.Dispose();
		if (obj != null)
		{
			parent?.ItemOnClick("CloseAndOpenGuildWindow");
		}
		else
		{
			requestFastJoinCmd.Enabled = true;
		}
	}

	private async void RequestJoinInGuild()
	{
		if (SelectGuild == null)
		{
			return;
		}
		if (!GuildDefinition.GuildApplyConditionChecking(Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo, SelectGuild, out var msg))
		{
			if (!string.IsNullOrEmpty(msg))
			{
				Toast.ShowInfo(msg);
			}
			return;
		}
		requestJoinInGuildCmd.Enabled = false;
		Loading loading = await Loading.Show();
		long uid = SelectGuild.Uid;
		if (!(await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestJoinInGuild(uid, OnApplyCoolingCompleted)))
		{
			loading?.Dispose();
			requestJoinInGuildCmd.Enabled = true;
			return;
		}
		MyGuildData obj = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestMyGuildData();
		loading?.Dispose();
		Toast.ShowInfo("已申请");
		if (SelectGuild != null && SelectGuild.Uid == uid)
		{
			ShowBtnApplyMask = true;
		}
		if (obj != null)
		{
			parent?.ItemOnClick("CloseAndOpenGuildWindow");
		}
		else
		{
			requestJoinInGuildCmd.Enabled = true;
		}
	}

	private void OnApplyCoolingCompleted(long uid)
	{
		if (SelectGuild != null && SelectGuild.Uid == uid)
		{
			ShowBtnApplyMask = false;
		}
	}
}
