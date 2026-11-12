using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Template;

public class Idle : AIBase
{
	protected FP _wanderRange;

	protected FP _wanderInterval;

	protected FP _wanderRate;

	private bool _castSpawnSkill;

	protected CoroutineNode _patrolCoroutine;

	protected CoroutineNode _wanderCoroutine;

	private bool _skillFinish;

	private TSVector2[] strollPoints;

	private bool strollInCircle;

	private bool isToughnessBroken;

	public void OnEnable()
	{
		_castSpawnSkill = true;
		_wanderRange = (_actor as MonsterAdventureActor).monsterAIInfo.wanderRange;
		_wanderInterval = (_actor as MonsterAdventureActor).monsterAIInfo.wanderInterval;
		_wanderRate = (_actor as MonsterAdventureActor).monsterAIInfo.wanderRate;
		strollPoints = (_actor as MonsterAdventureActor).spawnerInfo.strollPoints;
		strollInCircle = (_actor as MonsterAdventureActor).spawnerInfo.strollInCircle;
	}

	public void OnStart()
	{
		isToughnessBroken = true;
		if (!(_actor is MonsterAdventureActor { ToughnessBrokenToIdle: false } monsterAdventureActor))
		{
			return;
		}
		isToughnessBroken = false;
		_skillFinish = false;
		bool jumpOverSpawnPerformance = monsterAdventureActor.spawnerInfo.jumpOverSpawnPerformance;
		int spawnSkillId = monsterAdventureActor.monsterAIInfo.spawnSkillId;
		if (!jumpOverSpawnPerformance && spawnSkillId > 0 && _castSpawnSkill)
		{
			ILRuntimeAPI.CreateSkill(spawnSkillId, monsterAdventureActor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: true, SkillCountdownTiming.Start, (bool success) =>
			{
				EnterIdleShowSkill();
			});
			_castSpawnSkill = false;
		}
		else
		{
			EnterIdleShowSkill();
		}
	}

	private void EnterIdleShowSkill()
	{
		int idleShowSkillId = (_actor as MonsterAdventureActor).monsterAIInfo.idleShowSkillId;
		if (idleShowSkillId > 0)
		{
			ILRuntimeAPI.CreateSkill(idleShowSkillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: true, SkillCountdownTiming.Start, (bool result) =>
			{
				BeginPatrol();
			});
		}
		else
		{
			BeginPatrol();
		}
	}

	private void BeginPatrol()
	{
		_skillFinish = true;
		if (strollPoints != null && strollPoints.Length != 0)
		{
			StartCoroutine(ref _wanderCoroutine, Wander());
		}
		else if (_wanderRange > 0 && _wanderRate > 0)
		{
			_patrolCoroutine = _actor.StartLogicCoroutine(Patrol());
		}
	}

	private IEnumerator Wander()
	{
		int index = 0;
		int _index = 0;
		int dirction = 1;
		int count = strollPoints.Length;
		bool moveFinish = false;
		while (true)
		{
			moveFinish = false;
			_actor.MoveTo(strollPoints[index], 0.1f, enableNavigation: false, AdventureActor.MovementMode.Run, () =>
			{
				moveFinish = true;
				if (strollInCircle)
				{
					index = _index++ % count;
				}
				else
				{
					if (index == 0 && dirction == -1)
					{
						dirction = 1;
					}
					else if (index == count - 1 && dirction == 1)
					{
						dirction = -1;
					}
					index += dirction;
				}
			});
			while (!moveFinish)
			{
				yield return null;
			}
		}
	}

	private IEnumerator Patrol()
	{
		TSVector2 initPosition = _actor.tsTransform.Position;
		while (true)
		{
			TSVector2 targetPosition = _actor.RandomActorReachablePointInsideRing(initPosition, 0.1, _wanderRange);
			bool moveFinish = false;
			_actor.MoveTo(targetPosition, 0.1f, enableNavigation: true, AdventureActor.MovementMode.Run, () =>
			{
				moveFinish = true;
			});
			while (!moveFinish)
			{
				yield return null;
			}
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_wanderInterval));
			while (!(TSRandom.Range(FP.Zero, FP.One) <= _wanderRate))
			{
				yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_wanderInterval));
			}
		}
	}

	public void OnStop()
	{
		if (!isToughnessBroken)
		{
			StopCoroutine(ref _wanderCoroutine);
			if (_patrolCoroutine != null)
			{
				_actor.StopLogicCoroutine(_patrolCoroutine);
				_patrolCoroutine = null;
			}
			int idleShowSkillId = (_actor as MonsterAdventureActor).monsterAIInfo.idleShowSkillId;
			if (idleShowSkillId > 0)
			{
				_actor.actorSkillManage.ClearSkillById(idleShowSkillId);
			}
			int spawnSkillId = (_actor as MonsterAdventureActor).monsterAIInfo.spawnSkillId;
			if (spawnSkillId > 0)
			{
				_actor.actorSkillManage.ClearSkillById(spawnSkillId);
			}
		}
	}

	public void OnUpdate()
	{
		if (!(_actor is MonsterAdventureActor monsterAdventureActor))
		{
			return;
		}
		if (isToughnessBroken)
		{
			if (!monsterAdventureActor.ToughnessBrokenToIdle)
			{
				_actor.Action();
			}
		}
		else
		{
			if (!_skillFinish || (!ModuleController<AdventureModuleController>.Instance.InBattleState && !monsterAdventureActor.IsPlayerSummoned(out var _, out var _)))
			{
				return;
			}
			if (ModuleController<AdventureModuleController>.Instance.levelInstance is BrickBreakerController)
			{
				_actor.Action();
				return;
			}
			ILRuntimeAPI.RangeSearch(_actor, (List<LogicEntity> result) =>
			{
				if (result.Count > 0)
				{
					_actor.Action();
				}
			});
		}
	}
}
