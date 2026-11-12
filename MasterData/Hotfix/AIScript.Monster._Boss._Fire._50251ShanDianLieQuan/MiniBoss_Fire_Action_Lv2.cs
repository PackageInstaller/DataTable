using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Boss._Fire._50251ShanDianLieQuan;

public class MiniBoss_Fire_Action_Lv2 : MonsterActionBase
{
	private readonly int Skillid_ShuaiWei = 5025120;

	private readonly int Skillid_ShuaiWei_Plus_Jin = 5025121;

	private readonly int Skillid_ShuaiWei_Plus_Yuan = 5025122;

	private readonly int Skillid_HuoQiu = 5025123;

	private readonly int Skillid_HuoQiu_Plus = 5025124;

	private readonly int Skillid_TiaoPu = 5025125;

	private readonly int Skillid_TiaoPu_Plus = 5025126;

	private readonly int Skillid_PenSheHuoYan = 5025127;

	private readonly int Skillid_DiMianPenFa = 5025128;

	private readonly int Skillid_Linger = 5025198;

	private readonly int Skillid_Scared = 5025130;

	private int SkillTimes01;

	private int SkillTimes02;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		SetLogicTagFpValue(_actor, "BattleStage", 1);
		SkillTimes01 = 0;
		SkillTimes02 = 0;
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
		FP cd = 10;
		FP initCd = 0;
		Func<bool> operationConditionFunc = Condition05;
		OperateDelegate operateIEnumerator = Scared;
		list2.Add(new PoolBranchInfo(actor, 1006, 999, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 40;
		FP initCd2 = 0;
		operationConditionFunc = Condition03;
		operateIEnumerator = DiMianPenFa;
		list2.Add(new PoolBranchInfo(actor2, 1001, 100, cd2, initCd2, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 10;
		FP initCd3 = 0;
		FP releaseDistance = 4;
		FP releaseAngle = 360;
		operateIEnumerator = ShuaiWei;
		list2.Add(new PoolBranchInfo(actor3, 1002, 90, cd3, initCd3, active: true, releaseDistance, releaseAngle, default, null, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		FP cd4 = 12;
		FP initCd4 = 0;
		FP releaseDistance2 = 100;
		FP releaseAngle2 = 360;
		operateIEnumerator = HuoQiu;
		list2.Add(new PoolBranchInfo(actor4, 1003, 80, cd4, initCd4, active: true, releaseDistance2, releaseAngle2, default, null, null, operateIEnumerator));
		AdventureActor actor5 = _actor;
		FP cd5 = 10;
		FP initCd5 = 0;
		FP releaseDistance3 = 15;
		FP releaseAngle3 = 360;
		operateIEnumerator = TiaoPu;
		list2.Add(new PoolBranchInfo(actor5, 1004, 70, cd5, initCd5, active: true, releaseDistance3, releaseAngle3, default, null, null, operateIEnumerator));
		AdventureActor actor6 = _actor;
		FP cd6 = 5;
		FP initCd6 = 0;
		FP releaseDistance4 = 100;
		FP releaseAngle4 = 360;
		operateIEnumerator = Linger;
		list2.Add(new PoolBranchInfo(actor6, 1005, 50, cd6, initCd6, active: true, releaseDistance4, releaseAngle4, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		PoolBranchesInfo poolBranchesInfo2 = new PoolBranchesInfo
		{
			index = 2
		};
		List<PoolBranchInfo> list3 = new List<PoolBranchInfo>();
		AdventureActor actor7 = _actor;
		FP cd7 = 10;
		FP initCd7 = 0;
		operationConditionFunc = Condition05;
		operateIEnumerator = Scared;
		list3.Add(new PoolBranchInfo(actor7, 2008, 1000, cd7, initCd7, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor8 = _actor;
		FP cd8 = 80;
		FP initCd8 = 0;
		operationConditionFunc = Condition02;
		operateIEnumerator = PenSheHuoYan;
		list3.Add(new PoolBranchInfo(actor8, 2001, 999, cd8, initCd8, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor9 = _actor;
		FP cd9 = 2;
		FP initCd9 = 0;
		operationConditionFunc = Condition04;
		operateIEnumerator = Linger;
		list3.Add(new PoolBranchInfo(actor9, 2002, 200, cd9, initCd9, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor10 = _actor;
		FP cd10 = 15;
		FP initCd10 = 0;
		operationConditionFunc = Condition01;
		operateIEnumerator = ShuaiWei_Plus_Yuan;
		list3.Add(new PoolBranchInfo(actor10, 2003, 100, cd10, initCd10, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor11 = _actor;
		FP cd11 = 18;
		FP initCd11 = 0;
		FP releaseDistance5 = 100;
		FP releaseAngle5 = 360;
		operateIEnumerator = HuoQiu_Plus;
		list3.Add(new PoolBranchInfo(actor11, 2004, 90, cd11, initCd11, active: true, releaseDistance5, releaseAngle5, default, null, null, operateIEnumerator));
		AdventureActor actor12 = _actor;
		FP cd12 = 20;
		FP initCd12 = 0;
		FP releaseDistance6 = 100;
		FP releaseAngle6 = 360;
		operateIEnumerator = TiaoPu_Plus;
		list3.Add(new PoolBranchInfo(actor12, 2005, 80, cd12, initCd12, active: true, releaseDistance6, releaseAngle6, default, null, null, operateIEnumerator));
		AdventureActor actor13 = _actor;
		FP cd13 = 10;
		FP initCd13 = 0;
		FP releaseDistance7 = 4;
		FP releaseAngle7 = 360;
		operateIEnumerator = ShuaiWei_Plus_Jin;
		list3.Add(new PoolBranchInfo(actor13, 2006, 70, cd13, initCd13, active: true, releaseDistance7, releaseAngle7, default, null, null, operateIEnumerator));
		AdventureActor actor14 = _actor;
		FP cd14 = 10;
		FP initCd14 = 5;
		FP releaseDistance8 = 100;
		FP releaseAngle8 = 360;
		operateIEnumerator = Linger;
		list3.Add(new PoolBranchInfo(actor14, 2007, 10, cd14, initCd14, active: true, releaseDistance8, releaseAngle8, default, null, null, operateIEnumerator));
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
		RemoveBuffFromTarget(_actor, 502510007);
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
		if (SkillTimes02 >= 2)
		{
			return true;
		}
		return false;
	}

	private bool Condition05()
	{
		if (GetBuffNum(_actor, 502510008) >= 1)
		{
			return true;
		}
		return false;
	}

	private void GotoCastskill(int id)
	{
		CastSkill(id);
	}

	private IEnumerator ShuaiWei()
	{
		GotoCastskill(Skillid_ShuaiWei);
		yield return WaitSkillFinish();
		SkillTimes01++;
		SkillTimes02++;
	}

	private IEnumerator ShuaiWei_Plus_Jin()
	{
		GotoCastskill(Skillid_ShuaiWei_Plus_Jin);
		yield return WaitSkillFinish();
		SkillTimes01++;
		SkillTimes02++;
	}

	private IEnumerator ShuaiWei_Plus_Yuan()
	{
		GotoCastskill(Skillid_ShuaiWei_Plus_Yuan);
		yield return WaitSkillFinish();
		SkillTimes01++;
		SkillTimes02++;
	}

	private IEnumerator HuoQiu_Plus()
	{
		GotoCastskill(Skillid_HuoQiu_Plus);
		yield return WaitSkillFinish();
		SkillTimes01++;
		SkillTimes02++;
	}

	private IEnumerator HuoQiu()
	{
		GotoCastskill(Skillid_HuoQiu);
		yield return WaitSkillFinish();
		SkillTimes01++;
		SkillTimes02++;
	}

	private IEnumerator TiaoPu()
	{
		GotoCastskill(Skillid_TiaoPu);
		yield return WaitSkillFinish();
		SkillTimes01++;
		SkillTimes02++;
	}

	private IEnumerator TiaoPu_Plus()
	{
		GotoCastskill(Skillid_TiaoPu_Plus);
		yield return WaitSkillFinish();
		SkillTimes01++;
		SkillTimes02++;
	}

	private IEnumerator PenSheHuoYan()
	{
		GotoCastskill(Skillid_PenSheHuoYan);
		yield return WaitSkillFinish();
		SwitchPool(1);
		SkillTimes01 = 0;
	}

	private IEnumerator DiMianPenFa()
	{
		GotoCastskill(Skillid_DiMianPenFa);
		yield return WaitSkillFinish();
		SwitchPool(2);
		SkillTimes01 = 0;
		SkillTimes02 = 0;
	}

	private IEnumerator Linger()
	{
		GotoCastskill(Skillid_Linger);
		yield return WaitSkillFinish();
		SkillTimes02 = 0;
	}

	private IEnumerator Scared()
	{
		GotoCastskill(Skillid_Scared);
		yield return WaitSkillFinish();
	}
}
