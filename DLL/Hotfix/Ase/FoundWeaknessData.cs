using System.Collections.Generic;
using Ase.ECS;
using GameFramework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase;

public class FoundWeaknessData : IReference
{
	[Name("弱点中心时刻", 0)]
	public float CentralMoment;

	[Name("最高弱点等级", 0)]
	public int Level;

	[Name("最高弱点时长", 0)]
	public float Timer;

	public void Clone(FoundWeaknessData data)
	{
		Level = data.Level;
		CentralMoment = data.CentralMoment;
		Timer = data.Timer;
	}

	public void CalcEntityTimeBuff(BaseEntity entity)
	{
		if (entity == null)
		{
			return;
		}
		List<HeroEntity> teamHero = entity.GetSystem<EntitySystem>().GetTeamHero();
		float num = 0f;
		float num2 = 0f;
		string propertyRatioKey = GetPropertyRatioKey(Level);
		string propertyAdditionKey = GetPropertyAdditionKey(Level);
		if (!string.IsNullOrEmpty(propertyRatioKey))
		{
			foreach (HeroEntity item in teamHero)
			{
				num = Mathf.Max(item.GetProperty(propertyRatioKey), num);
			}
		}
		if (!string.IsNullOrEmpty(propertyAdditionKey))
		{
			foreach (HeroEntity item2 in teamHero)
			{
				num2 = Mathf.Max(item2.GetProperty(propertyAdditionKey), num2);
			}
		}
		float num3 = 0f;
		float num4 = 0f;
		string monsterPropertyRatioKey = GetMonsterPropertyRatioKey(Level);
		string monsterPropertyAdditionKey = GetMonsterPropertyAdditionKey(Level);
		if (!string.IsNullOrEmpty(monsterPropertyRatioKey))
		{
			num3 = entity.GetProperty(monsterPropertyRatioKey);
		}
		if (!string.IsNullOrEmpty(monsterPropertyAdditionKey))
		{
			num4 = entity.GetProperty(monsterPropertyAdditionKey);
		}
		Timer = Mathf.Max(0f, Timer + num2 + Timer * num + num4 + Timer * num3);
	}

	private string GetPropertyRatioKey(int level)
	{
		return level switch
		{
			2 => "HighWeaknessTimerExtendRatio2", 
			3 => "HighWeaknessTimerExtendRatio3", 
			4 => "HighWeaknessTimerExtendRatio4", 
			_ => string.Empty, 
		};
	}

	private string GetPropertyAdditionKey(int level)
	{
		return level switch
		{
			2 => "HighWeaknessTimerExtend2Addition", 
			3 => "HighWeaknessTimerExtend3Addition", 
			4 => "HighWeaknessTimerExtend4Addition", 
			_ => string.Empty, 
		};
	}

	private string GetMonsterPropertyRatioKey(int level)
	{
		return level switch
		{
			2 => "MonsterHighWeaknessTimer2Ratio", 
			3 => "MonsterHighWeaknessTimer3Ratio", 
			4 => "MonsterHighWeaknessTimer4Ratio", 
			_ => string.Empty, 
		};
	}

	private string GetMonsterPropertyAdditionKey(int level)
	{
		return level switch
		{
			2 => "MonsterHighWeaknessTimer2Addition", 
			3 => "MonsterHighWeaknessTimer3Addition", 
			4 => "MonsterHighWeaknessTimer4Addition", 
			_ => string.Empty, 
		};
	}

	public void Clear()
	{
		CentralMoment = 0f;
		Level = 0;
		Timer = 0f;
	}
}
