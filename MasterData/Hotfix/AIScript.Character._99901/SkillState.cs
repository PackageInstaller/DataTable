using AdventureBehaviour;

namespace AIScript.Character._99901;

public class SkillState : IState
{
	public ActionKey actionKey;

	public SkillPhaseFeatureFlag skillPhaseFeatureFlag;

	public bool CanCast;

	public int specialSkill;

	public bool isInterruptAttack;

	public bool ingoreCDAndEnergy;

	private bool isRushJoinDodge;

	public SkillState(AdventureActor actor, PlayerSkillCd skillManager, AimTarget aimTarget)
	{
		_actor = actor;
		_skillManage = skillManager;
		_aimTarget = aimTarget;
	}

	public void SetSkill(ActionKey actionKey, SkillPhaseFeatureFlag skillPhaseFeatureFlag, int specialSkill, bool isInterruptAttack, bool ingoreCDAndEnergy = false, bool isRushJoinDodge = true)
	{
		this.actionKey = actionKey;
		this.specialSkill = specialSkill;
		this.skillPhaseFeatureFlag = skillPhaseFeatureFlag;
		this.isInterruptAttack = isInterruptAttack;
		this.ingoreCDAndEnergy = ingoreCDAndEnergy;
		this.isRushJoinDodge = isRushJoinDodge;
	}

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
		int skillId = currentBindSkillId;
		AdventureActor actor = _actor;
		SkillPhaseFeatureFlag skillCastBehaviourType = skillPhaseFeatureFlag;
		SkillCountdownTiming countdownTiming = skillCountdownTiming;
		CanCast = ILRuntimeAPI.CreateSkill(skillId, actor, skillCastBehaviourType, SkillLauncherType.Character, isInterruptAttack, isBreakable: false, countdownTiming, (bool success) =>
		{
			Exit();
		}, null, ingoreCDAndEnergy, isRushJoinDodge);
	}

	public override void Update()
	{
		base.Update();
		if (_actor.attackTarget != null && _actor.attackComboPhase == Combo.Phase.Recovery && _actor.CheckBreakAttack(SkillPhaseFeatureFlag.Normal))
		{
			_actor.InterruptAttack(force: true);
		}
	}

	public override void Exit()
	{
		base.Exit();
	}
}
