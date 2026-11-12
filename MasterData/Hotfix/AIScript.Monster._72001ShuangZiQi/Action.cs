using System;
using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._72001ShuangZiQi;

public class Action : MonsterActionBase
{
	private static readonly int Skill_Solider = 7200101;

	private static readonly int Skill_General = 7200104;

	private static readonly int Skill_Artillery = 7200102;

	private static readonly int Skill_Carrier = 7200103;

	private static readonly int Skill_RanSe = 7200105;

	private static readonly int Skill_GanRao = 7200106;

	private static readonly int Skill_Show = 7200107;

	private static readonly int Skill_General_P3 = 7200108;

	private static readonly int Skill_Artillery2 = 7200111;

	private static readonly int Skill_General3 = 7200112;

	private static readonly int Skill_Test = 0;

	private PlayFX playFX_Reduce = new PlayFX();

	private Vector3 HittedFXPosition;

	private bool isRed;

	private bool isAtk;

	private int phase;

	private int lv;

	private bool check_Solider;

	private bool check_General;

	private bool check_Artillery;

	private bool check_Carrier;

	private bool check_RanSe;

	private bool check_GanRao;

	private bool check_Show;

	private bool check_Artillery2;

	private bool check_General3;

	private PlayerAdventureActor mainCtrActor => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	protected override void OnActionEnable()
	{
		HittedFXPosition = new Vector3((float)GetPosition().x, 2f, (float)GetPosition().y);
	}

	protected override void OnActionDisable()
	{
		check_Solider = false;
		check_General = false;
		check_Artillery = false;
		check_Carrier = false;
		check_RanSe = false;
		check_GanRao = false;
		check_Show = false;
		check_Artillery2 = false;
		check_General3 = false;
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.GroupController, active: true, GroupMessageOperate);
		InitListenEvent(MonsterEventType.SelfReceiveDamage, active: true, RecieveDamageFX);
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
		FP cd = 0.1;
		FP initCd = 0;
		Func<bool> operationConditionFunc = Check_Solider;
		OperateDelegate operateIEnumerator = DoCast_Solider;
		list2.Add(new PoolBranchInfo(actor, 1001, 1, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 0.1;
		FP initCd2 = 0;
		operationConditionFunc = Check_General;
		operateIEnumerator = DoCast_General;
		list2.Add(new PoolBranchInfo(actor2, 1002, 1, cd2, initCd2, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 0.1;
		FP initCd3 = 0;
		operationConditionFunc = Check_Artillery;
		operateIEnumerator = DoCast_Artillery;
		list2.Add(new PoolBranchInfo(actor3, 1003, 1, cd3, initCd3, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		FP cd4 = 0.1;
		FP initCd4 = 0;
		operationConditionFunc = Check_Carrier;
		operateIEnumerator = DoCast_Carrier;
		list2.Add(new PoolBranchInfo(actor4, 1004, 1, cd4, initCd4, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor5 = _actor;
		FP cd5 = 0.1;
		FP initCd5 = 0;
		operationConditionFunc = Check_RanSe;
		operateIEnumerator = DoCast_RanSe;
		list2.Add(new PoolBranchInfo(actor5, 1005, 1, cd5, initCd5, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor6 = _actor;
		FP cd6 = 0.1;
		FP initCd6 = 0;
		operationConditionFunc = Check_GanRao;
		operateIEnumerator = DoCast_GanRao;
		list2.Add(new PoolBranchInfo(actor6, 1005, 1, cd6, initCd6, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor7 = _actor;
		FP cd7 = 0.1;
		FP initCd7 = 0;
		operationConditionFunc = Check_Show;
		operateIEnumerator = DoCast_Show;
		list2.Add(new PoolBranchInfo(actor7, 1006, 1, cd7, initCd7, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor8 = _actor;
		FP cd8 = 0.1;
		FP initCd8 = 0;
		operationConditionFunc = Check_Artillery2;
		operateIEnumerator = DoCast_Artillery2;
		list2.Add(new PoolBranchInfo(actor8, 1007, 1, cd8, initCd8, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor9 = _actor;
		FP cd9 = 0.1;
		FP initCd9 = 0;
		operationConditionFunc = Check_General3;
		operateIEnumerator = DoCast_General3;
		list2.Add(new PoolBranchInfo(actor9, 1008, 1, cd9, initCd9, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private void GroupMessageOperate(IEvent evt)
	{
		switch ((evt as AdventureGroupControllerToMonsterMessage).operationType)
		{
		case "WakeUp":
			isRed = GetLogicTagToggleValue(_actor, "Red");
			phase = GetLogicTagFpValue(_actor, "Phase").AsInt();
			lv = GetLogicTagFpValue(_actor, "Level").AsInt();
			break;
		case "Skill_Soldier":
			check_Solider = true;
			break;
		case "Skill_General":
			check_General = true;
			break;
		case "Skill_Artillery":
			check_Artillery = true;
			break;
		case "Skill_Carrier":
			check_Carrier = true;
			break;
		case "Skill_RanSe":
			check_RanSe = true;
			break;
		case "Skill_GanRao":
			check_GanRao = true;
			break;
		case "Skill_Show":
			check_Show = true;
			break;
		case "Skill_Artillery2":
			check_Artillery2 = true;
			break;
		case "Skill_General3":
			check_General3 = true;
			break;
		case "InterruptAllSkill":
			InterruptSkill();
			break;
		}
	}

	private bool Check_Solider()
	{
		return check_Solider;
	}

	private IEnumerator DoCast_Solider()
	{
		GotoCastSkill(Skill_Solider);
		check_Solider = false;
		yield return WaitSkillFinish();
	}

	private bool Check_General()
	{
		return check_General;
	}

	private IEnumerator DoCast_General()
	{
		if (GetLogicTagFpValue(_actor, "Phase") == 3)
		{
			GotoCastSkill(Skill_General_P3);
		}
		else
		{
			GotoCastSkill(Skill_General);
		}
		check_General = false;
		yield return WaitSkillFinish();
	}

	private bool Check_Artillery()
	{
		return check_Artillery;
	}

	private IEnumerator DoCast_Artillery()
	{
		GotoCastSkill(Skill_Artillery);
		check_Artillery = false;
		yield return WaitSkillFinish();
	}

	private bool Check_Carrier()
	{
		return check_Carrier;
	}

	private IEnumerator DoCast_Carrier()
	{
		GotoCastSkill(Skill_Carrier);
		check_Carrier = false;
		yield return WaitSkillFinish();
	}

	private bool Check_RanSe()
	{
		return check_RanSe;
	}

	private IEnumerator DoCast_RanSe()
	{
		GotoCastSkill(Skill_RanSe);
		check_RanSe = false;
		yield return WaitSkillFinish();
	}

	private bool Check_GanRao()
	{
		return check_GanRao;
	}

	private IEnumerator DoCast_GanRao()
	{
		GotoCastSkill(Skill_GanRao);
		check_GanRao = false;
		yield return WaitSkillFinish();
	}

	private bool Check_Show()
	{
		return check_Show;
	}

	private IEnumerator DoCast_Show()
	{
		GotoCastSkill(Skill_Show);
		check_Show = false;
		yield return WaitSkillFinish();
	}

	private bool Check_Artillery2()
	{
		return check_Artillery2;
	}

	private IEnumerator DoCast_Artillery2()
	{
		GotoCastSkill(Skill_Artillery2);
		check_Artillery2 = false;
		yield return WaitSkillFinish();
	}

	private bool Check_General3()
	{
		return check_General3;
	}

	private IEnumerator DoCast_General3()
	{
		GotoCastSkill(Skill_General3);
		check_General3 = false;
		yield return WaitSkillFinish();
	}

	private void GotoCastSkill(int ID)
	{
		if (Skill_Test != 0)
		{
			ID = Skill_Test;
		}
		CastSkill(ID);
	}

	private void RecieveDamageFX(IEvent evt)
	{
		AdventureActor adventureActor = (evt as AdventureActorReceiveDamageEvent).from as AdventureActor;
		if (adventureActor != null && adventureActor == mainCtrActor)
		{
			bool flag = adventureActor.buffComponent.CheckBuffByBuffTag(CommonHelper.StringToHash("RedChess"));
			bool flag2 = adventureActor.buffComponent.CheckBuffByBuffTag(CommonHelper.StringToHash("GreenChess"));
			if (flag && isRed && !flag2)
			{
				playFX_Reduce.Play(_actor, "fx_m72001_base_shield_red", 1f, HittedFXPosition, _actor.transform.rotation);
			}
			else if ((!flag && !isRed) & flag2)
			{
				playFX_Reduce.Play(_actor, "fx_m72002_base_shield_green", 1f, HittedFXPosition, _actor.transform.rotation);
			}
		}
	}
}
