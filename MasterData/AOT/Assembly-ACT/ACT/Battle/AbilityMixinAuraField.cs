using System.Collections.Generic;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;
using UnityEngine.Animations;

namespace ACT.Battle;

public class AbilityMixinAuraField : BaseAbilityMixin
{
	private ConfigMixinAuraField m_Config;

	private BoxCollider m_Box;

	private GameObject m_Go;

	private MonoAuraField m_AuraField;

	private List<Entity> m_List;

	public AbilityMixinAuraField(ConfigMixinAuraField config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinAuraField)config;
	}

	internal override void ResetForPool()
	{
		ReleaseAuraObject();
		ReleaseEntityList();
		m_Config = null;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		m_Go = new GameObject();
		Vector3 position = m_Config.center.Return(new ActionMemory(caster, owner, FindTargetResult.EntityOnly(owner), null, ability));
		m_Go.transform.position = position;
		m_Box = m_Go.AddComponent<BoxCollider>();
		m_Box.size = m_Config.range;
		m_Box.isTrigger = true;
		if (m_Config.rangePosCanUpdate)
		{
			ParentConstraint parentConstraint = m_Go.AddComponent<ParentConstraint>();
			ConstraintSource source = new ConstraintSource
			{
				sourceTransform = owner.GetRootTransform(),
				weight = 1f
			};
			parentConstraint.AddSource(source);
			Vector3 value = source.sourceTransform.InverseTransformPoint(m_Go.transform.position);
			parentConstraint.SetTranslationOffset(0, value);
			parentConstraint.constraintActive = true;
		}
		m_AuraField = m_Go.AddComponent<MonoAuraField>();
		m_AuraField.onEnter = OnAuraTriggerEnter;
		m_AuraField.onExit = OnAuraTriggerExit;
		m_List = ListPool<Entity>.Get();
	}

	private void OnAuraTriggerEnter(Entity entity)
	{
		if (isActive && m_Config != null && m_Config.where.Check(default, entity) && entity.TryGetCompAbility(out CompAbility component))
		{
			component.AddAbility(caster, m_Config.ability, AbilitySource.Ability, ability.skillLevelInfo, 1);
			string[] abilities = m_Config.abilities;
			foreach (string abName in abilities)
			{
				component.AddAbility(caster, abName, AbilitySource.Ability, ability.skillLevelInfo, 1);
			}
			if (m_Config.leaveAreaRemoveAbility)
			{
				m_List.Add(entity);
			}
		}
	}

	private void OnAuraTriggerExit(Entity entity)
	{
		if (isActive && m_Config != null && m_Config.where.Check(default, entity) && entity.TryGetCompAbility(out CompAbility component) && m_Config.leaveAreaRemoveAbility)
		{
			component.RemoveAbility(m_Config.ability);
			string[] abilities = m_Config.abilities;
			foreach (string name in abilities)
			{
				component.RemoveAbility(name);
			}
			m_List?.Remove(entity);
		}
	}

	internal override void OnRemove()
	{
		ReleaseAuraField();
	}

	internal override void OnSilentRemove()
	{
		ReleaseAuraField();
	}

	private void ReleaseAuraField()
	{
		ReleaseAuraObject();
		if (m_List != null && m_Config != null && m_Config.leaveAreaRemoveAbility)
		{
			for (int num = m_List.Count - 1; num >= 0; num--)
			{
				if (m_List[num].TryGetCompAbility(out CompAbility component))
				{
					component.RemoveAbility(m_Config.ability);
					string[] abilities = m_Config.abilities;
					foreach (string name in abilities)
					{
						component.RemoveAbility(name);
					}
				}
			}
		}
		ReleaseEntityList();
	}

	private void ReleaseAuraObject()
	{
		if (m_AuraField != null)
		{
			m_AuraField.onEnter = null;
			m_AuraField.onExit = null;
		}
		if (m_Box != null)
		{
			m_Box.enabled = false;
		}
		if (m_Go != null)
		{
			m_Go.SetActive(value: false);
			Object.Destroy(m_Go);
		}
		m_AuraField = null;
		m_Box = null;
		m_Go = null;
	}

	private void ReleaseEntityList()
	{
		if (m_List != null)
		{
			ListPool<Entity>.Release(m_List);
			m_List = null;
		}
	}
}
