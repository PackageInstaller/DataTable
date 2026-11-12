using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15501;

public class NormalAttackState : IState
{
	public bool CanCast;

	public override void Enter()
	{
		base.Enter();
		int currentBindSkillId = _skillManage.GetCurrentBindSkillId(ActionKey.Normal);
		CanCast = ILRuntimeAPI.CreateSkill(currentBindSkillId, _actor, SkillPhaseFeatureFlag.Normal, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool success) =>
		{
			Exit();
		});
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
