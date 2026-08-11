using System.Collections.Generic;
using Ase;

public class PeripheryHeroData : NumericalBase
{
	private int _id;

	public bool isRobot;

	public long Uid;

	public bool IsSkin;

	public int SkinConfigId = -1;

	public string Name;

	public int Level;

	public WeaponEnum Weapon;

	public int DestinyLevel;

	public HeroAttributeEnum HeroAttributeEnum;

	public Dictionary<string, float> PropertyDic = new Dictionary<string, float>();

	public int Rarity;

	public int SeatId = -1;

	public List<int> RoundEmojis = new List<int>();

	public Dictionary<BattleObserverEventEnum, int> FightEventEmojisDic = new Dictionary<BattleObserverEventEnum, int>();

	public int Indicator;

	public Dictionary<int, int> UseSkillCameraSkinId;

	public bool UnLockAutoFight;

	private string _skinSuffix;

	public Dictionary<int, BattleProps> PropsData = new Dictionary<int, BattleProps>();

	public Dictionary<int, List<DRCultivateSkillEffect>> SkillEffectDic = new Dictionary<int, List<DRCultivateSkillEffect>>();

	public Dictionary<int, List<DRCultivateSkillLevel>> SkillLevelDic = new Dictionary<int, List<DRCultivateSkillLevel>>();

	public List<int> BuffList = new List<int>();

	public List<int> BTList = new List<int>();

	public List<int> SmallOrderList = new List<int>();

	public Dictionary<int, int> SkillBigLevel = new Dictionary<int, int>();

	private HeroModel heroModel;

	public int Id
	{
		get
		{
			return _id;
		}
		set
		{
			Set(ref _id, value, "Id");
		}
	}

	public string SkinSuffix
	{
		get
		{
			return _skinSuffix;
		}
		set
		{
			Set(ref _skinSuffix, value, "SkinSuffix");
		}
	}

	private PeripheryHeroData()
	{
	}

	public float GetBattleProperty(string propertyKey)
	{
		PropertyDic.TryGetValue(propertyKey, out var value);
		return value;
	}

	public void PropertyAdd(string propertyKey, float value)
	{
		if (PropertyDic.TryGetValue(propertyKey, out var value2))
		{
			PropertyDic[propertyKey] = value2 + value;
		}
		else
		{
			PropertyDic.Add(propertyKey, value);
		}
	}

	public static PeripheryHeroData CreateByConfig(int configId)
	{
		PeripheryHeroData peripheryHeroData = new PeripheryHeroData();
		DRHeroInfo dataRow = GameEntry.DataTable.GetDataRow<DRHeroInfo>(configId);
		peripheryHeroData.Id = configId;
		peripheryHeroData.Weapon = dataRow.WeaponEnum;
		peripheryHeroData.HeroAttributeEnum = dataRow.HeroAttributeEnum;
		return peripheryHeroData;
	}

	public static PeripheryHeroData TestCreate()
	{
		return new PeripheryHeroData
		{
			Id = 1104,
			Weapon = WeaponEnum.Sword,
			HeroAttributeEnum = HeroAttributeEnum.Ice,
			PropertyDic = 
			{
				{ "Hp", 5000f },
				{ "Energy", 5000f },
				{ "EnergyRecoverySpeed", 1f },
				{ "Attack", 20f }
			}
		};
	}

	public static PeripheryHeroData CreateEmpty()
	{
		return new PeripheryHeroData();
	}

	public void ClearBattleProps()
	{
		if (PropsData != null)
		{
			PropsData.Clear();
		}
	}

	public void SetBpDataMax()
	{
		if (PropsData == null)
		{
			return;
		}
		foreach (KeyValuePair<int, BattleProps> propsDatum in PropsData)
		{
			propsDatum.Value.SetBpDataMax(propsDatum.Key);
		}
	}

	public int AddBPDataImmediately(BattleProps bpData)
	{
		if (PropsData == null)
		{
			PropsData = new Dictionary<int, BattleProps>();
			PropsData.Add(1, bpData);
			return 1;
		}
		if (PropsData.ContainsKey(1))
		{
			if (PropsData[1] == null)
			{
				PropsData[1] = bpData;
				return 1;
			}
			if (PropsData.ContainsKey(2))
			{
				if (PropsData[2] == null)
				{
					PropsData[2] = bpData;
					return 2;
				}
				return 0;
			}
			PropsData.Add(2, bpData);
			return 2;
		}
		PropsData.Add(1, bpData);
		return 1;
	}

	public List<int> GetBattleProps()
	{
		List<int> list = new List<int>(2);
		if (PropsData.TryGetValue(1, out var value) && value != null)
		{
			list.Add(value.TeamId);
		}
		if (PropsData.TryGetValue(2, out var value2) && value2 != null)
		{
			list.Add(value2.TeamId);
		}
		return list;
	}

	public HeroModel GetHeroModel()
	{
		return heroModel;
	}

	public HeroModel SetHeroModel(HeroModel heroModel)
	{
		return this.heroModel = heroModel;
	}
}
