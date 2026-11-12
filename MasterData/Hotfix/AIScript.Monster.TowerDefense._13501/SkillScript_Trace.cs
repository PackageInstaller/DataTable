using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._13501;

public class SkillScript_Trace : SkillSimpleBase
{
	private string key_run = "Run";

	private FP trace_StopDis = 1.5;

	private FP trace_MaxTime = 10;

	private TraceTarget traceTarget = new TraceTarget();

	private bool reachedTarget;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		reachedTarget = false;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		traceTarget.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(0, key_run, flushInputedKeys: true, forceInterruptAttack: true);
		yield return _actor.WaitTime(0.1f);
		for (FP totalTime = trace_MaxTime; totalTime > 0; totalTime -= _actor.LogicDeltaTime)
		{
			if (reachedTarget)
			{
				break;
			}
			if (_actor.monsterTarget != null)
			{
				traceTarget.BeginTrace(_actor, _actor.monsterTarget, trace_StopDis, -1, -1, () =>
				{
					reachedTarget = true;
				}, (bool isdie, bool isInterrupt, bool _, bool _) =>
				{
				});
			}
			yield return null;
		}
		CancelAttack();
		_actor.DestroySelf();
	}
}
