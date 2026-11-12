using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._72014KuiLeiShiTi;

public class Action : MonsterActionBase
{
	private bool _checkQiangHuaJuNu;

	private bool _checkQiangHuaBiaoQiang;

	private bool _checkQuanTiQiangHua;

	private bool _battleUnlocked;

	private const float PAI_DI_RANGE = 8f;

	private const float PAI_DI_CD = 10f;

	private static readonly FP PostSkillWait = 1;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.POOL;
		List<PoolBranchesInfo> list = new List<PoolBranchesInfo>();
		PoolBranchesInfo poolBranchesInfo = new PoolBranchesInfo
		{
			index = 1
		};
		List<PoolBranchInfo> list2 = new List<PoolBranchInfo>
		{
			new PoolBranchInfo(_actor, 1001, 2, 0.1, 0, active: true, operateIEnumerator: DoQiangHuaJuNu, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => _checkQiangHuaJuNu),
			new PoolBranchInfo(_actor, 1002, 2, 0.1, 0, active: true, operateIEnumerator: DoQiangHuaBiaoQiang, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => _checkQiangHuaBiaoQiang),
			new PoolBranchInfo(_actor, 1003, 2, 0.1, 0, active: true, operateIEnumerator: DoQuanTiQiangHua, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => _checkQuanTiQiangHua)
		};
		AdventureActor actor = _actor;
		FP cd = 10f;
		FP initCd = 0;
		Func<bool> operationConditionFunc = CanPaiDi;
		OperateDelegate operateIEnumerator = DoPaiDi;
		list2.Add(new PoolBranchInfo(actor, 1004, 1, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.GroupController, active: true, GroupMessageOperate);
	}

	private void GroupMessageOperate(IEvent evt)
	{
		if (evt is AdventureGroupControllerToMonsterMessage adventureGroupControllerToMonsterMessage)
		{
			switch (adventureGroupControllerToMonsterMessage.operationType)
			{
			case "BattleStart":
				_battleUnlocked = true;
				break;
			case "QiangHua_JuNu":
				_checkQiangHuaJuNu = true;
				break;
			case "QiangHua_BiaoQiang":
				_checkQiangHuaBiaoQiang = true;
				break;
			case "QuanTiQiangHua":
				_checkQuanTiQiangHua = true;
				break;
			}
		}
	}

	private bool CanPaiDi()
	{
		if (!_battleUnlocked)
		{
			return false;
		}
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		if (logicEntity == null)
		{
			return false;
		}
		return Distance(GetPosition(), GetEntityPosition(logicEntity)) < 8f;
	}

	private IEnumerator DoQiangHuaJuNu()
	{
		_checkQiangHuaJuNu = false;
		CastSkill(7201383);
		yield return WaitSkillFinish();
	}

	private IEnumerator DoQiangHuaBiaoQiang()
	{
		_checkQiangHuaBiaoQiang = false;
		CastSkill(7201382);
		yield return WaitSkillFinish();
	}

	private IEnumerator DoQuanTiQiangHua()
	{
		_checkQuanTiQiangHua = false;
		CastSkill(7201384);
		yield return WaitSkillFinish();
	}

	private IEnumerator DoPaiDi()
	{
		CastSkill(7201381);
		yield return WaitSkillFinish();
		yield return WaitTime(PostSkillWait);
	}

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		ResetCheck();
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		ResetCheck();
	}

	private void ResetCheck()
	{
		_checkQiangHuaJuNu = false;
		_checkQiangHuaBiaoQiang = false;
		_checkQuanTiQiangHua = false;
	}
}
