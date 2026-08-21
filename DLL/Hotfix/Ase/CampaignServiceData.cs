using System.Collections.Generic;

namespace Ase;

public static class CampaignServiceData
{
	public class BuildingInfo
	{
		public int BuildingId;

		public List<(int, long)> MaterialInfos = new List<(int, long)>();

		public int BuildingLevel;

		public int PointId;

		public bool IsUnlock;

		public bool Upgraded;

		public BuildingInfo(PbCampaignBuildingInfo pbData, bool upgraded = false)
		{
			BuildingId = pbData.BuildingId;
			pbData.MaterialInfos?.ForEach(delegate(PbCampaignBuildingMaterialInfo p)
			{
				MaterialInfos.Add((p.ItemId, p.Count));
			});
			BuildingLevel = pbData.BuildingLevel;
			PointId = pbData.PointId;
			IsUnlock = pbData.IsUnlock;
			Upgraded = upgraded;
		}
	}

	public class WorldBossInfo
	{
		public int PointId;

		public int PlayId;

		public long BossHP;

		public long Times;

		public WorldBossInfo(PbCampaignWorldBossInfo pbData)
		{
			PointId = pbData.PointId;
			PlayId = pbData.PlayId;
			BossHP = pbData.BossHP;
			Times = pbData.Times;
		}
	}

	public class BossKillInfo
	{
		public List<string> PlayerNames;

		public int CopyId;

		public int ReportType;

		public BossKillInfo(PbCampaignBossKillInfo pbData)
		{
			PlayerNames = pbData.PlayerNames;
			CopyId = pbData.CopyId;
			ReportType = pbData.ReportType;
		}
	}

	public class BranchTaskInfo
	{
		public int PlayId;

		public long YesterdayValue;

		public long TotalValue;

		public BranchTaskInfo(PbCampaignBranchTaskProgress pbData)
		{
			PlayId = pbData.PlayId;
			YesterdayValue = pbData.YesterdayValue;
			TotalValue = pbData.TotalValue;
		}
	}

	public class DailyTaskInfo
	{
		public int PointId;

		public int PlayId;

		public bool IsCompleted;

		public DailyTaskInfo(PbCampaignDailyTaskInfo pbData)
		{
			PointId = pbData.PointId;
			PlayId = pbData.PlayId;
			IsCompleted = pbData.IsCompleted;
		}
	}

	public class MainInfo
	{
		public List<WorldBossInfo> FinalBossHP;

		public List<int> MainTaskProgress;

		public List<int> BranchTaskProgress;

		public List<BossKillInfo> BossKillInfos;

		public List<BranchTaskInfo> BranchTaskProgressInfos;

		public long NextMainStageTime;

		public MainInfo(GetCampaignInfoResponse response)
		{
			FinalBossHP = new List<WorldBossInfo>();
			response.FinalBossHP.ForEach(delegate(PbCampaignWorldBossInfo p)
			{
				FinalBossHP.Add(new WorldBossInfo(p));
			});
			MainTaskProgress = response.MainTaskProgress;
			BranchTaskProgress = response.BranchTaskProgress;
			BossKillInfos = new List<BossKillInfo>();
			response.BossKillInfos.ForEach(delegate(PbCampaignBossKillInfo p)
			{
				BossKillInfos.Add(new BossKillInfo(p));
			});
			BranchTaskProgressInfos = new List<BranchTaskInfo>();
			response.BranchTaskProgressInfos.ForEach(delegate(PbCampaignBranchTaskProgress p)
			{
				BranchTaskProgressInfos.Add(new BranchTaskInfo(p));
			});
			NextMainStageTime = response.NextMainStageTime;
		}

		public DRCampaign GetCurMainTaskConfig()
		{
			if (MainTaskProgress == null)
			{
				MainTaskProgress = new List<int>();
			}
			int count = MainTaskProgress.Count;
			int num = ((count > 0) ? MainTaskProgress[count - 1] : 0);
			if (num <= 0)
			{
				return null;
			}
			return GameEntry.DataTable.GetDataRow<DRCampaign>(num);
		}

		public DRCampaign GetCurBranchTaskConfig()
		{
			if (BranchTaskProgress == null)
			{
				BranchTaskProgress = new List<int>();
			}
			int count = BranchTaskProgress.Count;
			int num = ((count > 0) ? BranchTaskProgress[count - 1] : 0);
			if (num <= 0)
			{
				return null;
			}
			return GameEntry.DataTable.GetDataRow<DRCampaign>(num);
		}
	}

	public class DetailInfo
	{
		public List<WorldBossInfo> WorldBossInfos;

		public List<BuildingInfo> BuildingInfos;

		public List<DailyTaskInfo> DailyTaskInfos;

		public DetailInfo(GetCampaignDetailInfoResponse response)
		{
			WorldBossInfos = new List<WorldBossInfo>();
			response.WorldBossInfos.ForEach(delegate(PbCampaignWorldBossInfo p)
			{
				WorldBossInfos.Add(new WorldBossInfo(p));
			});
			BuildingInfos = new List<BuildingInfo>();
			response.BuildingInfos.ForEach(delegate(PbCampaignBuildingInfo p)
			{
				BuildingInfos.Add(new BuildingInfo(p));
			});
			DailyTaskInfos = new List<DailyTaskInfo>();
			response.DailyTaskInfos.ForEach(delegate(PbCampaignDailyTaskInfo p)
			{
				DailyTaskInfos.Add(new DailyTaskInfo(p));
			});
		}

		public void AddWorldBossInfo(List<WorldBossInfo> newInfos)
		{
			if (newInfos == null)
			{
				return;
			}
			if (WorldBossInfos == null)
			{
				WorldBossInfos = new List<WorldBossInfo>();
			}
			newInfos.ForEach(delegate(WorldBossInfo a)
			{
				int num = WorldBossInfos.FindIndex((WorldBossInfo b) => b.PlayId.Equals(a.PlayId));
				if (num >= 0)
				{
					WorldBossInfos[num] = a;
				}
				else
				{
					WorldBossInfos.Add(a);
				}
			});
		}

		public void RefreshBuildingInfo(List<BuildingInfo> newBuildingInfos)
		{
			if (newBuildingInfos != null)
			{
				BuildingInfos = newBuildingInfos;
			}
		}

		public bool ExistEliteMonster()
		{
			if (WorldBossInfos == null)
			{
				WorldBossInfos = new List<WorldBossInfo>();
			}
			return WorldBossInfos.Exists(delegate(WorldBossInfo p)
			{
				DRCampaignLevel dataRow = GameEntry.DataTable.GetDataRow<DRCampaignLevel>(p.PlayId);
				return dataRow != null && dataRow.Type == 1;
			});
		}
	}

	public static string GetTaskTargetText(string textFormat, List<(int, int)> pars)
	{
		if (string.IsNullOrEmpty(textFormat) || pars == null || pars.Count <= 0)
		{
			return string.Empty;
		}
		List<object> args = new List<object>();
		pars.ForEach(delegate((int, int) p)
		{
			args.Add(p.Item1 * p.Item2);
		});
		return string.Format(textFormat, args.ToArray());
	}
}
