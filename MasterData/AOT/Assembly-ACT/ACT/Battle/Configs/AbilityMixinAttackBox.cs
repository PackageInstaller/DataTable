using System.Collections.Generic;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

public class AbilityMixinAttackBox : BaseAbilityMixin
{
	private ConfigMixinAttackBox m_Config;

	private ActionMemory actionMemory;

	private float hitCD;

	private Dictionary<Entity, float> entityHitCD;

	public AbilityMixinAttackBox(ConfigMixinAttackBox config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void OnAdd()
	{
		actionMemory = new ActionMemory(owner, owner, FindTargetResult.EntityOnly(owner), null, ability);
		hitCD = m_Config.hitCD.Return(actionMemory);
		m_Config.mixinTimer.TimerStart(ability);
		if (entityHitCD == null)
		{
			entityHitCD = new Dictionary<Entity, float>();
		}
	}

	internal override void Update()
	{
	}

	internal override void FixedUpdate()
	{
		if (m_Config.mixinTimer != null && m_Config.mixinTimer.TimerIsFinishByFixedUpdate())
		{
			return;
		}
		List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
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
		if (m_Config.findTargets is ConfigFindFlexibleAreaTargets configFindFlexibleAreaTargets)
		{
			float startTime = m_Config.mixinTimer.startTime;
			float num = m_Config.mixinTimer.endTime;
			float time = Time.time;
			if (num < 0f)
			{
				num = 1f;
			}
			if (num > startTime)
			{
				if (time >= startTime && time <= num)
				{
					float value = (Time.time - startTime) / (num - startTime);
					configFindFlexibleAreaTargets.ChangeTargetRange(Mathf.Clamp01(value));
				}
			}
			else if (Mathf.Approximately(num, startTime))
			{
				configFindFlexibleAreaTargets.ChangeTargetRange(1f);
			}
		}
		m_Config.findTargets.FindTargets(actionMemory, list, whereTargets);
		float time2 = Time.time;
		foreach (FindTargetResult item in list)
		{
			Entity entity = item.entity;
			if (!(entity == null))
			{
				if (!entityHitCD.TryGetValue(entity, out var value2))
				{
					SystemAbility.DoActions(new ActionMemory(actionMemory.caster, actionMemory.owner, item, null, ability), m_Config.configActions);
					entityHitCD[entity] = time2;
				}
				else if (time2 - value2 >= hitCD)
				{
					SystemAbility.DoActions(new ActionMemory(actionMemory.caster, actionMemory.owner, item, null, ability), m_Config.configActions);
					entityHitCD[entity] = time2;
				}
			}
		}
		ListPool<FindTargetResult>.Release(list);
	}
}
