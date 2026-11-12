using AdventureBehaviour;

namespace AIScript.Character._16101.Summoned.FangWeiBiao;

public class SkillState : IState
{
	public bool CanCast;

	private int skillId;

	public SkillState(AdventureActor actor)
	{
		_actor = actor;
	}

	public void SetSkill(int id)
	{
		skillId = id;
	}

	public override void Enter()
	{
		base.Enter();
		CanCast = ILRuntimeAPI.CreateSkill(skillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool success) =>
		{
			Exit();
		});
		if (!CanCast)
		{
			Exit();
		}
	}
}
