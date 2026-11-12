using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._72015KuiLeiBiaoQiang;

public class Action : MonsterActionBase
{
	private bool _checkPuGongDanDuan;

	private bool _checkFengKuangTouZhi;

	private bool _checkXiShuaSaoJi;

	private bool _battleUnlocked;

	private bool _checkFeiYueLianZhan;

	private bool _checkQiangHua;

	private bool _qiangHuaBuffReported;

	private static readonly FP PostSkillWait = 1;

	private static readonly FP ChaseStopDistance = 2.5f;

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
			new PoolBranchInfo(_actor, 1001, 2, 0.1, 0, active: true, operateIEnumerator: DoFeiYueLianZhan, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => _checkFeiYueLianZhan),
			new PoolBranchInfo(_actor, 1002, 2, 0.1, 0, active: false, operateIEnumerator: DoQiangHua, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => _checkQiangHua)
		};
		AdventureActor actor = _actor;
		FP cd = 0.2;
		FP initCd = 0;
		Func<bool> operationConditionFunc = CanReportQiangHuaBuff;
		OperateDelegate operateIEnumerator = DoReportQiangHuaBuff;
		list2.Add(new PoolBranchInfo(actor, 1006, 2, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		list2.Add(new PoolBranchInfo(_actor, 1003, 1, 0.1, 0, active: true, operateIEnumerator: DoPuGongDanDuan, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => _checkPuGongDanDuan));
		list2.Add(new PoolBranchInfo(_actor, 1004, 1, 0.1, 0, active: true, operateIEnumerator: DoFengKuangTouZhi, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => _checkFengKuangTouZhi));
		list2.Add(new PoolBranchInfo(_actor, 1005, 1, 0.1, 0, active: true, operateIEnumerator: DoXiShuaSaoJi, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => _checkXiShuaSaoJi));
		AdventureActor actor2 = _actor;
		FP cd2 = 0.1;
		FP initCd2 = 0;
		operationConditionFunc = CanChase;
		operateIEnumerator = DoChase;
		list2.Add(new PoolBranchInfo(actor2, 1007, 0, cd2, initCd2, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
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
			case "PuGongDanDuan":
				_checkPuGongDanDuan = true;
				break;
			case "FengKuangTouZhi":
				_checkFengKuangTouZhi = true;
				break;
			case "XiShuaSaoJi":
				_checkXiShuaSaoJi = true;
				break;
			case "FeiYueLianZhan":
				_checkFeiYueLianZhan = true;
				break;
			case "ShiFangQiangHuaJi":
				_checkQiangHua = true;
				break;
			}
		}
	}

	private IEnumerator DoPuGongDanDuan()
	{
		_checkPuGongDanDuan = false;
		SetLogicTagFpValue(_actor, "NeedChase", 1);
		StopMove();
		CastSkill(7201501);
		yield return WaitSkillFinish();
		SetLogicTagFpValue(_actor, "NeedChase", 0);
		yield return WaitTime(PostSkillWait);
	}

	private IEnumerator DoFengKuangTouZhi()
	{
		_checkFengKuangTouZhi = false;
		SetLogicTagFpValue(_actor, "NeedChase", 1);
		StopMove();
		CastSkill(7201502);
		yield return WaitSkillFinish();
		SetLogicTagFpValue(_actor, "NeedChase", 0);
		yield return WaitTime(PostSkillWait);
	}

	private IEnumerator DoXiShuaSaoJi()
	{
		_checkXiShuaSaoJi = false;
		SetLogicTagFpValue(_actor, "NeedChase", 1);
		StopMove();
		CastSkill(7201503);
		yield return WaitSkillFinish();
		SetLogicTagFpValue(_actor, "NeedChase", 0);
		yield return WaitTime(PostSkillWait);
	}

	private void StopMove()
	{
		_actor.StandBy();
	}

	private IEnumerator DoFeiYueLianZhan()
	{
		_checkFeiYueLianZhan = false;
		SetLogicTagFpValue(_actor, "NeedChase", 1);
		StopMove();
		CastSkill(7201504);
		yield return WaitSkillFinish();
		SetLogicTagFpValue(_actor, "NeedChase", 0);
		yield return WaitTime(PostSkillWait);
	}

	private IEnumerator DoQiangHua()
	{
		_checkQiangHua = false;
		SetLogicTagFpValue(_actor, "NeedChase", 1);
		StopMove();
		CastSkill(7201505);
		yield return WaitSkillFinish();
		SetLogicTagFpValue(_actor, "NeedChase", 0);
		yield return WaitTime(PostSkillWait);
	}

	private bool CanReportQiangHuaBuff()
	{
		if (GetBuffNum(_actor, 720140110) <= 0)
		{
			_qiangHuaBuffReported = false;
			return false;
		}
		return !_qiangHuaBuffReported;
	}

	private IEnumerator DoReportQiangHuaBuff()
	{
		_qiangHuaBuffReported = true;
		SendMessageToGroupController(_actor.Id, "BeEnhanced");
		yield break;
	}

	private bool HasPendingCommand()
	{
		if (!_checkPuGongDanDuan && !_checkFengKuangTouZhi && !_checkXiShuaSaoJi && !_checkFeiYueLianZhan)
		{
			return _checkQiangHua;
		}
		return true;
	}

	private bool CanChase()
	{
		if (!_battleUnlocked)
		{
			return false;
		}
		if (HasPendingCommand())
		{
			return false;
		}
		LogicEntity currentPlayer = GetCurrentPlayer();
		if (currentPlayer == null)
		{
			return false;
		}
		return Distance(GetPosition(), GetEntityPosition(currentPlayer)) > ChaseStopDistance;
	}

	private IEnumerator DoChase()
	{
		LogicEntity player = GetCurrentPlayer();
		if (player == null)
		{
			yield break;
		}
		int frameCount = 0;
		TSVector2 entityPosition = GetEntityPosition(player);
		_actor.MoveTo(entityPosition, ChaseStopDistance, enableNavigation: true);
		while (!HasPendingCommand() && Distance(GetPosition(), GetEntityPosition(player)) > ChaseStopDistance)
		{
			frameCount++;
			if (frameCount >= 10)
			{
				frameCount = 0;
				entityPosition = GetEntityPosition(player);
				_actor.MoveTo(entityPosition, ChaseStopDistance, enableNavigation: true);
			}
			yield return null;
		}
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
		_checkPuGongDanDuan = false;
		_checkFengKuangTouZhi = false;
		_checkXiShuaSaoJi = false;
		_checkFeiYueLianZhan = false;
		_checkQiangHua = false;
	}
}
