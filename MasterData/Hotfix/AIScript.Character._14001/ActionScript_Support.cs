using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14001;

public class ActionScript_Support : ActionScript
{
	private TraceTarget _traceTarget;

	private AimTarget _aimTarget;

	private FP _checkTraceInterval;

	private bool _forceTrace;

	private bool _waitForBattleReady;

	private FP _durationTime_P23;

	private CoroutineNode _perkLogicCor_P24;

	private CoroutineNode _perkLogicCor_P29;

	public override void OnStart()
	{
		base.OnStart();
		_forceTrace = false;
		_waitForBattleReady = false;
		_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514022, out var perkLevel) && _actor.isHide)
		{
			_actor.Visible();
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514024, out perkLevel))
		{
			if (_perkLogicCor_P24 != null)
			{
				_actor.StopLogicCoroutine(_perkLogicCor_P24);
			}
			_perkLogicCor_P24 = _actor.StartLogicCoroutine(PerkLogic_P24(), runImmediately: true);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514029, out perkLevel))
		{
			if (_perkLogicCor_P29 != null)
			{
				_actor.StopLogicCoroutine(_perkLogicCor_P29);
			}
			_perkLogicCor_P29 = _actor.StartLogicCoroutine(PerkLogic_P29(), runImmediately: true);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
	}

	protected override void OnCastSkill()
	{
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, OnSkillFinish);
	}

	private void OnSkillFinish(bool success)
	{
		(_actor as PlayerAdventureActor).isAssistAIFinish = true;
		if (success && CommonUtils.HavePersonalPerk(_actor.dataID, 514023, out var perkLevel) && SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor is PlayerAdventureActor playerAdventureActor && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.SE)
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 514022, out perkLevel) && _actor.isHide)
			{
				_actor.Visible();
			}
			(_actor as PlayerAdventureActor).isResidentAssist = true;
			_durationTime_P23 = CommonUtils.GetScriptValue(_actor, 14023011);
		}
	}

	private IEnumerator PerkLogic_P24()
	{
		FP interval = 0;
		while (true)
		{
			if (interval > 0)
			{
				interval -= _actor.LogicDeltaTime;
			}
			else
			{
				interval = Config_Support.interval_Trigger_P24;
				if (_actor.attackTarget != null)
				{
					AdventureActor actor = _actor;
					FP range = 0;
					TSVector2 position = _actor.tsTransform.Position;
					TSVector2 position2 = _actor.attackTarget.tsTransform.Position;
					ILRuntimeAPI.Shoot("Bullet_140_Support_Skill_P24_Boom", actor, range, position, default, position2, null, AimType.Position, BulletDirectionType.BulletToTarget);
				}
			}
			yield return null;
		}
	}

	private IEnumerator PerkLogic_P29()
	{
		FP interval = CommonUtils.GetScriptValue(_actor, 14029011);
		FP addBuffInterval = interval;
		while (true)
		{
			if (addBuffInterval > 0)
			{
				addBuffInterval -= _actor.LogicDeltaTime;
			}
			else
			{
				addBuffInterval = interval;
				_actor.buffComponent.AddBuff(14029011, _actor);
			}
			yield return null;
		}
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		if ((_actor as PlayerAdventureActor).isResidentAssist)
		{
			_actor.attackTarget = GetAttackTarget(activeActorTargetFirst: true);
			if (_waitForBattleReady)
			{
				_waitForBattleReady = false;
				_traceTarget?.CancelTrace();
				LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
				TSVector2 result = ILRuntimeAPI.GetRandomPointInShape(_actor, new DeterministicShape
				{
					shapeType = DeterministicShape.ShapeType.Circle,
					position = activedPlayerActor.tsTransform.Position,
					innerRadius = activedPlayerActor.GetRadius(),
					radius = Config_Support.randomRadius_Teleport_P23
				});
				if (!_actor.QueryPositionWalkable(result))
				{
					_actor.QueryClosestPositionWalkable(result, out result);
				}
				_actor.Teleport(result);
			}
			if (_checkTraceInterval > 0)
			{
				_checkTraceInterval -= _actor.LogicDeltaTime;
			}
			else if (CheckTrace())
			{
				_checkTraceInterval = Config_Support.interval_CheckTrace_P23;
			}
			if (CanNormalAttack())
			{
				if (_actor.aimMode != AdventureActor.AimMode.AimAtAttackTarget)
				{
					if (_aimTarget == null)
					{
						_aimTarget = new AimTarget();
					}
					_aimTarget.Aim(_actor, _actor.attackTarget as AdventureActor, default, playStartAnim: true);
				}
				if (ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal), _actor, SkillPhaseFeatureFlag.Normal, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false))
				{
					_traceTarget?.CancelTrace();
				}
			}
			else if (_actor.aimMode != AdventureActor.AimMode.Forward)
			{
				_aimTarget?.Cancel();
				_aimTarget?.Clear();
			}
			if (_durationTime_P23 > 0)
			{
				_durationTime_P23 -= _actor.LogicDeltaTime;
				return;
			}
			_traceTarget?.CancelTrace();
			(_actor as PlayerAdventureActor).isResidentAssist = false;
			_durationTime_P23 = 0;
		}
		else
		{
			_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
		}
	}

	private LogicEntity GetAttackTarget(bool activeActorTargetFirst = false)
	{
		if (_forceTrace)
		{
			return null;
		}
		return CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst);
	}

	private bool CanNormalAttack()
	{
		if (_forceTrace)
		{
			return false;
		}
		if (_actor.attackTarget == null)
		{
			return false;
		}
		return _actor.DistanceWithRadius(_actor.attackTarget) <= CommonUtils.GetAttackRange(_actor);
	}

	private bool CheckTrace()
	{
		if (_forceTrace)
		{
			return false;
		}
		if (_traceTarget == null)
		{
			_traceTarget = new TraceTarget();
		}
		if (_actor.actorSkillManage.HaveRunningSkill())
		{
			_traceTarget.CancelTrace();
			return false;
		}
		(LogicEntity target, FP stopDistance, bool forceTrace) traceInfo = GetTraceInfo();
		LogicEntity item = traceInfo.target;
		FP item2 = traceInfo.stopDistance;
		bool item3 = traceInfo.forceTrace;
		_forceTrace = item3;
		if (item != null)
		{
			_traceTarget.BeginTrace(_actor, item, item2, -1, -1, null, null, NavAgentTypeNames.NavigationUpdateQualityLevel.MedQualityNavigationUpdate, AdventureActor.MovementMode.Run, OnTraceFinish);
			return true;
		}
		return false;
	}

	private (LogicEntity target, FP stopDistance, bool forceTrace) GetTraceInfo()
	{
		FP fP = _actor.DistanceWithRadius(SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor);
		if (fP > Config_Support.distance_ForceTrace_P23)
		{
			return (target: SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor, stopDistance: Config_Support.distance_StopTrace_ForPlayer_P23, forceTrace: true);
		}
		if (_actor.attackTarget != null)
		{
			if (_actor.DistanceWithRadius(_actor.attackTarget) > CommonUtils.GetAttackRange(_actor))
			{
				return (target: _actor.attackTarget, stopDistance: CommonUtils.GetAttackRange(_actor), forceTrace: false);
			}
		}
		else if (fP > Config_Support.distance_StopTrace_ForPlayer_P23)
		{
			return (target: SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor, stopDistance: Config_Support.distance_StopTrace_ForPlayer_P23, forceTrace: false);
		}
		return (target: null, stopDistance: 0, forceTrace: false);
	}

	private void OnTraceFinish()
	{
		_forceTrace = false;
	}

	private void OnBattleReady(IEvent _)
	{
		_waitForBattleReady = true;
	}

	public override void OnStop()
	{
		base.OnStop();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		_aimTarget?.Cancel();
		_aimTarget?.Clear();
		_traceTarget?.CancelTrace();
		_forceTrace = false;
		_waitForBattleReady = false;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514024, out var perkLevel))
		{
			if (_perkLogicCor_P24 != null)
			{
				_actor.StopLogicCoroutine(_perkLogicCor_P24);
			}
			_perkLogicCor_P24 = null;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514029, out perkLevel))
		{
			if (_perkLogicCor_P29 != null)
			{
				_actor.StopLogicCoroutine(_perkLogicCor_P29);
			}
			_perkLogicCor_P29 = null;
			_actor.buffComponent.RemoveBuffByBuffId(14029011);
		}
	}
}
