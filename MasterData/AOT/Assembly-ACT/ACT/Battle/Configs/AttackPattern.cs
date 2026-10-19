using System;
using System.Collections.Generic;
using ACT.Utility;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public abstract class AttackPattern : TimelineItem
{
	[Tooltip("没勾上的就不会被找到，一般用默认的即可")]
	public FilterEntityType filterEntityType = GameUtility.defaultFilterEntityType;

	[Tooltip("功能暂时有问题")]
	public AllianceCondition allianceCondition;

	public FindTargetWithActions nextFindTargetActions;

	[Tooltip("命中时对命中目标执行, server auth")]
	public ConfigAction[] onHitTarget;

	[Tooltip("只有命中人和怪对目标执行, server auth")]
	public ConfigAction[] onHitCharacterTarget;

	public ActionHit hit;

	[HideInInspector]
	[Obsolete]
	public ActionFireEffect effect;

	[HideInInspector]
	[Obsolete]
	public ActionFrameHalt frameHalt;

	[HideInInspector]
	[Obsolete]
	public ActionHitSounds hitSounds;

	[Tooltip("命中时对自身执行, server auth")]
	public ConfigAction[] onHitSelf;

	[Tooltip("只有打中角色和敌人才会执行")]
	public ConfigAction[] onHitCharacter;

	[HideInInspector]
	[Obsolete]
	public ActionFrameHalt frameHalt2Self;

	public virtual void DoClientAuthActions(Entity attacker, FindTargetResult target, Ability dummyAbility)
	{
		ActionMemory memory = new ActionMemory(attacker, attacker, target, null, dummyAbility);
		ActionMemory memory2 = new ActionMemory(attacker, attacker, attacker, null, dummyAbility);
		if (target.targetSourceType == FindTargetResult.TargetSourceType.Damageable)
		{
			hit?.Do(memory);
		}
		else if (target.entity.IsBehaveEntity() && !target.entity.InTag(MotionTag_backUp.Invincibility))
		{
			if (target.entity.TryGetCompAbility(out CompAbility component) && component.IsHavePosture && !component.IsWeak)
			{
				GameLoader.meta.shieldHitEffect?.Do(memory);
			}
			if (hit != null)
			{
				hit.cameraNoise?.Do(memory2);
				hit.attackerFrameHalt?.Do(memory2);
			}
			if (attacker == MonoECS.instance.mainEntity)
			{
				MonoECS.instance.entityLocal.compCamera.hits.Add(target.entity);
			}
		}
	}

	public virtual void DoServerAuthActions(Entity attacker, FindTargetResult target, Ability dummyAbility)
	{
		ActionMemory memory = new ActionMemory(attacker, attacker, target, null, dummyAbility);
		SystemAbility.DoActions(memory, onHitTarget);
		if (target.entity.IsBehaveEntity())
		{
			SystemAbility.DoActions(memory, onHitCharacterTarget);
		}
		hit?.Do(memory);
	}

	internal virtual AttackResolveResult DoServerAuthActionsAndCollect(Entity attacker, FindTargetResult target, Ability dummyAbility, MotionPrimaryTypeTag motionPrimaryTypeTag, MotionTypeTag motionTypeTag)
	{
		ActionMemory memory = new ActionMemory(attacker, attacker, target, null, dummyAbility);
		SystemAbility.DoActions(memory, onHitTarget);
		if (target.entity.IsBehaveEntity())
		{
			SystemAbility.DoActions(memory, onHitCharacterTarget);
		}
		if (hit == null)
		{
			return default;
		}
		return hit.DoAndCollectResult(memory, motionPrimaryTypeTag, motionTypeTag);
	}

	internal virtual void Init()
	{
	}

	internal virtual void Handle(SystemAbility systemAbility, Entity behave, Ability dummyAbility, int stateIndex, int attackIndex)
	{
	}

	internal virtual void HandleTemp(SystemAbility systemAbility, Entity entity, Ability dummyAbility, int stateIndex, int attackIndex)
	{
	}

	private void OnFilterEntityTypeOrAllianceConditionChanged()
	{
		if (this is AreaAttackPattern)
		{
			(this as AreaAttackPattern).OnFindTargetsChanged();
		}
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ability)
	{
		ConfigAbility.CacheActionList(list, onHitTarget, ability);
		ConfigAbility.CacheActionList(list, onHitCharacterTarget, ability);
		ConfigAbility.CacheActionList(list, onHitSelf, ability);
		ConfigAbility.CacheActionList(list, onHitCharacter, ability);
		List<ConfigAction> list2 = new List<ConfigAction>();
		if (hit != null)
		{
			list2.Add(hit);
		}
		ConfigAbility.CacheActionList(list, list2.ToArray(), ability);
		nextFindTargetActions?.CacheActionList(list, ability);
	}

	public override void Precache(List<YooAssetReference> list)
	{
		hit?.hitEffect?.Precache(list);
	}

	public void CollectEffectPrewarm(EffectPrewarmCollector collector, ConfigSkinBattleMapping mapping = null)
	{
		hit?.hitEffect?.CollectEffectPrewarm(collector, mapping);
	}
}
