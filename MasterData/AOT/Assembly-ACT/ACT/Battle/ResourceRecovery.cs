using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Battle;

public static class ResourceRecovery
{
	public static void Process(ActionMemory memory, AttackData atkData, ActionHit config)
	{
		if (!atkData.directAttacker.IsCharacter())
		{
			return;
		}
		Entity caster = memory.caster;
		CompMotion? compMotion = caster.GetCompMotion();
		FSMRuntimeState fSMRuntimeState = compMotion?.layer0Peak;
		ConfigMotion configMotion = compMotion?.layer0PeakConfig;
		if (caster.IsValid && fSMRuntimeState != null && !(configMotion == null) && !fSMRuntimeState.hasRecoveredEnergyThisMotion)
		{
			fSMRuntimeState.hasRecoveredEnergyThisMotion = true;
			ActionMemory memory2 = new ActionMemory(memory.caster, memory.owner, memory.caster, null, memory.ability);
			float num = configMotion.normalEnergyValue?.Return(memory2) ?? 0f;
			if (num > 0f)
			{
				caster.GetCompAbility().ActionModifyNormalEnergy(num, memory.ability, ActionChangeNormalEnergy.State.Normal);
			}
			float num2 = configMotion.assistValue?.Return(memory2) ?? 0f;
			if (num2 > 0f)
			{
				GameManager.assistSystem.ChangeAssistValueForCharacter(caster, num2, CompAbility.AssistChangeReason.Ability);
			}
		}
	}
}
