using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11101;

public class NormalAttackState : IState
{
	private FP meleeAttackDistance = 0.2;

	private int skillId = 11110002;

	private FP skillCd = 3;

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
		if (attackTarget != null)
		{
			if (_actor.attackComboPhase == Combo.Phase.Recovery && _actor.CheckBreakAttack(SkillPhaseFeatureFlag.Normal))
			{
				_actor.InterruptAttack(force: true);
			}
			FP fP = _actor.DistanceWithRadius(attackTarget);
			FP logicTagValue = _actor.logicVariable.GetLogicTagValue("lastTime");
			if (meleeAttackDistance > fP && _actor.LogicTime - logicTagValue > skillCd)
			{
				_actor.logicVariable.SetLogicTagValue("lastTime", _actor.LogicTime);
				ActorTryCastSkill actorTryCastSkill = ActorTryCastSkill.Generate();
				actorTryCastSkill.sender = _actor;
				actorTryCastSkill.skillId = skillId;
				actorTryCastSkill.flag = SkillPhaseFeatureFlag.Skill2;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(actorTryCastSkill);
			}
		}
	}
}
