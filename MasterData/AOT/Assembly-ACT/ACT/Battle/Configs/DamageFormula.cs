using System;
using ACT.Core;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public struct DamageFormula
{
	private enum BaseValueType
	{
		Property,
		RuntimeValue,
		TeamProperty
	}

	public enum RuntimeValue
	{
		AttackerHp,
		AttackeeHp,
		AttackerPercentHp,
		AttackeePercentHp,
		AttackerAbilityStack,
		AttackeeAbilityStack,
		AttackerMaxHp,
		AttackeeMaxHp
	}

	[SerializeField]
	private BaseValueType valueType;

	[Tooltip("取一个什么属性进行计算")]
	public uint property;

	[Tooltip("取一个属性的基础，加成，额外，还是总量")]
	public GetCoefficientType coefficientType;

	[SerializeField]
	private RuntimeValue runtimeValue;

	[SerializeField]
	public string abilityName;

	[SerializeField]
	private int teamIndex;

	public DynamicFloat mulKey;

	public DynamicFloat constKey;

	public DynamicFloat levelKey;

	public void Cal(Ability ability, Entity attacker, Entity attackee, out float p, out float m, out float constValue, out float l, ActionMemory memory = default(ActionMemory))
	{
		p = 0f;
		switch (valueType)
		{
		case BaseValueType.Property:
			p = attacker.GetCompAbility().GetProperty(property).value;
			break;
		case BaseValueType.RuntimeValue:
		{
			CompAbility compAbility = attacker.GetCompAbility();
			CompAbility compAbility2 = attackee.GetCompAbility();
			p = runtimeValue switch
			{
				RuntimeValue.AttackerHp => compAbility.hp, 
				RuntimeValue.AttackeeHp => compAbility2.hp, 
				RuntimeValue.AttackerPercentHp => (float)compAbility.hp / (float)compAbility.maxHP, 
				RuntimeValue.AttackeePercentHp => (float)compAbility2.hp / (float)compAbility2.maxHP, 
				RuntimeValue.AttackerAbilityStack => compAbility.TryGetAbility(abilityName, includeAdd: true, out var ab) ? ab.stack : 0, 
				RuntimeValue.AttackeeAbilityStack => compAbility2.TryGetAbility(abilityName, includeAdd: true, out var ab2) ? ab2.stack : 0, 
				RuntimeValue.AttackerMaxHp => compAbility.maxHP, 
				RuntimeValue.AttackeeMaxHp => compAbility2.maxHP, 
				_ => throw new ArgumentOutOfRangeException(), 
			};
			break;
		}
		case BaseValueType.TeamProperty:
		{
			Entity teamCharacter = MonoECS.instance.localPlayer.GetTeamCharacter(teamIndex);
			if (!(teamCharacter == null))
			{
				p = teamCharacter.GetCompAbility().GetProperty(property).value;
			}
			break;
		}
		}
		m = mulKey.GetFloat(ability, memory);
		constValue = constKey.GetFloat(ability, memory);
		l = levelKey.GetFloat(ability, memory);
	}
}
