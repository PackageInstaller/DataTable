using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

public class ConfigProperty : ScriptableObject
{
	public const uint ElementDamageOffset = 19u;

	public const uint ElementResistOffset = 29u;

	public const uint ElementRealDamageOffset = 49u;

	public const uint pMaxHP = 1u;

	public const uint pATK = 2u;

	public const uint pCritChance = 3u;

	public const uint pCritMul = 4u;

	public const uint pDef = 8u;

	public const uint pDefPenetration = 13u;

	public const uint pEndureLevel = 15u;

	public const uint pEnemyFrameHaltReduce = 16u;

	public const uint pChargeRate = 40u;

	public const uint pMaxPosture = 41u;

	public const uint pPostureDmgChar = 42u;

	public const uint pWeakMul = 43u;

	public const uint pDamageMulAdd = 44u;

	public const uint pLifeSteal = 45u;

	public const uint pAssistMax = 55u;

	public const uint pCritConversion = 57u;

	public const uint pBurstMulAdd = 58u;

	public const uint pNormalAttack = 61u;

	public const uint pSkillAttack = 62u;

	public const uint pUltraAttack = 63u;

	public const uint pAssistAttack = 64u;

	public const uint pAssistCost = 65u;

	public const uint pDamageRduction = 66u;

	public const uint pVulnerable = 67u;

	public const uint pAirAttack = 68u;

	public const uint pCantBeAttack = 100u;

	public const uint pSuperArmor = 101u;

	public const uint pCD = 200u;

	public const uint pDodgeCd = 201u;

	public const uint pDodgeDisMul = 202u;

	public const uint pDummyDuration = 203u;

	public const uint pControl = 204u;

	public const uint pMaxShield = 205u;

	public const uint pSkillCooldownReduction = 206u;

	public const uint pWeakCoefficient = 207u;

	public const uint pNormalEnergyCoefficient = 208u;

	public const uint pAssistValueCoefficient = 209u;

	public const uint pDodgeInvincibleTime = 210u;

	public const uint pEquipedBloodBottleRecoverHpNum = 211u;

	public const uint pBloodBottleRecoverCd = 222u;

	public const uint pBloodBottleRecoverCount = 223u;

	public const uint pViscousVerVelocityCoefficient = 224u;

	public const uint pViscousHorVelocityCoefficient = 225u;

	public const uint MannerTypePropertyStart = 55u;

	public const uint CharacterDamageTypeNoWeak = 69u;

	public const uint CharacterDamageTypeWeak = 70u;

	public List<PropertyItem> properties;

	public PropertyItem GetPropertyItem(uint propertyId)
	{
		foreach (PropertyItem property in properties)
		{
			if (property.id == propertyId)
			{
				return property;
			}
		}
		return default;
	}

	public void sortList()
	{
		properties.Sort((PropertyItem a, PropertyItem b) => a.id.CompareTo(b.id));
	}
}
