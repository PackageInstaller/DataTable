using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70061WuYu.BigHeadGhost;

public class Action : MonsterActionBase
{
	private const int Skill_BowTie = 7006121;

	private const int Skill_RocketHeadbutt = 7006122;

	private const int Skill_EnergyCircle = 7006123;

	private const int Skill_SpinSlash = 7006124;

	private const int Skill_DeathWord = 7006125;

	private const int Phase2BuffId = 700619300;

	private const int Skill_Wander = 7006128;

	protected static readonly FP LifeTime = 15;

	public static readonly FP PerfumeGain = 16;

	protected bool _hasFastExplodeTag;

	internal const string DeathWordStartedTag = "BigHeadGhost_DeathWordStarted";

	protected override void OnActionEnable()
	{
		_hasFastExplodeTag = HasFastExplodeTag();
		SetLogicTagToggleValue(_actor, "BigHeadGhost_DeathWordStarted", value: false);
		if (_hasFastExplodeTag)
		{
			AddBuffToTarget(_actor, 700619300);
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
		FP cd2 = 14;
		FP initCd = 8;
		FP releaseDistance = 15;
		operationConditionFunc = Check_SpinSlash;
		operateIEnumerator = DoCast_SpinSlash;
		list2.Add(new PoolBranchInfo(actor2, 1003, 190, cd2, initCd, active: true, releaseDistance, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 4;
		FP initCd2 = 0;
		FP releaseDistance2 = 3;
		FP releaseAngle = 10;
		operationConditionFunc = Check_BowTie;
		operateIEnumerator = DoCast_BowTie;
		list2.Add(new PoolBranchInfo(actor3, 1004, 90, cd3, initCd2, active: true, releaseDistance2, releaseAngle, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		FP cd4 = 6;
		FP initCd3 = 3;
		FP releaseDistance3 = 5;
		FP releaseAngle2 = 5;
		operationConditionFunc = Check_RocketHeadbutt;
		operateIEnumerator = DoCast_RocketHeadbutt;
		list2.Add(new PoolBranchInfo(actor4, 1005, 100, cd4, initCd3, active: true, releaseDistance3, releaseAngle2, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor5 = _actor;
		FP cd5 = 0;
		FP initCd4 = 0;
		operateIEnumerator = DoWander;
		list2.Add(new PoolBranchInfo(actor5, 1006, 1, cd5, initCd4, active: true, default, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected bool Check_DeathWord()
	{
		return !GetLogicTagToggleValue(_actor, "BigHeadGhost_DeathWordStarted");
	}

	protected IEnumerator DoCast_DeathWord()
	{
		InterruptSkill();
		CastSkill(7006125);
		yield return WaitSkillFinish();
	}

	protected bool Check_BowTie()
	{
		if (GetLogicTagToggleValue(_actor, "BigHeadGhost_DeathWordStarted"))
		{
			return false;
		}
		return true;
	}

	protected IEnumerator DoCast_BowTie()
	{
		CastSkill(7006121);
		yield return WaitSkillFinish();
	}

	protected bool Check_RocketHeadbutt()
	{
		if (GetLogicTagToggleValue(_actor, "BigHeadGhost_DeathWordStarted"))
		{
			return false;
		}
		return true;
	}

	protected IEnumerator DoCast_RocketHeadbutt()
	{
		CastSkill(7006122);
		yield return WaitSkillFinish();
	}

	protected bool Check_EnergyCircle()
	{
		if (GetLogicTagToggleValue(_actor, "BigHeadGhost_DeathWordStarted"))
		{
			return false;
		}
		if (!_hasFastExplodeTag)
		{
			return false;
		}
		return true;
	}

	protected IEnumerator DoCast_EnergyCircle()
	{
		CastSkill(7006123);
		yield return WaitSkillFinish();
	}

	protected bool Check_SpinSlash()
	{
		if (GetLogicTagToggleValue(_actor, "BigHeadGhost_DeathWordStarted"))
		{
			return false;
		}
		if (!_hasFastExplodeTag)
		{
			return false;
		}
		return true;
	}

	protected IEnumerator DoCast_SpinSlash()
	{
		CastSkill(7006124);
		yield return WaitSkillFinish();
	}

	protected virtual IEnumerator DoWander()
	{
		SetLogicTagToggleValue(_actor, "ExecutingCanBreakBranch", value: true);
		CastSkill(7006128);
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
