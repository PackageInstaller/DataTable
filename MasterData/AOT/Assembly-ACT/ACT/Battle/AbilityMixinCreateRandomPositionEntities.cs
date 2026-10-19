using System;
using ACT.Battle.Configs;
using ACT.MultiPlayer;
using ACT.Utility;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinCreateRandomPositionEntities : BaseAbilityMixin
{
	private ConfigMixinCreateRandomPositions m_Config;

	private Vector3[] m_Positons;

	private int m_Count;

	private ActionMemory m_ActionMemory;

	private int[] m_Indexes;

	private byte m_Seed;

	private CmdMixinSync m_RandomSync;

	public AbilityMixinCreateRandomPositionEntities(ConfigMixinCreateRandomPositions config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
		m_Count = m_Config.points.Length - m_Config.invisible;
		m_Positons = new Vector3[m_Config.points.Length];
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinCreateRandomPositions)config;
		m_Count = m_Config.points.Length - m_Config.invisible;
		EnsurePositionBuffer(m_Config.points.Length);
		m_ActionMemory = default;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		m_Count = 0;
		m_ActionMemory = default;
		m_Seed = 0;
		m_RandomSync = default;
		if (m_Positons != null)
		{
			Array.Clear(m_Positons, 0, m_Positons.Length);
		}
		base.ResetForPool();
	}

	private void EnsurePositionBuffer(int length)
	{
		if (m_Positons == null || m_Positons.Length != length)
		{
			m_Positons = new Vector3[length];
		}
	}

	internal override void OnAdd()
	{
		CreatSeed();
		m_ActionMemory = new ActionMemory(caster, owner, FindTargetResult.EntityOnly(owner));
	}

	private void CreatSeed()
	{
		m_Seed = (byte)DateTime.Now.Ticks;
		m_RandomSync.ability = ability.config.id;
		m_RandomSync.mixin = index;
		m_RandomSync.byteParam = m_Seed;
	}

	internal override void TriggerAbility()
	{
		GenRandomPos();
		CreateEntity();
	}

	private void GenRandomPos()
	{
		if (m_Config.invisible > m_Config.points.Length)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"检查不显示的浮游炮数量,不显示数量{m_Config.invisible}超过最大预设数量{m_Config.points.Length}");
			}
			return;
		}
		if (m_Config.invisible > m_Config.max - m_Config.min + 1)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"检查不显示的浮游炮数量,不显示数量{m_Config.invisible}超过唯一随机预设数量{m_Count}");
			}
			return;
		}
		UnityEngine.Random.State state = UnityEngine.Random.state;
		UnityEngine.Random.InitState(m_Seed);
		for (int i = 0; i < m_Config.points.Length; i++)
		{
			m_Positons[i] = m_Config.points[i].Return(m_ActionMemory);
		}
		m_Positons.RandomSort(m_Config.min, m_Config.max);
		m_Seed = (byte)UnityEngine.Random.Range(0, 256);
		UnityEngine.Random.state = state;
	}

	private void CreateEntity()
	{
		for (int i = 0; i < m_Positons.Length - m_Config.invisible; i++)
		{
			Do(m_Positons[i]);
		}
	}

	public void Do(Vector3 position)
	{
		Vector3 vector = VectorUtility.HorizontalDirection(m_ActionMemory.target.entity.IsFaceLeft(), m_Config.createConfig.offest);
		Vector3 vector2 = position + vector;
		if (!m_Config.createConfig.ignoreEnviroment)
		{
			Vector3 colliderPosition = m_ActionMemory.target.entity.GetCompTransform().colliderPosition;
			Vector3 direction = vector2 - colliderPosition;
			if (Physics.SphereCast(colliderPosition, m_Config.createConfig.size.x, direction, out var hitInfo, direction.magnitude, BattleConsts.enviromentMask))
			{
				vector2 = colliderPosition + direction.normalized * hitInfo.distance;
			}
		}
		MonoECS.instance.SpawnFlexibleEntity(m_Config.createConfig.GetParams(vector2 - vector, Quaternion.identity), m_ActionMemory.target.entity, ability);
	}
}
