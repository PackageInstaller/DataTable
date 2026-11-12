using System;
using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._31601JiYiSuiPian_Guang;

public class Action : MonsterActionBase
{
	private static readonly FP LifeTime = 5;

	private static readonly FP EatRadius = 2;

	private static readonly FP CheckInterval = 0.03f;

	private static readonly int EatenBuffId = 316010100;

	private readonly string fx_born = "fx_StoryActivity_16_base_white_ring";

	private static readonly FP fx_bornPositionY = 0;

	public const string EatenTag = "JiYiSuiPian_Eaten";

	private bool _eaten;

	private bool _timeEnd;

	private bool _dieTriggered;

	private CoroutineNode _timerCor;

	private CoroutineNode _checkCor;

	private PlayFX _bornFx;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.POOL;
		_thinkInterval = CheckInterval;
		_delayStartTime = 0;
		List<PoolBranchesInfo> list = new List<PoolBranchesInfo>();
		PoolBranchesInfo poolBranchesInfo = new PoolBranchesInfo
		{
			index = 1
		};
		List<PoolBranchInfo> list2 = new List<PoolBranchInfo>();
		AdventureActor actor = _actor;
		FP cd = 0;
		FP initCd = 0;
		Func<bool> operationConditionFunc = Condition_Die;
		OperateDelegate operateIEnumerator = DoDie;
		list2.Add(new PoolBranchInfo(actor, 1001, 999, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		PlayBornFx();
		_eaten = false;
		_timeEnd = false;
		_dieTriggered = false;
		SetLogicTagToggleValue(_actor, "JiYiSuiPian_Eaten", value: false);
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetSearchedImmunityEnable(autoDisableWhenSkillDisable: false);
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
		_actor.ignoreDeterministicCollision = true;
		StartCor(ref _timerCor, Timer());
		StartCor(ref _checkCor, CheckPlayer());
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		StopCor(ref _timerCor);
		StopCor(ref _checkCor);
		StopBornFx();
	}

	protected override void SetListenEvents()
	{
	}

	private void PlayBornFx()
	{
		if (!string.IsNullOrEmpty(fx_born))
		{
			ILRuntimeAPI.PlayFX(ref _bornFx, _actor, null, fx_born, fx_bornPositionY, GetPosition(), TSVector2.zero);
		}
	}

	private void StopBornFx()
	{
		if (_bornFx != null)
		{
			if (_bornFx.isPlaying)
			{
				_bornFx.Stop(dontPlaySubFX: true);
			}
			_bornFx.Clear();
		}
	}

	private IEnumerator Timer()
	{
		for (FP timeCount = FP.Zero; timeCount < LifeTime; timeCount += _actor.LogicDeltaTime)
		{
			yield return null;
		}
		_timeEnd = true;
	}

	private IEnumerator CheckPlayer()
	{
		while (_actor.state == ActorState.Spawn)
		{
			yield return null;
		}
		while (!_eaten && !_timeEnd)
		{
			LogicEntity currentPlayer = GetCurrentPlayer();
			if (CheckTargetIsValid(currentPlayer) && Distance(GetPosition(), GetEntityPosition(currentPlayer)) <= EatRadius)
			{
				AddBuffToTarget(currentPlayer, EatenBuffId);
				SetLogicTagToggleValue(_actor, "JiYiSuiPian_Eaten", value: true);
				_eaten = true;
				StopBornFx();
				break;
			}
			yield return WaitTime(CheckInterval);
		}
	}

	private bool Condition_Die()
	{
		if (_eaten || _timeEnd)
		{
			return !_dieTriggered;
		}
		return false;
	}

	private IEnumerator DoDie()
	{
		_dieTriggered = true;
		StopCor(ref _checkCor);
		StopCor(ref _timerCor);
		while (_actor.state == ActorState.Spawn)
		{
			yield return null;
		}
		InterruptSkill();
		_actor.DestroySelf();
	}
}
