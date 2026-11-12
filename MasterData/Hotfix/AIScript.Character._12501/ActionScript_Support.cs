using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12501;

public class ActionScript_Support : ActionScript
{
	private TraceTarget _traceTarget;

	private FP _checkTraceInterval;

	private bool _forceTrace;

	private CoroutineNode _perkLoigcCor_P29;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		if (InBerserkState)
		{
			((PlayerAdventureActor)_actor).isResidentAssist = true;
		}
	}

	public override void OnStart()
	{
		base.OnStart();
		_forceTrace = false;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512529, out var _))
		{
			if (_perkLoigcCor_P29 != null)
			{
				_actor.StopLogicCoroutine(_perkLoigcCor_P29);
			}
			_perkLoigcCor_P29 = _actor.StartLogicCoroutine(PerkLogic_P29());
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
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

	private IEnumerator PerkLogic_P29()
	{
		FP interval = Config_Support.addBuffInterval_P29;
		while (true)
		{
			if (interval > 0)
			{
				interval -= _actor.LogicDeltaTime;
			}
			else
			{
				_actor.buffComponent?.AddBuff(12529011, _actor);
				interval = Config_Support.addBuffInterval_P29;
			}
			yield return null;
		}
	}

	protected override void OnCastSkill()
	{
		if (!ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.End, OnSkillFinish))
		{
			return;
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512523, out var perkLevel))
		{
			_actor.buffComponent?.AddBuff(12523011, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512530, out perkLevel) && InBerserkState)
		{
			int timingBuffCount = CommonUtils.GetScriptValue(_actor, 12530011).AsInt();
			AddBerserkTime(timingBuffCount);
			_actor.buffComponent?.AddBuff(12530011, _actor);
		}
		if (!ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512533, out perkLevel))
		{
			return;
		}
		FP scriptValue = CommonUtils.GetScriptValue(_actor, 12533001);
		if (!(TSRandom.Range(FP.Zero, 100) <= scriptValue))
		{
			return;
		}
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			actorL.buffComponent.AddBuff(12533011, _actor);
		}
	}

	protected override void OnCastUltimate()
	{
		if (ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.D), _actor, SkillPhaseFeatureFlag.Ultimate, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, OnUltraSkillFinish))
		{
			_actor.attackTarget = GetAttackTarget(activeActorTargetFirst: true);
		}
	}

	private void OnSkillFinish(bool _)
	{
		((PlayerAdventureActor)_actor).isAssistAIFinish = true;
	}

	private void OnUltraSkillFinish(bool _)
	{
		((PlayerAdventureActor)_actor).isAssistAIFinish = true;
		if (InBerserkState)
		{
			((PlayerAdventureActor)_actor).isResidentAssist = true;
		}
	}

	protected override void OnExitBerserkSkillFinish(bool success)
	{
		base.OnExitBerserkSkillFinish(success);
		if (success)
		{
			((PlayerAdventureActor)_actor).isResidentAssist = false;
		}
	}

	public override void OnUpdate()
	{
		if (InBerserkState)
		{
			_actor.attackTarget = GetAttackTarget();
			if (_checkTraceInterval > 0)
			{
				_checkTraceInterval -= _actor.LogicDeltaTime;
			}
			else if (CheckTrace())
			{
				_checkTraceInterval = Config_Support.interval_CheckTrace;
			}
			if (CanNormalAttack() && ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal), _actor, SkillPhaseFeatureFlag.Normal, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false))
			{
				_traceTarget?.CancelTrace();
			}
			base.OnUpdate();
		}
		else
		{
			base.OnUpdate();
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
		if (fP > Config_Support.distance_ForceTrace)
		{
			return (target: SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor, stopDistance: Config_Support.distance_StopTrace_ForPlayer, forceTrace: true);
		}
		if (_actor.attackTarget != null)
		{
			if (_actor.DistanceWithRadius(_actor.attackTarget) > CommonUtils.GetAttackRange(_actor))
			{
				return (target: _actor.attackTarget, stopDistance: CommonUtils.GetAttackRange(_actor), forceTrace: false);
			}
		}
		else if (fP > Config_Support.distance_StopTrace_ForPlayer)
		{
			return (target: SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor, stopDistance: Config_Support.distance_StopTrace_ForPlayer, forceTrace: false);
		}
		return (target: null, stopDistance: 0, forceTrace: false);
	}

	private void OnTraceFinish()
	{
		_forceTrace = false;
	}

	protected override void OnExitBerserk()
	{
		base.OnExitBerserk();
		_traceTarget?.CancelTrace();
		_traceTarget?.Clear();
	}

	public override void OnStop()
	{
		base.OnStop();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512529, out var _))
		{
			_actor.buffComponent.RemoveBuffByBuffId(12529011);
		}
		Clear();
	}

	private void Clear()
	{
		if (_perkLoigcCor_P29 != null)
		{
			_actor.StopLogicCoroutine(_perkLoigcCor_P29);
		}
		_perkLoigcCor_P29 = null;
		_traceTarget?.CancelTrace();
		_traceTarget?.Clear();
		_checkTraceInterval = 0;
		_forceTrace = false;
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		ForceExitBerserkState();
		((PlayerAdventureActor)_actor).isResidentAssist = false;
	}
}
