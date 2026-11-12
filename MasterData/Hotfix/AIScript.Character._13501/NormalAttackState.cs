using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13501;

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
		LogicEntity attackTarget = GetAttackTarget();
		FP fP = _actor.DistanceWithRadius(attackTarget);
		if (attackTarget != null && CommonUtils.GetAttackRange(_actor) > fP && _actor.attackComboPhase == Combo.Phase.Recovery && _actor.CheckBreakAttack(SkillPhaseFeatureFlag.Normal))
		{
			_actor.InterruptAttack(force: true);
		}
	}
}
