using System;
using System.ComponentModel;
using Sirenix.Utilities;
using UnityEngine;

namespace Ase;

public static class GuildDefinition
{
	public enum Flag
	{
		[Description("休闲")]
		Pleasure = 1,
		[Description("自由")]
		Freedom,
		[Description("竞技")]
		Combat
	}

	public enum AuditType
	{
		[Description("手动审核")]
		ManualAudit = 1,
		[Description("自动通过")]
		AutoApprove
	}

	public enum GuildPositions
	{
		[Description("会长")]
		Master = 1,
		[Description("副会长")]
		ViceMaster,
		[Description("优秀成员")]
		ExcellentMember,
		[Description("普通成员")]
		NormalMember
	}

	public enum GuildPermissions
	{
		Buff,
		ReplyApplication,
		Find,
		AuditSetting,
		DescriptionChange,
		KickMember,
		PositionChange,
		GuildInfoChange,
		GuildBuild
	}

	public enum GuildState
	{
		Normal,
		TestRun
	}

	public const float ApplicationCoolingMin = 2f;

	public const float JustQuitGuildCoolingHour = 3f;

	public const float InvitePlayerCoolingSecond = 20f;

	public const int MaxApplicationCount = 30;

	public static int GetGuildFundPropId()
	{
		DRGuildConfig dataRow = GameEntry.DataTable.GetDataRow<DRGuildConfig>(14);
		if (dataRow == null)
		{
			return 0;
		}
		int.TryParse(dataRow.Value, out var result);
		return result;
	}

	public static int GetGuildMainShopId()
	{
		return GameEntry.DataTable.GetDataRow((DRMainShopList p) => p.ShopPosition == 2)?.Id ?? 0;
	}

	public static int GetGuildMaxLevel()
	{
		int maxLevel = 0;
		GameEntry.DataTable.GetAllDataRow<DRGuildLev>()?.ForEach(delegate(DRGuildLev p)
		{
			maxLevel = Math.Max(p.GuildLv, maxLevel);
		});
		return maxLevel;
	}

	public static int GetMaxMemberCount(int level)
	{
		int result = 0;
		DRGuildLev dataRow = GameEntry.DataTable.GetDataRow((DRGuildLev p) => p.GuildLv == level);
		if (dataRow != null)
		{
			result = dataRow.MemberLimit;
		}
		return result;
	}

	public static int GetMaxViceMasterCount(int guildLevel)
	{
		int result = 0;
		DRGuildLev dataRow = GameEntry.DataTable.GetDataRow((DRGuildLev p) => p.GuildLv == guildLevel);
		if (dataRow != null)
		{
			result = dataRow.ViceLimit;
		}
		return result;
	}

	public static int GetMaxExcellentMemberCount(int guildLevel)
	{
		int result = 0;
		DRGuildLev dataRow = GameEntry.DataTable.GetDataRow((DRGuildLev p) => p.GuildLv == guildLevel);
		if (dataRow != null)
		{
			result = dataRow.ExcellentMemberLimit;
		}
		return result;
	}

	public static int GetMaxApplicationCount()
	{
		int.TryParse(GameEntry.DataTable.GetDataRow<DRGuildConfig>(8).Value, out var result);
		return result;
	}

	public static int GetMinLevelForApply()
	{
		int.TryParse(GameEntry.DataTable.GetDataRow<DRGuildConfig>(1)?.Value ?? "0", out var result);
		return result;
	}

	public static int GetMaxLevelForApply()
	{
		int.TryParse(GameEntry.DataTable.GetDataRow<DRGuildConfig>(2).Value, out var result);
		return result;
	}

	public static int GetConsumeIdForCreateGuild()
	{
		int.TryParse(GameEntry.DataTable.GetDataRow<DRGuildConfig>(3).Value, out var result);
		return result;
	}

	public static int GetConsumeCountForCreateGuild()
	{
		int.TryParse(GameEntry.DataTable.GetDataRow<DRGuildConfig>(4).Value, out var result);
		return result;
	}

	public static string GetGuildFundIcon()
	{
		return GameEntry.DataTable.GetDataRow<DRGuildConfig>(5).Value;
	}

	public static int GetInvitationCountdown()
	{
		int.TryParse(GameEntry.DataTable.GetDataRow<DRGuildConfig>(7).Value, out var result);
		return result;
	}

	public static string GetGuildCreateAlertDialog()
	{
		return GameEntry.DataTable.GetDataRow<DRGuildConfig>(13).Value.Replace("\\n", "\n");
	}

	public static int GetGuildBaseBuffId()
	{
		return GameEntry.DataTable.GetDataRow<DRGuildBuff>(1)?.Value ?? 0;
	}

	public static int GetGuildTeammateBuffId()
	{
		return GameEntry.DataTable.GetDataRow<DRGuildBuff>(2)?.Value ?? 0;
	}

	public static string GetGuildFlagIcon(int flag)
	{
		return $"GuildFlag_{flag}";
	}

	public static bool GuildNameValidityChecking(string name)
	{
		if (string.IsNullOrEmpty(name))
		{
			return false;
		}
		if (name.Contains("\n") || name.Contains("\t") || name.Contains("\r"))
		{
			return false;
		}
		if (name.Length >= 4)
		{
			return name.Length <= 12;
		}
		return false;
	}

	public static bool GuildDescValidityChecking(string desc)
	{
		if (string.IsNullOrEmpty(desc))
		{
			return false;
		}
		if (desc.Length >= 0)
		{
			return desc.Length <= 40;
		}
		return false;
	}

	public static bool GuildApplyConditionChecking(PlayerData playerData, GuildData guildData, out string msg)
	{
		IGuildService service = Singleton<ServiceSystem>.Instance.GetService<IGuildService>();
		if (service != null && service.GetMyGuildData() != null)
		{
			msg = "当前已有公会";
			return false;
		}
		if (playerData.Level < guildData.ApplyLevelThreshold)
		{
			msg = "未满足申请条件";
			return false;
		}
		if (guildData.IsFull())
		{
			msg = "公会人数已满，申请失败";
			return false;
		}
		if (playerData.QuitGuildCoolingSecond > 0f)
		{
			msg = $"主动退出公会后{3f}小时内无法申请";
			return false;
		}
		if (service != null)
		{
			service.GetGuildApplicationState(guildData.Uid, out var isCooling, out var _);
			if (isCooling)
			{
				msg = "不可重复申请";
				return false;
			}
		}
		msg = string.Empty;
		return true;
	}

	public static bool CheckGuildMemberPermission(GuildPositions position, GuildPermissions permission)
	{
		bool result = false;
		DRGuildJobInfo dataRow = GameEntry.DataTable.GetDataRow<DRGuildJobInfo>((int)position);
		if (dataRow != null)
		{
			switch (permission)
			{
			case GuildPermissions.Buff:
				result = dataRow.Buff == 1;
				break;
			case GuildPermissions.ReplyApplication:
				result = dataRow.Apply == 1;
				break;
			case GuildPermissions.Find:
				result = dataRow.Find == 1;
				break;
			case GuildPermissions.AuditSetting:
				result = dataRow.ApplySetting == 1;
				break;
			case GuildPermissions.DescriptionChange:
				result = dataRow.AimChange == 1;
				break;
			case GuildPermissions.KickMember:
				result = dataRow.Dismis == 1;
				break;
			case GuildPermissions.PositionChange:
				result = dataRow.JobChange == 1;
				break;
			case GuildPermissions.GuildInfoChange:
				result = dataRow.InfoChange == 1;
				break;
			case GuildPermissions.GuildBuild:
				result = dataRow.LevUp == 1;
				break;
			}
		}
		return result;
	}

	public static string GetStateString(int state)
	{
		char[] array = Convert.ToString(state, 2).ToCharArray();
		Array.Reverse(array);
		return new string(array);
	}

	public static Color GetPositionColor(GuildPositions position)
	{
		Color color = Color.white;
		switch (position)
		{
		case GuildPositions.Master:
			ColorUtility.TryParseHtmlString("#e7ba73", out color);
			break;
		case GuildPositions.ViceMaster:
			ColorUtility.TryParseHtmlString("#ddc298", out color);
			break;
		case GuildPositions.ExcellentMember:
			ColorUtility.TryParseHtmlString("#d4bed7", out color);
			break;
		case GuildPositions.NormalMember:
			ColorUtility.TryParseHtmlString("#dad2cd", out color);
			break;
		}
		return color;
	}
}
