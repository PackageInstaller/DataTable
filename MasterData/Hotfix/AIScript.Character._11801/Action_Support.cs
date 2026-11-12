using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11801;

public class Action_Support : ActorActionBase
{
	private readonly FP traceStopDistance = 1;

	private TraceTarget _traceTarget;

	private AdventureActor _target;

	private CoroutineNode _traceCoroutineNode;

	protected override void OnCastUltimate()
	{
		if (ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.D), _actor, SkillPhaseFeatureFlag.Ultimate, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, OnUltraSkillFinish))
		{
			StartCoroutine(ref _traceCoroutineNode, Trace());
		}
	}

	private IEnumerator Trace()
	{
		while (true)
		{
			AdventureActor adventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.attackTarget as AdventureActor;
			if (_target != null && !_target.actorHealthInfo.isAlive)
			{
				ILRuntimeAPI.CancelTraceTarget(_traceTarget);
			}
			if (adventureActor != null)
			{
				if (_target != null && adventureActor != _target)
				{
					ILRuntimeAPI.CancelTraceTarget(_traceTarget);
				}
				if (adventureActor != _target && ILRuntimeAPI.CalcDistanceBetweenTwoActor(_actor, adventureActor) > traceStopDistance)
				{
					_target = adventureActor;
					ILRuntimeAPI.BeginTraceTarget(ref _traceTarget, _actor, _target, traceStopDistance, -1, -1, null, null, NavAgentTypeNames.NavigationUpdateQualityLevel.MedQualityNavigationUpdate, AdventureActor.MovementMode.Walk, () =>
					{
						_target = null;
					});
				}
			}
			yield return null;
		}
	}

	private void OnUltraSkillFinish(bool success)
	{
		((PlayerAdventureActor)_actor).isAssistAIFinish = true;
		StopCoroutine(_traceCoroutineNode);
		ILRuntimeAPI.CancelTraceTarget(_traceTarget);
		_target = null;
	}

	public override void OnStop()
	{
		base.OnStop();
		StopCoroutine(_traceCoroutineNode);
		ILRuntimeAPI.CancelTraceTarget(_traceTarget);
		ILRuntimeAPI.ClearTraceTarget(_traceTarget);
		_target = null;
	}
}
