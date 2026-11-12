using AdventureBehaviour;

namespace AIScript.Monster._13500020BoomGhost;

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
		Exit();
		_actor.DestroySelf();
	}

	public override void ForceExit()
	{
		traceTarget.CancelTrace();
	}
}
