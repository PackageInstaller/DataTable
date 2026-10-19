using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.UI;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine.Localization;

namespace ACT.MissionSystem;

public class PermissionLevelCondition : MissionCondition
{
	private sealed class PermissionLevelHyperLink : IConditionDescriptionHyperLink
	{
		private readonly int _systemId;

		public PermissionLevelHyperLink(int systemId)
		{
			_systemId = systemId;
		}

		public void OnClick()
		{
			if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(_systemId))
			{
				Singleton<SystemUnlockManager>.instance.ShowUnlockTip(_systemId);
			}
			else
			{
				OpenSystem(_systemId);
			}
		}
	}

	private LocalizedString m_Description;

	internal static IConditionDescriptionHyperLink CreateHyperLink(int systemId)
	{
		return new PermissionLevelHyperLink(systemId);
	}

	public override IEnumerable<ConditionDescription> GetDescriptions()
	{
		object param = Param;
		if (!(param is PermissionLevelConditionParam { systemIds: not null } param2))
		{
			yield break;
		}
		if (Desc != 0)
		{
			if (m_Description == null)
			{
				m_Description = new LocalizedString(LocalizationUtility.localizeTableName_shortcommon, Desc);
			}
			yield return new ConditionDescription
			{
				HaveContent = (Desc != 0),
				DescriptionContent = m_Description
			};
		}
		foreach (int systemId in param2.systemIds)
		{
			SystemOpen data = CoreUtils.GetData(systemId, RuntimeConfigs.data.systemOpens);
			if (data != null)
			{
				yield return new ConditionDescription
				{
					HaveHyperLink = true,
					HyperLinkTextId = data.localNameId,
					DescriptionContentTable = LocalizationUtility.localizeTableName_shortcommon,
					HyperLinkLogic = new PermissionLevelHyperLink(systemId)
				};
			}
		}
	}

	protected override async void OnInMissionWorld()
	{
		do
		{
			if (CheckCondition())
			{
				await MarkSuccess();
				if (!IsRepeat)
				{
					break;
				}
			}
			await UniTask.Yield();
		}
		while (InMissionWorld);
	}

	public override bool PreCheckCondition()
	{
		return CheckCondition();
	}

	private bool CheckCondition()
	{
		if (!(Param is PermissionLevelConditionParam permissionLevelConditionParam))
		{
			return false;
		}
		return SystemUnlockManager.playerLevel >= permissionLevelConditionParam.level;
	}

	internal static void OpenSystem(int systemId)
	{
		switch ((SystemType)systemId)
		{
		case SystemType.Bag:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_BAGPANEL);
			break;
		case SystemType.Weapon:
		case SystemType.CharacterSkill:
		case SystemType.Equip:
		case SystemType.Destiny:
		case SystemType.CharacterView:
		case SystemType.Elitist:
		case SystemType.ChipBtn:
		case SystemType.SkillBtn:
		case SystemType.LevelBtn:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHARACTER);
			break;
		case SystemType.DrawCard:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CARDDRAW);
			break;
		case SystemType.HandBook:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_HANDBOOK);
			break;
		case SystemType.Mission:
		case SystemType.DailyMission:
		case SystemType.WipeOutMission:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TASK);
			break;
		case SystemType.Team:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEAM);
			break;
		case SystemType.Abyss:
		case SystemType.CycleAbyss:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ABYSSLIST);
			break;
		case SystemType.Training:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TRAININGGROUND);
			break;
		case SystemType.Shop:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_SHOP);
			break;
		case SystemType.MapUnLock:
		case SystemType.ArsenalMapUnlock:
		case SystemType.AurumMapUnlock:
		case SystemType.SewerMapUnlock:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_LARGEMAP);
			break;
		case SystemType.SystemGuide:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_SYSTEMGUIDE);
			break;
		case SystemType.Message:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_SNS);
			break;
		case SystemType.Mailbox:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_MAILBOXPANEL);
			break;
		case SystemType.Announcement:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ANNOUNCEMENT);
			break;
		case SystemType.Settings:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_SETTINGS);
			break;
		case SystemType.Collection:
		case SystemType.Treasure:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ITEMTREASURECENTER);
			break;
		case SystemType.BloodBottleUse:
		case SystemType.BloodBottleCultivate:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_BLOODBOTTLE);
			break;
		case SystemType.Raid:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_RAID);
			break;
		case SystemType.BattlePass:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_BATTLEPASS);
			break;
		case SystemType.Lounge:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_LOUNGEMAIN);
			break;
		case SystemType.TextLibrary:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTLIBRARY);
			break;
		case SystemType.Rogue:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ROGUEENTRANCE);
			break;
		case SystemType.Activity:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ACTIVITYCENTER);
			break;
		case SystemType.Craft:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMCRAFTING);
			break;
		case SystemType.Temple:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEMPLEENTRANCE);
			break;
		case SystemType.LevelUp:
		case SystemType.PlayerWorldLevel:
		case SystemType.Break:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_MONOJOURNEYTRACESVIEW);
			break;
		default:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ESC);
			break;
		}
	}
}
