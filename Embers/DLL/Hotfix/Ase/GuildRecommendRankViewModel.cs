using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public class GuildRecommendRankViewModel : OptionBase
{
	private GuildRankItemData selectItem;

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

	private bool showBtnApplyMask;

	private List<KeyValuePair<int, GuildData>> rankDatas = new List<KeyValuePair<int, GuildData>>();

	private InteractionRequest onRankDatasChanged = new InteractionRequest();

	private SimpleCommand requestJoinInGuildCmd;

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

	public List<KeyValuePair<int, GuildData>> RankDatas => rankDatas;

	public InteractionRequest OnRankDatasChanged => onRankDatasChanged;

	public SimpleCommand RequestJoinInGuildCmd => requestJoinInGuildCmd;

	public GuildRecommendRankViewModel()
	{
	}

	public GuildRecommendRankViewModel(OptionBase parent)
	{
		base.parent = parent;
		requestJoinInGuildCmd = new SimpleCommand(RequestJoinInGuild);
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is GuildRankItemData guildRankItemData)
		{
			SetSelectGuild(guildRankItemData);
		}
		else if (obj is OptionArg { OptionName: "OpenReport" } optionArg)
		{
			parent?.ItemOnClick(optionArg);
		}
	}

	public async Task RequestRankDatas()
	{
		Loading loading = await Loading.Show();
		List<GuildData> list = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestGuildRankData();
		loading?.Dispose();
		if (list != null)
		{
			rankDatas.Clear();
			for (int i = 1; i <= list.Count; i++)
			{
				rankDatas.Add(new KeyValuePair<int, GuildData>(i, list[i - 1]));
			}
			NoTips = ((list.Count > 0) ? string.Empty : "暂无公会排行");
			onRankDatasChanged.Raise();
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

	private void SetSelectGuild(GuildRankItemData itemData)
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
}
