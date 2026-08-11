using GameFramework.Runtime;

namespace Ase;

public class BPData : ViewModelBase
{
	private int teamId;

	private string name;

	private int level;

	private int levelMax;

	private int id;

	private int count;

	private bool isLock;

	private int quality;

	private string icon;

	private string desc;

	private int carryMax;

	private int aiTreeId;

	private int skillId;

	private int _carryPropNumber;

	private BattlePropEnum type;

	public int TeamId
	{
		get
		{
			return teamId;
		}
		private set
		{
			Set(ref teamId, value, "TeamId");
		}
	}

	public string Name
	{
		get
		{
			return name;
		}
		private set
		{
			Set(ref name, value, "Name");
		}
	}

	public int Level
	{
		get
		{
			return level;
		}
		private set
		{
			Set(ref level, value, "Level");
		}
	}

	public int LevelMax
	{
		get
		{
			return levelMax;
		}
		private set
		{
			Set(ref levelMax, value, "LevelMax");
		}
	}

	public int Id
	{
		get
		{
			return id;
		}
		private set
		{
			Set(ref id, value, "Id");
		}
	}

	public int Count
	{
		get
		{
			return count;
		}
		private set
		{
			Set(ref count, value, "Count");
		}
	}

	public bool IsLock
	{
		get
		{
			return isLock;
		}
		private set
		{
			Set(ref isLock, value, "IsLock");
		}
	}

	public int Quality
	{
		get
		{
			return quality;
		}
		private set
		{
			Set(ref quality, value, "Quality");
		}
	}

	public string Icon
	{
		get
		{
			return icon;
		}
		private set
		{
			Set(ref icon, value, "Icon");
		}
	}

	public string Desc
	{
		get
		{
			return desc;
		}
		private set
		{
			Set(ref desc, value, "Desc");
		}
	}

	public BattlePropEnum Type
	{
		get
		{
			return type;
		}
		private set
		{
			Set(ref type, value, "Type");
		}
	}

	public int CarryMax
	{
		get
		{
			return carryMax;
		}
		private set
		{
			Set(ref carryMax, value, "CarryMax");
		}
	}

	public int AiTreeId => aiTreeId;

	public int SkillId => skillId;

	public int CarryPropNumber => _carryPropNumber;

	public static BPData Create(DRBattlePropInfo battlePropInfo, bool isLock, int count)
	{
		return new BPData
		{
			id = battlePropInfo.Id,
			name = battlePropInfo.Name,
			teamId = battlePropInfo.TeamId,
			count = count,
			level = battlePropInfo.Lev,
			levelMax = battlePropInfo.LevMax,
			quality = battlePropInfo.Quality,
			icon = battlePropInfo.Icon,
			desc = battlePropInfo.Function,
			type = battlePropInfo.BattlePropEnum,
			aiTreeId = battlePropInfo.AiTreeID,
			skillId = battlePropInfo.PropSkillID,
			carryMax = battlePropInfo.TakeLimit,
			isLock = isLock
		};
	}

	public void RefreshFromServer(BPData bpData)
	{
		Name = bpData.Name;
		TeamId = bpData.TeamId;
		Count = count;
		Level = bpData.level;
		LevelMax = bpData.LevelMax;
		Quality = bpData.Quality;
		Icon = bpData.Icon;
		Desc = bpData.Desc;
		Type = bpData.Type;
		aiTreeId = bpData.aiTreeId;
		skillId = bpData.skillId;
		CarryMax = bpData.carryMax;
		IsLock = bpData.isLock;
	}

	public static BPData Create(BPData battlePropInfo, int count)
	{
		return new BPData
		{
			id = battlePropInfo.Id,
			name = battlePropInfo.Name,
			teamId = battlePropInfo.TeamId,
			count = count,
			level = battlePropInfo.Level,
			levelMax = battlePropInfo.LevelMax,
			quality = battlePropInfo.Quality,
			icon = battlePropInfo.Icon,
			desc = battlePropInfo.desc,
			type = battlePropInfo.Type,
			aiTreeId = battlePropInfo.aiTreeId,
			skillId = battlePropInfo.skillId,
			isLock = battlePropInfo.IsLock
		};
	}

	public void UpdateLevelAndCount(DRBattlePropInfo info, int count)
	{
		Id = info.Id;
		Name = info.Name;
		Level = info.Lev;
		Quality = info.Quality;
		Icon = info.Icon;
		Desc = info.Function;
		CarryMax = info.TakeLimit;
		aiTreeId = info.AiTreeID;
		skillId = info.PropSkillID;
		IsLock = false;
		Count = count;
	}

	public void AddCount(int count)
	{
		Count += count;
	}

	public void SetCarryPropNumberToMax()
	{
		_carryPropNumber = ((count >= carryMax) ? carryMax : count);
	}

	public int GetCarryPropNumber()
	{
		if (count < carryMax)
		{
			return count;
		}
		return carryMax;
	}

	public void Consume()
	{
		if (count > 0)
		{
			Count--;
		}
		if (_carryPropNumber > count)
		{
			_carryPropNumber = count;
		}
	}

	public void Release()
	{
		Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().UseBattleProp(this);
	}
}
