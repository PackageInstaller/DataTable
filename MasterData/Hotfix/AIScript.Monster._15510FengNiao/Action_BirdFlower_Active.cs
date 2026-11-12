using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._15510FengNiao;

public class Action_BirdFlower_Active : MonsterActionBase
{
	private static readonly int Skill_UltraBomb = 1551054;

	private static readonly int Skill_Shoot = 1551052;

	private static readonly int Skill_Sleep = 1551053;

	private static readonly int Skill_WakeUp = 1551055;

	private static readonly int Skill_WakeUpBomb = 1551056;

	private static readonly int Skill_Bomb = 1551057;

	private static readonly int Skill_Test = 0;

	private static readonly FP HPCostPerTime = 0.008;

	private static readonly FP HPResumePerTime = 0.03;

	private static readonly FP PerTime = 0.1;

	private bool IsActive;

	private FP DirectDamageValue;

	private FP LightDistance;

	private bool IsMasterFastRecover;

	private LogicEntity MasterBird;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.POOL;
		SetLogicTagToggleValue(_actor, "Shoot", value: false);
		SetLogicTagToggleValue(_actor, "ActiveHurt", value: true);
		SetLogicTagToggleValue(_actor, "Awaken", value: true);
		IsActive = true;
		DirectDamageValue = 0;
		List<PoolBranchesInfo> list = new List<PoolBranchesInfo>();
		PoolBranchesInfo poolBranchesInfo = new PoolBranchesInfo
		{
			index = 1
		};
		List<PoolBranchInfo> list2 = new List<PoolBranchInfo>();
		AdventureActor actor = _actor;
		FP cd = 0;
		FP initCd = 0;
		OperateDelegate operateIEnumerator = InitialCast;
		list2.Add(new PoolBranchInfo(actor, 1000, 999, cd, initCd, active: true, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 1;
		FP initCd2 = 0;
		Func<bool> operationConditionFunc = CheckBomb;
		operateIEnumerator = BombCast;
		list2.Add(new PoolBranchInfo(actor2, 1001, 200, cd2, initCd2, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 1;
		FP initCd3 = 0;
		operationConditionFunc = CheckShoot;
		operateIEnumerator = ShootCast;
		list2.Add(new PoolBranchInfo(actor3, 1002, 100, cd3, initCd3, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		FP cd4 = 1;
		FP initCd4 = 0;
		operateIEnumerator = SleepCast;
		list2.Add(new PoolBranchInfo(actor4, 1003, 500, cd4, initCd4, active: false, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor5 = _actor;
		FP cd5 = 1;
		FP initCd5 = 0;
		operateIEnumerator = WakeUpCast;
		list2.Add(new PoolBranchInfo(actor5, 1004, 500, cd5, initCd5, active: false, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor6 = _actor;
		FP cd6 = 1;
		FP initCd6 = 0;
		operateIEnumerator = WakeUpBombCast;
		list2.Add(new PoolBranchInfo(actor6, 1005, 500, cd6, initCd6, active: false, default, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfHpChanged, active: true, PhaseChange);
	}

	private IEnumerator InitialCast()
	{
		IsMasterFastRecover = false;
		StartCoroutine(HPOperate());
		StartCoroutine(CheckMasterFastRecover());
		while (GetTargetByTeammateIndex(0).Count == 0)
		{
			yield return null;
		}
		MasterBird = GetTargetByTeammateIndex(0).get_Item(0);
		SetLogicTagFpValue(_actor, "Difficulty", GetLogicTagFpValue(MasterBird, "Difficulty"));
		SetPoolBranchActive(1000, active: false);
	}

	private IEnumerator BombCast()
	{
		if (GetLogicTagToggleValue(MasterBird, "FlowerAwakening"))
		{
			GotoCastSkill(Skill_Bomb);
		}
		else
		{
			GotoCastSkill(Skill_UltraBomb);
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator ShootCast()
	{
		GotoCastSkill(Skill_Shoot);
		yield return WaitSkillFinish();
	}

	private IEnumerator SleepCast()
	{
		GotoCastSkill(Skill_Sleep);
		yield return WaitSkillFinish();
		SetPoolBranchActive(1003, active: false);
		SetPoolBranchActive(1001, active: false);
	}

	private IEnumerator WakeUpCast()
	{
		GotoCastSkill(Skill_WakeUp);
		yield return WaitSkillFinish();
		SetPoolBranchActive(1004, active: false);
		SetPoolBranchActive(1001, active: true);
	}

	private IEnumerator WakeUpBombCast()
	{
		GotoCastSkill(Skill_WakeUpBomb);
		yield return WaitSkillFinish();
		SetPoolBranchActive(1005, active: false);
		SetPoolBranchActive(1001, active: true);
	}

	private void PhaseChange(IEvent evt)
	{
		if (_actor.actorHealthInfo.hp <= 1 && IsActive)
		{
			InterruptSkill();
			SetBattleOutEnable(autoDisableWhenSkillDisable: false);
			SetPoolBranchActive(1003, active: true);
			IsActive = false;
		}
		else if ((FP)_actor.actorHealthInfo.hpPercentage >= 1 && !IsActive)
		{
			InterruptSkill();
			SetBattleOutDisable();
			if (!GetLogicTagToggleValue(MasterBird, "FlowerAwakening") && !GetLogicTagToggleValue(MasterBird, "UltraSkilling"))
			{
				SetPoolBranchActive(1004, active: true);
			}
			else
			{
				SetPoolBranchActive(1005, active: true);
			}
			IsActive = true;
		}
	}

	private void GotoCastSkill(int ID)
	{
		if (Skill_Test != 0)
		{
			ID = Skill_Test;
		}
		CastSkill(ID);
	}

	private bool CheckShoot()
	{
		if (GetLogicTagToggleValue(_actor, "Shoot") && IsActive)
		{
			return true;
		}
		return false;
	}

	private bool CheckBomb()
	{
		if (IsActive && Distance(GetEntityPositionObsoleted(MasterBird), GetPosition()) <= GetLogicTagFpValue(MasterBird, "LightDistance") && (GetLogicTagToggleValue(MasterBird, "FlowerAwakening") || GetLogicTagToggleValue(MasterBird, "UltraSkilling")))
		{
			return true;
		}
		return false;
	}

	private IEnumerator HPOperate()
	{
		while (true)
		{
			LightDistance = GetLogicTagFpValue(MasterBird, "LightDistance");
			FP fP = Distance(GetEntityPositionObsoleted(MasterBird), GetPosition());
			if (IsActive)
			{
				if (fP <= LightDistance)
				{
					if (IsMasterFastRecover)
					{
						DirectDamageValue = _actor.actorHealthInfo.hpMax * -1;
					}
					else
					{
						DirectDamageValue = _actor.actorHealthInfo.hpMax * HPResumePerTime * -1;
					}
				}
				else if (GetLogicTagToggleValue(_actor, "ActiveHurt"))
				{
					DirectDamageValue = _actor.actorHealthInfo.hpMax * HPCostPerTime;
				}
			}
			else if (GetLogicTagToggleValue(MasterBird, "InFlowerAwakenSkill"))
			{
				if (fP <= LightDistance && IsMasterFastRecover)
				{
					DirectDamageValue = _actor.actorHealthInfo.hpMax * -1;
				}
				else
				{
					DirectDamageValue = 0;
				}
			}
			else
			{
				DirectDamageValue = 0;
			}
			if (IsMasterFastRecover)
			{
				IsMasterFastRecover = false;
			}
			if (DirectDamageValue > 0)
			{
				DirectDamage(_actor, (int)(long)DirectDamageValue, null, showHud: false);
			}
			else if (DirectDamageValue < 0)
			{
				DirectHeal(_actor, (int)(long)(-DirectDamageValue));
			}
			yield return WaitTime(PerTime);
		}
	}

	private IEnumerator CheckMasterFastRecover()
	{
		while (true)
		{
			if (!IsMasterFastRecover && GetLogicTagToggleValue(MasterBird, "FastRecoverFlower"))
			{
				IsMasterFastRecover = true;
				while (GetLogicTagToggleValue(MasterBird, "FastRecoverFlower"))
				{
					yield return null;
				}
				IsMasterFastRecover = false;
			}
			yield return null;
		}
	}
}
