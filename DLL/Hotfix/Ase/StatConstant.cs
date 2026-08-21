using System.Collections.Generic;

namespace Ase;

public static class StatConstant
{
	public static Dictionary<EnergyConmuseEnum, string> EnergyConmuseDescDic = new Dictionary<EnergyConmuseEnum, string>
	{
		{
			EnergyConmuseEnum.Parry,
			"格挡"
		},
		{
			EnergyConmuseEnum.Skill,
			"技能"
		}
	};

	public static Dictionary<EnergyRecoverEnum, string> EnergyRecoverDescDic = new Dictionary<EnergyRecoverEnum, string>
	{
		{
			EnergyRecoverEnum.Normal,
			"自然回复"
		},
		{
			EnergyRecoverEnum.Skill,
			"技能"
		},
		{
			EnergyRecoverEnum.MonsterKonckDown,
			"怪物击倒"
		},
		{
			EnergyRecoverEnum.KillMonster,
			"击杀怪物"
		}
	};

	public static Dictionary<WeaponStatEnum, string> WeaponStatDescDic = new Dictionary<WeaponStatEnum, string>
	{
		{
			WeaponStatEnum.SwordLayer,
			"气刃值总量"
		},
		{
			WeaponStatEnum.SwordKeennessTime,
			"开刃时间"
		},
		{
			WeaponStatEnum.Anger,
			"怒气获取总量"
		},
		{
			WeaponStatEnum.AngerByFight,
			"怒气转化斗志次数"
		},
		{
			WeaponStatEnum.Fight,
			"斗志消耗总量"
		},
		{
			WeaponStatEnum.Bullet,
			"子弹数据"
		},
		{
			WeaponStatEnum.HeroHeat,
			"灵能消耗总量"
		},
		{
			WeaponStatEnum.Awaken,
			"觉醒值总量"
		},
		{
			WeaponStatEnum.AwakenTime,
			"AwakenTime"
		},
		{
			WeaponStatEnum.Cast,
			"蓄力值消耗总量"
		}
	};

	public static string GetStatDesc(this EnergyConmuseEnum energyEnum)
	{
		if (EnergyConmuseDescDic.TryGetValue(energyEnum, out var value))
		{
			return value;
		}
		return "None";
	}

	public static string GetStatDesc(this EnergyRecoverEnum recoverEnum)
	{
		if (EnergyRecoverDescDic.TryGetValue(recoverEnum, out var value))
		{
			return value;
		}
		return "None";
	}

	public static string GetStatDesc(this WeaponStatEnum weaponEnum)
	{
		if (WeaponStatDescDic.TryGetValue(weaponEnum, out var value))
		{
			return value;
		}
		return "None";
	}
}
