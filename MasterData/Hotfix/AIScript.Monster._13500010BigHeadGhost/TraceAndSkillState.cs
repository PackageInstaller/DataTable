using AdventureBehaviour;

namespace AIScript.Monster._13500010BigHeadGhost;

public class TraceAndSkillState : IState
{
	public bool CanCast;

	public SkillInfo skillInfo;

	public LogicEntity target;

	private TraceTarget traceTarget = new TraceTarget();

	public override void Enter()
	{
		base.Enter();
		if (_actor.DistanceWithRadius(target) > skillInfo.trace_StopDis)
		{
			traceTarget.BeginTrace(_actor, target, skillInfo.trace_StopDis, skillInfo.trace_CancleDis, skillInfo.trace_Duration, () =>
			{
				CastSkill();
			}, (bool isdie, bool isInterrupt, bool _, bool _) =>
			{
				Exit();
			});
		}
		else
		{
			CastSkill();
		}
	}

	private void CastSkill()
	{
		if (ILRuntimeAPI.CreateSkill(skillInfo.skillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool success) =>
		{
			Exit();
		}))
		{
			AdventureActor summonActor = (_actor as MonsterAdventureActor).monsterSummonInfo.SummonActor;
			skillInfo.lastCastTime = summonActor.LogicTime;
		}
	}

	public override void ForceExit()
	{
		traceTarget.CancelTrace();
		_actor.InterruptAttack(force: true);
	}
}
