using AdventureBehaviour;

namespace AIScript.Character._11301;

public class SkillState : IState
{
	public ActionKey actionKey;

	public SkillPhaseFeatureFlag skillPhaseFeatureFlag;

	public bool CanCast;

	public int specialSkill;

	public bool isInterruptAttack;

	public bool isRushJoinDodge;

	public override void Enter()
	{
		base.Enter();
		SkillCountdownTiming countdownTiming = SkillCountdownTiming.Start;
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
				countdownTiming = SkillCountdownTiming.End;
			}
		}
		CanCast = ILRuntimeAPI.CreateSkill(currentBindSkillId, _actor, skillPhaseFeatureFlag, SkillLauncherType.Character, isInterruptAttack, isBreakable: false, countdownTiming, (bool success) =>
		{
			Exit();
		}, null, ingoreCDAndEnergy: false, isRushJoinDodge);
	}

	public override void Update()
	{
		base.Update();
		if (_actor.attackTarget != null && _actor.attackComboPhase == Combo.Phase.Recovery && actionKey != ActionKey.D && _actor.CheckBreakAttack(SkillPhaseFeatureFlag.Normal))
		{
			_actor.InterruptAttack(force: true);
		}
	}
}
