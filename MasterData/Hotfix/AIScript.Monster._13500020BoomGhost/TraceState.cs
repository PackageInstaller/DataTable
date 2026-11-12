using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._13500020BoomGhost;

public class TraceState : IState
{
	private FP startDistance = 5;

	private FP stopDistance = 3;

	private FP cancleDistance = -1;

	private FP traceDuration = -1;

	private TraceTarget traceTarget = new TraceTarget();

	public LogicEntity target;

	public override void Enter()
	{
		base.Enter();
		if (target != null && TSVector2.Distance(_actor.tsTransform.Position, target.tsTransform.Position) > startDistance)
		{
			traceTarget.BeginTrace(_actor, target, stopDistance, cancleDistance, traceDuration, () =>
			{
				Exit();
			}, (bool isdie, bool isInterrupt, bool _, bool _) =>
			{
				Exit();
			});
		}
		else
		{
			Exit();
		}
	}

	public override void Update()
	{
		base.Update();
		if (_actor.monsterTarget != null)
		{
			traceTarget.CancelTrace();
		}
	}

	public override void ForceExit()
	{
		traceTarget.CancelTrace();
	}
}
