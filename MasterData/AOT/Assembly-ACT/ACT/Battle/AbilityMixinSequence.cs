using System;
using ACT.Battle.Configs;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinSequence : BaseAbilityMixin
{
	private ConfigMixinSequence m_Config;

	private int m_Index;

	private float m_Time;

	private int[] m_RandomOrder;

	private int m_ExecuteCount;

	public AbilityMixinSequence(ConfigMixinSequence config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinSequence)config;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		m_Index = 0;
		m_Time = 0f;
		m_ExecuteCount = 0;
		if (m_RandomOrder != null)
		{
			Array.Clear(m_RandomOrder, 0, m_RandomOrder.Length);
		}
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		if (m_Config.randomOrder)
		{
			ResetRandomSequence();
		}
	}

	internal override void FixedUpdate()
	{
		if (m_Config.randomOrder)
		{
			FixedUpdateRandomSequence();
		}
		else
		{
			if (m_Config.elements == null)
			{
				return;
			}
			if (m_Index >= m_Config.elements.Length && m_Config.loop)
			{
				m_Index = 0;
				m_Time = 0f;
			}
			if (m_Index < m_Config.elements.Length)
			{
				float num = m_Config.elements[m_Index].delay.Return(new ActionMemory(caster, owner, owner));
				if (m_Time >= num)
				{
					DoActions(owner, null, m_Config.elements[m_Index].actions);
					m_Time -= num;
					m_Index++;
				}
				m_Time += owner.GetCompTime().fixedDeltaTime;
			}
		}
	}

	private void FixedUpdateRandomSequence()
	{
		if (m_Config.elements == null)
		{
			return;
		}
		if (m_RandomOrder == null || m_RandomOrder.Length != m_Config.elements.Length)
		{
			ResetRandomSequence();
		}
		if (m_Index >= m_ExecuteCount && m_Config.loop)
		{
			ResetRandomSequence();
		}
		if (m_Index < m_ExecuteCount)
		{
			ConfigMixinSequence.MixinSequenceElement mixinSequenceElement = m_Config.elements[m_RandomOrder[m_Index]];
			float num = mixinSequenceElement.delay.Return(new ActionMemory(caster, owner, owner));
			if (m_Time >= num)
			{
				DoActions(owner, null, mixinSequenceElement.actions);
				m_Time -= num;
				m_Index++;
			}
			m_Time += owner.GetCompTime().fixedDeltaTime;
		}
	}

	private void ResetRandomSequence()
	{
		m_Index = 0;
		m_Time = 0f;
		int num = m_Config.elements?.Length ?? 0;
		m_ExecuteCount = GetRandomExecuteCount(num);
		if (m_RandomOrder == null || m_RandomOrder.Length != num)
		{
			m_RandomOrder = new int[num];
		}
		for (int i = 0; i < num; i++)
		{
			m_RandomOrder[i] = i;
		}
		for (int j = 0; j < m_ExecuteCount; j++)
		{
			int num2 = UnityEngine.Random.Range(j, num);
			int num3 = m_RandomOrder[j];
			m_RandomOrder[j] = m_RandomOrder[num2];
			m_RandomOrder[num2] = num3;
		}
	}

	private int GetRandomExecuteCount(int elementCount)
	{
		if (m_Config.randomExecuteCount <= 0)
		{
			return elementCount;
		}
		return Mathf.Min(m_Config.randomExecuteCount, elementCount);
	}
}
