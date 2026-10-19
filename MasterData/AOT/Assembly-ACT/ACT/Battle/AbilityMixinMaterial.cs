using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinMaterial : BaseAbilityMixin
{
	private ConfigMixinMaterial m_Config;

	private Guid abilityMaterialGuid;

	private Material m_AppliedMaterial;

	private bool m_AppliedExclusivePriority;

	public AbilityMixinMaterial(ConfigMixinMaterial config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
		m_Priority = config.priority;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinMaterial)config;
		m_Priority = m_Config.priority;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		abilityMaterialGuid = Guid.Empty;
		m_AppliedMaterial = null;
		m_AppliedExclusivePriority = false;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		ConfigCharacter config = owner.GetConfig();
		m_AppliedMaterial = m_Config.material[config.monsterWeigtType];
		m_AppliedExclusivePriority = m_Config.exclusivePriority;
		abilityMaterialGuid = Guid.Empty;
		if (!m_AppliedExclusivePriority)
		{
			MonoEntity mono = owner.GetMono();
			if ((object)mono == null)
			{
				return;
			}
			MaterialOverride materialOverride = mono.materialOverride;
			if ((object)materialOverride != null)
			{
				if (materialOverride._MatList == null)
				{
					materialOverride._MatList = new List<Material>();
				}
				if (!materialOverride._MatList.Contains(m_AppliedMaterial))
				{
					materialOverride._MatList.Add(m_AppliedMaterial);
				}
			}
		}
		else
		{
			abilityMaterialGuid = owner.GetCompAbility().ApplyMaterialEffect(m_AppliedMaterial, m_Config.priority);
		}
	}

	internal override void FixedUpdate()
	{
		if (owner.IsAlive())
		{
			return;
		}
		MonoEntity mono = owner.GetMono();
		if ((object)mono != null)
		{
			MaterialOverride materialOverride = mono.materialOverride;
			if ((object)materialOverride != null && m_AppliedMaterial != null && materialOverride._MatList != null && materialOverride._MatList.Contains(m_AppliedMaterial))
			{
				materialOverride._MatList.Remove(m_AppliedMaterial);
			}
		}
	}

	internal override void OnRemove()
	{
		ReleaseMaterial();
	}

	internal override void OnSilentRemove()
	{
		ReleaseMaterial();
	}

	private void ReleaseMaterial()
	{
		if (!owner.IsValid)
		{
			ClearAppliedState();
			return;
		}
		CompAbility component;
		if (!m_AppliedExclusivePriority)
		{
			if (m_AppliedMaterial != null)
			{
				MonoEntity mono = owner.GetMono();
				if ((object)mono != null)
				{
					MaterialOverride materialOverride = mono.materialOverride;
					if ((object)materialOverride != null && materialOverride._MatList != null && materialOverride._MatList.Contains(m_AppliedMaterial))
					{
						materialOverride._MatList.Remove(m_AppliedMaterial);
					}
				}
			}
		}
		else if (abilityMaterialGuid != Guid.Empty && owner.TryGetCompAbility(out component))
		{
			component.RemoveMaterialEffect(abilityMaterialGuid);
		}
		ClearAppliedState();
	}

	private void ClearAppliedState()
	{
		abilityMaterialGuid = Guid.Empty;
		m_AppliedMaterial = null;
		m_AppliedExclusivePriority = false;
	}
}
