using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11301;

public class TraceState : IState
{
	private FP cancleDistance = -1;

	private FP traceDuration = -1;

	private TraceTarget traceTarget = new TraceTarget();

	public LogicEntity target;

	public override void Enter()
	{
		base.Enter();
		if (target != null)
		{
			traceTarget.BeginTrace(_actor, target, Config.trace_stop, cancleDistance, traceDuration, () =>
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

	public override void Exit()
	{
		base.Exit();
	}

	public void ForceExit()
	{
		traceTarget.CancelTrace();
	}
}
