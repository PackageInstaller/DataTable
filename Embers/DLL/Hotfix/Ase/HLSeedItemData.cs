using UnityEngine;

namespace Ase;

public class HLSeedItemData : OptionBase
{
	private int seedId;

	private string seedIcon;

	private int seedRarity;

	private bool isLock;

	private bool isSelected;

	private int useTime;

	private bool showRedPoint;

	public int SeedId => seedId;

	public string SeedIcon => seedIcon;

	public int SeedRarity => seedRarity;

	public bool IsLock => isLock;

	public int UseTime => useTime;

	public bool IsSelected
	{
		get
		{
			return isSelected;
		}
		set
		{
			Set(ref isSelected, value, "IsSelected");
		}
	}

	public bool ShowRedPoint
	{
		get
		{
			return showRedPoint;
		}
		set
		{
			Set(ref showRedPoint, value, "ShowRedPoint");
		}
	}

	public HLSeedItemData(OptionBase parent, int id, string icon, int rarity, bool isLock, int useTime)
	{
		base.parent = parent;
		seedId = id;
		seedIcon = icon;
		seedRarity = rarity;
		this.isLock = isLock;
		isSelected = false;
		this.useTime = useTime;
	}

	public void OnClick()
	{
		if (isLock)
		{
			string message = "";
			DRFarmSeed drFarmSeed = GameEntry.DataTable.GetDataRow<DRFarmSeed>(seedId);
			if (drFarmSeed.UnlockType == 1)
			{
				message = $"余温熔炉Lv.{drFarmSeed.UnlockTypeEx}解锁";
			}
			else if (drFarmSeed.UnlockType == 2)
			{
				DRMonsterAttr dataRow = GameEntry.DataTable.GetDataRow((DRMonsterAttr p) => p.MonsterType == drFarmSeed.UnlockTypeEx);
				if (dataRow == null)
				{
					Toast.ShowError($"怪物表查询不到ID:{drFarmSeed.UnlockTypeEx}的怪物数据");
					return;
				}
				if (GameEntry.DataTable.GetDataRow<DRMonster>(dataRow.MonsterType) == null)
				{
					Toast.ShowError($"怪物表查询不到ID:{drFarmSeed.UnlockTypeEx}的怪物数据");
					return;
				}
				message = "在世界上击杀" + dataRow.Name + "获得";
			}
			else if (drFarmSeed.UnlockType == 3)
			{
				DRTask dataRow2 = GameEntry.DataTable.GetDataRow<DRTask>(drFarmSeed.UnlockTypeEx);
				if (dataRow2 == null)
				{
					Toast.ShowError($"任务表查询不到ID:{drFarmSeed.UnlockTypeEx}的任务数据");
					return;
				}
				message = "完成任务:" + dataRow2.TaskName + "获得";
			}
			else if (drFarmSeed.UnlockType == 4)
			{
				DRMap dataRow3 = GameEntry.DataTable.GetDataRow<DRMap>(drFarmSeed.UnlockTypeEx);
				if (dataRow3 == null)
				{
					Toast.ShowError($"任务表查询不到ID:{drFarmSeed.UnlockTypeEx}的地图数据");
					return;
				}
				message = dataRow3.Name + "星辉晶樽获得";
			}
			Toast.ShowInfo(message);
		}
		else
		{
			if (ShowRedPoint)
			{
				PlayerPrefs.SetInt("RedPoint" + $"FarmSeed_{seedId}", 0);
				ShowRedPoint = false;
			}
			parent?.ItemOnClick(new OptionArg(this, "Seed"));
		}
	}
}
