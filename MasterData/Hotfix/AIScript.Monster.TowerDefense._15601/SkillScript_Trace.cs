using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._15601;

public class SkillScript_Trace : SkillSimpleBase
{
	private string key_base = "Run";

	private string key_P4 = "Run_P2";

	public FP trace_StopDis = 1;

	public FP trace_CancleDis = -1;

	public FP trace_Duration = -1;

	private FP traceTime = 2;

	private const int perkId_4 = 1560104;

	public FP addLeftTime_4 = 3;

	private string areaEffect_Trace = "AreaEffect_P4";

	private TraceTarget traceTarget = new TraceTarget();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		traceTarget.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		string actionKey = (GetPerk(1560104) ? key_P4 : key_base);
		BeginAttack(0, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return _actor.WaitTime(0.1f);
		if (GetPerk(1560104))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_Trace, default, default, (AreaEffectEntity entity) =>
			{
			});
		}
		for (FP totleTime = (GetPerk(1560104) ? (traceTime + addLeftTime_4) : traceTime); totleTime > 0; totleTime -= _actor.LogicDeltaTime)
		{
			traceTarget.BeginTrace(_actor, _actor.monsterTarget, trace_StopDis, trace_CancleDis, trace_Duration, () =>
			{
			}, (bool isdie, bool isInterrupt, bool _, bool _) =>
			{
			});
			yield return null;
		}
		CancelAttack();
		_actor.DestroySelf();
	}
}
