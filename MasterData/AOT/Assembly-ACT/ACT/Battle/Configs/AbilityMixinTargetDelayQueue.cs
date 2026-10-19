using System.Collections.Generic;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

public class AbilityMixinTargetDelayQueue : BaseAbilityMixin
{
	private ConfigMixinTargetDelayQueue m_Config;

	private ActionMemory actionMemory;

	private ActionMemory targetMemory;

	private List<FindTargetResult> targets;

	private float delayTime;

	private float startTime;

	private new int index;

	private bool isFinished;

	private int doNum;

	public AbilityMixinTargetDelayQueue(ConfigMixinTargetDelayQueue config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinTargetDelayQueue)config;
	}

	internal override void ResetForPool()
	{
		ReleaseTargets();
		m_Config = null;
		actionMemory = default;
		targetMemory = default;
		delayTime = 0f;
		startTime = 0f;
		index = 0;
		isFinished = false;
		doNum = 0;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		actionMemory = new ActionMemory(owner, owner, FindTargetResult.EntityOnly(owner), null, ability);
		targets = ListPool<FindTargetResult>.Get();
		WhereTargets whereTargets = default;
		switch (m_Config.findTargetType)
		{
		case FindTargetType.opposingCampsAttackable:
			whereTargets.alliance = GameUtility.GetAlliance(AllianceCondition.OwnerEnemy, actionMemory.owner.GetAlliance());
			whereTargets.canBeAttack = true;
			break;
		case FindTargetType.opposingCampsCantAttackable:
			whereTargets.alliance = GameUtility.GetAlliance(AllianceCondition.OwnerEnemy, actionMemory.owner.GetAlliance());
			whereTargets.canBeAttack = false;
			break;
		case FindTargetType.opposingCampsAttackableAndCantAttackable:
			whereTargets.alliance = GameUtility.GetAlliance(AllianceCondition.OwnerEnemy, actionMemory.owner.GetAlliance());
			whereTargets.canBeAttack = false;
			break;
		case FindTargetType.selfCampsAttackable:
			whereTargets.alliance = GameUtility.GetAlliance(AllianceCondition.Owner, actionMemory.owner.GetAlliance());
			whereTargets.canBeAttack = true;
			break;
		case FindTargetType.selfCampsCantAttackable:
			whereTargets.alliance = GameUtility.GetAlliance(AllianceCondition.Owner, actionMemory.owner.GetAlliance());
			whereTargets.canBeAttack = false;
			break;
		case FindTargetType.selfCampsAttackableAndCantAttackable:
			whereTargets.alliance = GameUtility.GetAlliance(AllianceCondition.Owner, actionMemory.owner.GetAlliance());
			whereTargets.canBeAttack = false;
			break;
		case FindTargetType.teamer:
		case FindTargetType.teamerFilterSelf:
			whereTargets.alliance = GameUtility.GetAlliance(AllianceCondition.Owner, actionMemory.owner.GetAlliance());
			whereTargets.canBeAttack = true;
			break;
		case FindTargetType.self:
			whereTargets.alliance = GameUtility.GetAlliance(AllianceCondition.Owner, actionMemory.owner.GetAlliance());
			whereTargets.canBeAttack = true;
			break;
		default:
			whereTargets.alliance = actionMemory.owner.GetAlliance().GetOp();
			whereTargets.canBeAttack = true;
			break;
		}
		m_Config.baseFindTargets.FindTargets(actionMemory, targets, whereTargets);
		delayTime = m_Config.delayTime.Return(actionMemory);
		startTime = Time.time;
		index = 0;
		isFinished = false;
		doNum = (int)m_Config.configFunction.Return(actionMemory);
	}

	internal override void OnRemove()
	{
		base.OnRemove();
		ReleaseTargets();
	}

	private void ReleaseTargets()
	{
		if (targets != null)
		{
			ListPool<FindTargetResult>.Release(targets);
			targets = null;
		}
	}

	internal override void FixedUpdate()
	{
		if (targets.Count <= 0 || !(Time.time - startTime >= delayTime) || isFinished)
		{
			return;
		}
		int num = 0;
		startTime = Time.time;
		while (num < doNum)
		{
			while (!targets[index].IsValid && index < targets.Count)
			{
				index++;
			}
			targetMemory = new ActionMemory(owner, owner, targets[index], null, ability);
			for (int i = 0; i < m_Config.configActions.Length; i++)
			{
				m_Config.configActions[i].Do(targetMemory);
			}
			index++;
			num++;
			if (index >= targets.Count)
			{
				isFinished = true;
				break;
			}
		}
	}
}
