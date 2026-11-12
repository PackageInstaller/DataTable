using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15801;

public class ActionScript_Soldier_Support : ActionScript_Summoned_Support
{
	public override void OnStart()
	{
		base.OnStart();
		if (HavePersonalPerk(515828, out var _))
		{
			_areaEffectId_P28 = ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_15801_Support_Skill_P28_Summon_BuffEachOther", _actor.tsTransform.Position);
			_perkLogic_P28 = _actor.StartLogicCoroutine(PerkLogic_P28(158528001, Config_Support.hitRadius_Soldier_P28, Config_Support.hitInnerRadius_Soldier_P28, Config_Support.hitInterval_Soldier_P28), runImmediately: true);
		}
	}

	protected override FP GetAttackRange()
	{
		return Config_Support.attackRange_Soldier;
	}

	protected override int GetNormalAttackSkillId()
	{
		return 15895003;
	}

	protected override FP GetNormalAttackInterval()
	{
		return Config_Support.useInterval_NormalAttack_Soldier;
	}

	protected override FP GetUseSkillInterval()
	{
		return Config_Support.useInterval_Skill_Soldier;
	}

	protected override int GetSkillId()
	{
		return 15895004;
	}
}
