using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._72016KuiLeiJuNu;

public class Action : MonsterActionBase
{
	private bool _checkPuTongSheJi;

	private bool _checkXianJing_BaoZha;

	private bool _checkXianJing_ChanRao;

	private bool _battleUnlocked;

	private bool _checkSiXianLianShe;

	private static readonly FP AutoAttackRange = 11;

	private static readonly FP ChaseStopDistance = 11;

	private static readonly FP RetreatTriggerDistance = 8;

	private static readonly FP RetreatTargetDistance = 11;

	private static readonly FP RetreatTimeout = 2;

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
		FP cd = 8;
		FP initCd = 0;
		Func<bool> operationConditionFunc = CanShanShuo;
		OperateDelegate operateIEnumerator = DoShanShuo;
		list2.Add(new PoolBranchInfo(actor, 1001, 5, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		list2.Add(new PoolBranchInfo(_actor, 1002, 3, 0.1, 0, active: true, operateIEnumerator: DoSiXianLianShe, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => _checkSiXianLianShe));
		list2.Add(new PoolBranchInfo(_actor, 1004, 1, 0.1, 0, active: true, operateIEnumerator: DoXiShuaXianJing_BaoZha, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => _checkXianJing_BaoZha));
		list2.Add(new PoolBranchInfo(_actor, 1005, 1, 0.1, 0, active: true, operateIEnumerator: DoXiShuaXianJing_ChanRao, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => _checkXianJing_ChanRao));
		list2.Add(new PoolBranchInfo(_actor, 1006, 1, 0.1, 0, active: true, operateIEnumerator: DoPuTongSheJi, releaseDistance: default, releaseAngle: default, traceDuration: default, operationConditionFunc: () => _checkPuTongSheJi));
		AdventureActor actor2 = _actor;
		FP cd2 = 4;
		FP initCd2 = 0;
		operationConditionFunc = CanAutoAttack;
		operateIEnumerator = DoAutoAttack;
		list2.Add(new PoolBranchInfo(actor2, 1007, 1, cd2, initCd2, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 0.1;
		FP initCd3 = 0;
		operationConditionFunc = CanChase;
		operateIEnumerator = DoChase;
		list2.Add(new PoolBranchInfo(actor3, 1008, 0, cd3, initCd3, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
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
			case "PuTongSheJi":
				_checkPuTongSheJi = true;
				break;
			case "XiShuaXianJing_BaoZha":
				_checkXianJing_BaoZha = true;
				break;
			case "XiShuaXianJing_ChanRao":
				_checkXianJing_ChanRao = true;
				break;
			case "SiXianLianShe":
				_checkSiXianLianShe = true;
				break;
			}
		}
	}

	private IEnumerator DoPuTongSheJi()
	{
		_checkPuTongSheJi = false;
		yield return StartCor(RetreatIfTooClose());
		SetLogicTagFpValue(_actor, "NeedChase", 1);
		StopMove();
		CastSkill(7201601);
		yield return WaitSkillFinish();
		SetLogicTagFpValue(_actor, "NeedChase", 0);
		yield return DoZhuangTian();
	}

	private bool CanAutoAttack()
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
		return Distance(GetPosition(), GetEntityPosition(currentPlayer)) <= AutoAttackRange;
	}

	private IEnumerator DoAutoAttack()
	{
		yield return StartCor(RetreatIfTooClose());
		SetLogicTagFpValue(_actor, "NeedChase", 1);
		StopMove();
		CastSkill(7201601);
		yield return WaitSkillFinish();
		SetLogicTagFpValue(_actor, "NeedChase", 0);
		yield return DoZhuangTian();
	}

	private IEnumerator DoXiShuaXianJing_BaoZha()
	{
		_checkXianJing_BaoZha = false;
		yield return StartCor(RetreatIfTooClose());
		SetLogicTagFpValue(_actor, "NeedChase", 1);
		StopMove();
		if (HasQiangHuaBuff())
		{
			SetLogicTagFpValue(_actor, "QiangHuaTrapType", 0);
			CastSkill(7201607);
		}
		else
		{
			CastSkill(7201608);
		}
		yield return WaitSkillFinish();
		SetLogicTagFpValue(_actor, "NeedChase", 0);
		yield return DoZhuangTian();
	}

	private bool HasQiangHuaBuff()
	{
		return GetBuffNum(_actor, 720140120) > 0;
	}

	private IEnumerator DoXiShuaXianJing_ChanRao()
	{
		_checkXianJing_ChanRao = false;
		yield return StartCor(RetreatIfTooClose());
		SetLogicTagFpValue(_actor, "NeedChase", 1);
		StopMove();
		if (HasQiangHuaBuff())
		{
			SetLogicTagFpValue(_actor, "QiangHuaTrapType", 1);
			CastSkill(7201607);
		}
		else
		{
			CastSkill(7201603);
		}
		yield return WaitSkillFinish();
		SetLogicTagFpValue(_actor, "NeedChase", 0);
		yield return DoZhuangTian();
	}

	private CoroutineNode DoZhuangTian()
	{
		StopMove();
		CastSkill(7201604);
		return WaitSkillFinish();
	}

	private bool CanShanShuo()
	{
		if (!_battleUnlocked)
		{
			return false;
		}
		LogicEntity currentPlayer = GetCurrentPlayer();
		if (currentPlayer == null)
		{
			return false;
		}
		return Distance(GetPosition(), GetEntityPosition(currentPlayer)) <= 2.5f;
	}

	private IEnumerator DoShanShuo()
	{
		StopMove();
		CastSkill(7201605);
		yield return WaitSkillFinish();
	}

	private IEnumerator DoSiXianLianShe()
	{
		_checkSiXianLianShe = false;
		yield return StartCor(RetreatIfTooClose());
		SetLogicTagFpValue(_actor, "NeedChase", 1);
		StopMove();
		CastSkill(7201606);
		yield return WaitSkillFinish();
		SetLogicTagFpValue(_actor, "NeedChase", 0);
		yield return DoZhuangTian();
	}

	private bool HasPendingCommand()
	{
		if (!_checkPuTongSheJi && !_checkXianJing_BaoZha && !_checkXianJing_ChanRao)
		{
			return _checkSiXianLianShe;
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

	private IEnumerator RetreatIfTooClose()
	{
		LogicEntity player = GetCurrentPlayer();
		if (player == null || Distance(GetPosition(), GetEntityPosition(player)) >= RetreatTriggerDistance)
		{
			yield break;
		}
		int frameCount = 0;
		FP elapsed = 0;
		while (Distance(GetPosition(), GetEntityPosition(player)) < RetreatTargetDistance && !(elapsed >= RetreatTimeout))
		{
			frameCount++;
			if (frameCount >= 10)
			{
				frameCount = 0;
				TSVector2 position = GetPosition();
				TSVector2 entityPosition = GetEntityPosition(player);
				TSVector2 normalized = (entityPosition - position).normalized;
				TSVector2 targetPosition = entityPosition - normalized * RetreatTargetDistance;
				_actor.MoveTo(targetPosition, 0, enableNavigation: true);
			}
			yield return null;
			elapsed += (FP)0.016f;
		}
		StopMove();
	}

	private void StopMove()
	{
		_actor.StandBy();
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
		_checkPuTongSheJi = false;
		_checkXianJing_BaoZha = false;
		_checkXianJing_ChanRao = false;
		_checkSiXianLianShe = false;
	}
}
