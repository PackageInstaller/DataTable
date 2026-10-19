using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改伤害", "Action", new string[] { "modify", "damage", "hit", "attack" })]
public class ActionModifyDamage : ConfigAction
{
	public ModifyDamageType type;

	[Tooltip("覆盖属性值")]
	public bool Override;

	public ConfigFunction<float> modifyValue;

	public override void Do(ActionMemory memory)
	{
		if (!(memory.evt is IGetAttackData getAttackData))
		{
			return;
		}
		AttackData attackData = getAttackData.GetAttackData();
		ActionMemory memory2 = new ActionMemory(memory.caster, memory.owner, FindTargetResult.EntityOnly(memory.owner), memory.evt, memory.ability);
		switch (type)
		{
		case ModifyDamageType.BaseDamagePhase:
			attackData.basePhaseAdd += modifyValue.Return(memory2);
			break;
		case ModifyDamageType.FinalPhaseMul:
			attackData.finalPhaseMul *= modifyValue.Return(memory2);
			break;
		case ModifyDamageType.ElementPhase:
			attackData.elementPhaseAdd += modifyValue.Return(memory2);
			break;
		case ModifyDamageType.MultiPowerPhase:
			attackData.AddMultiPower += modifyValue.Return(memory2);
			break;
		case ModifyDamageType.TenacityAtkPhase:
			attackData.attackerTenacityAtk *= modifyValue.Return(memory2);
			break;
		case ModifyDamageType.criticalPhaseAdd:
			attackData.criticalPhaseAdd += modifyValue.Return(memory2);
			if (Override)
			{
				attackData.criticalChance = 0f;
			}
			break;
		case ModifyDamageType.defPenetrationPhaseAdd:
			attackData.defPenetrationPhaseAdd += modifyValue.Return(memory2);
			if (Override)
			{
				attackData.defPenetration = 0f;
			}
			break;
		case ModifyDamageType.criticalMulPhaseAdd:
			attackData.criticalMulPhaseAdd += modifyValue.Return(memory2);
			if (Override)
			{
				attackData.criticalMul = 0f;
			}
			break;
		case ModifyDamageType.weakPhaseAdd:
			attackData.weakPhaseAdd += modifyValue.Return(memory2);
			break;
		case ModifyDamageType.extraMulPhaseAdd:
			attackData.finalPhaseAdd += modifyValue.Return(memory2);
			break;
		case ModifyDamageType.postureBaseAdd:
			attackData.postureBaseAdd += modifyValue.Return(memory2);
			break;
		case ModifyDamageType.MultiPosturePhase:
			attackData.multiPosturePhase += modifyValue.Return(memory2);
			break;
		case ModifyDamageType.FinalPhaseAdd:
			attackData.finalPhaseAdd += modifyValue.Return(memory2);
			if (Override)
			{
				float damageMulAdd = memory.owner.GetCompAbility().DamageMulAdd;
				attackData.finalPhaseAdd -= damageMulAdd;
			}
			break;
		case ModifyDamageType.MannerDamagePhase:
			attackData.MannerPhaseAdd += modifyValue.Return(memory2);
			break;
		case ModifyDamageType.ForceWeakElement:
			attackData.isWeakElement = modifyValue.Return(memory2) > 0f;
			attackData.isWeakElementOverridden = true;
			break;
		case ModifyDamageType.ForceStrongWeakElement:
			attackData.isStrongWeakElement = modifyValue.Return(memory2) > 0f;
			attackData.isStrongWeakElementOverridden = true;
			break;
		case ModifyDamageType.PartWeakPhaseAdd:
			attackData.partWeakPhaseAdd = modifyValue.Return(memory2);
			break;
		case ModifyDamageType.decayPhaseMul:
			break;
		}
	}

	public bool CanDamageTypeOverride()
	{
		ModifyDamageType modifyDamageType = type;
		if ((uint)(modifyDamageType - 5) <= 2u || modifyDamageType == ModifyDamageType.FinalPhaseAdd)
		{
			return true;
		}
		return false;
	}
}
