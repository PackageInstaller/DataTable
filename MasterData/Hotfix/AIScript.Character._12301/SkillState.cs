using AdventureBehaviour;

namespace AIScript.Character._12301;

public class SkillState : IState
{
	public ActionKey actionKey;

	public SkillPhaseFeatureFlag skillPhaseFeatureFlag;

	public bool CanCast;

	public int specialSkill;

	public bool isInterruptAttack;

	public override void Enter()
	{
		base.Enter();
		SkillCountdownTiming countdownTiming = SkillCountdownTiming.Start;
		int skillId = ((specialSkill == 0) ? _skillManage.GetCurrentBindSkillId(actionKey) : specialSkill);
		CanCast = ILRuntimeAPI.CreateSkill(skillId, _actor, skillPhaseFeatureFlag, SkillLauncherType.Character, isInterruptAttack, isBreakable: false, countdownTiming, (bool success) =>
		{
			Exit();
		});
	}

	public override void Update()
	{
		base.Update();
		if (_actor.attackTarget != null && _actor.attackComboPhase == Combo.Phase.Recovery && _actor.CheckBreakAttack(SkillPhaseFeatureFlag.Normal))
		{
			_actor.InterruptAttack(force: true);
		}
	}
}
