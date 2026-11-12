#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using Nova.Hotfix;
using TrueSync;

namespace AIScript.BrickBreaker.Monster;

public class Action : AIBase
{
	protected FP _thinkInterval;

	protected List<MonsterActionBranch> _branchInfos;

	protected AIBranchPool _aiBranchPool;

	protected CoroutineNode _checkQualifiedAIBranchCoroutine;

	protected TraceTarget _traceTarget;

	protected LookAtTarget _lookAtTarget;

	protected bool _castingSkill;

	protected BranchInfo _executeBranch;

	protected CoroutineNode _setBranchCdByConfigCoroutine;

	protected LogicEntity target;

	private bool _inSwitchStateProtect;

	public void OnEnable()
	{
		_aiBranchPool?.ResetBranchInitCD();
	}

	public void OnSpecialEnable()
	{
		NovaLogger.Debug("BrickBreaker.Monster Action OnSpecialEnable");
		if (_actor is MonsterAdventureActor monsterAdventureActor)
		{
			_thinkInterval = monsterAdventureActor.monsterAIInfo.thinkInterval;
			_branchInfos = monsterAdventureActor.monsterAIInfo.actionBranchs;
		}
		if (_aiBranchPool == null)
		{
			_aiBranchPool = new AIBranchPool();
		}
		_aiBranchPool.Init(_actor, _branchInfos);
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		if (null != instance)
		{
			instance.AddEventListener("ACTOR_HP_CHANGED", OnHpChanged);
			instance.AddEventListener("CUSTOM_HANDLE_AI_BRANCH", OnCustomHandleAiBranch);
			instance.AddEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawn);
			instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_NEAR_DEATH", OnMonsterNearDeath);
			instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDied);
			instance.AddEventListener("ACTOR_GET_BUFF", OnMonsterGetBuff);
			instance.AddEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnMonsterToughnessStateChange);
			instance.AddEventListener("MONSTER_TARGET_CHANGED", OnMonsterTargetChange);
		}
		_actor?.AddEventListener("CLEAR_MONSTER_AI_BRANCH_CD", OnClearAiBranchCD);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_SWITCH_CUSTOM_STATE", OnSwitchState);
	}

	public void OnSpecialDisable()
	{
		NovaLogger.Debug("BrickBreaker.Monster Action OnSpecialDisable");
		_lookAtTarget?.Clear();
		_traceTarget?.Clear();
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		if (null != instance)
		{
			instance.RemoveEventListener("ACTOR_HP_CHANGED", OnHpChanged);
			instance.RemoveEventListener("CUSTOM_HANDLE_AI_BRANCH", OnCustomHandleAiBranch);
			instance.RemoveEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawn);
			instance.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_NEAR_DEATH", OnMonsterNearDeath);
			instance.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDied);
			instance.RemoveEventListener("ACTOR_GET_BUFF", OnMonsterGetBuff);
			instance.RemoveEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnMonsterToughnessStateChange);
			instance.RemoveEventListener("MONSTER_TARGET_CHANGED", OnMonsterTargetChange);
		}
		_actor?.RemoveEventListener("CLEAR_MONSTER_AI_BRANCH_CD", OnClearAiBranchCD);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_SWITCH_CUSTOM_STATE", OnSwitchState);
	}

	private void OnSwitchState(IEvent evt)
	{
		if (evt == null)
		{
			return;
		}
		AdventureMonsterSwitchCustomStateEvent adventureMonsterSwitchCustomStateEvent = (AdventureMonsterSwitchCustomStateEvent)evt;
		if (adventureMonsterSwitchCustomStateEvent.commonHandle)
		{
			if (_castingSkill)
			{
				if (adventureMonsterSwitchCustomStateEvent.breakCurrentAction)
				{
					_actor.actorSkillManage.DestoryAllSkill();
				}
				else if (!_inSwitchStateProtect)
				{
					_inSwitchStateProtect = true;
					_actor.EnableImmuneControl();
					(_actor as MonsterAdventureActor).monsterToughnessInfo.lockToughness = true;
				}
			}
			else
			{
				_traceTarget?.CancelTrace();
				_lookAtTarget?.StopLookAt();
			}
		}
		if (adventureMonsterSwitchCustomStateEvent.customHandle)
		{
			OnHandleCustomSwitchState();
		}
	}

	protected virtual void OnHandleCustomSwitchState()
	{
	}

	private void OnActorSpawn(IEvent evt)
	{
		if (evt != null && ((AdventurActorSpawned)evt).sender is MonsterAdventureActor monsterAdventureActor)
		{
			string param = $"{monsterAdventureActor.dataID}出生";
			_aiBranchPool.ActiveOrDeactiveByEvent(HotfixEnum.monsterAIBranchActiveConditionType.TARGET_MONSTER_BASIC_STATE, param, 0L, 0L);
		}
	}

	private void OnMonsterNearDeath(IEvent evt)
	{
		if (evt != null)
		{
			AdventureMonsterNearDeathEvent adventureMonsterNearDeathEvent = (AdventureMonsterNearDeathEvent)evt;
			string param = $"{adventureMonsterNearDeathEvent.dataID}濒死";
			_aiBranchPool.ActiveOrDeactiveByEvent(HotfixEnum.monsterAIBranchActiveConditionType.TARGET_MONSTER_BASIC_STATE, param, 0L, 0L);
		}
	}

	private void OnMonsterDied(IEvent evt)
	{
		if (evt != null)
		{
			AdventureMonsterDiedEvent adventureMonsterDiedEvent = (AdventureMonsterDiedEvent)evt;
			string param = $"{adventureMonsterDiedEvent.monsterID}死亡";
			_aiBranchPool.ActiveOrDeactiveByEvent(HotfixEnum.monsterAIBranchActiveConditionType.TARGET_MONSTER_BASIC_STATE, param, 0L, 0L);
		}
	}

	private void OnMonsterGetBuff(IEvent evt)
	{
		if (evt != null)
		{
			AdventureActorGetBuff adventureActorGetBuff = (AdventureActorGetBuff)evt;
			MonsterAdventureActor monsterAdventureActor = adventureActorGetBuff.sender as MonsterAdventureActor;
			if (!(monsterAdventureActor == null))
			{
				long param = ((target == null) ? 0 : target.Id);
				_aiBranchPool.ActiveOrDeactiveByEvent(HotfixEnum.monsterAIBranchActiveConditionType.TARGET_MONSTER_BUFFID, adventureActorGetBuff.eventInfo.buffId.ToString(), monsterAdventureActor.Id, param);
				_aiBranchPool.ActiveOrDeactiveByEvent(HotfixEnum.monsterAIBranchActiveConditionType.TARGET_MONSTER_BUFFGROUPID, adventureActorGetBuff.eventInfo.buffGroupId.ToString(), monsterAdventureActor.Id, param);
			}
		}
	}

	private void OnMonsterToughnessStateChange(IEvent evt)
	{
		if (evt is MonsterToughnessStateChangeEvent monsterToughnessStateChangeEvent)
		{
			long param = ((target == null) ? 0 : target.Id);
			_aiBranchPool.ActiveOrDeactiveByEvent(HotfixEnum.monsterAIBranchActiveConditionType.TARGET_TOUGHNESS_STATECHANGE, monsterToughnessStateChangeEvent.isToughnessBroken.ToString(), monsterToughnessStateChangeEvent.actor.Id, param);
		}
	}

	private void OnHpChanged(IEvent evt)
	{
		AdventureActorHpChangedEvent adventureActorHpChangedEvent = (AdventureActorHpChangedEvent)evt;
		if (!(adventureActorHpChangedEvent.sender as AdventureActor != _actor))
		{
			int num = (int)(long)(adventureActorHpChangedEvent.currentHp / adventureActorHpChangedEvent.maxHp * 100);
			_aiBranchPool.ActiveOrDeactiveByEvent(HotfixEnum.monsterAIBranchActiveConditionType.HP_PER_MORE_OR_EQUAL, num.ToString(), 0L, 0L);
			_aiBranchPool.ActiveOrDeactiveByEvent(HotfixEnum.monsterAIBranchActiveConditionType.HP_PER_LESS, num.ToString(), 0L, 0L);
		}
	}

	private void OnCustomHandleAiBranch(IEvent evt)
	{
		AdventureCustomHandleAiBranchEvent adventureCustomHandleAiBranchEvent = (AdventureCustomHandleAiBranchEvent)evt;
		if (!(adventureCustomHandleAiBranchEvent.target != _actor))
		{
			_aiBranchPool.ExecuteCustomEvent(adventureCustomHandleAiBranchEvent.eventType, adventureCustomHandleAiBranchEvent.ids);
		}
	}

	private void OnMonsterTargetChange(IEvent evt)
	{
		if (evt is AdventureMonsterTargetChangedEvent adventureMonsterTargetChangedEvent && adventureMonsterTargetChangedEvent.sender as AdventureActor == _actor && _executeBranch != null && !_castingSkill)
		{
			_traceTarget?.CancelTrace();
			_lookAtTarget?.StopLookAt();
		}
	}

	private void OnClearAiBranchCD(IEvent evt)
	{
		if (evt is AdventureClearMonsterAiBranchCDEvent)
		{
			_aiBranchPool.ClearBranchCD();
		}
	}

	public void OnStart()
	{
		_checkQualifiedAIBranchCoroutine = _actor.StartLogicCoroutine(CheckQualifiedAIBranch());
	}

	private IEnumerator CheckQualifiedAIBranch()
	{
		while (true)
		{
			while (_castingSkill || (_actor.logicVariable?.GetLogicTagToggle("ExecutingSpecialSkill") ?? false))
			{
				LogicVariable logicVariable = _actor.logicVariable;
				if (logicVariable == null || logicVariable.GetLogicTagToggle("ExecutingCanBreakSkill"))
				{
					break;
				}
				yield return null;
			}
			if (_executeBranch == null)
			{
				Action action = this;
				LogicEntity logicEntity = (_actor.monsterTarget = SearchTarget());
				action.target = logicEntity;
				if (target == null && _actor is MonsterAdventureActor)
				{
					break;
				}
			}
			FP fP = _actor.DistanceWithRadius(target);
			BranchInfo qualifiedBranch = _aiBranchPool.CheckQualifiedBranch(fP, target);
			if (qualifiedBranch != null && qualifiedBranch != _executeBranch && ((_executeBranch != null && qualifiedBranch.baseInfo.Priority > _executeBranch.baseInfo.Priority) || _executeBranch == null))
			{
				if (_actor.logicVariable?.GetLogicTagToggle("ExecutingCanBreakSkill") ?? false)
				{
					_actor.actorSkillManage.DestoryAllSkill();
				}
				_traceTarget?.CancelTrace();
				_lookAtTarget?.StopLookAt();
				_executeBranch = qualifiedBranch;
				AdventureActorRunBranchEvent adventureActorRunBranchEvent = AdventureActorRunBranchEvent.Generate();
				adventureActorRunBranchEvent.sender = _actor;
				adventureActorRunBranchEvent.branchId = qualifiedBranch.baseInfo.Id;
				adventureActorRunBranchEvent.skillId = qualifiedBranch.baseInfo.SkillId;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorRunBranchEvent);
				if (_actor.actorInfo.moveType == HotfixEnum.actorMovType.STATIC || fP <= FP.FromMyriad(qualifiedBranch.baseInfo.ReleaseDistance))
				{
					if (_actor.actorInfo.moveType != HotfixEnum.actorMovType.STATIC)
					{
						TSVector2 a = target.tsTransform.Position - _actor.tsTransform.Position;
						TSVector2 forward = _actor.tsTransform.Forward;
						if (TSVector2.Angle(a, forward) > FP.FromMyriad(qualifiedBranch.baseInfo.ReleaseAngle))
						{
							if (_lookAtTarget == null)
							{
								_lookAtTarget = new LookAtTarget();
							}
							_lookAtTarget.BeginLookAt(_actor, target, 0, 0, () =>
							{
								CastSkill(qualifiedBranch);
							}, ignoreActorTimeScale: false, () =>
							{
								_executeBranch = null;
							});
						}
						else
						{
							CastSkill(qualifiedBranch);
						}
					}
					else
					{
						CastSkill(qualifiedBranch);
					}
				}
				else
				{
					if (_traceTarget == null)
					{
						_traceTarget = new TraceTarget();
					}
					_traceTarget.BeginTrace(_actor, target, FP.FromMyriad(qualifiedBranch.baseInfo.ReleaseDistance), -1, FP.FromMyriad(qualifiedBranch.baseInfo.TraceDuration), () =>
					{
						CastSkill(qualifiedBranch);
					}, (bool isdie, bool isInterrupt, bool _, bool _) =>
					{
						_executeBranch = null;
					});
				}
			}
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_thinkInterval));
		}
		_actor.Idle();
	}

	private void CastSkill(BranchInfo qualifiedBranch)
	{
		StartProcessBranchCdByConfig();
		if (qualifiedBranch.baseInfo.SkillId != 0)
		{
			_castingSkill = true;
			_aiBranchPool.RefreshBranchCastSkillTimes(qualifiedBranch);
			ILRuntimeAPI.CreateSkill(qualifiedBranch.baseInfo.SkillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false, isBreakable: false, SkillCountdownTiming.Start, (bool success) =>
			{
				if (_castingSkill)
				{
					EndProcessBranchCdByConfig();
					_aiBranchPool.ExecuteFollowEvent(_executeBranch.baseInfo);
					_executeBranch = null;
					_castingSkill = false;
					if (_inSwitchStateProtect)
					{
						_inSwitchStateProtect = false;
						_actor.DisableImmuneControl();
						(_actor as MonsterAdventureActor).monsterToughnessInfo.lockToughness = false;
					}
				}
			}, (FP cd) =>
			{
				if (_castingSkill)
				{
					_executeBranch.SetSkillCdExpireTime(cd, _actor.LogicTime);
				}
			});
		}
		else
		{
			EndProcessBranchCdByConfig();
			_aiBranchPool.ExecuteFollowEvent(_executeBranch.baseInfo);
			_executeBranch = null;
		}
	}

	private void StartProcessBranchCdByConfig()
	{
		if (_executeBranch.baseInfo.StartCDTime == 0)
		{
			_executeBranch.ResetAiCdExpireTime(_actor.LogicTime);
		}
		else
		{
			_setBranchCdByConfigCoroutine = _actor.StartLogicCoroutine(ProcessBranchCdByConfig());
		}
	}

	private void EndProcessBranchCdByConfig()
	{
		if (_setBranchCdByConfigCoroutine != null)
		{
			_actor.StopLogicCoroutine(_setBranchCdByConfigCoroutine);
			_setBranchCdByConfigCoroutine = null;
		}
	}

	private IEnumerator ProcessBranchCdByConfig()
	{
		FP currentTime = 0;
		FP startTime = FP.FromMyriad(_executeBranch.baseInfo.StartCDTime);
		while (true)
		{
			currentTime += _actor.LogicDeltaTime;
			if (currentTime >= startTime)
			{
				break;
			}
			yield return null;
		}
		_executeBranch?.ResetAiCdExpireTime(_actor.LogicTime);
	}

	public void OnStop()
	{
		if (_checkQualifiedAIBranchCoroutine != null)
		{
			_actor.StopLogicCoroutine(_checkQualifiedAIBranchCoroutine);
			_checkQualifiedAIBranchCoroutine = null;
		}
		_castingSkill = false;
		_executeBranch = null;
		EndProcessBranchCdByConfig();
		_traceTarget?.CancelTrace();
		_lookAtTarget?.StopLookAt();
		if (_inSwitchStateProtect)
		{
			_inSwitchStateProtect = false;
			_actor.DisableImmuneControl();
			(_actor as MonsterAdventureActor).monsterToughnessInfo.lockToughness = false;
		}
	}

	public virtual LogicEntity SearchTarget()
	{
		return _actor.actorSearchTargetInfo.GetMonsterAttackTarget();
	}
}
