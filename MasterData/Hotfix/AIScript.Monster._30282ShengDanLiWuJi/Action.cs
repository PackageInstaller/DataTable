using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30282ShengDanLiWuJi;

public class Action : MonsterActionBase
{
	private readonly int Kill = 3028204;

	private readonly int Area = 3028203;

	private readonly int Gift = 3028202;

	private FP Cooldown;

	private int Times;

	private int MaxTimes;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		InitListenEvent(MonsterEventType.CustomEventOnlySelfOrSummoner, active: true, OnCustomEvt);
		Times = 0;
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
	}

	protected override void SetConfig()
	{
		if (GetMonsterTagValue(_actor, 1) == "Lv3")
		{
			Cooldown = 8;
			MaxTimes = 7;
		}
		else if (GetMonsterTagValue(_actor, 1) == "Lv2")
		{
			Cooldown = 6;
			MaxTimes = 11;
		}
		else
		{
			Cooldown = 4;
			MaxTimes = 14;
		}
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
		Func<bool> operationConditionFunc = Condition01;
		OperateDelegate operateIEnumerator = Attack02;
		list2.Add(new PoolBranchInfo(actor, 1, 99, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cooldown = Cooldown;
		FP initCd2 = 0;
		FP releaseDistance = 100;
		FP releaseAngle = 360;
		operateIEnumerator = Attack01;
		list2.Add(new PoolBranchInfo(actor2, 2, 10, cooldown, initCd2, active: true, releaseDistance, releaseAngle, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private void OnCustomEvt(IEvent evt)
	{
		if (!(_actor == null) && !_actor.isDead && !_actor.inDying && !_actor.isDeclareDead && evt is AdventureActorCustomEvent adventureActorCustomEvent && !string.IsNullOrEmpty(adventureActorCustomEvent.eventName))
		{
			if (adventureActorCustomEvent.eventName.Equals("ShengDanTaLouSkill03"))
			{
				SetLogicTagToggleValue(_actor, "ShengDanTaLouSkill03_Area", value: true);
				CastSkill(Area);
			}
			if (adventureActorCustomEvent.eventName.Equals("ShengDanTaLouSkill09"))
			{
				SetLogicTagToggleValue(_actor, "ShengDanTaLouSkill09_Area", value: true);
				CastSkill(Area);
			}
			if (adventureActorCustomEvent.eventName.Equals("ShengDanQiEChe"))
			{
				SetLogicTagToggleValue(_actor, "ShengDanQiEChe_Area", value: true);
				CastSkill(Area);
			}
		}
	}

	private bool Condition01()
	{
		if (Times >= MaxTimes)
		{
			return true;
		}
		return false;
	}

	private IEnumerator Attack01()
	{
		CastSkill(Gift);
		Times++;
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack02()
	{
		CastSkill(Kill);
		yield return WaitSkillFinish();
	}
}
