using System.Collections.Generic;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinDanmaku : BaseAbilityMixin
{
	private ConfigMixinDanmaku config;

	private float m_Time;

	private int m_Index;

	private List<(Vector3, Vector3)> m_PositionsAndRotations;

	public AbilityMixinDanmaku(ConfigMixinDanmaku config, Ability ab, byte index)
		: base(ab, index)
	{
		this.config = config;
	}

	internal override void RebindForPool(ConfigMixin configMixin, Ability ab, byte newIndex)
	{
		base.RebindForPool(configMixin, ab, newIndex);
		config = (ConfigMixinDanmaku)configMixin;
	}

	internal override void ResetForPool()
	{
		config = null;
		m_Time = 0f;
		m_Index = 0;
		m_PositionsAndRotations = null;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		m_PositionsAndRotations = ListPool<(Vector3, Vector3)>.Get();
		base.OnAdd();
	}

	internal override void OnRemove()
	{
		if (m_PositionsAndRotations != null)
		{
			ListPool<(Vector3, Vector3)>.Release(m_PositionsAndRotations);
			m_PositionsAndRotations = null;
		}
	}

	internal override void OnSilentRemove()
	{
		if (m_PositionsAndRotations != null)
		{
			ListPool<(Vector3, Vector3)>.Release(m_PositionsAndRotations);
			m_PositionsAndRotations = null;
		}
	}

	internal override void FixedUpdate()
	{
		int count = m_PositionsAndRotations.Count;
		if (m_Index >= count)
		{
			return;
		}
		m_Time -= owner.GetCompTime().fixedDeltaTime;
		if (!(m_Time <= 0f))
		{
			return;
		}
		ActionMemory memory = new ActionMemory(caster, owner, owner, null, ability);
		(Vector3, Vector3) tuple = m_PositionsAndRotations[m_Index];
		if (config.useMatchingProjectile)
		{
			MonoECS.FlexibleParams p = config.projectileMatching.Return(memory).GetParams(tuple.Item1, Quaternion.LookRotation(tuple.Item2));
			MonoECS.instance.SpawnFlexibleEntity(p, memory.target.entity, memory.ability);
		}
		else if (config.useArray)
		{
			ActionCreatFlexibleEntity[] flexibleEntityArray = config.flexibleEntityArray;
			for (int i = 0; i < flexibleEntityArray.Length; i++)
			{
				MonoECS.FlexibleParams p2 = flexibleEntityArray[i].GetParams(tuple.Item1, Quaternion.LookRotation(tuple.Item2));
				MonoECS.instance.SpawnFlexibleEntity(p2, memory.target.entity, memory.ability);
			}
		}
		else
		{
			MonoECS.FlexibleParams p3 = config.flexibleEntity.GetParams(tuple.Item1, Quaternion.LookRotation(tuple.Item2));
			MonoECS.instance.SpawnFlexibleEntity(p3, memory.target.entity, memory.ability);
		}
		SystemAbility.DoActions(memory, config.onProjectileCreate);
		m_Time = config.timeIntervalPattern?.GetIntervalTime(memory, m_Index) ?? 0f;
		m_Index++;
	}

	internal override void TriggerAbility()
	{
		m_Index = 0;
		m_Time = 0f;
		config.transformsPattern.GetPositionsAndRotation(new ActionMemory(caster, owner, owner, null, ability), m_PositionsAndRotations);
		base.TriggerAbility();
	}
}
