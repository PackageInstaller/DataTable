using System.Collections;
using System.Collections.Generic;
using AIScript.Character._12301;
using AIScript.Utils;
using AdventureBehaviour;
using Nova.Hotfix;
using TrueSync;

namespace AIScript.Monster._12301111FengTun;

public class Action : AIBase
{
	private FP _thinkInterval = 0.05f;

	private int buff_default = 12393011;

	private FP distance_BeginFollow = 5;

	private FP distance_FinishFollow = 2;

	private FP serachRange = 10;

	protected SkillPool _skillPool;

	protected TraceTarget _traceTarget;

	protected CoroutineNode _checkQualifiedSkillCoroutine;

	private List<MonsterActionBranch> _branchInfos;

	private AIBranchPool _aiBranchPool = new AIBranchPool();

	private BranchInfo curBrach;

	private CoroutineNode corSelectSkill;

	private CoroutineNode corBranchCd;

	protected CoroutineNode _traceCor;

	private bool iMove;

	public void OnEnable()
	{
		CommonUtils_MonsterAPI.SetHideModelDisable(_actor);
		_branchInfos = (_actor as MonsterAdventureActor).monsterAIInfo.actionBranchs;
		_aiBranchPool.Init(_actor, _branchInfos);
		PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor;
		if (playerAdventureActor != null)
		{
			FP leftTime = (_actor as MonsterAdventureActor).monsterSummonInfo.LeftTime;
			int currentBindSkillId = playerAdventureActor.playerSkillCd.GetCurrentBindSkillId(ActionKey.B);
			MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintStart", currentBindSkillId, leftTime.AsFloat(), a3: true);
			playerAdventureActor.logicVariable.SetLogicTagValue("summonId", _actor.Id);
			AIScript.Character._12301.Parallel.summmerID = _actor.Id;
		}
		iMove = false;
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).buffComponent.AddBuff(buff_default, _actor);
		}
		Parallel.start_p3_Time = _actor.LogicTime;
		AIScript.Character._12301.Parallel.numMax = 0;
		if (Parallel.iPerk6)
		{
			playerAdventureActor.buffComponent.AddBuff(12306011, _actor);
		}
	}

	public void OnDisable()
	{
		StopCoroutine(ref corSelectSkill);
		StopCoroutine(ref corBranchCd);
		PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor;
		if (playerAdventureActor != null)
		{
			playerAdventureActor.logicVariable.SetLogicTagValue("summonId", 0);
			int currentBindSkillId = playerAdventureActor.playerSkillCd.GetCurrentBindSkillId(ActionKey.B);
			MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintEnd", currentBindSkillId);
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).buffComponent.RemoveBuffByBuffId(buff_default);
		}
		if (_traceCor != null)
		{
			_actor.StopLogicCoroutine(_traceCor);
		}
		_traceCor = null;
		CommonUtils_MonsterAPI.SetHideModelEnable(_actor);
		AIScript.Character._12301.Parallel.summmerID = 0L;
		if (Parallel.iPerk6 && playerAdventureActor != null)
		{
			playerAdventureActor.buffComponent.RemoveBuffByBuffId(12306011);
		}
	}

	public void OnStart()
	{
		_actor.EnableCloseBlock();
		_actor.EnableMovementAgent();
		StartCoroutine(ref corSelectSkill, CheckQualifiedAIBranch());
		_traceCor = _actor.StartLogicCoroutine(TracePlayer());
		CommonUtils_MonsterAPI.SetUnparalleledEnable(_actor);
		_actor.EnableSearchedImmunity();
		if (curBrach != null)
		{
			curBrach.isRunning = false;
		}
		_actor.actorSkillManage.DestoryAllSkill();
	}

	protected IEnumerator TracePlayer()
	{
		LogicEntity followTarget = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		FP checkInterval = 0;
		while (!(SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor == null))
		{
			if (checkInterval > 0.01f)
			{
				if (TSVector2.DistanceSquared(_actor.tsTransform.Position, followTarget.tsTransform.Position) > distance_BeginFollow * distance_BeginFollow)
				{
					if (_traceTarget == null)
					{
						_traceTarget = new TraceTarget();
					}
					iMove = true;
					_actor.AimAtTarget(followTarget);
					_traceTarget.BeginTrace(_actor, followTarget, distance_FinishFollow, -1, -1, onCallBack, onCancelBack);
				}
				else if (TSVector2.DistanceSquared(_actor.tsTransform.Position, followTarget.tsTransform.Position) <= distance_FinishFollow * distance_FinishFollow && iMove)
				{
					_traceTarget?.CancelTrace();
				}
				checkInterval = 0;
			}
			checkInterval += _actor.LogicDeltaTime;
			yield return null;
		}
		_traceTarget?.CancelTrace();
	}

	private void onCallBack()
	{
		iMove = false;
	}

	private void onCancelBack(bool isdie, bool isInterrupt, bool isTimeout, bool isDistanceOut)
	{
		iMove = false;
	}

	public void OnUpdate()
	{
		_actor.tsTransform.PositionY = CommonHelper.GetTerrainHeight(_actor.tsTransform.Position, _actor.tsTransform.PositionY);
	}

	private IEnumerator CheckQualifiedAIBranch()
	{
		while (true)
		{
			PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
			if (activedPlayerActor != null)
			{
				_actor.attackTarget = activedPlayerActor.attackTarget;
				if (_actor.attackTarget == null)
				{
					_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: false);
					if (_actor.attackTarget == null && (curBrach == null || !curBrach.isRunning))
					{
						_actor.attackTarget = ILRuntimeAPI.GetTargetNearByRange(_actor, serachRange);
					}
				}
				if ((curBrach == null || !curBrach.isRunning) && _actor.attackTarget != null)
				{
					BranchInfo branchInfo = _aiBranchPool.CheckQualifiedBranchByCD();
					if (branchInfo != null)
					{
						curBrach = branchInfo;
						curBrach.isRunning = true;
						CastSkill(branchInfo);
					}
				}
				else if (iMove && _actor.attackTarget == null)
				{
					_actor.CancelAiming();
					_actor.AimAtTarget(activedPlayerActor);
				}
			}
			yield return _thinkInterval;
		}
	}

	private void CastSkill(BranchInfo qualifiedBranch)
	{
		StartProcessBranchCdByConfig();
		if (!ILRuntimeAPI.CreateSkill(qualifiedBranch.baseInfo.SkillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool success) =>
		{
			qualifiedBranch.isRunning = false;
			if (success)
			{
				EndProcessBranchCdByConfig();
			}
		}))
		{
			EndProcessBranchCdByConfig();
		}
		else
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
	}

	private void StartProcessBranchCdByConfig()
	{
		if (curBrach.baseInfo.StartCDTime == 0)
		{
			curBrach.ResetAiCdExpireTime(_actor.LogicTime);
		}
		else
		{
			StartCoroutine(ref corBranchCd, ProcessBranchCdByConfig());
		}
	}

	private void EndProcessBranchCdByConfig()
	{
		StopCoroutine(ref corBranchCd);
	}

	private IEnumerator ProcessBranchCdByConfig()
	{
		FP currentTime = 0;
		FP startTime = FP.FromMyriad(curBrach.baseInfo.StartCDTime);
		while (true)
		{
			currentTime += _actor.LogicDeltaTime;
			if (currentTime >= startTime)
			{
				break;
			}
			yield return null;
		}
		curBrach.ResetAiCdExpireTime(_actor.LogicTime);
	}
}
