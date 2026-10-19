using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public abstract class DungeonCompletionConditionBase : MissionCondition
{
	private sealed class DungeonConditionHyperLink : IConditionDescriptionHyperLink
	{
		private readonly int _systemId;

		private readonly int _targetId;

		public DungeonConditionHyperLink(int systemId, int targetId)
		{
			_systemId = systemId;
			_targetId = targetId;
		}

		public void OnClick()
		{
			if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(_systemId))
			{
				Singleton<SystemUnlockManager>.instance.ShowUnlockTip(_systemId);
				return;
			}
			switch ((SystemType)_systemId)
			{
			case SystemType.Rogue:
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ROGUEENTRANCE);
				break;
			case SystemType.Abyss:
			case SystemType.CycleAbyss:
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ABYSSLIST, new MonoAbyssListData
				{
					IsOpenAbyssTeamPanel = true,
					AbyssId = _targetId
				});
				break;
			case SystemType.Training:
				OpenTrainingRaid(_targetId);
				break;
			default:
				PermissionLevelCondition.OpenSystem(_systemId);
				break;
			}
		}

		private static void OpenTrainingRaid(int raidId)
		{
			int num = FindRaidEntrance(raidId);
			if (num <= 0)
			{
				PermissionLevelCondition.OpenSystem(1024);
				return;
			}
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_RAID, new MonoRaidViewData
			{
				RaidEntranceId = num,
				RaidId = raidId
			});
		}

		private static int FindRaidEntrance(int raidId)
		{
			if (raidId <= 0 || RuntimeConfigs.data?.raidEntranceDatas == null)
			{
				return 0;
			}
			foreach (KeyValuePair<int, RaidEntranceData> raidEntranceData in RuntimeConfigs.data.raidEntranceDatas)
			{
				int[] array = raidEntranceData.Value?.raidId;
				if (array == null)
				{
					continue;
				}
				for (int i = 0; i < array.Length; i++)
				{
					if (array[i] == raidId)
					{
						return raidEntranceData.Key;
					}
				}
			}
			return 0;
		}
	}

	protected abstract int SystemId { get; }

	protected abstract bool CheckCondition();

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
}
