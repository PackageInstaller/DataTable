using System.Collections.Generic;
using ACT.Battle.Configs;
using Bamboo.ECS;
using UnityEngine.Pool;

namespace ACT.Battle;

public class AbilityMixinSpotlightTrigger : BaseAbilityMixin
{
	private ConfigMixinSpotlightTrigger m_Config;

	private HashSet<Entity> m_Entities;

	private List<Entity> m_TempRemoveEntities;

	public AbilityMixinSpotlightTrigger(ConfigMixinSpotlightTrigger config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinSpotlightTrigger)config;
	}

	internal override void ResetForPool()
	{
		ReleaseBuffersForPool();
		m_Config = null;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		m_Entities = CollectionPool<HashSet<Entity>, Entity>.Get();
		m_TempRemoveEntities = CollectionPool<List<Entity>, Entity>.Get();
	}

	internal override void FixedUpdate()
	{
		if (!owner.HasCompSpotLightBuffer())
		{
			return;
		}
		CompSpotLightBuffer compSpotLightBuffer = owner.GetCompSpotLightBuffer();
		foreach (Entity entity in m_Entities)
		{
			if (!compSpotLightBuffer.inViewEr.Contains(entity))
			{
				if (entity.IsValid)
				{
					SystemAbility.DoActions(caster, owner, FindTargetResult.EntityOnly(entity), null, ability, m_Config.onRemove);
				}
				m_TempRemoveEntities.Add(entity);
			}
		}
		foreach (Entity tempRemoveEntity in m_TempRemoveEntities)
		{
			m_Entities.Remove(tempRemoveEntity);
		}
		foreach (Entity item in compSpotLightBuffer.inViewEr)
		{
			if (m_Entities.Add(item) && item.IsValid)
			{
				SystemAbility.DoActions(caster, owner, FindTargetResult.EntityOnly(item), null, ability, m_Config.onAdd);
			}
		}
		m_TempRemoveEntities.Clear();
	}

	internal override void OnRemove()
	{
		Clear();
	}

	internal override void OnSilentRemove()
	{
		Clear();
	}

	private void Clear()
	{
		if (m_Entities != null)
		{
			foreach (Entity entity in m_Entities)
			{
				if (entity.IsValid)
				{
					SystemAbility.DoActions(caster, owner, FindTargetResult.EntityOnly(entity), null, ability, m_Config.onRemove);
				}
			}
			m_Entities.Clear();
			m_TempRemoveEntities.Clear();
		}
		ReleaseBuffersForPool();
	}

	private void ReleaseBuffersForPool()
	{
		if (m_Entities != null)
		{
			m_Entities.Clear();
			CollectionPool<HashSet<Entity>, Entity>.Release(m_Entities);
			m_Entities = null;
		}
		if (m_TempRemoveEntities != null)
		{
			m_TempRemoveEntities.Clear();
			CollectionPool<List<Entity>, Entity>.Release(m_TempRemoveEntities);
			m_TempRemoveEntities = null;
		}
	}
}
