using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30901ChiHou;

public class Action_SandSoldier : MonsterActionBase
{
	private readonly int SkillId_Slash = 3090101;

	private readonly int SkillId_DashAttack = 3090102;

	private readonly int SkillId_ShieldDash = 3090103;

	private readonly int SkillId_ShieldSmash = 3090104;

	private readonly int SkillId_DashAndSmash = 3090108;

	private readonly int SkillId_SandBoom = 3090107;

	private readonly int SkillId_Wander = 9999970;

	private readonly int testSkillId;

	private readonly FP TimeMax = 10;

	private DeterministicShape DashShape;

	private bool SpawnSkillEnd;

	private FP TimeCount;

	private bool TimeEnd;

	private bool StartTimer;

	protected override void OnActionStart()
	{
		base.OnActionStart();
		StartCor(Timer());
	}

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
		Func<bool> operationConditionFunc = Condition05;
		OperateDelegate operateIEnumerator = SelfDestroy;
		list2.Add(new PoolBranchInfo(actor, 1, 999, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 0;
		FP initCd2 = 0;
		operationConditionFunc = Condition06;
		operateIEnumerator = Skill_DashAndSmash;
		list2.Add(new PoolBranchInfo(actor2, 2, 110, cd2, initCd2, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 0;
		FP initCd3 = 0;
		operationConditionFunc = Condition01;
		operateIEnumerator = Skill_ShieldDash;
		list2.Add(new PoolBranchInfo(actor3, 3, 100, cd3, initCd3, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		FP cd4 = 0;
		FP initCd4 = 0;
		operationConditionFunc = Condition02;
		operateIEnumerator = Skill_ShieldSmash;
		list2.Add(new PoolBranchInfo(actor4, 4, 100, cd4, initCd4, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor5 = _actor;
		FP cd5 = 5;
		FP initCd5 = 0;
		operationConditionFunc = Condition03;
		operateIEnumerator = Skill_DashAttack;
		list2.Add(new PoolBranchInfo(actor5, 5, 90, cd5, initCd5, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor6 = _actor;
		FP cd6 = 0;
		FP initCd6 = 0;
		operationConditionFunc = Condition04;
		operateIEnumerator = Skill_Slash;
		list2.Add(new PoolBranchInfo(actor6, 6, 80, cd6, initCd6, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor7 = _actor;
		FP cd7 = 0;
		FP initCd7 = 0;
		operateIEnumerator = Skill_Wander;
		list2.Add(new PoolBranchInfo(actor7, 7, 70, cd7, initCd7, active: true, default, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void OnActionEnable()
	{
		if (GetPosition().x < 0)
		{
			TSVector2 position = new TSVector2(6.25, 0);
			FP width = 12.5;
			FP length = 15;
			FP rotation = 0;
			DashShape = GetShapeData(DeterministicShape.ShapeType.Rectangle, position, width, length, default, default, default, rotation);
		}
		else
		{
			TSVector2 position2 = new TSVector2(-6.25, 0);
			FP width2 = 12.5;
			FP length2 = 15;
			FP rotation = 0;
			DashShape = GetShapeData(DeterministicShape.ShapeType.Rectangle, position2, width2, length2, default, default, default, rotation);
		}
		SpawnSkillEnd = false;
		TimeCount = 0;
		TimeEnd = false;
		StartTimer = false;
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.CustomEventOnlySelfOrSummoner, active: true, OnCustomEvt);
	}

	private void OnCustomEvt(IEvent evt)
	{
		if (!(_actor == null) && !_actor.isDead && !_actor.inDying && !_actor.isDeclareDead && evt is AdventureActorCustomEvent adventureActorCustomEvent && !string.IsNullOrEmpty(adventureActorCustomEvent.eventName) && adventureActorCustomEvent.eventName.Equals("SandSoldier_Boom"))
		{
			InterruptSkill();
			GotoCastSkill(SkillId_SandBoom);
		}
	}

	private IEnumerator Timer()
	{
		while (TimeCount < TimeMax)
		{
			yield return null;
			if (StartTimer)
			{
				TimeCount += _actor.LogicDeltaTime;
			}
		}
		TimeEnd = true;
	}

	private void GotoCastSkill(int ID)
	{
		if (testSkillId != 0)
		{
			ID = testSkillId;
		}
		CastSkill(ID);
	}

	private bool Condition01()
	{
		if (AreaCheckMonsterTarget(DashShape) && !SpawnSkillEnd)
		{
			return true;
		}
		return false;
	}

	private bool Condition02()
	{
		if (!AreaCheckMonsterTarget(DashShape) && !SpawnSkillEnd)
		{
			return true;
		}
		return false;
	}

	private bool Condition06()
	{
		if (GetTargetByTeammateIndex(0).Count != 0)
		{
			if (GetLogicTagToggleValue(GetTargetByTeammateIndex(0).get_Item(0), "CallArmy") && !SpawnSkillEnd)
			{
				return true;
			}
			return false;
		}
		return false;
	}

	private bool Condition03()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) >= 5)
		{
			return true;
		}
		return false;
	}

	private bool Condition04()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) < 3)
		{
			return true;
		}
		return false;
	}

	private bool Condition05()
	{
		if (TimeEnd)
		{
			return true;
		}
		return false;
	}

	private IEnumerator Skill_ShieldDash()
	{
		GotoCastSkill(SkillId_ShieldDash);
		yield return WaitSkillFinish();
		SpawnSkillEnd = true;
		StartTimer = true;
	}

	private IEnumerator Skill_ShieldSmash()
	{
		GotoCastSkill(SkillId_ShieldSmash);
		yield return WaitSkillFinish();
		SpawnSkillEnd = true;
		StartTimer = true;
	}

	private IEnumerator Skill_DashAndSmash()
	{
		GotoCastSkill(SkillId_DashAndSmash);
		yield return WaitSkillFinish();
		SpawnSkillEnd = true;
		StartTimer = true;
	}

	private IEnumerator Skill_Slash()
	{
		GotoCastSkill(SkillId_Slash);
		yield return WaitSkillFinish();
	}

	private IEnumerator Skill_DashAttack()
	{
		GotoCastSkill(SkillId_DashAttack);
		yield return WaitSkillFinish();
	}

	private IEnumerator Skill_Wander()
	{
		SetLogicTagToggleValue(_actor, "ExecutingCanBreakBranch", value: true);
		GotoCastSkill(SkillId_Wander);
		yield return WaitSkillFinish();
	}

	private IEnumerator SelfDestroy()
	{
		_actor.DestroySelf();
		yield break;
	}
}
