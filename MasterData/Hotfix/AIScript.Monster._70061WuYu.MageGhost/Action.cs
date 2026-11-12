using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70061WuYu.MageGhost;

public class Action : MonsterActionBase
{
	private const int Skill_MagicBullet = 7006131;

	private const int Skill_DeathWord = 7006132;

	private const int Phase2BuffId = 700619400;

	private const int Skill_Wander = 7006135;

	protected static readonly FP LifeTime = 15;

	public static readonly FP PerfumeGain = 12;

	protected bool _hasFastExplodeTag;

	internal const string DeathWordStartedTag = "MageGhost_DeathWordStarted";

	protected override void OnActionEnable()
	{
		_hasFastExplodeTag = HasFastExplodeTag();
		SetLogicTagToggleValue(_actor, "MageGhost_DeathWordStarted", value: false);
		if (_hasFastExplodeTag)
		{
			AddBuffToTarget(_actor, 700619400);
		}
	}

	protected override void SetConfig()
	{
		_hasFastExplodeTag = HasFastExplodeTag();
		_monsterAIType = MonsterAIType.POOL;
		List<PoolBranchesInfo> list = new List<PoolBranchesInfo>();
		PoolBranchesInfo poolBranchesInfo = new PoolBranchesInfo
		{
			index = 1
		};
		List<PoolBranchInfo> list2 = new List<PoolBranchInfo>();
		AdventureActor actor = _actor;
		FP cd = 0;
		FP lifeTime = LifeTime;
		Func<bool> operationConditionFunc = Check_DeathWord;
		OperateDelegate operateIEnumerator = DoCast_DeathWord;
		list2.Add(new PoolBranchInfo(actor, 1001, 999, cd, lifeTime, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 6;
		FP initCd = 0;
		FP releaseDistance = 12;
		FP releaseAngle = 15;
		operationConditionFunc = Check_MagicBullet;
		operateIEnumerator = DoCast_MagicBullet;
		list2.Add(new PoolBranchInfo(actor2, 1002, 100, cd2, initCd, active: true, releaseDistance, releaseAngle, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 0;
		FP initCd2 = 0;
		operateIEnumerator = DoWander;
		list2.Add(new PoolBranchInfo(actor3, 1003, 1, cd3, initCd2, active: true, default, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected bool Check_DeathWord()
	{
		return !GetLogicTagToggleValue(_actor, "MageGhost_DeathWordStarted");
	}

	protected IEnumerator DoCast_DeathWord()
	{
		InterruptSkill();
		CastSkill(7006132);
		yield return WaitSkillFinish();
	}

	protected bool Check_MagicBullet()
	{
		if (GetLogicTagToggleValue(_actor, "MageGhost_DeathWordStarted"))
		{
			return false;
		}
		return true;
	}

	protected IEnumerator DoCast_MagicBullet()
	{
		CastSkill(7006131);
		yield return WaitSkillFinish();
	}

	protected IEnumerator DoWander()
	{
		SetLogicTagToggleValue(_actor, "ExecutingCanBreakBranch", value: true);
		CastSkill(7006135);
		yield return WaitSkillFinish();
	}

	protected int GetSummonerPhase()
	{
		AdventureActor adventureActor = _actor.GetLogicComponent<MonsterSummonInfo>()?.SummonActor;
		if (adventureActor == null)
		{
			return 1;
		}
		int num = GetLogicTagFpValue(adventureActor, "Phase").AsInt();
		if (num < 1)
		{
			num = 1;
		}
		return num;
	}

	protected bool HasFastExplodeTag()
	{
		AdventureActor adventureActor = _actor.GetLogicComponent<MonsterSummonInfo>()?.SummonActor;
		if (adventureActor != null)
		{
			return GetLogicTagToggleValue(adventureActor, "FastExplodeTagId");
		}
		return false;
	}
}
