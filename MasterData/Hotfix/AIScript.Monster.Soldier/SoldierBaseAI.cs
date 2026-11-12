using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using Nova.Hotfix;
using TrueSync;

namespace AIScript.Monster.Soldier;

public class SoldierBaseAI : MonsterActionBase
{
	private static readonly int kMoYuBuffTag = CommonHelper.StringToHash("Soldier_MoYu");

	private bool _tracing;

	private PoolBranchInfo _attackBranch;

	private readonly List<LogicEntity> _searchEntities = new List<LogicEntity>();

	private LookAtTarget _lookAt;

	private bool _inSupportCastStance;

	private int _castToken;

	private SoldierActor soldierActor => _actor as SoldierActor;

	protected override void OnActionEnable()
	{
		if (soldierActor != null)
		{
			soldierActor.soldierAI = this;
		}
		EnsureAttackBranch();
	}

	protected override void OnActionDisable()
	{
		CleanupForExit();
	}

	protected override void OnActionStop()
	{
		CleanupForExit();
	}

	private void CleanupForExit()
	{
		_tracing = false;
		_actor.InterruptMovement();
		ILRuntimeAPI.ClearLookAt(_lookAt);
		_lookAt = null;
		if (!(soldierActor != null))
		{
			return;
		}
		if (_inSupportCastStance)
		{
			_inSupportCastStance = false;
			if (soldierActor.isSupport)
			{
				soldierActor.ExitSupportCastStance();
			}
		}
		soldierActor.EndEnergyRegenSuspend();
		soldierActor.isCastingSupport = false;
		if (soldierActor.isAimAtTarget)
		{
			_actor.CancelAiming();
		}
		if (soldierActor.soldierAI == this)
		{
			soldierActor.soldierAI = null;
		}
	}

	public bool TriggerSupportCast()
	{
		if (soldierActor == null || !soldierActor.isSupport)
		{
			return false;
		}
		if (soldierActor.isCastingSupport)
		{
			return false;
		}
		if (soldierActor.supportSkillId == 0)
		{
			return false;
		}
		Skill skill = Singleton<HotfixDataController>.Instance.GetSkill(soldierActor.supportSkillId);
		if (skill == null || string.IsNullOrEmpty(skill.FCPath))
		{
			return false;
		}
		if (HasMoYuBuff())
		{
			return false;
		}
		_actor.StartLogicCoroutine(SupportCastFlow(), runImmediately: true);
		return true;
	}

	private IEnumerator SupportCastFlow()
	{
		this.soldierActor.isCastingSupport = true;
		SoldierLevelController soldierLevelController = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
		SoldierActor soldierActor = ((soldierLevelController != null) ? soldierLevelController.GetMainControlActor(this.soldierActor.isEnemyCamp) : null);
		AdventureActor lookTarget = ((soldierActor != null) ? GetMainControlAttackTarget(soldierActor) : null);
		TSVector2 position;
		TSVector2 forward;
		if (this.soldierActor.onStageType == HotfixEnum.ChessAssistOnStageType.NotAppearing)
		{
			yield return _actor.StartLogicCoroutine(ReleaseSupportSkill(lookTarget), runImmediately: true);
		}
		else if (soldierLevelController != null && TryPickSupportCastPose(soldierLevelController, out position, out forward))
		{
			this.soldierActor.EnterSupportCastStance(position, forward);
			_inSupportCastStance = true;
			yield return _actor.StartLogicCoroutine(ReleaseSupportSkill(lookTarget), runImmediately: true);
			if (_inSupportCastStance)
			{
				_inSupportCastStance = false;
				if (this.soldierActor.isSupport)
				{
					this.soldierActor.ExitSupportCastStance();
				}
			}
		}
		this.soldierActor.isCastingSupport = false;
	}

	protected override void SetConfig()
	{
		_thinkInterval = 0.1;
		_monsterAIType = MonsterAIType.POOL;
		EnsureAttackBranch();
	}

	private void EnsureAttackBranch()
	{
		if (_attackBranch == null && !(_actor == null) && !(soldierActor == null) && !soldierActor.isSupport)
		{
			_attackBranch = new PoolBranchInfo(_actor, 1, 1, 0, 0, active: true, (soldierActor.skillRadius > soldierActor.normalAttackRadius) ? soldierActor.skillRadius : soldierActor.normalAttackRadius, 30, -1, () => target != null, null, BattleAttack);
			List<PoolBranchesInfo> poolBranches = new List<PoolBranchesInfo>
			{
				new PoolBranchesInfo
				{
					index = 1,
					braches = new List<PoolBranchInfo> { _attackBranch }
				}
			};
			InitPoolBranches(1, poolBranches);
		}
	}

	protected override IEnumerator CheckQualifiedPoolBranch()
	{
		if (_delayStartTime > 0)
		{
			yield return WaitTime(_delayStartTime);
		}
		while (true)
		{
			if (_actor == null || _actor.actorInfo == null)
			{
				yield return null;
				continue;
			}
			if (!(soldierActor == null))
			{
				AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
				if ((object)instance != null && instance.InBattleState)
				{
					if (IsInStrongControl())
					{
						InterruptTracking();
						yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_thinkInterval), runImmediately: true);
						continue;
					}
					if (HasMoYuBuff())
					{
						InterruptTracking();
						yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_thinkInterval), runImmediately: true);
						continue;
					}
					if (soldierActor.isSupport)
					{
						yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_thinkInterval), runImmediately: true);
						continue;
					}
					if (_attackBranch == null)
					{
						EnsureAttackBranch();
						if (_attackBranch == null)
						{
							yield return null;
							continue;
						}
					}
					while (_branchRunning)
					{
						LogicVariable logicVariable = _actor.logicVariable;
						if (logicVariable == null || logicVariable.GetLogicTagToggle("ExecutingCanBreakBranch"))
						{
							break;
						}
						yield return null;
					}
					if (_tracing)
					{
						if (!IsTargetValid(target))
						{
							_tracing = false;
							_actor.InterruptMovement();
							if (_executeBranch == _attackBranch)
							{
								_executeBranch = null;
							}
							yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_thinkInterval), runImmediately: true);
							continue;
						}
						FP fP = (ShouldUseMainSkill() ? soldierActor.skillRadius : soldierActor.normalAttackRadius);
						if (_actor.DistanceWithRadius(target) <= fP)
						{
							_tracing = false;
							_actor.InterruptMovement();
							StartWaitingOperateCoroutine(_attackBranch);
						}
						yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_thinkInterval), runImmediately: true);
						continue;
					}
					if (_executeBranch != null)
					{
						yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_thinkInterval), runImmediately: true);
						continue;
					}
					SoldierBaseAI soldierBaseAI = this;
					LogicEntity logicEntity = (_actor.monsterTarget = FindNearestConfrontTarget());
					soldierBaseAI.target = logicEntity;
					if (target == null)
					{
						yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_thinkInterval), runImmediately: true);
						continue;
					}
					FP fP2 = _actor.DistanceWithRadius(target);
					PoolBranchInfo branch = _attackBranch;
					_executeBranch = branch;
					FP fP3 = (ShouldUseMainSkill() ? soldierActor.skillRadius : soldierActor.normalAttackRadius);
					if (_actor.actorInfo.moveType == HotfixEnum.actorMovType.STATIC || fP2 <= fP3)
					{
						StartWaitingOperateCoroutine(branch);
					}
					else
					{
						_tracing = true;
						if (!_actor.TrackMove(target, fP3, enableNavigation: false, NavAgentTypeNames.NavigationUpdateQualityLevel.MedQualityNavigationUpdate, AdventureActor.MovementMode.Run, () =>
						{
							if (_tracing)
							{
								if (!IsTargetValid(target))
								{
									AbortTracking(branch);
								}
								else
								{
									_tracing = false;
									StartWaitingOperateCoroutine(branch);
								}
							}
						}, () =>
						{
							AbortTracking(branch);
						}))
						{
							AbortTracking(branch);
						}
					}
					yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_thinkInterval), runImmediately: true);
					continue;
				}
			}
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_thinkInterval), runImmediately: true);
		}
	}

	private void AbortTracking(PoolBranchInfo branch)
	{
		if (_tracing)
		{
			_tracing = false;
			if (_executeBranch == branch)
			{
				_executeBranch = null;
			}
		}
	}

	private void InterruptTracking()
	{
		if (_tracing)
		{
			_tracing = false;
			_actor.InterruptMovement();
			if (_executeBranch == _attackBranch)
			{
				_executeBranch = null;
			}
		}
	}

	private bool TryPickSupportCastPose(SoldierLevelController levelCtrl, out TSVector2 position, out TSVector2 forward)
	{
		position = default;
		forward = default;
		SoldierActor mainControlActor = levelCtrl.GetMainControlActor(soldierActor.isEnemyCamp);
		if (mainControlActor == null)
		{
			return false;
		}
		FP assistSkillAngle = soldierActor.actorInfo.assistSkillAngle;
		FP assistSkillRadius = soldierActor.actorInfo.assistSkillRadius;
		HotfixEnum.AssistOnStageOrientation assistSkillOnStageOrientation = soldierActor.actorInfo.assistSkillOnStageOrientation;
		AdventureActor mainControlAttackTarget = GetMainControlAttackTarget(mainControlActor);
		if (soldierActor.onStageType == HotfixEnum.ChessAssistOnStageType.Front)
		{
			AdventureActor adventureActor = mainControlAttackTarget;
			if (adventureActor == null)
			{
				adventureActor = SearchAttackTargetAroundMainCtrl(mainControlActor);
			}
			if (adventureActor == null)
			{
				TSVector2 normalized = mainControlActor.tsTransform.Forward.normalized;
				FP backOffset = AdventureModuleController.Config.BackOffset;
				position = mainControlActor.tsTransform.Position - normalized * backOffset;
				if (!mainControlActor.QueryPositionReachable(position))
				{
					position = mainControlActor.RandomActorReachablePointInsideRing(mainControlActor.tsTransform.Position, AdventureModuleController.Config.defRdin, AdventureModuleController.Config.defRd);
				}
				forward = mainControlActor.tsTransform.Forward;
				return true;
			}
			position = GetAngleReachablePoint(mainControlActor, adventureActor, assistSkillAngle, assistSkillRadius);
			forward = (adventureActor.tsTransform.Position - position).normalized;
			return true;
		}
		position = GetDefendReachablePoint(mainControlActor, assistSkillAngle, assistSkillRadius);
		switch (assistSkillOnStageOrientation)
		{
		case HotfixEnum.AssistOnStageOrientation.None:
		case HotfixEnum.AssistOnStageOrientation.Same:
			forward = mainControlActor.tsTransform.Forward;
			break;
		case HotfixEnum.AssistOnStageOrientation.LookAt:
			forward = (mainControlActor.tsTransform.Position - position).normalized;
			break;
		case HotfixEnum.AssistOnStageOrientation.BackOn:
			forward = (position - mainControlActor.tsTransform.Position).normalized;
			break;
		default:
			forward = mainControlActor.tsTransform.Forward;
			break;
		}
		return true;
	}

	private AdventureActor GetMainControlAttackTarget(AdventureActor mainCtrl)
	{
		if (mainCtrl.monsterTarget is AdventureActor { actorHealthInfo: { isAlive: not false } } adventureActor && !adventureActor.IsSearchedImmunity() && !(adventureActor is SoldierActor { isSupport: not false }))
		{
			return adventureActor;
		}
		return null;
	}

	private AdventureActor SearchAttackTargetAroundMainCtrl(AdventureActor mainCtrl)
	{
		_searchEntities.Clear();
		CommonUtils.SearchNearTargetsByCircle(mainCtrl, mainCtrl.tsTransform.Position, AdventureModuleController.Config.SearchRadius, isConfront: true, includeSelf: false, _searchEntities);
		for (int i = 0; i < _searchEntities.Count; i++)
		{
			if (_searchEntities.get_Item(i) is AdventureActor { actorHealthInfo: { isAlive: not false } } adventureActor && !adventureActor.IsSearchedImmunity() && !(adventureActor is SoldierActor { isSupport: not false }))
			{
				return adventureActor;
			}
		}
		return null;
	}

	private TSVector2 GetAngleReachablePoint(AdventureActor anchor, AdventureActor anchorTarget, FP angle, FP radius)
	{
		TSVector2 normalized = (anchor.tsTransform.Position - anchorTarget.tsTransform.Position).normalized;
		FP fP = angle / 2;
		if (TSRandom.Range(0, 10) > 5)
		{
			fP = -fP;
		}
		FP fP2 = radius + anchorTarget.dtCollider.Radius;
		TSVector2 tSVector = TSVector2.Rotate(normalized, fP);
		TSVector2 tSVector2 = anchorTarget.tsTransform.Position + tSVector * fP2;
		if (anchor.QueryPositionReachable(tSVector2))
		{
			return tSVector2;
		}
		tSVector = TSVector2.Rotate(normalized, -fP);
		tSVector2 = anchorTarget.tsTransform.Position + tSVector * fP2;
		if (anchor.QueryPositionReachable(tSVector2))
		{
			return tSVector2;
		}
		return anchor.RandomActorReachablePointInsideRing(anchor.tsTransform.Position, AdventureModuleController.Config.defRdin, AdventureModuleController.Config.defRd);
	}

	private TSVector2 GetDefendReachablePoint(AdventureActor anchor, FP angle, FP radius)
	{
		TSVector2 tSVector = anchor.tsTransform.Forward;
		if (angle > 0)
		{
			tSVector = TSVector2.Rotate(tSVector, -angle);
		}
		TSVector2 tSVector2 = anchor.tsTransform.Position + tSVector * radius;
		if (anchor.QueryPositionReachable(tSVector2))
		{
			return tSVector2;
		}
		TSVector2 tSVector3 = anchor.RandomActorReachablePointInsideRing(tSVector2, 0, AdventureModuleController.Config.defRd);
		if (tSVector3 != tSVector2)
		{
			return tSVector3;
		}
		return anchor.RandomActorReachablePointInsideRing(anchor.tsTransform.Position, AdventureModuleController.Config.defRdin, AdventureModuleController.Config.defRd);
	}

	private bool IsInStrongControl()
	{
		return _actor.forceControl;
	}

	private bool ShouldUseMainSkill()
	{
		if (soldierActor.isEnergyFull)
		{
			return soldierActor.mainSkillId != 0;
		}
		return false;
	}

	protected virtual bool CanInterruptNormalAttackForMainSkill()
	{
		return true;
	}

	protected virtual bool OnMainSkillReadyDuringNormalAttack(SoldierActor caster)
	{
		return false;
	}

	private bool HasMoYuBuff()
	{
		if (_actor?.buffComponent != null)
		{
			return _actor.buffComponent.CheckBuffByBuffTag(kMoYuBuffTag);
		}
		return false;
	}

	private bool IsTargetValid(LogicEntity entity)
	{
		if (entity is AdventureActor { actorHealthInfo: { isAlive: not false } } adventureActor && !adventureActor.IsSearchedImmunity())
		{
			if (adventureActor is SoldierActor soldierActor)
			{
				return !soldierActor.isSupport;
			}
			return true;
		}
		return false;
	}

	public LogicEntity FindNearestConfrontTarget()
	{
		if (_actor.isTaunt && !_actor.isTauntWeakened && _actor.tauntFromActor != null)
		{
			ActorHealthInfo actorHealthInfo = _actor.tauntFromActor.actorHealthInfo;
			if (actorHealthInfo != null && actorHealthInfo.isAlive && !_actor.tauntFromActor.IsSearchedImmunity() && !(_actor.tauntFromActor is SoldierActor { isSupport: not false }))
			{
				return _actor.tauntFromActor;
			}
		}
		_searchEntities.Clear();
		CommonUtils.SearchNearTargetsByCircle(_actor, _actor.actorSearchTargetInfo.monsterSearchRange, isConfront: true, includeSelf: false, _searchEntities);
		for (int i = 0; i < _searchEntities.Count; i++)
		{
			if (_searchEntities.get_Item(i) is AdventureActor { actorHealthInfo: { isAlive: not false } } adventureActor && !adventureActor.IsSearchedImmunity() && !(adventureActor is SoldierActor { isSupport: not false }))
			{
				return _searchEntities.get_Item(i);
			}
		}
		return null;
	}

	private IEnumerator BattleAttack()
	{
		if (IsInStrongControl() || HasMoYuBuff())
		{
			yield break;
		}
		LogicEntity logicEntity = target;
		_actor.attackTarget = logicEntity;
		_actor.soldierAttackTarget = logicEntity;
		if (logicEntity != null)
		{
			if (_lookAt != null)
			{
				ILRuntimeAPI.ClearLookAt(_lookAt);
				_lookAt = null;
			}
			if (_actor.aimMode != AdventureActor.AimMode.Forward)
			{
				_actor.CancelAiming();
			}
			_actor.StopRotate();
			bool rotateDone = false;
			ILRuntimeAPI.BeginLookAt(ref _lookAt, _actor, logicEntity, 0, 0, () =>
			{
				rotateDone = true;
			}, ignoreActorTimeScale: false, () =>
			{
				rotateDone = true;
			});
			while (!rotateDone)
			{
				if (IsInStrongControl())
				{
					ILRuntimeAPI.ClearLookAt(_lookAt);
					_lookAt = null;
					yield break;
				}
				yield return null;
			}
		}
		SoldierActor caster = soldierActor;
		bool useMainSkill = ShouldUseMainSkill();
		bool[] doneFlag = new bool[1];
		if (!TryCastSkill(useMainSkill ? caster.mainSkillId : caster.normalSkillId, useMainSkill, useMainSkill, doneFlag))
		{
			yield break;
		}
		while (!doneFlag[0])
		{
			if (IsInStrongControl())
			{
				if (useMainSkill)
				{
					caster.EndEnergyRegenSuspend();
				}
				if (caster.isAimAtTarget)
				{
					_actor.CancelAiming();
				}
				ILRuntimeAPI.ClearLookAt(_lookAt);
				_lookAt = null;
				yield break;
			}
			if (!useMainSkill && !IsTargetValid(target))
			{
				if (caster.isAimAtTarget)
				{
					_actor.CancelAiming();
				}
				ILRuntimeAPI.ClearLookAt(_lookAt);
				_lookAt = null;
				_actor.actorSkillManage?.DestoryAllSkill();
				yield break;
			}
			if ((useMainSkill || !ShouldUseMainSkill() || !OnMainSkillReadyDuringNormalAttack(caster)) && !useMainSkill && caster.stopNormalAttack && CanInterruptNormalAttackForMainSkill() && ShouldUseMainSkill())
			{
				if (!IsTargetValid(target))
				{
					if (caster.isAimAtTarget)
					{
						_actor.CancelAiming();
					}
					ILRuntimeAPI.ClearLookAt(_lookAt);
					_lookAt = null;
					_actor.actorSkillManage?.DestoryAllSkill();
					yield break;
				}
				useMainSkill = true;
				doneFlag = new bool[1];
				if (!TryCastSkill(caster.mainSkillId, consumeEnergy: true, isMainSkill: true, doneFlag))
				{
					if (caster.isAimAtTarget)
					{
						_actor.CancelAiming();
					}
					ILRuntimeAPI.ClearLookAt(_lookAt);
					_lookAt = null;
					yield break;
				}
			}
			if (caster.isAimAtTarget)
			{
				AdventureActor adventureActor = _actor.attackTarget as AdventureActor;
				if (adventureActor != null)
				{
					ActorHealthInfo actorHealthInfo = adventureActor.actorHealthInfo;
					if (actorHealthInfo != null && actorHealthInfo.isAlive)
					{
						_actor.AimAtTarget(adventureActor);
						goto IL_03b3;
					}
				}
				_actor.CancelAiming();
			}
			goto IL_03b3;
			IL_03b3:
			yield return null;
		}
		if (caster.isAimAtTarget)
		{
			_actor.CancelAiming();
		}
		ILRuntimeAPI.ClearLookAt(_lookAt);
		_lookAt = null;
	}

	private bool TryCastSkill(int skillId, bool consumeEnergy, bool isMainSkill, bool[] doneFlag)
	{
		if (skillId == 0)
		{
			return false;
		}
		SoldierActor caster = soldierActor;
		bool suspendRegen = consumeEnergy && caster.isSkillEndStartRecover;
		SkillPhaseFeatureFlag skillCastBehaviourType = (isMainSkill ? SkillPhaseFeatureFlag.Skill1 : SkillPhaseFeatureFlag.Normal);
		int myToken = ++_castToken;
		if (suspendRegen)
		{
			caster.BeginEnergyRegenSuspend();
		}
		if (!ILRuntimeAPI.CreateSkill(skillId, _actor, skillCastBehaviourType, SkillLauncherType.DynamicActor, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool _) =>
		{
			if (myToken == _castToken)
			{
				doneFlag[0] = true;
				if (suspendRegen)
				{
					caster.EndEnergyRegenSuspend();
				}
			}
		}))
		{
			if (suspendRegen)
			{
				caster.EndEnergyRegenSuspend();
			}
			return false;
		}
		if (!soldierActor.isEnemyCamp & isMainSkill)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("Soldier_CastSkill", soldierActor.Id, soldierActor.dataID, skillId);
		}
		if (consumeEnergy)
		{
			caster.ConsumeEnergy();
		}
		return true;
	}

	private IEnumerator ReleaseSupportSkill(AdventureActor lookTarget = null)
	{
		if (IsInStrongControl() || soldierActor == null || soldierActor.supportSkillId == 0)
		{
			yield break;
		}
		if (lookTarget != null)
		{
			_actor.monsterTarget = lookTarget;
			_actor.attackTarget = lookTarget;
			_actor.soldierAttackTarget = lookTarget;
			bool rotateDone = false;
			ILRuntimeAPI.BeginLookAt(ref _lookAt, _actor, lookTarget, 0, 0, () =>
			{
				rotateDone = true;
			}, ignoreActorTimeScale: false, () =>
			{
				rotateDone = true;
			});
			while (!rotateDone)
			{
				if (IsInStrongControl())
				{
					ILRuntimeAPI.ClearLookAt(_lookAt);
					_lookAt = null;
					yield break;
				}
				yield return null;
			}
		}
		SoldierActor caster = soldierActor;
		bool suspendRegen = caster.isSkillEndStartRecover;
		bool done = false;
		if (suspendRegen)
		{
			caster.BeginEnergyRegenSuspend();
		}
		if (!ILRuntimeAPI.CreateSkill(soldierActor.supportSkillId, _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.DynamicActor, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool _) =>
		{
			done = true;
			if (suspendRegen)
			{
				caster.EndEnergyRegenSuspend();
			}
		}))
		{
			if (suspendRegen)
			{
				caster.EndEnergyRegenSuspend();
			}
			yield break;
		}
		if (!soldierActor.isEnemyCamp)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("Soldier_CastSkill", soldierActor.Id, soldierActor.dataID, soldierActor.supportSkillId);
		}
		caster.ConsumeEnergy();
		while (!done)
		{
			if (IsInStrongControl())
			{
				caster.EndEnergyRegenSuspend();
				break;
			}
			yield return null;
		}
	}
}
