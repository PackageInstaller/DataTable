#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using UnityEngine;

namespace Ase;

public class BattleStatisticDetailViewModel : ItemOptionBase
{
	private string heroName;

	private int configId;

	private Color color;

	private string statisticName1;

	private string statisticName2;

	private int totalValue;

	private float proportion;

	private List<BattleStatisticDetailData> detailDatas;

	private DRDamageStatistic configData;

	public string HeroName
	{
		get
		{
			return heroName;
		}
		set
		{
			Set(ref heroName, value, "HeroName");
		}
	}

	public string StatisticName1
	{
		get
		{
			return statisticName1;
		}
		private set
		{
			Set(ref statisticName1, value, "StatisticName1");
		}
	}

	public string StatisticName2
	{
		get
		{
			return statisticName2;
		}
		private set
		{
			Set(ref statisticName2, value, "StatisticName2");
		}
	}

	public int TotalValue
	{
		get
		{
			return totalValue;
		}
		private set
		{
			Set(ref totalValue, value, "TotalValue");
		}
	}

	public float Proportion
	{
		get
		{
			return proportion;
		}
		private set
		{
			Set(ref proportion, value, "Proportion");
		}
	}

	public Color Color
	{
		get
		{
			return color;
		}
		set
		{
			Set(ref color, value, "Color");
		}
	}

	public List<BattleStatisticDetailData> DetailDatas => detailDatas;

	public DRDamageStatistic ConfigData => configData;

	public BattleStatisticDetailViewModel()
	{
	}

	public BattleStatisticDetailViewModel(int configId, List<BattleStatisticDetailData> detailDatas, int totalValue, float proportion)
	{
		this.configId = configId;
		this.totalValue = totalValue;
		this.proportion = proportion;
		this.detailDatas = detailDatas;
		DRDamageStatistic dataRow = GameEntry.DataTable.GetDataRow<DRDamageStatistic>(configId);
		if (dataRow == null)
		{
			Log.Error($"DRDamageStatistic 找不到战斗数据统计配置ID {configId}");
			return;
		}
		configData = dataRow;
		statisticName1 = dataRow.Name1;
		statisticName2 = dataRow.Name2;
		ColorUtility.TryParseHtmlString(dataRow.Color, out color);
	}
}
