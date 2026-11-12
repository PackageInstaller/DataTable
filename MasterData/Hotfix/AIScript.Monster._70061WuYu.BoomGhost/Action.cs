using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70061WuYu.BoomGhost;

public class Action : MonsterActionBase
{
	private const int Skill_DeathWord = 7006111;

	private const int Phase2BuffId = 700619200;

	private static readonly FP LifeTime = 15;

	private static readonly FP NearDistance = 2;

	public static readonly FP PerfumeGain = 8;

	private const int DeathWordBranchId = 1001;

	private static readonly FP DeathWordRecoverCd = 1;

	private bool _hasFastExplodeTag;

	internal const string DeathWordStartedTag = "BoomGhost_DeathWordStarted";

	private bool _wasLostControl;

	protected override void OnActionEnable()
	{
		_hasFastExplodeTag = HasFastExplodeTag();
		SetLogicTagToggleValue(_actor, "BoomGhost_DeathWordStarted", value: false);
		_wasLostControl = false;
		if (_hasFastExplodeTag)
		{
			AddBuffToTarget(_actor, 700619200);
		}
	}

	protected override void SetListenEvents()
	{
		base.SetListenEvents();
		InitListenEvent(MonsterEventType.SelfLostControl, active: true, OnSelfLostControl);
	}

	private void OnSelfLostControl(IEvent evt)
	{
		_wasLostControl = true;
	}

	protected override void OnActionStart()
	{
		base.OnActionStart();
		if (_wasLostControl)
		{
			_wasLostControl = false;
			if (GetPoolBranchCD(1001) <= DeathWordRecoverCd)
			{
				SetPoolBranchCD(1001, DeathWordRecoverCd);
			}
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
		FP deathWordRecoverCd = DeathWordRecoverCd;
		FP lifeTime = LifeTime;
		Func<bool> operationConditionFunc = Check_DeathWord;
		OperateDelegate operateIEnumerator = DoCast_DeathWord;
		list2.Add(new PoolBranchInfo(actor, 1001, 999, deathWordRecoverCd, lifeTime, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd = 0;
		FP initCd = 0;
		FP nearDistance = NearDistance;
		operateIEnumerator = DoChase;
		list2.Add(new PoolBranchInfo(actor2, 1002, 1, cd, initCd, active: true, nearDistance, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private bool Check_DeathWord()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: false) <= NearDistance || GetPoolBranchCD(1001) <= 0)
		{
			return !GetLogicTagToggleValue(_actor, "BoomGhost_DeathWordStarted");
		}
		return false;
	}

	private IEnumerator DoCast_DeathWord()
	{
		InterruptSkill();
		CastSkill(7006111);
		yield return WaitSkillFinish();
	}

	private IEnumerator DoChase()
	{
		yield return null;
		if (Check_DeathWord() && GetPoolBranchCD(1001) > DeathWordRecoverCd)
		{
			SetPoolBranchCD(1001, DeathWordRecoverCd);
		}
	}

	private int GetSummonerPhase()
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

	private bool HasFastExplodeTag()
	{
		AdventureActor adventureActor = _actor.GetLogicComponent<MonsterSummonInfo>()?.SummonActor;
		if (adventureActor != null)
		{
			return GetLogicTagToggleValue(adventureActor, "FastExplodeTagId");
		}
		return false;
	}
}
