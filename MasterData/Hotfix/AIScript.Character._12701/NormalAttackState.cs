using AdventureBehaviour;

namespace AIScript.Character._12701;

public class NormalAttackState : IState
{
	public override void Enter()
	{
		base.Enter();
		if (!ILRuntimeAPI.CreateSkill(_skillManage.GetCurrentBindSkillId(ActionKey.Normal), _actor, SkillPhaseFeatureFlag.Normal, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool success) =>
		{
			Exit();
		}))
		{
			Exit();
		}
	}

	public override void Update()
	{
		base.Update();
		if (GetAttackTarget() != null && _actor.attackComboPhase == Combo.Phase.Recovery && _actor.CheckBreakAttack(SkillPhaseFeatureFlag.Normal))
		{
			_actor.InterruptAttack(force: true);
		}
	}
}
