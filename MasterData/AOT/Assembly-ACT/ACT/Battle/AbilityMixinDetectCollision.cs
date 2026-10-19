using ACT.Battle.Configs;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinDetectCollision : BaseAbilityMixin
{
	private ConfigMixinDetectCollision m_Config;

	private ActionMemory m_ActionMemory;

	private Vector3 startPoint;

	public AbilityMixinDetectCollision(ConfigMixinDetectCollision config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
		m_ActionMemory = new ActionMemory(caster, owner, caster, null, ab);
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinDetectCollision)config;
		m_ActionMemory = new ActionMemory(caster, owner, caster, null, ab);
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		m_ActionMemory = default;
		startPoint = default;
		base.ResetForPool();
	}

	internal override void FixedUpdate()
	{
		startPoint = m_Config.startPoint.Return(m_ActionMemory);
		switch (m_Config.raycastType)
		{
		case RaycastType.Ray:
			DoRayCast();
			break;
		case RaycastType.Box:
			DoBoxRayCast();
			break;
		case RaycastType.Sphere:
			DoSphereRayCast();
			break;
		}
	}

	private void DoRayCast()
	{
		Vector3[] directions = m_Config.directions;
		foreach (Vector3 vector in directions)
		{
			Vector3 direction = (owner.IsFaceLeft() ? (-vector) : vector);
			if (Physics.Raycast(startPoint, direction, m_Config.distance, BattleConsts.enviromentMask))
			{
				DoActions();
				break;
			}
		}
	}

	private void DoBoxRayCast()
	{
		Vector3[] directions = m_Config.directions;
		foreach (Vector3 vector in directions)
		{
			Vector3 direction = (owner.IsFaceLeft() ? vector : (-vector));
			if (Physics.BoxCast(startPoint, m_Config.size.extents, direction, Quaternion.identity, m_Config.distance, BattleConsts.enviromentMask))
			{
				DoActions();
				break;
			}
		}
	}

	private void DoSphereRayCast()
	{
		Vector3[] directions = m_Config.directions;
		foreach (Vector3 vector in directions)
		{
			Vector3 direction = (owner.IsFaceLeft() ? vector : (-vector));
			if (Physics.SphereCast(startPoint, m_Config.radius, direction, out var _, m_Config.distance, BattleConsts.enviromentMask))
			{
				DoActions();
				break;
			}
		}
	}

	private void DoActions()
	{
		ConfigAction[] actions = m_Config.actions;
		for (int i = 0; i < actions.Length; i++)
		{
			actions[i].CheckDo(m_ActionMemory);
		}
	}
}
