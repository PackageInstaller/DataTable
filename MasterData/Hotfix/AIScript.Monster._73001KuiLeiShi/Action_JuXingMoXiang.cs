using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;

namespace AIScript.Monster._73001KuiLeiShi;

public class Action_JuXingMoXiang : MonsterActionBase
{
	private AdventureActor boss;

	private bool check_Bombard;

	private bool check_LaserSweep;

	private bool check_Appear;

	private bool check_Approach;

	private bool check_JiGuangFangShe;

	private bool check_ShuFuXianJing;

	private bool check_P1_HeXinBaoFa;

	private bool check_P2_CoreLaser;

	private bool check_P2_JuXiangHuiJi;

	private bool check_P2_ZhuNengGuangXian;

	private bool check_P2_ShuFuXianJing;

	private bool check_P2_HeXinBaoFa;

	private bool check_P2_NengLiangQiu;

	private bool check_P2_JiGuangFangShe;

	private bool check_P2_LiPaoHongJi;

	private bool check_P2_ParalyzeCharge;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		int dataID = (int)(long)GetLogicTagFpValue(_actor, Config_JuXingMoXiang.PartnerDataIdTag);
		List<LogicEntity> targetByDataID = GetTargetByDataID(dataID);
		boss = ((targetByDataID.Count > 0) ? (targetByDataID.get_Item(0) as AdventureActor) : null);
		boss?.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnSelfCustomEvent);
		ResetAllChecks();
		EnergyHudShow(isShow: true, _actor.Id, 0, 0);
		CommonUtils_MonsterAPI.SetUnparalleledEnable(_actor);
		CommonUtils_MonsterAPI.SetCloseBlockEnable(_actor);
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		boss?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnSelfCustomEvent);
		boss = null;
		ResetAllChecks();
		CommonUtils_MonsterAPI.SetUnparalleledDisable(_actor);
		CommonUtils_MonsterAPI.SetCloseBlockDisable(_actor);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.GroupController, active: true, GroupMessageOperate);
	}

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.POOL;
		List<PoolBranchesInfo> poolBranches = new List<PoolBranchesInfo>
		{
			new PoolBranchesInfo
			{
				index = 1,
				braches = new List<PoolBranchInfo>
				{
					new PoolBranchInfo(_actor, 1001, 1, 0.1, 0, active: true, operateIEnumerator: DoCast_Bombard, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => check_Bombard),
					new PoolBranchInfo(_actor, 1002, 1, 0.1, 0, active: true, operateIEnumerator: DoCast_LaserSweep, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => check_LaserSweep),
					new PoolBranchInfo(_actor, 1003, 1, 0.1, 0, active: true, operateIEnumerator: DoCast_Appear, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => check_Appear),
					new PoolBranchInfo(_actor, 1004, 1, 0.1, 0, active: true, operateIEnumerator: DoCast_Approach, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => check_Approach),
					new PoolBranchInfo(_actor, 1005, 1, 0.1, 0, active: true, operateIEnumerator: DoCast_JiGuangFangShe, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => check_JiGuangFangShe),
					new PoolBranchInfo(_actor, 1006, 1, 0.1, 0, active: true, operateIEnumerator: DoCast_ShuFuXianJing, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => check_ShuFuXianJing),
					new PoolBranchInfo(_actor, 1010, 1, 0.1, 0, active: true, operateIEnumerator: DoCast_P1_HeXinBaoFa, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => check_P1_HeXinBaoFa),
					new PoolBranchInfo(_actor, 2001, 1, 0.1, 0, active: true, operateIEnumerator: DoCast_P2_CoreLaser, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => check_P2_CoreLaser),
					new PoolBranchInfo(_actor, 2002, 1, 0.1, 0, active: true, operateIEnumerator: DoCast_P2_JuXiangHuiJi, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => check_P2_JuXiangHuiJi),
					new PoolBranchInfo(_actor, 2003, 1, 0.1, 0, active: true, operateIEnumerator: DoCast_P2_ZhuNengGuangXian, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => check_P2_ZhuNengGuangXian),
					new PoolBranchInfo(_actor, 2004, 1, 0.1, 0, active: true, operateIEnumerator: DoCast_P2_ShuFuXianJing, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => check_P2_ShuFuXianJing),
					new PoolBranchInfo(_actor, 2005, 1, 0.1, 0, active: true, operateIEnumerator: DoCast_P2_HeXinBaoFa, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => check_P2_HeXinBaoFa),
					new PoolBranchInfo(_actor, 2006, 1, 0.1, 0, active: true, operateIEnumerator: DoCast_P2_NengLiangQiu, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => check_P2_NengLiangQiu),
					new PoolBranchInfo(_actor, 2007, 1, 0.1, 0, active: true, operateIEnumerator: DoCast_P2_JiGuangFangShe, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => check_P2_JiGuangFangShe),
					new PoolBranchInfo(_actor, 2008, 1, 0.1, 0, active: true, operateIEnumerator: DoCast_P2_LiPaoHongJi, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => check_P2_LiPaoHongJi),
					new PoolBranchInfo(_actor, 2009, 1, 0.1, 0, active: true, operateIEnumerator: DoCast_P2_ParalyzeCharge, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => check_P2_ParalyzeCharge)
				}
			}
		};
		InitPoolBranches(1, poolBranches);
	}

	private void GroupMessageOperate(IEvent evt)
	{
		switch ((evt as AdventureGroupControllerToMonsterMessage).operationType)
		{
		case "P2_CoreLaser":
			check_P2_CoreLaser = true;
			break;
		case "P2_JuXiangHuiJi":
			check_P2_JuXiangHuiJi = true;
			break;
		case "P2_ZhuNengGuangXian":
			check_P2_ZhuNengGuangXian = true;
			break;
		case "P2_ShuFuXianJing":
			check_P2_ShuFuXianJing = true;
			break;
		case "P2_HeXinBaoFa":
			check_P2_HeXinBaoFa = true;
			break;
		case "P2_NengLiangQiu":
			check_P2_NengLiangQiu = true;
			break;
		case "P2_JiGuangFangShe":
			check_P2_JiGuangFangShe = true;
			break;
		case "P2_LiPaoHongJi":
			check_P2_LiPaoHongJi = true;
			break;
		case "P2_ParalyzeCharge":
			check_P2_ParalyzeCharge = true;
			break;
		case "Bombard":
			check_Bombard = true;
			break;
		case "LaserSweep":
			check_LaserSweep = true;
			break;
		case "Skill_HeXinBaoFa":
			check_P1_HeXinBaoFa = true;
			break;
		case "InterruptAllSkill":
			InterruptSkill();
			_actor.InterruptAttack(force: true);
			break;
		}
	}

	private void OnSelfCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent)
		{
			if (adventureActorCustomEvent.eventHashCode == Config_JuXingMoXiang.evt_JiGuangFangShe)
			{
				check_JiGuangFangShe = true;
			}
			if (adventureActorCustomEvent.eventHashCode == Config_JuXingMoXiang.evt_ShuFuXianJing)
			{
				check_ShuFuXianJing = true;
			}
		}
	}

	private void OnCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent && !(adventureActorCustomEvent.sender as AdventureActor != boss))
		{
			if (adventureActorCustomEvent.eventHashCode == Config_JuXingMoXiang.evt_GiantGolemAppear)
			{
				check_Appear = true;
			}
			if (adventureActorCustomEvent.eventHashCode == Common_73001.evt_GiantGolemApproach)
			{
				check_Approach = true;
			}
			if (adventureActorCustomEvent.eventHashCode == Config_JuXingMoXiang.evt_JiGuangFangShe)
			{
				check_JiGuangFangShe = true;
			}
			if (adventureActorCustomEvent.eventHashCode == Config_JuXingMoXiang.evt_ShuFuXianJing)
			{
				check_ShuFuXianJing = true;
			}
		}
	}

	private void ResetAllChecks()
	{
		check_Bombard = false;
		check_LaserSweep = false;
		check_Appear = false;
		check_Approach = false;
		check_JiGuangFangShe = false;
		check_ShuFuXianJing = false;
		check_P1_HeXinBaoFa = false;
		check_P2_CoreLaser = false;
		check_P2_JuXiangHuiJi = false;
		check_P2_ZhuNengGuangXian = false;
		check_P2_ShuFuXianJing = false;
		check_P2_HeXinBaoFa = false;
		check_P2_NengLiangQiu = false;
		check_P2_JiGuangFangShe = false;
		check_P2_LiPaoHongJi = false;
		check_P2_ParalyzeCharge = false;
	}

	private IEnumerator DoCast_P1_HeXinBaoFa()
	{
		check_P1_HeXinBaoFa = false;
		CastSkill(7201216);
		SetLogicTagFpValue(_actor, Config_JuXingMoXiang.EnergyTag, 0);
		if (boss != null)
		{
			BossEnergyValueChage(0, boss);
		}
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Config_JuXingMoXiang.Skill_HeXinBaoFa_Finish, value: true);
	}

	private IEnumerator DoCast_Bombard()
	{
		check_Bombard = false;
		CastSkill(7201213);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Common_73001.Skill_GiantGolemBombard_Finish, value: true);
	}

	private IEnumerator DoCast_LaserSweep()
	{
		check_LaserSweep = false;
		CastSkill(7201214);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Common_73001.Skill_GiantGolemLaserSweep_Finish, value: true);
	}

	private IEnumerator DoCast_Appear()
	{
		check_Appear = false;
		CastSkill(7201217);
		yield return WaitSkillFinish();
	}

	private IEnumerator DoCast_Approach()
	{
		check_Approach = false;
		CastSkill(7201218);
		yield return WaitSkillFinish();
	}

	private IEnumerator DoCast_JiGuangFangShe()
	{
		check_JiGuangFangShe = false;
		CastSkill(7201204);
		yield return WaitSkillFinish();
	}

	private IEnumerator DoCast_ShuFuXianJing()
	{
		check_ShuFuXianJing = false;
		CastSkill(7201205);
		yield return WaitSkillFinish();
	}

	private IEnumerator DoCast_P2_CoreLaser()
	{
		check_P2_CoreLaser = false;
		CastSkill(7201202);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Config_JuXingMoXiang.Skill_CoreLaser_Finish, value: true);
	}

	private IEnumerator DoCast_P2_JuXiangHuiJi()
	{
		check_P2_JuXiangHuiJi = false;
		CastSkill(7201201);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Config_JuXingMoXiang.Skill_JuXiangHuiJi_Finish, value: true);
	}

	private IEnumerator DoCast_P2_ZhuNengGuangXian()
	{
		check_P2_ZhuNengGuangXian = false;
		CastSkill(7201207);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Config_JuXingMoXiang.Skill_ZhuNengGuangXian_Phase2_Finish, value: true);
	}

	private IEnumerator DoCast_P2_ShuFuXianJing()
	{
		check_P2_ShuFuXianJing = false;
		CastSkill(7201205);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Config_JuXingMoXiang.Skill_ShuFuXianJing_Finish, value: true);
	}

	private IEnumerator DoCast_P2_HeXinBaoFa()
	{
		check_P2_HeXinBaoFa = false;
		CastSkill(7201206);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Config_JuXingMoXiang.Skill_HeXinBaoFa_Phase2_Finish, value: true);
	}

	private IEnumerator DoCast_P2_NengLiangQiu()
	{
		check_P2_NengLiangQiu = false;
		CastSkill(7201208);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Config_JuXingMoXiang.Skill_NengLiangQiu_Phase2_Finish, value: true);
	}

	private IEnumerator DoCast_P2_JiGuangFangShe()
	{
		check_P2_JiGuangFangShe = false;
		CastSkill(7201204);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Config_JuXingMoXiang.Skill_JiGuangFangShe_Finish, value: true);
	}

	private IEnumerator DoCast_P2_LiPaoHongJi()
	{
		check_P2_LiPaoHongJi = false;
		CastSkill(7201203);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Config_JuXingMoXiang.Skill_LiPaoHongJi_Phase2_Finish, value: true);
	}

	private IEnumerator DoCast_P2_ParalyzeCharge()
	{
		check_P2_ParalyzeCharge = false;
		CastSkill(7201209);
		yield return WaitSkillFinish();
		SetLogicTagToggleValue(_actor, Config_JuXingMoXiang.Skill_ParalyzeCharge_Finish, value: true);
	}
}
