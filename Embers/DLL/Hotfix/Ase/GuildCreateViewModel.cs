using System;
using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class GuildCreateViewModel : OptionBase
{
	private string guildName;

	private string guildDesc;

	private GuildDefinition.Flag guildFlag;

	private int applyLevelThreshold;

	private GuildDefinition.AuditType auditType;

	private int cosumeId;

	private string consumeIcon = "";

	private int consumeCount;

	private string consumeCountText;

	private int applyLevelMin;

	private int applyLevelMax;

	private InteractionRequest onApplyLevelThresholdChanged = new InteractionRequest();

	private SimpleCommand createCmd;

	private TabItemData curFlagTab;

	public InteractionRequest OnApplyLevelThresholdChanged => onApplyLevelThresholdChanged;

	public SimpleCommand CreateCmd => createCmd;

	public string GuildName
	{
		get
		{
			return guildName;
		}
		set
		{
			Set(ref guildName, value, "GuildName");
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

	public GuildDefinition.Flag GuildFlag
	{
		get
		{
			return guildFlag;
		}
		set
		{
			Set(ref guildFlag, value, "GuildFlag");
		}
	}

	public int ApplyLevelThreshold
	{
		get
		{
			return applyLevelThreshold;
		}
		set
		{
			Set(ref applyLevelThreshold, value, "ApplyLevelThreshold");
			onApplyLevelThresholdChanged.Raise();
		}
	}

	public GuildDefinition.AuditType AuditType
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

	public int ConsumeCount
	{
		get
		{
			return consumeCount;
		}
		set
		{
			Set(ref consumeCount, value, "ConsumeCount");
		}
	}

	public string ConsumeCountText
	{
		get
		{
			return consumeCountText;
		}
		set
		{
			Set(ref consumeCountText, value, "ConsumeCountText");
		}
	}

	public string ConsumeIcon
	{
		get
		{
			return consumeIcon;
		}
		set
		{
			Set(ref consumeIcon, value, "ConsumeIcon");
		}
	}

	public int ApplyLevelMin
	{
		get
		{
			return applyLevelMin;
		}
		set
		{
			Set(ref applyLevelMin, value, "ApplyLevelMin");
		}
	}

	public int ApplyLevelMax
	{
		get
		{
			return applyLevelMax;
		}
		set
		{
			Set(ref applyLevelMax, value, "ApplyLevelMax");
		}
	}

	public GuildCreateViewModel()
	{
	}

	public GuildCreateViewModel(OptionBase parent, GuildDefinition.Flag flag, int applyLevel, GuildDefinition.AuditType auditType)
	{
		createCmd = new SimpleCommand(TryCreateGuild);
		ApplyLevelMin = GuildDefinition.GetMinLevelForApply();
		ApplyLevelMax = GuildDefinition.GetMaxLevelForApply();
		cosumeId = GuildDefinition.GetConsumeIdForCreateGuild();
		DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(cosumeId);
		ConsumeIcon = dataRow.Icon;
		ConsumeCount = GuildDefinition.GetConsumeCountForCreateGuild();
		ConsumeCountText = string.Format("<color={0}>{1}</color>", (MoneyDefinition.GetMoneyCount((RoleMoneyEnum)cosumeId) < consumeCount) ? "red" : "white", ConsumeCount);
		base.parent = parent;
		GuildFlag = flag;
		ApplyLevelThreshold = applyLevel;
		AuditType = auditType;
		List<DRGuildConfig> list = GameEntry.DataTable.GetDataRows((DRGuildConfig p) => p.Id == 9 || p.Id == 10 || p.Id == 11).ToList();
		int index = new Random().Next(0, list.Count);
		GuildDesc = list[index].Value;
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is TabItemData flagTabSelected)
		{
			SetFlagTabSelected(flagTabSelected);
		}
	}

	private void SetFlagTabSelected(TabItemData tabItemData)
	{
		if (curFlagTab != null)
		{
			curFlagTab.IsSelected = false;
		}
		curFlagTab = tabItemData;
		curFlagTab.IsSelected = true;
		GuildFlag = (GuildDefinition.Flag)curFlagTab.TabIndex;
	}

	public void OnBtnLevelRedClick()
	{
		ApplyLevelThreshold--;
	}

	public void OnBtnLevelIncClick()
	{
		ApplyLevelThreshold++;
	}

	public void OnApplyLevelInputEndEdit(string content)
	{
		if (int.TryParse(content, out var result))
		{
			if (result >= ApplyLevelMin && result <= ApplyLevelMax)
			{
				ApplyLevelThreshold = result;
				return;
			}
			Toast.ShowInfo("该等级限制不可设定");
			onApplyLevelThresholdChanged.Raise();
		}
		else
		{
			Toast.ShowInfo("无效输入");
			onApplyLevelThresholdChanged.Raise();
		}
	}

	public void OnAuditTypeClick(GuildDefinition.AuditType at)
	{
		AuditType = at;
	}

	private async void TryCreateGuild()
	{
		createCmd.Enabled = false;
		if (!GuildDefinition.GuildNameValidityChecking(GuildName))
		{
			Toast.ShowInfo("公会名不可用");
		}
		else if (!GuildDefinition.GuildDescValidityChecking(GuildDesc))
		{
			Toast.ShowInfo("宗旨不可用");
		}
		else if (MoneyDefinition.GetMoneyCount((RoleMoneyEnum)cosumeId) < consumeCount)
		{
			Toast.ShowInfo("消耗货币不足");
		}
		else
		{
			if (!(Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetPlayerData()
				.QuitGuildCoolingSecond > 0f))
			{
				CreateGuild();
				return;
			}
			Toast.ShowInfo("主动退出公会后3小时内无法创建");
		}
		createCmd.Enabled = true;
	}

	private async void CreateGuild()
	{
		if (await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestCreateGuild(GuildName, GuildDesc, (int)GuildFlag, (int)AuditType, ApplyLevelThreshold) != null)
		{
			parent?.ItemOnClick("CloseAndOpenGuildWindow");
		}
		else
		{
			createCmd.Enabled = true;
		}
	}
}
