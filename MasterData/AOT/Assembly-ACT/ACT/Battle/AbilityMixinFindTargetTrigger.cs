using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Utility;
using Bamboo.ECS;
using UnityEngine.Pool;

namespace ACT.Battle;

public class AbilityMixinFindTargetTrigger : BaseAbilityMixin
{
	private ConfigMixinFindTargetTrigger m_Config;

	private List<FindTargetResult> m_FindTargetResults;

	private HashSet<FindTargetResult> m_HashSet;

	public AbilityMixinFindTargetTrigger(ConfigMixinFindTargetTrigger config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinFindTargetTrigger)config;
	}

	internal override void ResetForPool()
	{
		if (m_HashSet != null)
		{
			m_HashSet.Clear();
			CollectionPool<HashSet<FindTargetResult>, FindTargetResult>.Release(m_HashSet);
			m_HashSet = null;
		}
		if (m_FindTargetResults != null)
		{
			m_FindTargetResults.Clear();
			CollectionPool<List<FindTargetResult>, FindTargetResult>.Release(m_FindTargetResults);
			m_FindTargetResults = null;
		}
		m_Config = null;
		base.ResetForPool();
	}

	internal override void FixedUpdate()
	{
		List<FindTargetResult> list = CollectionPool<List<FindTargetResult>, FindTargetResult>.Get();
		WhereTargets whereTargets = new WhereTargets
		{
			canBeAttack = m_Config.canBeAttack,
			FilterEntityType = m_Config.filterEntityType,
			alliance = GameUtility.GetAlliance(m_Config.alliance, owner.GetAlliance())
		};
		m_Config.findCondition.FindTargets(new ActionMemory(caster, owner, FindTargetResult.EntityOnly(owner), null, ability), list, whereTargets);
		m_HashSet.Clear();
		foreach (FindTargetResult findTargetResult in m_FindTargetResults)
		{
			m_HashSet.Add(findTargetResult);
		}
		m_FindTargetResults.Clear();
		foreach (FindTargetResult item in list)
		{
			if (m_HashSet.Remove(item))
			{
				SystemAbility.DoActions(caster, owner, item, null, ability, m_Config.onTriggerStay);
			}
			else
			{
				SystemAbility.DoActions(caster, owner, item, null, ability, m_Config.onTriggerEnter);
			}
			m_FindTargetResults.Add(item);
		}
		foreach (FindTargetResult item2 in m_HashSet)
		{
			if (item2.IsValid)
			{
				SystemAbility.DoActions(caster, owner, item2, null, ability, m_Config.onTriggerExit);
			}
		}
		CollectionPool<List<FindTargetResult>, FindTargetResult>.Release(list);
	}

	internal override void OnAdd()
	{
		m_FindTargetResults = CollectionPool<List<FindTargetResult>, FindTargetResult>.Get();
		m_HashSet = CollectionPool<HashSet<FindTargetResult>, FindTargetResult>.Get();
	}

	internal override void OnRemove()
	{
		if (m_FindTargetResults != null)
		{
			foreach (FindTargetResult findTargetResult in m_FindTargetResults)
			{
				if (findTargetResult.IsValid)
				{
					SystemAbility.DoActions(caster, owner, findTargetResult, null, ability, m_Config.onTriggerExit);
				}
			}
			m_FindTargetResults.Clear();
		}
		if (m_HashSet != null)
		{
			CollectionPool<HashSet<FindTargetResult>, FindTargetResult>.Release(m_HashSet);
			m_HashSet = null;
		}
		if (m_FindTargetResults != null)
		{
			CollectionPool<List<FindTargetResult>, FindTargetResult>.Release(m_FindTargetResults);
			m_FindTargetResults = null;
		}
	}

	internal override void OnSilentRemove()
	{
		if (m_FindTargetResults != null)
		{
			foreach (FindTargetResult findTargetResult in m_FindTargetResults)
			{
				if (findTargetResult.IsValid)
				{
					SystemAbility.DoActions(caster, owner, findTargetResult, null, ability, m_Config.onTriggerExit);
				}
			}
			m_FindTargetResults.Clear();
		}
		if (m_HashSet != null)
		{
			CollectionPool<HashSet<FindTargetResult>, FindTargetResult>.Release(m_HashSet);
			m_HashSet = null;
		}
		if (m_FindTargetResults != null)
		{
			CollectionPool<List<FindTargetResult>, FindTargetResult>.Release(m_FindTargetResults);
			m_FindTargetResults = null;
		}
	}
}
