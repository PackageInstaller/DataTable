using System.Collections.Generic;

namespace Ase.ECS;

public class BattleMonsterData : EntityViewModel
{
	private DRMonster _drMonster;

	private DRMonsterAttr _drMonsterAttr;

	private string _name;

	private float _atkLightLevel;

	private float _hpLightLevel;

	private string levelShow;

	public string Name
	{
		get
		{
			return _name;
		}
		private set
		{
			Set(ref _name, value, "Name");
		}
	}

	public bool IsChangeState
	{
		get
		{
			if (_drMonsterAttr == null)
			{
				return false;
			}
			return _drMonster.IsChangeState;
		}
	}

	public int StateType
	{
		get
		{
			if (_drMonsterAttr == null)
			{
				return 0;
			}
			return _drMonster.StateType;
		}
	}

	public string Icon
	{
		get
		{
			if (_drMonsterAttr == null)
			{
				return string.Empty;
			}
			return _drMonster.Head;
		}
	}

	public string LevelShow => levelShow;

	private BattleMonsterData()
	{
	}

	public new static BattleMonsterData Empty()
	{
		return new BattleMonsterData
		{
			Name = string.Empty,
			level = 1
		};
	}

	public static BattleMonsterData Create(BaseEntity baseEntity, DRMonster monster, DRMonsterAttr drMonsterAttr)
	{
		BattleMonsterData battleMonsterData = new BattleMonsterData();
		battleMonsterData._drMonster = monster;
		battleMonsterData._drMonsterAttr = drMonsterAttr;
		battleMonsterData.entity = baseEntity;
		battleMonsterData.Name = drMonsterAttr.Name;
		battleMonsterData.level = drMonsterAttr.MonsterLevel;
		if (!drMonsterAttr.HideMonsterLevel)
		{
			battleMonsterData.levelShow = "Lv." + drMonsterAttr.MonsterLevel + "  ";
		}
		else
		{
			battleMonsterData.levelShow = string.Empty;
		}
		return battleMonsterData;
	}

	protected override void InitEmptyProperty()
	{
		if (_drMonsterAttr == null || _drMonster == null)
		{
			return;
		}
		float num = _drMonsterAttr.Hp;
		float num2 = _drMonsterAttr.Attack;
		float num3 = _drMonsterAttr.MaxTenacity;
		float baseTough = _drMonsterAttr.BaseTough;
		_atkLightLevel = _drMonsterAttr.AtkLightLevel;
		_hpLightLevel = _drMonsterAttr.HpLightLevel;
		AttrAssignmentData data = default(AttrAssignmentData);
		entity.GetWorld().MonsterAttrHandle(entity, _drMonsterAttr, ref data);
		num = data.Hp;
		num2 = data.Attack;
		num3 = data.MaxTenacity;
		baseTough = data.BaseTough;
		_atkLightLevel = data.AtkLightLevel;
		_hpLightLevel = data.HpLightLevel;
		propertyList.Add("Hp", PropertyData.Create(num, 0f, num));
		propertyList.Add("Attack", PropertyData.Create(num2));
		propertyList.Add("Defence", PropertyData.Create(_drMonsterAttr.Defence));
		propertyList.Add("BaseTough", PropertyData.Create(baseTough, 0f, baseTough));
		propertyList.Add("TenacityBreakTime", PropertyData.Create(_drMonsterAttr.TenacityBreakTime));
		propertyList.Add("DefensePowerLevel", PropertyData.Create(0f, -100f, 50000f));
		propertyList.Add("DefensePowerLevelExtra", PropertyData.Create(0f, -100f, 50000f));
		propertyList.Add("AttackRadio", PropertyData.Create(1f, 50000f));
		propertyList.Add("FixAttack", PropertyData.Create(0f, 50000f));
		propertyList.Add("HpRadio", PropertyData.Create(1f, 50000f));
		propertyList.Add("FixHp", PropertyData.Create(0f, 50000f));
		propertyList.Add("DefenceRadio", PropertyData.Create(1f, 50000f));
		propertyList.Add("FixDefence", PropertyData.Create(0f, 50000f));
		propertyList.Add("Tenacity", PropertyData.Create(num3, 0f, num3));
		propertyList.Add("Level", PropertyData.Create(_drMonsterAttr.MonsterLevel));
		propertyList.Add("Speed", PropertyData.Create(_drMonster.Speed));
		propertyList.Add("RotateSpeed", PropertyData.Create(_drMonster.TurnAroundSpeed));
		propertyList.Add("MonsterAnger", PropertyData.Create(0f, 0f, _drMonsterAttr.AngerMax));
		propertyList.Add("AmendByLight", PropertyData.Create(0f, 50000f));
		propertyList.Add("AmendByDark", PropertyData.Create(0f, 50000f));
		propertyList.Add("AmendByWater", PropertyData.Create(0f, 50000f));
		propertyList.Add("AmendByFire", PropertyData.Create(0f, 50000f));
		propertyList.Add("AmendByWind", PropertyData.Create(0f, 50000f));
		propertyList.Add("AmendToLight", PropertyData.Create(0f, 50000f));
		propertyList.Add("AmendToDark", PropertyData.Create(0f, 50000f));
		propertyList.Add("AmendToWater", PropertyData.Create(0f, 50000f));
		propertyList.Add("AmendToFire", PropertyData.Create(0f, 50000f));
		propertyList.Add("AmendToWind", PropertyData.Create(0f, 50000f));
		propertyList.Add("TenacityMitigate", PropertyData.Create(0f, -1000f, 50000f));
		propertyList.Add("MonsterHighWeaknessTimer2Ratio", PropertyData.Create(0f, 0f, 1000f));
		propertyList.Add("MonsterHighWeaknessTimer3Ratio", PropertyData.Create(0f, 0f, 1000f));
		propertyList.Add("MonsterHighWeaknessTimer4Ratio", PropertyData.Create(0f, 0f, 1000f));
		propertyList.Add("MonsterHighWeaknessTimer2Addition", PropertyData.Create(0f, 0f, 1000f));
		propertyList.Add("MonsterHighWeaknessTimer3Addition", PropertyData.Create(0f, 0f, 1000f));
		propertyList.Add("MonsterHighWeaknessTimer4Addition", PropertyData.Create(0f, 0f, 1000f));
		propertyList.Add("AttractionMultiplier", PropertyData.Create(1f));
		propertyList.Add("AttractionPower", PropertyData.Create(1f));
		propertyList.Add("AttractionResistance", PropertyData.Create(9999f));
		propertyList.Add("SkillDamageAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("FireDamageRadio", PropertyData.Create(0f, 50000f));
		propertyList.Add("WindDamageRadio", PropertyData.Create(0f, 50000f));
		propertyList.Add("WaterDamageRadio", PropertyData.Create(0f, 50000f));
		propertyList.Add("LightDamageRadio", PropertyData.Create(0f, 50000f));
		propertyList.Add("DarkDamageRadio", PropertyData.Create(0f, 50000f));
		propertyList.Add("IceDamageRadio", PropertyData.Create(0f, 50000f));
		propertyList.Add("ThunderDamageRadio", PropertyData.Create(0f, 50000f));
		propertyList.Add("RockDamageRadio", PropertyData.Create(0f, 50000f));
		propertyList.Add("DragonDamageRadio", PropertyData.Create(0f, 50000f));
		propertyList.Add("IgnoreDefence", PropertyData.Create(0f, 1f));
		propertyList.Add("BreakDamageAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("LightResistance", PropertyData.Create(0f, 50000f));
		propertyList.Add("DarkResistance", PropertyData.Create(0f, 50000f));
		propertyList.Add("WaterResistance", PropertyData.Create(0f, 50000f));
		propertyList.Add("FireResistance", PropertyData.Create(0f, 50000f));
		propertyList.Add("WindResistance", PropertyData.Create(0f, 50000f));
		propertyList.Add("IceResistance", PropertyData.Create(0f, 50000f));
		propertyList.Add("ThunderResistance", PropertyData.Create(0f, 50000f));
		propertyList.Add("RockResistance", PropertyData.Create(0f, 50000f));
		propertyList.Add("DragonResistance", PropertyData.Create(0f, 50000f));
		propertyList.Add("TeamDamageAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("AmendByIce", PropertyData.Create(0f, 50000f));
		propertyList.Add("AmendByThunder", PropertyData.Create(0f, 50000f));
		propertyList.Add("AmendByRock", PropertyData.Create(0f, 50000f));
		propertyList.Add("AmendByDragon", PropertyData.Create(0f, 50000f));
		propertyList.Add("AmendToIce", PropertyData.Create(0f, 50000f));
		propertyList.Add("AmendToThunder", PropertyData.Create(0f, 50000f));
		propertyList.Add("AmendToRock", PropertyData.Create(0f, 50000f));
		propertyList.Add("AmendToDragon", PropertyData.Create(0f, 50000f));
		propertyList.Add("DamageAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("TenacityAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("CureAddition", PropertyData.Create(0f, 50000f));
		InitMonsterPropertyBonus();
		InitMonsterWeaknessProperty();
		foreach (KeyValuePair<string, PropertyData> property in propertyList)
		{
			property.Value.SetPropertyName(property.Key);
		}
	}

	private void InitMonsterPropertyBonus()
	{
		switch (entity.GetSystem<EntitySystem>().GetTeamHeroNumber(isIncludeAi: false))
		{
		case 2:
			AddMonsterPropertyBonus(_drMonsterAttr.BonusType, _drMonsterAttr.DoubleBonusNum);
			break;
		case 3:
			AddMonsterPropertyBonus(_drMonsterAttr.BonusType, _drMonsterAttr.TriBonusNum);
			break;
		}
	}

	private void AddMonsterPropertyBonus(List<string> propertyList, List<float> bonusList)
	{
		if (propertyList.IsNullOrEmpty() || bonusList.IsNullOrEmpty() || propertyList.Count != bonusList.Count)
		{
			return;
		}
		for (int i = 0; i < propertyList.Count; i++)
		{
			PropertyData propertyData = GetPropertyData(propertyList[i]);
			if (propertyData != null)
			{
				float curValue = propertyData.CurValue;
				curValue += curValue * bonusList[i];
				propertyData.Reset(curValue, 0f, curValue);
				propertyData.ResetValue(toMax: false, isExecuteValueChanged: false);
			}
		}
	}

	private void InitMonsterWeaknessProperty()
	{
		List<string> elementsWeakness = _drMonsterAttr.ElementsWeakness;
		List<float> weaknessValue = _drMonsterAttr.WeaknessValue;
		if (!elementsWeakness.IsNullOrEmpty() && !weaknessValue.IsNullOrEmpty() && elementsWeakness.Count == weaknessValue.Count)
		{
			for (int i = 0; i < elementsWeakness.Count; i++)
			{
				GetPropertyData(elementsWeakness[i])?.Addition(weaknessValue[i], isIgnoreMax: false, isExecuteValueChanged: false);
			}
		}
	}

	protected override void CalcPropertyLight()
	{
		propertyLightDic.Add("Attack", _atkLightLevel);
		propertyLightDic.Add("Hp", _hpLightLevel);
	}

	public override string GetBattleHeadIcon()
	{
		return _drMonster.Head;
	}

	public override string GetName()
	{
		return _drMonsterAttr.Name;
	}

	public int GetMonsterType()
	{
		return _drMonsterAttr.MonsterType;
	}

	public List<string> AmendList()
	{
		return _drMonsterAttr.ElementsWeakness;
	}
}
