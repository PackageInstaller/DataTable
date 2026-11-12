using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._16001;

public class ActionScript_Support : ActionScript
{
	private CoroutineNode _assitLogicCor;

	private bool _pauseAssitLogic;

	private FP _checkTraceInterval;

	private FP _lastTriggerTeleportTime;

	private AimTarget _aimTarget;

	private int _canAimCount;

	private int _canTraceCount;

	private bool InAssitState
	{
		get
		{
			if (((PlayerAdventureActor)_actor).status == ActorStatus.Special)
			{
				return ((PlayerAdventureActor)_actor).specialStatusTime > 0;
			}
			return false;
		}
	}

	private bool CanAim
	{
		get
		{
			if (_pauseAssitLogic)
			{
				return false;
			}
			return _canAimCount > 0;
		}
	}

	private bool CanTrace
	{
		get
		{
			if (_pauseAssitLogic)
			{
				return false;
			}
			if (_canTraceCount <= 0)
			{
				return _actor.logicVariable.GetLogicTagToggle("CanTrace_Teleport");
			}
			return true;
		}
	}

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		if (_aimTarget == null)
		{
			_aimTarget = new AimTarget();
		}
	}

	public override void OnStart()
	{
		base.OnStart();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516032, out var _))
		{
			foreach (AdventureActor allPlayerActor in ILRuntimeAPI.GetAllPlayerActors(_actor))
			{
				allPlayerActor.buffComponent.AddBuff(16032011, _actor);
			}
		}
		if (InAssitState)
		{
			_actor.ReplaceAnimationGroup();
			((PlayerAdventureActor)_actor).isResidentAssist = true;
			if (_assitLogicCor != null)
			{
				_actor.StopLogicCoroutine(_assitLogicCor);
			}
			_assitLogicCor = _actor.StartLogicCoroutine(AssitLogic(((PlayerAdventureActor)_actor).specialStatusTime), runImmediately: true);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
	}

	protected override void OnCastSkill()
	{
		if (ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, OnSkillFinish))
		{
			if (_assitLogicCor != null)
			{
				_actor.StopLogicCoroutine(_assitLogicCor);
			}
			_assitLogicCor = _actor.StartLogicCoroutine(AssitLogic(Config_Support.durationTime_Assit), runImmediately: true);
		}
	}

	protected override void OnCastUltimate()
	{
		if (ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.D), _actor, SkillPhaseFeatureFlag.Ultimate, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, OnUltraSkillFinish))
		{
			_actor.StandBy();
			_aimTarget.Cancel();
			_aimTarget.Clear();
			if (InAssitState)
			{
				_pauseAssitLogic = true;
			}
		}
	}

	private void OnSkillFinish(bool success)
	{
		((PlayerAdventureActor)_actor).isAssistAIFinish = true;
		if (success)
		{
			((PlayerAdventureActor)_actor).isResidentAssist = true;
		}
	}

	private void OnUltraSkillFinish(bool success)
	{
		((PlayerAdventureActor)_actor).isAssistAIFinish = true;
		if (success && InAssitState)
		{
			ILRuntimeAPI.CreateSkill(16032007, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool _) =>
			{
				_checkTraceInterval = 0;
				_pauseAssitLogic = false;
			});
		}
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
	}

	private IEnumerator AssitLogic(FP durationTime)
	{
		((PlayerAdventureActor)_actor).status = ActorStatus.Special;
		((PlayerAdventureActor)_actor).specialStatusTime = durationTime;
		while (!((PlayerAdventureActor)_actor).isResidentAssist)
		{
			yield return null;
		}
		_canAimCount = 1;
		_canTraceCount = 1;
		while (InAssitState)
		{
			if (!_pauseAssitLogic)
			{
				CheckTeleport();
				CastSkill();
				CheckAim();
				if (_checkTraceInterval > 0)
				{
					_checkTraceInterval -= _actor.LogicDeltaTime;
				}
				else
				{
					CheckTrace();
					_checkTraceInterval = Config_Support.interval_CheckTrace;
				}
				((PlayerAdventureActor)_actor).specialStatusTime -= _actor.LogicDeltaTime;
			}
			yield return null;
		}
		((PlayerAdventureActor)_actor).status = ActorStatus.Default;
		((PlayerAdventureActor)_actor).specialStatusTime = 0;
		while (!ILRuntimeAPI.CreateSkill(16032001, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, OnExitSkillFinish))
		{
			yield return null;
		}
		_actor.StandBy();
		_aimTarget.Cancel();
		_canAimCount = 0;
		_canTraceCount = 0;
		_assitLogicCor = null;
	}

	private void CheckTeleport()
	{
		if ((_lastTriggerTeleportTime <= 0 || _actor.LogicTime - _lastTriggerTeleportTime > Config_Support.triggerCD_Teleport) && _actor.DistanceWithRadius(SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor) > Config_Support.distance_CanTeleport)
		{
			_canAimCount--;
			_canTraceCount--;
			ILRuntimeAPI.CreateSkill(16032002, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool _) =>
			{
				_canAimCount++;
				_canTraceCount++;
			});
			_lastTriggerTeleportTime = _actor.LogicTime;
		}
	}

	private void CastSkill()
	{
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516022, out var perkLevel) && _actor.logicVariable.GetLogicTagToggle("CanRotateFire_P22"))
		{
			_canAimCount--;
			ILRuntimeAPI.CreateSkill(16032005, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool _) =>
			{
				_canAimCount++;
			});
		}
		else if (CommonUtils.HavePersonalPerk(_actor.dataID, 516021, out perkLevel) && _actor.logicVariable.GetLogicTagToggle("CanLineFire_P21") && _actor.logicVariable.GetLogicTagValue("DecibelState") == 1)
		{
			_canAimCount--;
			_canTraceCount--;
			ILRuntimeAPI.CreateSkill(16032004, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool _) =>
			{
				_canAimCount++;
				_canTraceCount++;
			});
		}
		else if (CommonUtils.HavePersonalPerk(_actor.dataID, 516023, out perkLevel) && _actor.logicVariable.GetLogicTagToggle("CanTriggerPerk_P23"))
		{
			ILRuntimeAPI.CreateSkill(16032006, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
		}
		else
		{
			ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal), _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
		}
	}

	private void CheckAim()
	{
		if (CanAim)
		{
			if (_actor.attackTarget != null)
			{
				_aimTarget.Aim(_actor, _actor.attackTarget as AdventureActor);
			}
			else if (_actor.aimMode != AdventureActor.AimMode.LockDirection)
			{
				_aimTarget.Aim(_actor, null, _actor.tsTransform.Forward);
			}
		}
		else if (_actor.aimMode != AdventureActor.AimMode.Forward)
		{
			_aimTarget.Cancel();
			_aimTarget.Clear();
		}
	}

	private void CheckTrace()
	{
		if (CanTrace)
		{
			if (SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor is PlayerAdventureActor playerAdventureActor && _actor.DistanceWithRadius(playerAdventureActor) > Config_Support.distance_StartTrace_ForPlayer)
			{
				TSVector2 randomPointInShape = ILRuntimeAPI.GetRandomPointInShape(_actor, new DeterministicShape
				{
					shapeType = DeterministicShape.ShapeType.Fan,
					innerRadius = playerAdventureActor.GetRadius(),
					radius = Config_Support.randomRadius_TracePosition_ForPlayer,
					angle = Config_Support.randomAngle_TracePosition_ForPlayer,
					position = playerAdventureActor.tsTransform.Position,
					rotation = playerAdventureActor.tsTransform.Back.GetAngle()
				});
				_actor.MoveTo(randomPointInShape, _actor.GetRadius(), enableNavigation: true);
			}
		}
		else if (_actor.movementState == ActorState.Move)
		{
			_actor.StandBy();
		}
	}

	private void OnExitSkillFinish(bool success)
	{
		if (success)
		{
			((PlayerAdventureActor)_actor).isResidentAssist = false;
		}
	}

	private void OnBattleReady(IEvent _)
	{
		if (!_actor.actorSkillManage.HaveSkill(16032002))
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
	}

	private void Clear()
	{
		if (_assitLogicCor != null)
		{
			_actor.StopLogicCoroutine(_assitLogicCor);
		}
		_assitLogicCor = null;
		_pauseAssitLogic = false;
		_lastTriggerTeleportTime = 0;
		_checkTraceInterval = 0;
		_canAimCount = 0;
		_canTraceCount = 0;
		_actor.StandBy();
		_aimTarget.Cancel();
		_aimTarget.Clear();
	}

	public override void OnStop()
	{
		base.OnStop();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516032, out var _))
		{
			foreach (AdventureActor allPlayerActor in ILRuntimeAPI.GetAllPlayerActors(_actor))
			{
				allPlayerActor.buffComponent.RemoveBuffByBuffId(16032011);
			}
		}
		Clear();
	}
}
