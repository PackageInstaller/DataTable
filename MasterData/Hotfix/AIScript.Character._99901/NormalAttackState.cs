using AdventureBehaviour;

namespace AIScript.Character._99901;

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
}
