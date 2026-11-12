using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12101;

public class ActionScript_Support : ActionScript
{
	private CoroutineNode _p23Cor;

	private bool _inStab;

	private FP _lastStabTime;

	private FP _distanceHoldTime;

	private bool _inRush;

	private FP _rushInRangeTime;

	public override void OnStart()
	{
		base.OnStart();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 512123, out var _))
		{
			((PlayerAdventureActor)_actor).isResidentAssist = true;
			_p23Cor = _actor.StartLogicCoroutine(P23_Loop(), runImmediately: true);
		}
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		if (_p23Cor == null)
		{
			_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
		}
	}

	public override void OnStop()
	{
		base.OnStop();
		if (_p23Cor != null)
		{
			_actor.StopLogicCoroutine(_p23Cor);
			_p23Cor = null;
		}
		_inStab = false;
		_lastStabTime = 0;
		_distanceHoldTime = 0;
		_inRush = false;
		_rushInRangeTime = 0;
	}

	private IEnumerator P23_Loop()
	{
		while (_player.isAssist)
		{
			_actor.attackTarget = null;
			_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
			if (!_inStab && CanCastStab() && _actor.attackTarget != null)
			{
				TryCastStab();
			}
			else
			{
				UpdateTrace();
			}
			yield return null;
		}
	}

	private bool CanCastStab()
	{
		if (!(_lastStabTime <= 0))
		{
			return _actor.LogicTime - _lastStabTime >= Config_Support.interval_StrongStab_P23;
		}
		return true;
	}

	private void TryCastStab()
	{
		AdventureActor adventureActor = _actor.attackTarget as AdventureActor;
		if (adventureActor == null)
		{
			return;
		}
		if (_actor.DistanceWithRadius(adventureActor) <= Config_Support.distance_CastClose_P23)
		{
			CastStab();
			return;
		}
		AdventureActor adventureActor2 = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as AdventureActor;
		if (!(adventureActor2 == null))
		{
			TSVector2 normalized = (adventureActor.tsTransform.Position - adventureActor2.tsTransform.Position).normalized;
			TSVector2 tSVector = new TSVector2(-normalized.y, normalized.x);
			TSVector2 tSVector2 = adventureActor.tsTransform.Position - normalized * Config_Support.distance_TeleportToEnemy_P23;
			TSVector2 tSVector3 = tSVector2 - tSVector * Config_Support.teleportOffset_Side_P23;
			TSVector2 tSVector4 = tSVector2 + tSVector * Config_Support.teleportOffset_Side_P23;
			TSVector2 position = _actor.tsTransform.Position;
			FP minRadiusSum = _actor.GetRadius() + adventureActor.GetRadius();
			TSVector2 candidate;
			TSVector2 candidate2;
			if (TSVector2.DistanceSquared(position, tSVector3) <= TSVector2.DistanceSquared(position, tSVector4))
			{
				candidate = tSVector3;
				candidate2 = tSVector4;
			}
			else
			{
				candidate = tSVector4;
				candidate2 = tSVector3;
			}
			if (!TryResolveAttackPos(candidate, adventureActor, minRadiusSum, out var result))
			{
				TryResolveAttackPos(candidate2, adventureActor, minRadiusSum, out result);
			}
			_actor.Teleport(result);
			CastStab();
		}
	}

	private bool TryResolveAttackPos(TSVector2 candidate, AdventureActor enemy, FP minRadiusSum, out TSVector2 result)
	{
		TSVector2 position = enemy.tsTransform.Position;
		if (TSVector2.Distance(candidate, position) < minRadiusSum)
		{
			TSVector2 normalized = (candidate - position).normalized;
			candidate = position + normalized * minRadiusSum;
		}
		result = candidate;
		if (_actor.QueryPositionWalkable(candidate))
		{
			return true;
		}
		if (_actor.QueryClosestPositionWalkable(candidate, out result))
		{
			return true;
		}
		result = candidate;
		return false;
	}

	private void CastStab()
	{
		_inStab = true;
		ILRuntimeAPI.CreateSkill(110, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, OnStabFinish);
	}

	private void OnStabFinish(bool _)
	{
		_inStab = false;
		_lastStabTime = _actor.LogicTime;
	}

	private void UpdateTrace()
	{
		AdventureActor adventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as AdventureActor;
		if (adventureActor == null)
		{
			return;
		}
		TSVector2 right = adventureActor.tsTransform.Right;
		TSVector2 forward = adventureActor.tsTransform.Forward;
		TSVector2 position = adventureActor.tsTransform.Position;
		TSVector2 tSVector = position - right * Config_Support.traceOffset_Side_P23 + forward * Config_Support.traceOffset_Forward_P23;
		TSVector2 tSVector2 = position + right * Config_Support.traceOffset_Side_P23 + forward * Config_Support.traceOffset_Forward_P23;
		TSVector2 position2 = _actor.tsTransform.Position;
		TSVector2 traceTarget = ((TSVector2.DistanceSquared(position2, tSVector) <= TSVector2.DistanceSquared(position2, tSVector2)) ? tSVector : tSVector2);
		if (!_actor.QueryPositionWalkable(traceTarget))
		{
			_actor.QueryClosestPositionWalkable(traceTarget, out traceTarget);
		}
		FP fP = _actor.DistanceWithRadius(adventureActor);
		if (fP <= Config_Support.distance_StartTrace_P23)
		{
			_distanceHoldTime = 0;
			if (_inRush)
			{
				_rushInRangeTime += _actor.LogicDeltaTime;
				if (_rushInRangeTime >= Config_Support.duration_RunEnd_P23)
				{
					_inRush = false;
					_rushInRangeTime = 0;
					_actor.StandBy();
				}
			}
			else
			{
				_actor.MoveTo(traceTarget, _actor.GetRadius(), enableNavigation: true);
			}
			return;
		}
		if (fP <= Config_Support.distance_MidRange_P23)
		{
			_rushInRangeTime = 0;
			_distanceHoldTime += _actor.LogicDeltaTime;
			if (!_inRush && _distanceHoldTime >= Config_Support.durationThreshold_Move_P23 && IsSkillRecoveryOrIdle())
			{
				_distanceHoldTime = 0;
				_inRush = true;
				_actor.tsTransform.Forward = (traceTarget - position2).normalized;
				ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.A), _actor, SkillPhaseFeatureFlag.Dodge, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool _) =>
				{
					_actor.MoveTo(traceTarget, _actor.GetRadius(), enableNavigation: true);
				});
			}
			return;
		}
		_rushInRangeTime = 0;
		_distanceHoldTime += _actor.LogicDeltaTime;
		if (_distanceHoldTime >= Config_Support.durationThreshold_Move_P23 && IsSkillRecoveryOrIdle())
		{
			_distanceHoldTime = 0;
			TSVector2 result = ILRuntimeAPI.GetRandomPointInShape(_actor, new DeterministicShape
			{
				shapeType = DeterministicShape.ShapeType.Fan,
				position = position,
				innerRadius = Config_Support.teleportInnerRadius_P23,
				radius = Config_Support.teleportOuterRadius_P23,
				angle = 180,
				rotation = adventureActor.tsTransform.Back.GetAngle()
			});
			if (!_actor.QueryPositionWalkable(result))
			{
				_actor.QueryClosestPositionWalkable(result, out result);
			}
			_actor.Teleport(result);
			_inRush = false;
		}
	}

	private bool IsSkillRecoveryOrIdle()
	{
		if (_actor.attackState != ActorState.AttackRecovery)
		{
			return _actor.attackState == ActorState.NonAttack;
		}
		return true;
	}
}
