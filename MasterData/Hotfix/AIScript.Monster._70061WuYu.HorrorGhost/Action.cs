using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70061WuYu.HorrorGhost;

public class Action : MonsterActionBase
{
	private const int Skill_LeftRightSweep = 7006141;

	private const int Skill_Slam = 7006142;

	private const int Skill_Charge = 7006143;

	private const int Skill_Wander = 7006146;

	private static readonly FP SweepRange = 3;

	private static readonly FP SlamRange = 4;

	private static readonly FP ChargeRange = 7;

	private static readonly FP RepositionSafeMargin = 3;

	private bool _repositioning;

	private bool _moveDone;

	private CoroutineNode _searchCor;

	private bool _searchDone;

	private bool _repositionFound;

	private TSVector2 _repositionTarget;

	private readonly List<FP> _availRanges = new List<FP>(3);

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.POOL;
		List<PoolBranchesInfo> list = new List<PoolBranchesInfo>();
		PoolBranchesInfo poolBranchesInfo = new PoolBranchesInfo
		{
			index = 1
		};
		List<PoolBranchInfo> list2 = new List<PoolBranchInfo>();
		AdventureActor actor = _actor;
		FP cd = 0;
		FP initCd = 0;
		Func<bool> operationConditionFunc = Check_Reposition;
		OperateDelegate operateIEnumerator = DoReposition;
		list2.Add(new PoolBranchInfo(actor, 1001, 200, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator, null, default, () =>
		{
			_repositioning = false;
		}));
		AdventureActor actor2 = _actor;
		FP cd2 = 7;
		FP initCd2 = 0;
		FP sweepRange = SweepRange;
		FP releaseAngle = 45;
		operationConditionFunc = Check_LeftRightSweep;
		operateIEnumerator = DoCast_LeftRightSweep;
		list2.Add(new PoolBranchInfo(actor2, 1002, 80, cd2, initCd2, active: true, sweepRange, releaseAngle, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 16;
		FP initCd3 = 16;
		FP slamRange = SlamRange;
		FP releaseAngle2 = 25;
		operationConditionFunc = Check_Slam;
		operateIEnumerator = DoCast_Slam;
		list2.Add(new PoolBranchInfo(actor3, 1004, 90, cd3, initCd3, active: true, slamRange, releaseAngle2, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		FP cd4 = 25;
		FP initCd4 = 25;
		FP chargeRange = ChargeRange;
		FP releaseAngle3 = 30;
		operationConditionFunc = Check_Charge;
		operateIEnumerator = DoCast_Charge;
		list2.Add(new PoolBranchInfo(actor4, 1005, 100, cd4, initCd4, active: true, chargeRange, releaseAngle3, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor5 = _actor;
		FP cd5 = 0;
		FP initCd5 = 0;
		operateIEnumerator = DoWander;
		list2.Add(new PoolBranchInfo(actor5, 1003, 1, cd5, initCd5, active: true, default, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void OnActionStop()
	{
		base.OnActionStop();
		_repositioning = false;
	}

	private bool Check_Reposition()
	{
		LogicEntity otherTerrorGhost = GetOtherTerrorGhost();
		if (otherTerrorGhost == null)
		{
			return false;
		}
		FP fP = GetBodyRadius(_actor) + GetBodyRadius(otherTerrorGhost);
		TSVector2 position = GetPosition();
		TSVector2 position2 = otherTerrorGhost.tsTransform.Position;
		if (TSVector2.Distance(position, position2) >= fP)
		{
			return false;
		}
		return _actor.Id < otherTerrorGhost.Id;
	}

	private IEnumerator DoReposition()
	{
		_repositioning = true;
		InterruptSkill();
		LogicEntity otherTerrorGhost = GetOtherTerrorGhost();
		if (otherTerrorGhost != null)
		{
			TSVector2 position = GetPosition();
			TSVector2 position2 = otherTerrorGhost.tsTransform.Position;
			TSVector2 tSVector = position - position2;
			if (tSVector.magnitude <= FP.Zero)
			{
				tSVector = new TSVector2(FP.One, FP.Zero);
			}
			FP dist = GetBodyRadius(_actor) + GetBodyRadius(otherTerrorGhost) + RepositionSafeMargin;
			LogicEntity attackTarget = GetAttackTarget();
			bool flag = attackTarget != null;
			TSVector2 playerPos = (flag ? GetEntityPosition(attackTarget) : default(TSVector2));
			_availRanges.Clear();
			if (!CheckSkillOnCD(7006141))
			{
				_availRanges.Add(SweepRange);
			}
			if (!CheckSkillOnCD(7006142))
			{
				_availRanges.Add(SlamRange);
			}
			if (!CheckSkillOnCD(7006143))
			{
				_availRanges.Add(ChargeRange);
			}
			_searchDone = false;
			_repositionFound = false;
			StartCor(ref _searchCor, TryFindRepositionTarget(position2, tSVector.normalized, dist, playerPos, flag, _availRanges));
			while (!_searchDone)
			{
				yield return null;
			}
			StopCor(_searchCor);
			if (!_repositionFound)
			{
				_repositioning = false;
				yield break;
			}
			_moveDone = false;
			AdventureActor actor = _actor;
			TSVector2 repositionTarget = _repositionTarget;
			FP stopDistance = 0.1;
			System.Action onComplete = OnMoveDone;
			System.Action onLeave = OnMoveDone;
			if (actor.MoveTo(repositionTarget, stopDistance, enableNavigation: true, AdventureActor.MovementMode.Run, onComplete, randomMove: false, forceMove: false, default, onLeave))
			{
				int frame = 0;
				while (!_moveDone && frame < 100)
				{
					LogicEntity otherTerrorGhost2 = GetOtherTerrorGhost();
					if (otherTerrorGhost2 == null || IsSeparatedEnough(otherTerrorGhost2))
					{
						_actor.InterruptMovement();
						break;
					}
					frame++;
					yield return null;
				}
				if (!_moveDone)
				{
					_actor.InterruptMovement();
				}
			}
		}
		_repositioning = false;
	}

	private void OnMoveDone()
	{
		_moveDone = true;
	}

	private bool Check_LeftRightSweep()
	{
		if (_repositioning || GetSummonerToughnessBrokenOrDispelStun())
		{
			return false;
		}
		return true;
	}

	private IEnumerator DoCast_LeftRightSweep()
	{
		CastSkill(7006141);
		yield return WaitSkillFinish();
	}

	private bool Check_Slam()
	{
		if (_repositioning || GetSummonerToughnessBrokenOrDispelStun())
		{
			return false;
		}
		return true;
	}

	private IEnumerator DoCast_Slam()
	{
		CastSkill(7006142);
		yield return WaitSkillFinish();
	}

	private bool Check_Charge()
	{
		if (_repositioning || GetSummonerToughnessBrokenOrDispelStun())
		{
			return false;
		}
		return true;
	}

	private IEnumerator DoCast_Charge()
	{
		CastSkill(7006143);
		yield return WaitSkillFinish();
	}

	private IEnumerator DoWander()
	{
		SetLogicTagToggleValue(_actor, "ExecutingCanBreakBranch", value: true);
		CastSkill(7006146);
		yield return WaitSkillFinish();
	}

	private LogicEntity GetOtherTerrorGhost()
	{
		List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(4);
		if (targetByTeammateIndex == null)
		{
			return null;
		}
		foreach (LogicEntity item in targetByTeammateIndex)
		{
			if (item.Id != _actor.Id)
			{
				return item;
			}
		}
		return null;
	}

	private FP GetBodyRadius(LogicEntity actor)
	{
		if (actor == null)
		{
			return FP.Zero;
		}
		DeterministicCollider logicComponent = actor.GetLogicComponent<DeterministicCollider>();
		if (!(logicComponent != null))
		{
			return FP.Zero;
		}
		return logicComponent.Radius;
	}

	private bool IsSeparatedEnough(LogicEntity other)
	{
		FP fP = GetBodyRadius(_actor) + GetBodyRadius(other) + RepositionSafeMargin;
		return TSVector2.DistanceSquared(GetPosition(), other.tsTransform.Position) >= fP * fP;
	}

	private IEnumerator TryFindRepositionTarget(TSVector2 otherPos, TSVector2 preferDir, FP dist, TSVector2 playerPos, bool hasPlayer, List<FP> availRanges)
	{
		FP minDistSq = dist * dist;
		TSVector2[] playerDirs;
		if (hasPlayer && availRanges.Count > 0)
		{
			TSVector2 tSVector = otherPos - playerPos;
			tSVector = ((!(tSVector.magnitude <= FP.Zero)) ? tSVector.normalized : new TSVector2(FP.One, FP.Zero));
			TSVector2 tSVector2 = new TSVector2(-tSVector.y, tSVector.x);
			playerDirs = new TSVector2[5]
			{
				tSVector2,
				-tSVector2,
				(tSVector2 - tSVector).normalized,
				(-tSVector2 - tSVector).normalized,
				-tSVector
			};
			foreach (FP range in availRanges)
			{
				TSVector2[] array = playerDirs;
				foreach (TSVector2 tSVector3 in array)
				{
					if (_actor.QueryClosestPositionWalkable(playerPos + tSVector3 * range, out var result) && TSVector2.DistanceSquared(otherPos, result) >= minDistSq)
					{
						_repositionTarget = result;
						_repositionFound = true;
						_searchDone = true;
						yield break;
					}
					yield return null;
				}
			}
		}
		TSVector2 tSVector4 = new TSVector2(-preferDir.y, preferDir.x);
		TSVector2[] array2 = new TSVector2[8]
		{
			preferDir,
			(preferDir + tSVector4).normalized,
			tSVector4,
			(tSVector4 - preferDir).normalized,
			-preferDir,
			(-preferDir - tSVector4).normalized,
			-tSVector4,
			(preferDir - tSVector4).normalized
		};
		playerDirs = array2;
		foreach (TSVector2 tSVector5 in playerDirs)
		{
			if (_actor.QueryClosestPositionWalkable(otherPos + tSVector5 * dist, out var result2) && TSVector2.DistanceSquared(otherPos, result2) >= minDistSq)
			{
				_repositionTarget = result2;
				_repositionFound = true;
				_searchDone = true;
				yield break;
			}
			yield return null;
		}
		_repositionFound = false;
		_searchDone = true;
	}

	private bool GetSummonerToughnessBrokenOrDispelStun()
	{
		AdventureActor adventureActor = _actor.GetLogicComponent<MonsterSummonInfo>()?.SummonActor;
		if (adventureActor == null)
		{
			return true;
		}
		MonsterAdventureActor monsterAdventureActor = adventureActor as MonsterAdventureActor;
		if (monsterAdventureActor.monsterToughnessInfo.isToughnessBroken || GetBuffNum(monsterAdventureActor, 700619100) == 0)
		{
			return true;
		}
		return false;
	}
}
