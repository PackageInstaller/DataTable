#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class RankTypeData : ViewModelBase
{
	private int id;

	private int tabId;

	private string name;

	private DateTime startTime;

	private DateTime endTime;

	private DateTime offTime;

	private RankDefinition.RankState state;

	private List<DRRank> rankDatas = new List<DRRank>();

	public List<DRRank> RankDatas => rankDatas;

	public int Id
	{
		get
		{
			return id;
		}
		set
		{
			Set(ref id, value, "Id");
		}
	}

	public int TabId
	{
		get
		{
			return tabId;
		}
		set
		{
			Set(ref tabId, value, "TabId");
		}
	}

	public string Name
	{
		get
		{
			return name;
		}
		set
		{
			Set(ref name, value, "Name");
		}
	}

	public DateTime StartTime
	{
		get
		{
			return startTime;
		}
		set
		{
			Set(ref startTime, value, "StartTime");
		}
	}

	public DateTime EndTime
	{
		get
		{
			return endTime;
		}
		set
		{
			Set(ref endTime, value, "EndTime");
		}
	}

	public DateTime OffTime
	{
		get
		{
			return offTime;
		}
		set
		{
			Set(ref offTime, value, "OffTime");
		}
	}

	public RankDefinition.RankState State
	{
		get
		{
			return state;
		}
		set
		{
			Set(ref state, value, "State");
		}
	}

	public RankTypeData()
	{
	}

	public RankTypeData(DRRankType drRankType)
	{
		Id = drRankType.Id;
		DRRankUIType dataRow = GameEntry.DataTable.GetDataRow<DRRankUIType>(drRankType.UITabType);
		TabId = drRankType.UITabType;
		Name = ((dataRow != null) ? dataRow.TabName : string.Empty);
		DRRank[] dataRows = GameEntry.DataTable.GetDataRows((DRRank p) => p.RankType == Id);
		if (dataRows != null)
		{
			DRRank[] array = dataRows;
			foreach (DRRank drRank in array)
			{
				if (rankDatas.Exists((DRRank p) => p.RankTarget == drRank.RankTarget))
				{
					Log.Error($"Rank表 总榜类型{Id} 存在重复RankTarget配置:{drRank.RankTarget}");
				}
				else
				{
					rankDatas.Add(drRank);
				}
			}
		}
		State = RankDefinition.GetRankState(drRankType.StartTime, drRankType.EndTime, drRankType.OffTime);
		TimeService.StringToDateTime(drRankType.StartTime, out startTime);
		TimeService.StringToDateTime(drRankType.EndTime, out endTime);
		TimeService.StringToDateTime(drRankType.OffTime, out offTime);
	}
}
