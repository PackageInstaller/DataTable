using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier;

public abstract class SoldierSkillCycleActionBase : MonsterActionBase
{
	protected readonly struct SkillEntry(int skillId, FP releaseRange, FP releaseAngle)
	{
		public readonly int skillId = skillId;

		public readonly FP releaseRange = releaseRange;

		public readonly FP releaseAngle = releaseAngle;
	}

	private SkillEntry[] _skillCycle;

	private int _skillIndex;

	private bool _tracing;

	private LookAtTarget _lookAt;

	private readonly List<LogicEntity> _searchEntities = new List<LogicEntity>();

	protected virtual FP SkillIntervalSeconds => 1;

	protected virtual FP InitialStrengthOverride => -1;

	private SoldierActor soldierActor => _actor as SoldierActor;

	protected abstract SkillEntry[] BuildSkillCycle();

	protected override void OnActionEnable()
	{
		if (_skillCycle == null)
		{
			_skillCycle = BuildSkillCycle();
		}
		_tracing = false;
		SetStrengthOverride(InitialStrengthOverride);
	}

	protected override void OnActionDisable()
	{
		_tracing = false;
		_actor?.InterruptMovement();
		ILRuntimeAPI.ClearLookAt(_lookAt);
		_lookAt = null;
	}

	protected override void OnActionStop()
	{
		_tracing = false;
		ILRuntimeAPI.ClearLookAt(_lookAt);
		_lookAt = null;
	}

	protected override void SetConfig()
	{
		_thinkInterval = 0.1;
		_monsterAIType = MonsterAIType.POOL;
		_skillCycle = BuildSkillCycle();
	}

	protected override IEnumerator CheckQualifiedPoolBranch()
	{
		if (_delayStartTime > 0)
		{
			yield return WaitTime(_delayStartTime);
		}
		while (true)
		{
			AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
			if ((object)instance != null && instance.InBattleState)
			{
				break;
			}
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_thinkInterval), runImmediately: true);
		}
		while (true)
		{
			if (_actor == null || _actor.actorInfo == null || _actor.isDead)
			{
				yield return null;
				continue;
			}
			if (IsInStrongControl())
			{
				if (_tracing)
				{
					_tracing = false;
					_actor.InterruptMovement();
				}
				yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_thinkInterval), runImmediately: true);
				continue;
			}
			SoldierSkillCycleActionBase soldierSkillCycleActionBase = this;
			LogicEntity logicEntity = (_actor.monsterTarget = FindNearestConfrontTarget());
			soldierSkillCycleActionBase.target = logicEntity;
			if (target == null)
			{
				yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_thinkInterval), runImmediately: true);
				continue;
			}
			SkillEntry entry = _skillCycle[_skillIndex];
			FP fP;
			if (entry.releaseRange > 0)
			{
				fP = entry.releaseRange;
			}
			else if (soldierActor != null)
			{
				fP = ((soldierActor.skillRadius > 0) ? soldierActor.skillRadius : soldierActor.normalAttackRadius);
			}
			else
			{
				fP = 0;
			}
			if (fP > 0 && _actor.DistanceWithRadius(target) > fP)
			{
				bool moveDone = false;
				_tracing = true;
				if (!_actor.TrackMove(target, fP, enableNavigation: false, NavAgentTypeNames.NavigationUpdateQualityLevel.MedQualityNavigationUpdate, AdventureActor.MovementMode.Run, () =>
				{
					if (_tracing)
					{
						_tracing = false;
						moveDone = true;
					}
				}, () =>
				{
					if (_tracing)
					{
						_tracing = false;
						moveDone = true;
					}
				}))
				{
					_tracing = false;
					yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_thinkInterval), runImmediately: true);
					continue;
				}
				while (!moveDone)
				{
					if (IsInStrongControl())
					{
						_tracing = false;
						_actor.InterruptMovement();
						break;
					}
					yield return null;
				}
				if (IsInStrongControl())
				{
					continue;
				}
				if (!IsTargetValid(target))
				{
					yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_thinkInterval), runImmediately: true);
					continue;
				}
			}
			_actor.attackTarget = target;
			_actor.soldierAttackTarget = target;
			bool rotateDone = false;
			TSVector2 position = _actor.tsTransform.Position;
			TSVector2 tSVector = target.tsTransform.Position - position;
			TSVector2 tSVector2 = ((tSVector.x == 0 && tSVector.y == 0) ? _actor.tsTransform.Forward : tSVector);
			TSVector2 tSVector3 = ((entry.releaseAngle == 0) ? tSVector2 : TSVector2.Rotate(tSVector2, entry.releaseAngle));
			TSVector2 targetPos = position + tSVector3;
			ILRuntimeAPI.BeginLookAtByPos(ref _lookAt, _actor, targetPos, 0, 0, () =>
			{
				rotateDone = true;
			}, () =>
			{
				rotateDone = true;
			});
			while (!rotateDone)
			{
				if (IsInStrongControl())
				{
					ILRuntimeAPI.ClearLookAt(_lookAt);
					_lookAt = null;
					break;
				}
				yield return null;
			}
			if (IsInStrongControl())
			{
				continue;
			}
			bool skillDone = false;
			if (!ILRuntimeAPI.CreateSkill(entry.skillId, _actor, SkillPhaseFeatureFlag.Normal, SkillLauncherType.DynamicActor, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool _) =>
			{
				skillDone = true;
			}))
			{
				yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_thinkInterval), runImmediately: true);
				continue;
			}
			_skillIndex = (_skillIndex + 1) % _skillCycle.Length;
			while (!skillDone && !IsInStrongControl())
			{
				yield return null;
			}
			if (!IsInStrongControl())
			{
				yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(SkillIntervalSeconds), runImmediately: true);
			}
		}
	}

	private LogicEntity FindNearestConfrontTarget()
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

	private static bool IsTargetValid(LogicEntity entity)
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

	private bool IsInStrongControl()
	{
		return _actor.forceControl;
	}
}
