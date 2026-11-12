using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._16001;

public class Action_Summon : AIBase
{
	private int skillId_Bounce = 8016005;

	private int maxCastTimes = 5;

	private readonly FP interval_CheckTrace_Summoned = 0.5;

	private int perkId_1 = 1600101;

	private int buffId_P1_Damage = 801600030;

	private int perkId_3 = 1600103;

	private readonly Dictionary<int, FP> modelScaleByCastTimes_3 = new Dictionary<int, FP>
	{
		{ 1, 1.1 },
		{ 2, 1.2 },
		{ 3, 1.3 },
		{ 4, 1.4 },
		{ 5, 1.5 }
	};

	public static readonly string logicTag_CastTimes = "Bubble_CastTimes";

	private AdventureActor _summoner;

	private int curCastTimes;

	private CoroutineNode _corLoop;

	private readonly TraceTarget _traceTarget = new TraceTarget();

	private FP _checkTraceInterval;

	public void OnEnable()
	{
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		if (logicComponent != null)
		{
			_summoner = logicComponent.SummonActor;
		}
		curCastTimes = 0;
		_checkTraceInterval = interval_CheckTrace_Summoned;
	}

	public void OnDisable()
	{
		_summoner = null;
		_actor.DisableCloseBlock();
	}

	public void OnStart()
	{
		_corLoop = _actor.StartLogicCoroutine(BubbleLoop(), runImmediately: true);
	}

	public void OnStop()
	{
		if (_corLoop != null)
		{
			_actor.StopLogicCoroutine(_corLoop);
		}
		_corLoop = null;
		_traceTarget.CancelTrace();
		_traceTarget.Clear();
		_checkTraceInterval = 0;
	}

	private IEnumerator BubbleLoop()
	{
		while (curCastTimes < maxCastTimes)
		{
			_actor.monsterTarget = GetAttackTarget();
			curCastTimes++;
			_actor.logicVariable.SetLogicTagValue(logicTag_CastTimes, curCastTimes);
			bool done = false;
			ILRuntimeAPI.CreateSkill(skillId_Bounce, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool success) =>
			{
				done = true;
			});
			while (!done)
			{
				yield return null;
			}
			if (GetPerk(perkId_1))
			{
				_actor.buffComponent.AddBuff(buffId_P1_Damage, _actor);
			}
			if (GetPerk(perkId_3) && modelScaleByCastTimes_3.TryGetValue(curCastTimes, out var value))
			{
				_actor.actorScaleInfo.modelScale = value;
			}
		}
		_actor.DestroySelf();
	}

	private LogicEntity GetAttackTarget()
	{
		if (_summoner != null && CommonUtils_MonsterAPI.CheckTargetIsValid(_summoner.attackTarget))
		{
			return _summoner.attackTarget;
		}
		List<LogicEntity> targetsByFactionByTD = CommonUtils.GetTargetsByFactionByTD(_actor, isFriend: false);
		return CommonUtils_MonsterAPI.GetTargetNearOrFar(_actor, iNear: true, targetsByFactionByTD);
	}

	public void OnUpdate()
	{
		if (_checkTraceInterval > 0)
		{
			_checkTraceInterval -= _actor.LogicDeltaTime;
			return;
		}
		LogicEntity attackTarget = GetAttackTarget();
		attackTarget = ((attackTarget == null) ? _summoner : attackTarget);
		_traceTarget.BeginTrace(_actor, attackTarget, attackTarget.GetRadius() + _actor.GetRadius() + 1f, -1, -1, null, null);
		_checkTraceInterval = interval_CheckTrace_Summoned;
	}
}
