using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11101;

public class SkillState : IState
{
	private FP meleeAttackDistance = 0.2;

	private int skillId = 11110002;

	private FP skillCd = 3;

	public ActionKey actionKey;

	public SkillPhaseFeatureFlag skillPhaseFeatureFlag;

	public bool CanCast;

	public int specialSkill;

	public bool isInterruptAttack;

	public bool isRushJoinDodge;

	public override void Enter()
	{
		base.Enter();
		SkillCountdownTiming skillCountdownTiming = SkillCountdownTiming.Start;
		int currentBindSkillId;
		if (specialSkill != 0)
		{
			currentBindSkillId = specialSkill;
		}
		else
		{
			currentBindSkillId = _skillManage.GetCurrentBindSkillId(actionKey);
			if (actionKey == ActionKey.B)
			{
				skillCountdownTiming = SkillCountdownTiming.End;
			}
		}
		int num = currentBindSkillId;
		AdventureActor actor = _actor;
		SkillPhaseFeatureFlag skillCastBehaviourType = skillPhaseFeatureFlag;
		SkillCountdownTiming countdownTiming = skillCountdownTiming;
		CanCast = ILRuntimeAPI.CreateSkill(num, actor, skillCastBehaviourType, SkillLauncherType.Character, isInterruptAttack, isBreakable: false, countdownTiming, (bool success) =>
		{
			Exit();
		}, null, ingoreCDAndEnergy: false, isRushJoinDodge);
	}

	public override void Update()
	{
		base.Update();
		LogicEntity attackTarget = GetAttackTarget();
		if (attackTarget != null && _actor.attackComboPhase == Combo.Phase.Recovery && _actor.CheckBreakAttack(SkillPhaseFeatureFlag.Normal))
		{
			_actor.InterruptAttack(force: true);
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
