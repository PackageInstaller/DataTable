#define LOG_ERROR
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster.Trap;

public class Action : AIBase
{
	private FP _thinkInterval = 0.2f;

	private CoroutineNode corSelectSkill;

	private CoroutineNode corBranchCd;

	private CoroutineNode corPatrol;

	private TrapAdventureActor trapActor;

	private List<MonsterActionBranch> _branchInfos;

	private AIBranchPool _aiBranchPool = new AIBranchPool();

	private BranchInfo curBrach;

	private List<DeterministicCollider> targets = new List<DeterministicCollider>();

	private DeterministicShape shape;

	private List<CoroutineNode> corList = new List<CoroutineNode>();

	private TSVector2 offset;

	public void OnEnable()
	{
		trapActor = _actor as TrapAdventureActor;
		SetUp();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TRAP_ACTIVE", OnTrapActive);
		for (int i = 0; i < trapActor.BornBuffs.Count; i++)
		{
			_actor.buffComponent.AddBuff(trapActor.BornBuffs.get_Item(i), _actor);
		}
		SetCollider(enable: false);
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRAP_ACTIVE", OnTrapActive);
		StopCoroutine(ref corSelectSkill);
		StopCoroutine(ref corBranchCd);
		StopCoroutine(ref corPatrol);
		foreach (CoroutineNode cor in corList)
		{
			_actor.StopLogicCoroutine(cor);
		}
		corList.Clear();
	}

	public void OnStart()
	{
		StartCoroutine(ref corSelectSkill, CheckQualifiedAIBranch());
		if (trapActor.isMove)
		{
			StartCoroutine(ref corPatrol, DoPatrol());
		}
	}

	private void SetUp()
	{
		_branchInfos = trapActor.monsterAIInfo.actionBranchs;
		if (trapActor.IsActive)
		{
			_aiBranchPool.Init(_actor, _branchInfos);
		}
		shape = trapActor.ShapeCfg;
		offset = _actor.tsTransform.TransformWorldPointToLocalSpace(shape.position);
	}

	private IEnumerator CheckQualifiedAIBranch()
	{
		while (true)
		{
			if (trapActor.IsActive && (curBrach == null || !curBrach.isRunning))
			{
				BranchInfo branchInfo = _aiBranchPool.CheckQualifiedBranchByCD();
				if (branchInfo != null)
				{
					curBrach = branchInfo;
					targets.Clear();
					if (trapActor.isMove)
					{
						shape.position = _actor.tsTransform.TransformLocalPointToWorldSpace(offset);
					}
					SceneSingleton<DeterministicCollisionManager>.Instance.GetTargetByShape(targets, shape, 8388864);
					if (targets.Count > 0)
					{
						FilterActor(targets);
						if (targets.Count > 0)
						{
							curBrach.isRunning = true;
							CastSkill(branchInfo);
						}
					}
				}
			}
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_thinkInterval));
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
	}

	public void FilterActor(List<DeterministicCollider> result)
	{
		for (int i = 0; i < result.Count; i++)
		{
			AdventureActor adventureActor = result.get_Item(i).Entity as AdventureActor;
			if (FilterEntityByTag(adventureActor) || _actor == adventureActor)
			{
				result.RemoveAt(i);
				i--;
			}
		}
	}

	public bool FilterEntityByTag(AdventureActor actor)
	{
		if (actor is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor.monsterInfo.subType == HotfixEnum.monsterSubType.Monster)
		{
			int[] trapTagIds = monsterAdventureActor.monsterInfo.trapTagIds;
			if (trapTagIds != null)
			{
				for (int i = 0; i < trapTagIds.Length; i++)
				{
					if (trapActor.FilterDic.Contains(trapTagIds[i]))
					{
						return true;
					}
				}
			}
		}
		if (actor is TrapAdventureActor)
		{
			return true;
		}
		if (actor is DestructibleStateSingle)
		{
			return true;
		}
		return false;
	}

	private void OnTrapActive(IEvent evt)
	{
		if (!(evt is AdventureTrapActive adventureTrapActive) || (adventureTrapActive.GroupId != trapActor.TrapGroupId && adventureTrapActive.GroupId != 0))
		{
			return;
		}
		SetCollider(adventureTrapActive.isActive);
		if (trapActor.IsActive == adventureTrapActive.isActive || (adventureTrapActive.isActive && !ModuleController<AdventureModuleController>.Instance.InBattleState))
		{
			return;
		}
		trapActor.IsActive = adventureTrapActive.isActive;
		if (trapActor.IsActive)
		{
			_aiBranchPool.Init(_actor, _branchInfos);
		}
		PlayEffect(adventureTrapActive.isActive);
		if (_actor.isPlayingAttackCombo && trapActor.trapCfg.InterruptSkill)
		{
			_actor.InterruptAttack(force: true);
		}
		if (adventureTrapActive.isActive)
		{
			foreach (int activeBuff in trapActor.ActiveBuffs)
			{
				_actor.buffComponent.AddBuff(activeBuff, _actor);
			}
			if (trapActor.ActiveBuffs.Count > 0)
			{
				for (int i = 0; i < trapActor.ActiveBuffs.Count; i += 2)
				{
					FP delayTime = FP.FromMyriad(trapActor.ActiveBuffs.get_Item(i));
					int buffId = trapActor.ActiveBuffs.get_Item(i + 1);
					CoroutineNode item = _actor.StartLogicCoroutine(AddBuff(buffId, delayTime));
					corList.Add(item);
				}
			}
			return;
		}
		if (trapActor.InActiveBuffs.Count > 0)
		{
			for (int j = 0; j < trapActor.InActiveBuffs.Count; j += 2)
			{
				FP delayTime2 = FP.FromMyriad(trapActor.InActiveBuffs.get_Item(j));
				int buffId2 = trapActor.InActiveBuffs.get_Item(j + 1);
				CoroutineNode item2 = _actor.StartLogicCoroutine(AddBuff(buffId2, delayTime2));
				corList.Add(item2);
			}
		}
		StopCoroutine(ref corPatrol);
		_actor.StandBy();
	}

	private IEnumerator AddBuff(int buffId, FP delayTime)
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(delayTime));
		_actor.buffComponent.AddBuff(buffId, _actor);
	}

	private void PlayEffect(bool active)
	{
		if (!string.IsNullOrEmpty(trapActor.trapCfg.ActiveEff))
		{
			if (active)
			{
				trapActor.PlayFX(trapActor.trapCfg.ActiveEff);
			}
			else
			{
				trapActor.StopFX(trapActor.trapCfg.ActiveEff);
			}
		}
	}

	private IEnumerator DoPatrol()
	{
		int index = 0;
		List<Transform> wayPoints = trapActor.transform.GetComponentInChildren<WayPoint>().wayPoints;
		if (wayPoints == null || wayPoints.Count == 0)
		{
			NovaLogger.Error(trapActor.name + " 路点为空");
			yield break;
		}
		List<TSVector2> worldWayPoint = new List<TSVector2>();
		foreach (Transform item2 in wayPoints)
		{
			TSVector2 item = new TSVector2(item2.position.x, item2.position.z);
			worldWayPoint.Add(item);
		}
		worldWayPoint.Add(_actor.tsTransform.Position);
		int count = worldWayPoint.Count;
		bool moveFinish = false;
		while (true)
		{
			moveFinish = false;
			TSVector2 targetPosition = worldWayPoint.get_Item(index);
			_actor.MoveTo(targetPosition, 0.1f, enableNavigation: false, AdventureActor.MovementMode.Run, () =>
			{
				moveFinish = true;
				index = ++index % count;
			}, randomMove: false, forceMove: false, default, () =>
			{
			}, stayWhenReachTarget: true);
			while (!moveFinish)
			{
				yield return null;
			}
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

	private void SetCollider(bool enable)
	{
		if (trapActor.trapTag.Equals("Die"))
		{
			if (enable)
			{
				trapActor.DisableCloseBlock();
			}
			else
			{
				trapActor.EnableCloseBlock();
			}
		}
	}
}
