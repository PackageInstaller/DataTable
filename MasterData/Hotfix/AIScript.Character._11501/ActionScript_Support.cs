using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11501;

public class ActionScript_Support : ActionScript
{
	private FP _removeTransfromStateBuffInterval;

	private FP _triggerInterval_FlyingBlade;

	private TraceTarget _traceTarget;

	private FP _checkTraceInterval;

	private bool _forceTrace;

	private PlayFX _playFX_P23;

	private CoroutineNode _perkLogicCor_P28;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		InitState();
		if (InTransformState)
		{
			_actor.ReplaceAnimationGroup();
			((PlayerAdventureActor)_actor).isResidentAssist = true;
			EnterTransformState(((PlayerAdventureActor)_actor).specialStatusTime);
		}
	}

	private void InitState()
	{
		_actor.actorSearchTargetInfo.visionRange = Config_Support.visionRange;
		_actor.actorSearchTargetInfo.visionAttackRange = Config_Support.visionAttackRange;
		_actor.actorSearchTargetInfo.visionDeg = Config_Support.visionDeg;
		_actor.actorSearchTargetInfo.hearRange = Config_Support.hearRange;
		_actor.actorSearchTargetInfo.hearAttackRange = Config_Support.hearAttackRange;
		((PlayerAdventureActor)_actor).searchType = PlayerActorSearchType.Melee;
		((PlayerAdventureActor)_actor).moveControlType = PlayerActorMoveType.Melee;
	}

	public override void OnStart()
	{
		base.OnStart();
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
	}

	protected override void OnCastSkill()
	{
		if (!ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.End, OnSkillFinish))
		{
			return;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511524, out var perkLevel))
		{
			((PlayerAdventureActor)_actor).SetLocalData("HitTimes_P24", "0");
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511525, out perkLevel))
		{
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(11525011);
			if (buffNumByID > 0)
			{
				_actor.buffComponent.AddBuffNum(11525013, buffNumByID, _actor);
				_actor.buffComponent.RemoveBuffByBuffId(11525011);
			}
			buffNumByID = _actor.buffComponent.GetBuffNumByID(11525014);
			if (buffNumByID > 0)
			{
				_actor.buffComponent.AddBuffNum(11525015, buffNumByID, _actor);
				_actor.buffComponent.RemoveBuffByBuffId(11525014);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511528, out perkLevel))
		{
			_actor.buffComponent.RemoveBuffByBuffId(11528011);
			_actor.buffComponent.RemoveBuffByBuffId(11528012);
		}
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 511532, out perkLevel))
		{
			return;
		}
		foreach (AdventureActor allPlayerActor in ILRuntimeAPI.GetAllPlayerActors(_actor))
		{
			if (allPlayerActor.actorElementInfo.elementType == HotfixEnum.elementType.LE)
			{
				allPlayerActor.buffComponent.AddBuff(11532011, _actor);
			}
		}
	}

	protected override void OnCastUltimate()
	{
		if (ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.D), _actor, SkillPhaseFeatureFlag.Ultimate, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, OnUltraSkillFinish))
		{
			ExitTransformState();
		}
	}

	private void OnSkillFinish(bool success)
	{
		((PlayerAdventureActor)_actor).isAssistAIFinish = true;
		if (success)
		{
			((PlayerAdventureActor)_actor).isResidentAssist = true;
			EnterTransformState(Config_Support.durationTime_TransformState);
		}
	}

	private void OnUltraSkillFinish(bool _)
	{
		((PlayerAdventureActor)_actor).isAssistAIFinish = true;
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent && adventureActorCustomEvent.eventHashCode == Config_Support.eventHashCode_TriggerFirstFlyingBlade)
		{
			_actor.StartLogicCoroutine(FlyingBladeLogic(_actor.attackTarget, isFirstRound: true), runImmediately: true);
		}
	}

	protected override void OnEnterTransformState()
	{
		base.OnEnterTransformState();
		_actor.buffComponent.RemoveBuffByBuffId(11593211);
		int num = TSMath.CeilToInt(((PlayerAdventureActor)_actor).specialStatusTime);
		if (num > 0)
		{
			_actor.buffComponent.AddBuffNum(11593211, num, _actor);
		}
		CheckTrace();
		_removeTransfromStateBuffInterval = Config_Support.removeTransfromStateBuffInterval;
		_triggerInterval_FlyingBlade = Config_Support.triggerInterval_FlyingBlade;
		_checkTraceInterval = Config_Support.interval_CheckTrace;
		_actor.logicVariable.SetLogicTagValue("NormalAttackStage", 0);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511521, out var perkLevel))
		{
			_actor.buffComponent.RemoveBuffByBuffId(11521011);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511523, out perkLevel) && CommonUtils.CheckAllPlayerActorAreSameElement(HotfixEnum.elementType.LE))
		{
			if (_playFX_P23 == null)
			{
				_playFX_P23 = new PlayFX();
			}
			_playFX_P23.Play(_actor, null, "fx_11501_buff_B2_Skill_attack_P23_Strengthen", _actor.tsTransform.PositionY, _actor.tsTransform.Position, default, null, 1f, 1f, actorScale: true);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511528, out perkLevel))
		{
			if (_perkLogicCor_P28 != null)
			{
				_actor.StopLogicCoroutine(_perkLogicCor_P28);
			}
			_perkLogicCor_P28 = _actor.StartLogicCoroutine(PerkLogic_P28(), runImmediately: true);
		}
	}

	private IEnumerator PerkLogic_P28()
	{
		FP addDamageBuffInterval = CommonUtils.GetScriptValue(_actor, 11528011);
		FP checkMoveBuffInterval = 0;
		while (true)
		{
			if (addDamageBuffInterval > 0)
			{
				addDamageBuffInterval -= _actor.LogicDeltaTime;
			}
			else
			{
				addDamageBuffInterval += CommonUtils.GetScriptValue(_actor, 11528011);
				_actor.buffComponent.AddBuff(11528011, _actor);
			}
			if (checkMoveBuffInterval > 0)
			{
				checkMoveBuffInterval -= _actor.LogicDeltaTime;
			}
			else
			{
				checkMoveBuffInterval += (FP)0.5;
				if (CanNormalAttack())
				{
					_actor.buffComponent.RemoveBuffByBuffId(11528012);
				}
				else
				{
					_actor.buffComponent.AddBuff(11528012, _actor);
				}
			}
			yield return null;
		}
	}

	protected override void OnTransformLogicUpdate()
	{
		base.OnTransformLogicUpdate();
		if (_removeTransfromStateBuffInterval > 0)
		{
			_removeTransfromStateBuffInterval -= _actor.LogicDeltaTime;
		}
		else
		{
			_actor.buffComponent.RemoveBuffByBuffId(11593211, 1);
			_removeTransfromStateBuffInterval += Config_Support.removeTransfromStateBuffInterval;
		}
		if (_triggerInterval_FlyingBlade > 0)
		{
			_triggerInterval_FlyingBlade -= _actor.LogicDeltaTime;
		}
		else
		{
			if (_actor.attackTarget != null)
			{
				_actor.StartLogicCoroutine(FlyingBladeLogic(_actor.attackTarget), runImmediately: true);
			}
			_triggerInterval_FlyingBlade += Config_Support.triggerInterval_FlyingBlade;
		}
		if (_checkTraceInterval > 0)
		{
			_checkTraceInterval -= _actor.LogicDeltaTime;
		}
		else
		{
			CheckTrace();
			_checkTraceInterval += Config_Support.interval_CheckTrace;
		}
		if (CanNormalAttack() && ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal), _actor, SkillPhaseFeatureFlag.Normal, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false))
		{
			CancelTrace();
		}
	}

	private IEnumerator FlyingBladeLogic(LogicEntity target, bool isFirstRound = false)
	{
		var (fxAliasOrPath, delayTime, shootCount, shootInterval, bulletKey) = GetFlyingBladeInfo(isFirstRound);
		CommonUtils.PlayOneOffFx(_actor, fxAliasOrPath);
		if (target == null)
		{
			yield break;
		}
		long targetId = target.Id;
		TSVector2 targetPosition = target.tsTransform.Position;
		while (delayTime > 0)
		{
			if (CommonUtils.CheckTargetIsValid(target, targetId))
			{
				targetPosition = target.tsTransform.Position;
			}
			delayTime -= _actor.LogicDeltaTime;
			yield return null;
		}
		DeterministicShape shape = new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Fan,
			innerRadius = Config_Support.shootDistance_FlyingBlade,
			radius = Config_Support.shootDistance_FlyingBlade,
			position = targetPosition
		};
		while (shootCount > 0)
		{
			TSVector2 tSVector = Config_Support.shootAngleRange_FlyingBlade.get_Item(TSRandom.Range(0, Config_Support.shootAngleRange_FlyingBlade.Count));
			FP fP = tSVector.y - tSVector.x;
			if (fP > 0)
			{
				shape.angle = fP;
				shape.rotation = TSVector2.Rotate(TSVector2.up, tSVector.x + fP * 0.5f).GetAngle();
				TSVector2 randomPointInShape = ILRuntimeAPI.GetRandomPointInShape(_actor, shape, isReachable: false);
				TSVector2 normalized = (targetPosition - randomPointInShape).normalized;
				ILRuntimeAPI.ShootByDirection(bulletKey, _actor, default, normalized, randomPointInShape, Config_Support.shootPositionY_FlyingBlade);
			}
			shootCount--;
			yield return _actor.WaitTime(shootInterval);
		}
	}

	private (string, FP, int, FP, string) GetFlyingBladeInfo(bool isFirstRound = false)
	{
		bool flag = CommonUtils.HavePersonalPerk(_actor.dataID, 511521, out var perkLevel) && CommonUtils.CheckAllPlayerActorAreSameElement(HotfixEnum.elementType.LE);
		bool flag2 = CommonUtils.HavePersonalPerk(_actor.dataID, 511522, out perkLevel);
		string item;
		if (isFirstRound)
		{
			if (flag)
			{
				item = (flag2 ? "fx_11501_base_B2_Skill_Blade_Shoot_2_P21P22_Strengthen" : "fx_11501_base_B2_Skill_Blade_Shoot_2_P21_Strengthen");
			}
			else
			{
				item = (flag2 ? "fx_11501_Base_B2_Skill_Blade_Shoot_2_P22_Strengthen" : "fx_11501_base_B2_Skill_Blade_Shoot_2");
			}
		}
		else if (flag)
		{
			item = (flag2 ? "fx_11501_base_B2_Skill_Blade_Shoot_2_P21P22_Strengthen" : "fx_11501_base_B2_Skill_Blade_Shoot_2_P21_Strengthen");
		}
		else
		{
			item = (flag2 ? "fx_11501_Base_B2_Skill_Blade_Shoot_2_P22_Strengthen" : "fx_11501_base_B2_Skill_Blade_Shoot_2");
		}
		FP item2 = (isFirstRound ? Config_Support.shootDelay_FlyingBlade_First : Config_Support.shootDelay_FlyingBlade);
		int item3 = (flag ? 10 : 6);
		FP item4 = (flag ? Config_Support.shootInterval_FlyingBlade_P21 : Config_Support.shootInterval_FlyingBlade);
		string item5 = (flag2 ? "Bullet_11501_Support_Skill_Fly_Blade_P22_Strengthen" : "Bullet_11501_Support_Skill_Fly_Blade_Base");
		return (item, item2, item3, item4, item5);
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
			CancelTrace();
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

	private void CancelTrace()
	{
		_traceTarget?.CancelTrace();
		_traceTarget?.Clear();
		_forceTrace = false;
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

	protected override void OnExitTransformState(bool force = false)
	{
		base.OnExitTransformState(force);
		_actor.buffComponent.RemoveBuffByBuffId(11593211);
		CancelTrace();
		if (force)
		{
			((PlayerAdventureActor)_actor).isResidentAssist = false;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511523, out var perkLevel))
		{
			_playFX_P23?.Stop();
			_playFX_P23?.Clear();
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511525, out perkLevel))
		{
			_actor.buffComponent.RemoveBuffByBuffId(11525013);
			_actor.buffComponent.RemoveBuffByBuffId(11525015);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511528, out perkLevel))
		{
			if (_perkLogicCor_P28 != null)
			{
				_actor.StopLogicCoroutine(_perkLogicCor_P28);
			}
			_perkLogicCor_P28 = null;
		}
	}

	protected override bool CastExitTransformStateSkill()
	{
		return ILRuntimeAPI.CreateSkill(11532002, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, OnExitTransformStateSkillFinish);
	}

	private void OnExitTransformStateSkillFinish(bool success)
	{
		if (success)
		{
			((PlayerAdventureActor)_actor).isResidentAssist = false;
		}
	}

	public override void OnStop()
	{
		base.OnStop();
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		_actor.buffComponent.RemoveBuffByBuffId(11593211);
		CancelTrace();
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		_playFX_P23?.Stop();
		_playFX_P23?.Clear();
	}
}
