using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Boss._Dark._50251ShanDianLieQuan;

public class MiniBoss_Dark_Action : MonsterActionBase
{
	private readonly int Skillid_ShuaiWei = 5025131;

	private readonly int Skillid_ShuaiWei_Plus_Jin = 5025132;

	private readonly int Skillid_ShuaiWei_Plus_Yuan = 5025133;

	private readonly int Skillid_DarkBall = 5025134;

	private readonly int Skillid_DarkBall_Plus = 5025135;

	private readonly int Skillid_TiaoPu = 5025136;

	private readonly int Skillid_TiaoPu_Plus = 5025137;

	private readonly int Skillid_ShadowLaser = 5025138;

	private readonly int Skillid_ShadowDash = 5025139;

	private readonly int Skillid_Linger = 5025198;

	private static readonly int testSkillId;

	private int SkillTimes01;

	private int SkillTimes02;

	private int SkillTimes03;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		SetLogicTagFpValue(_actor, "BattleStage", 1);
		SkillTimes01 = 0;
		SkillTimes02 = 0;
		if (GetMonsterTagValue(_actor, 1) == "Hard")
		{
			SkillTimes03 = 3;
		}
		else
		{
			SkillTimes03 = 2;
		}
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
		FP cd = 40;
		FP initCd = 0;
		Func<bool> operationConditionFunc = Condition03;
		OperateDelegate operateIEnumerator = ShadowDash;
		list2.Add(new PoolBranchInfo(actor, 1001, 100, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 10;
		FP initCd2 = 0;
		FP releaseDistance = 4;
		FP releaseAngle = 360;
		operateIEnumerator = ShuaiWei;
		list2.Add(new PoolBranchInfo(actor2, 1002, 90, cd2, initCd2, active: true, releaseDistance, releaseAngle, default, null, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 12;
		FP initCd3 = 0;
		FP releaseDistance2 = 100;
		FP releaseAngle2 = 360;
		operateIEnumerator = DarkBall;
		list2.Add(new PoolBranchInfo(actor3, 1003, 80, cd3, initCd3, active: true, releaseDistance2, releaseAngle2, default, null, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		FP cd4 = 10;
		FP initCd4 = 0;
		FP releaseDistance3 = 15;
		FP releaseAngle3 = 360;
		operateIEnumerator = TiaoPu;
		list2.Add(new PoolBranchInfo(actor4, 1004, 70, cd4, initCd4, active: true, releaseDistance3, releaseAngle3, default, null, null, operateIEnumerator));
		AdventureActor actor5 = _actor;
		FP cd5 = 5;
		FP initCd5 = 0;
		FP releaseDistance4 = 100;
		FP releaseAngle4 = 360;
		operateIEnumerator = Linger;
		list2.Add(new PoolBranchInfo(actor5, 1005, 50, cd5, initCd5, active: true, releaseDistance4, releaseAngle4, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		PoolBranchesInfo poolBranchesInfo2 = new PoolBranchesInfo
		{
			index = 2
		};
		List<PoolBranchInfo> list3 = new List<PoolBranchInfo>();
		AdventureActor actor6 = _actor;
		FP cd6 = 80;
		FP initCd6 = 0;
		operationConditionFunc = Condition02;
		operateIEnumerator = ShadowLaser;
		list3.Add(new PoolBranchInfo(actor6, 2001, 999, cd6, initCd6, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor7 = _actor;
		FP cd7 = 2;
		FP initCd7 = 0;
		operationConditionFunc = Condition04;
		operateIEnumerator = Linger;
		list3.Add(new PoolBranchInfo(actor7, 2002, 200, cd7, initCd7, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor8 = _actor;
		FP cd8 = 15;
		FP initCd8 = 0;
		operationConditionFunc = Condition01;
		operateIEnumerator = ShuaiWei_Plus_Yuan;
		list3.Add(new PoolBranchInfo(actor8, 2003, 100, cd8, initCd8, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor9 = _actor;
		FP cd9 = 18;
		FP initCd9 = 0;
		FP releaseDistance5 = 100;
		FP releaseAngle5 = 360;
		operateIEnumerator = DarkBall_Plus;
		list3.Add(new PoolBranchInfo(actor9, 2004, 90, cd9, initCd9, active: true, releaseDistance5, releaseAngle5, default, null, null, operateIEnumerator));
		AdventureActor actor10 = _actor;
		FP cd10 = 20;
		FP initCd10 = 0;
		FP releaseDistance6 = 100;
		FP releaseAngle6 = 360;
		operateIEnumerator = TiaoPu_Plus;
		list3.Add(new PoolBranchInfo(actor10, 2005, 80, cd10, initCd10, active: true, releaseDistance6, releaseAngle6, default, null, null, operateIEnumerator));
		AdventureActor actor11 = _actor;
		FP cd11 = 10;
		FP initCd11 = 0;
		FP releaseDistance7 = 4;
		FP releaseAngle7 = 360;
		operateIEnumerator = ShuaiWei_Plus_Jin;
		list3.Add(new PoolBranchInfo(actor11, 2006, 70, cd11, initCd11, active: true, releaseDistance7, releaseAngle7, default, null, null, operateIEnumerator));
		AdventureActor actor12 = _actor;
		FP cd12 = 10;
		FP initCd12 = 5;
		FP releaseDistance8 = 100;
		FP releaseAngle8 = 360;
		operateIEnumerator = Linger;
		list3.Add(new PoolBranchInfo(actor12, 2007, 10, cd12, initCd12, active: true, releaseDistance8, releaseAngle8, default, null, null, operateIEnumerator));
		poolBranchesInfo2.braches = list3;
		list.Add(poolBranchesInfo2);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(2, poolBranches);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfToughnessBroken, active: true, InterruptStrong);
	}

	private void InterruptStrong(IEvent evt)
	{
		RemoveBuffFromTarget(_actor, 502510010);
		SwitchPool(1);
		SkillTimes01 = 0;
		SkillTimes02 = 0;
	}

	private bool Condition01()
	{
		if (Distance(GetPosition(), GetEntityPosition(GetAttackTarget())) > 8 && Distance(GetPosition(), GetEntityPosition(GetAttackTarget())) <= 30)
		{
			return true;
		}
		return false;
	}

	private bool Condition02()
	{
		if (SkillTimes01 >= 5)
		{
			return true;
		}
		return false;
	}

	private bool Condition03()
	{
		if (SkillTimes01 >= 4)
		{
			return true;
		}
		return false;
	}

	private bool Condition04()
	{
		if (SkillTimes02 >= SkillTimes03)
		{
			return true;
		}
		return false;
	}

	private void GotoCastSkill(int ID)
	{
		if (testSkillId != 0)
		{
			ID = testSkillId;
		}
		CastSkill(ID);
	}

	private IEnumerator ShuaiWei()
	{
		GotoCastSkill(Skillid_ShuaiWei);
		yield return WaitSkillFinish();
		SkillTimes01++;
		SkillTimes02++;
	}

	private IEnumerator ShuaiWei_Plus_Jin()
	{
		GotoCastSkill(Skillid_ShuaiWei_Plus_Jin);
		yield return WaitSkillFinish();
		SkillTimes01++;
		SkillTimes02++;
	}

	private IEnumerator ShuaiWei_Plus_Yuan()
	{
		GotoCastSkill(Skillid_ShuaiWei_Plus_Yuan);
		yield return WaitSkillFinish();
		SkillTimes01++;
		SkillTimes02++;
	}

	private IEnumerator DarkBall_Plus()
	{
		GotoCastSkill(Skillid_DarkBall_Plus);
		yield return WaitSkillFinish();
		SkillTimes01++;
		SkillTimes02++;
	}

	private IEnumerator DarkBall()
	{
		GotoCastSkill(Skillid_DarkBall);
		yield return WaitSkillFinish();
		SkillTimes01++;
		SkillTimes02++;
	}

	private IEnumerator TiaoPu()
	{
		GotoCastSkill(Skillid_TiaoPu);
		yield return WaitSkillFinish();
		SkillTimes01++;
		SkillTimes02++;
	}

	private IEnumerator TiaoPu_Plus()
	{
		GotoCastSkill(Skillid_TiaoPu_Plus);
		yield return WaitSkillFinish();
		SkillTimes01++;
		SkillTimes02++;
	}

	private IEnumerator ShadowLaser()
	{
		GotoCastSkill(Skillid_ShadowLaser);
		yield return WaitSkillFinish();
		SwitchPool(1);
		SkillTimes01 = 0;
	}

	private IEnumerator ShadowDash()
	{
		GotoCastSkill(Skillid_ShadowDash);
		yield return WaitSkillFinish();
		SwitchPool(2);
		SkillTimes01 = 0;
		SkillTimes02 = 0;
	}

	private IEnumerator Linger()
	{
		GotoCastSkill(Skillid_Linger);
		yield return WaitSkillFinish();
		SkillTimes02 = 0;
	}
}
