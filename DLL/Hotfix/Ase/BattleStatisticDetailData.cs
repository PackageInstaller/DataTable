using GameFramework.Runtime;

namespace Ase;

public class BattleStatisticDetailData : ViewModelBase
{
	private string skillName;

	private int damage;

	private int tencity;

	private long dps;

	private float damageProportion;

	private float energyProportion;

	public string SkillName
	{
		get
		{
			return skillName;
		}
		set
		{
			Set(ref skillName, value, "SkillName");
		}
	}

	public int Damage
	{
		get
		{
			return damage;
		}
		set
		{
			Set(ref damage, value, "Damage");
		}
	}

	public long Dps
	{
		get
		{
			return dps;
		}
		set
		{
			Set(ref dps, value, "Dps");
		}
	}

	public float DamageProportion
	{
		get
		{
			return damageProportion;
		}
		set
		{
			Set(ref damageProportion, value, "DamageProportion");
		}
	}

	public float EnergyProportion
	{
		get
		{
			return energyProportion;
		}
		set
		{
			Set(ref energyProportion, value, "EnergyProportion");
		}
	}

	public BattleStatisticDetailData()
	{
	}

	public BattleStatisticDetailData(string skillName, int damage, long dps, float damageProportion, float energyProportion)
	{
		this.skillName = skillName;
		this.damage = damage;
		this.dps = dps;
		this.damageProportion = damageProportion;
		this.energyProportion = energyProportion;
	}

	public BattleStatisticDetailData(int id, int type, int damage, int dps, float damageProportion, float energyProportion)
	{
	}

	public BattleStatisticDetailData(InputOptionEnum optionEnum, int heroId, int damage, int dps, float damageProportion, float energyProportion)
	{
	}
}
