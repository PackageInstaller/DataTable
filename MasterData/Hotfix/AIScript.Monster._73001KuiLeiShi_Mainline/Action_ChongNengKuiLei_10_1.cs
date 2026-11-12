using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Action_ChongNengKuiLei_10_1 : MonsterActionBase
{
	private readonly int Skill_2 = 7201374;

	private readonly int Skill_1 = 7201375;

	private int _deathCount;

	private FP SkillTimes01;

	private string tag1 = "Mark1";

	private bool _finalStarted;

	private FP SkillTimes02;

	private readonly int testSkillId;

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
		FP cd = 5;
		FP initCd = 3;
		Func<bool> operationConditionFunc = Condition02;
		OperateDelegate operateIEnumerator = Attack01;
		list2.Add(new PoolBranchInfo(actor, 1, 70, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 10;
		FP initCd2 = 1.5;
		operationConditionFunc = Condition01;
		operateIEnumerator = Attack02;
		list2.Add(new PoolBranchInfo(actor2, 2, 999, cd2, initCd2, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void OnActionEnable()
	{
		SkillTimes01 = 0;
		SkillTimes02 = 0;
		SetSuperArmorEnable(autoDisableWhenSkillDisable: false);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvt);
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvt);
	}

	private void GotoCastSkill(int ID)
	{
		if (testSkillId != 0)
		{
			ID = testSkillId;
		}
		CastSkill(ID);
	}

	private void OnCustomEvt(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent { eventName: not null } adventureActorCustomEvent && adventureActorCustomEvent.eventName.Equals("OnCustomEvt"))
		{
			_finalStarted = true;
			SkillTimes01 = 1;
			SkillTimes02 = 1;
		}
	}

	private bool Condition01()
	{
		if (_finalStarted)
		{
			return false;
		}
		return SkillTimes01 == 0;
	}

	private bool Condition02()
	{
		if (_finalStarted)
		{
			return false;
		}
		LogicEntity attackTarget = GetAttackTarget();
		if (attackTarget == null)
		{
			return false;
		}
		if (Distance(GetPosition(), GetEntityPosition(attackTarget)) < 8)
		{
			return SkillTimes02 == 0;
		}
		return false;
	}

	private IEnumerator Attack01()
	{
		GotoCastSkill(Skill_1);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack02()
	{
		GotoCastSkill(Skill_2);
		SkillTimes01 = 1;
		yield return WaitSkillFinish();
	}
}
