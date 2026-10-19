using System;
using System.Collections.Generic;
using ACT.MultiPlayer;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

public class AreaAttackPattern : AttackPattern
{
	public BaseFindTargetsByArea findTargets;

	[HideInInspector]
	public bool doEnvironmentCheck;

	[Space(10f)]
	[Tooltip("负值表示只判定一次,单位为秒")]
	public float hitCD = -1f;

	[Tooltip("负值、0、1都表示只判定一次，大于1表示最大命中次数")]
	public int maxHitCount = -1;

	[Space(10f)]
	[Obsolete]
	[HideInInspector]
	public ActionEnemyTraction carry;

	[HideInInspector]
	public int HitCount;

	public BaseFindTargets _findTargets => findTargets;

	internal override void Init()
	{
		_findTargets.OnInit();
	}

	internal override void Handle(SystemAbility systemAbility, Entity entity, Ability dummyAbility, int stateIndex, int attackIndex)
	{
		HitCount = 0;
		bool doServerAuthActions = false;
		bool doRemoteAttack = true;
		int hitCount = HitCount;
		HandleImpl(systemAbility, entity, dummyAbility, stateIndex, attackIndex, doServerAuthActions, doRemoteAttack);
		if (HitCount > hitCount && systemAbility != null)
		{
			ConfigMotion layer0PeakConfig = entity.GetCompMotion().layer0PeakConfig;
			ActionMemory memory = new ActionMemory(entity, entity, FindTargetResult.EntityOnly(entity));
			float value = layer0PeakConfig.specialEnergyValue?.Return(memory) ?? 0f;
			entity.GetCompAbility().ActionModifySpecialEnergy(value, dummyAbility, ActionChangeSpecialEnergy.State.Normal);
		}
	}

	internal override void HandleTemp(SystemAbility systemAbility, Entity entity, Ability dummyAbility, int stateIndex, int attackIndex)
	{
		HandleImpl(systemAbility, entity, dummyAbility, stateIndex, attackIndex, doServerAuthActions: true, doRemoteAttack: false);
	}

	private void HandleImpl(SystemAbility systemAbility, Entity entity, Ability dummyAbility, int stateIndex, int attackIndex, bool doServerAuthActions, bool doRemoteAttack)
	{
		List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
		List<int> list2 = ListPool<int>.Get();
		WhereTargets whereTargets = new WhereTargets
		{
			alliance = GameUtility.GetAlliance(allianceCondition, entity.GetCompAlliance().alliance),
			canBeAttack = false,
			FilterEntityType = filterEntityType
		};
		_findTargets.FindTargets(entity, list);
		whereTargets.FindTargets(list, entity);
		int num = 0;
		if (list.Count > 0)
		{
			bool flag = false;
			int count = list.Count;
			CompAbility compAbility = entity.GetCompAbility();
			for (int i = 0; i < count; i++)
			{
				list2.Add(0);
			}
			for (int num2 = count - 1; num2 >= 0; num2--)
			{
				FindTargetResult findTargetResult = list[num2];
				if (compAbility.IsHited(findTargetResult, this))
				{
					list.RemoveAt(num2);
					list2.RemoveAt(num2);
				}
				else
				{
					int ordinal = (list2[num2] = compAbility.SetHited(findTargetResult, hitCD, this, maxHitCount));
					num++;
					if (doServerAuthActions)
					{
						compAbility.SetHitRecoveryEnergyContext(this, ordinal);
						DoServerAuthActions(entity, findTargetResult, dummyAbility);
						compAbility.ClearHitRecoveryEnergyContext();
					}
					flag = true;
				}
			}
			if (flag)
			{
				List<FindTargetResult> list3 = ListPool<FindTargetResult>.Get();
				List<int> list4 = ListPool<int>.Get();
				for (int num4 = list.Count - 1; num4 >= 0; num4--)
				{
					if (!list[num4].damageable)
					{
						list3.Add(list[num4]);
						list4.Add(list2[num4]);
					}
				}
				if (list3.Count > 0)
				{
					if (doServerAuthActions)
					{
						SystemAbility.DoActions(entity, entity, FindTargetResult.EntityOnly(entity), null, dummyAbility, onHitSelf);
					}
					if (doRemoteAttack)
					{
						CmdMotionAttack cmd = new CmdMotionAttack
						{
							attacker = entity.Id,
							state = stateIndex,
							attackIndex = (byte)attackIndex,
							targets = list3,
							hitRecoveryOrdinals = list4
						};
						Singleton<GameManager>.instance.ecsManager.systemAbility.RemoteEntityAttack(cmd);
					}
				}
				ListPool<FindTargetResult>.Release(list3);
				ListPool<int>.Release(list4);
			}
			for (int num5 = list.Count - 1; num5 >= 0; num5--)
			{
				FindTargetResult target = list[num5];
				DoClientAuthActions(entity, target, dummyAbility);
			}
		}
		nextFindTargetActions?.FindTarget(new ActionMemory(entity, entity, FindTargetResult.EntityOnly(entity)), list);
		ListPool<FindTargetResult>.Release(list);
		ListPool<int>.Release(list2);
		HitCount += num;
	}

	private static int FilterTargetsBlockedByEnvironment(Entity entity, List<FindTargetResult> targets)
	{
		Vector3 colliderPosition = entity.GetCompTransform().colliderPosition;
		int num = 0;
		for (int num2 = targets.Count - 1; num2 >= 0; num2--)
		{
			FindTargetResult findTargetResult = targets[num2];
			if (findTargetResult.entity.IsValid)
			{
				Vector3 colliderPosition2 = findTargetResult.entity.GetCompTransform().colliderPosition;
				if (!((colliderPosition2 - colliderPosition).sqrMagnitude <= Mathf.Epsilon))
				{
					num++;
					if (Physics.Linecast(colliderPosition, colliderPosition2, BattleConsts.enviromentMask))
					{
						targets.RemoveAt(num2);
					}
				}
			}
		}
		return num;
	}

	private static void MoveDummyTargetsToEnd(List<FindTargetResult> targets)
	{
		if (targets.Count <= 1)
		{
			return;
		}
		int num = 0;
		for (int i = 0; i < targets.Count; i++)
		{
			if (!IsDummyTarget(targets[i]))
			{
				if (num != i)
				{
					FindTargetResult value = targets[i];
					targets[i] = targets[num];
					targets[num] = value;
				}
				num++;
			}
		}
	}

	private static bool IsDummyTarget(FindTargetResult target)
	{
		if (target.targetSourceType != FindTargetResult.TargetSourceType.Damageable && target.entity.IsValid)
		{
			return target.entity.IsDummy();
		}
		return false;
	}

	public void OnFindTargetsChanged()
	{
		if (findTargets is ConfigFindRayCastRangeTargets)
		{
			(findTargets as ConfigFindRayCastRangeTargets).filterEntityType = filterEntityType;
			(findTargets as ConfigFindRayCastRangeTargets).allianceCondition = allianceCondition;
		}
	}

	public override bool CanDoPeriod()
	{
		return true;
	}
}
