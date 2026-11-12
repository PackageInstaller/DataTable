using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15801;

public class ActionScript_Support : ActionScript
{
	private TraceTarget _traceTarget;

	private FP _checkTraceInterval;

	private bool _forceTrace;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		if (InTransformState)
		{
			((PlayerAdventureActor)_actor).isResidentAssist = true;
		}
	}

	public override void OnStart()
	{
		base.OnStart();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515831, out var _))
		{
			PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
			if (activedPlayerActor != null && activedPlayerActor.actorElementInfo.elementType == HotfixEnum.elementType.FE)
			{
				activedPlayerActor.buffComponent.AddBuff(15831011, _actor);
			}
		}
		_forceTrace = false;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
	}

	protected override int GetDefaultSkillId()
	{
		return 15832000;
	}

	protected override void OnCastSkill()
	{
		if (ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool _) =>
		{
			((PlayerAdventureActor)_actor).isAssistAIFinish = true;
		}))
		{
			_traceTarget?.CancelTrace();
		}
	}

	protected override void OnCastUltimate()
	{
		if (BeginTransfrom(() =>
		{
			((PlayerAdventureActor)_actor).isAssistAIFinish = true;
		}) && CommonUtils.HavePersonalPerk(_actor.dataID, 515832, out var _))
		{
			_actor.buffComponent.AddBuff(15832011, _actor);
		}
	}

	private void OnCastSkillEnd(IEvent evt)
	{
		if (evt is AdventureActorCastSkillEndEvent { isRelease: false, sender: PlayerAdventureActor sender } adventureActorCastSkillEndEvent && sender == _actor && adventureActorCastSkillEndEvent.skillEventInfo.skillId == 15832000 && !InTransformState && !(_actor.logicVariable.GetLogicTagValue("RemainingSkillShootTimes") <= 0))
		{
			TSVector2 logicTagTSVector2Value = _actor.logicVariable.GetLogicTagTSVector2Value("SummoneCasematePosition");
			TSVector2 logicTagTSVector2Value2 = _actor.logicVariable.GetLogicTagTSVector2Value("SummoneCasemateDirection");
			ILRuntimeAPI.SummonMonster(_actor, 0, 15832031, logicTagTSVector2Value, logicTagTSVector2Value2, Config_Support.summonCfg_Casemate, null, null, useTerrainHeight: true);
		}
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
	}

	protected override void OnTransfromFinish()
	{
		base.OnTransfromFinish();
		((PlayerAdventureActor)_actor).isResidentAssist = true;
	}

	protected override void OnTransformUpdate()
	{
		base.OnTransformUpdate();
		if (InTransformState)
		{
			if (_checkTraceInterval > 0)
			{
				_checkTraceInterval -= _actor.LogicDeltaTime;
			}
			else if (CheckTrace())
			{
				_checkTraceInterval = Config_Support.interval_CheckTrace_Transfrom;
			}
		}
		else if (_traceTarget != null && _traceTarget.Tracing)
		{
			_traceTarget.CancelTrace();
		}
	}

	protected override LogicEntity GetTransformAttackTarget()
	{
		return CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
	}

	protected override void OnTransformNormalAttack()
	{
		base.OnTransformNormalAttack();
		_traceTarget?.CancelTrace();
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
		if (fP > Config_Support.distance_ForceTrace_Transfrom)
		{
			return (target: SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor, stopDistance: Config_Support.distance_StopTrace_ForPlayer_Transfrom, forceTrace: true);
		}
		if (_actor.attackTarget != null)
		{
			if (_actor.DistanceWithRadius(_actor.attackTarget) > CommonUtils.GetAttackRange(_actor))
			{
				return (target: _actor.attackTarget, stopDistance: CommonUtils.GetAttackRange(_actor), forceTrace: false);
			}
		}
		else if (fP > Config_Support.distance_StopTrace_ForPlayer_Transfrom)
		{
			return (target: SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor, stopDistance: Config_Support.distance_StopTrace_ForPlayer_Transfrom, forceTrace: false);
		}
		return (target: null, stopDistance: 0, forceTrace: false);
	}

	private void OnTraceFinish()
	{
		_forceTrace = false;
	}

	private void OnBattleReady(IEvent _)
	{
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		TSVector2 result = ILRuntimeAPI.GetRandomPointInShape(_actor, new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Circle,
			position = activedPlayerActor.tsTransform.Position,
			innerRadius = activedPlayerActor.GetRadius(),
			radius = Config_Support.randomRadius_Teleport
		});
		if (!_actor.QueryPositionWalkable(result))
		{
			_actor.QueryClosestPositionWalkable(result, out result);
		}
		_actor.Teleport(result);
	}

	protected override void OnReturnFinish()
	{
		base.OnReturnFinish();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515832, out var _))
		{
			_actor.buffComponent.RemoveBuffByBuffId(15832011);
		}
		((PlayerAdventureActor)_actor).isAssistAIFinish = true;
		((PlayerAdventureActor)_actor).isResidentAssist = false;
	}

	public override void OnStop()
	{
		base.OnStop();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
		_traceTarget?.CancelTrace();
		_traceTarget?.Clear();
		_forceTrace = false;
	}
}
