using ACT.Battle.Configs;
using ACT.Utility;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinUnilateral : BaseAbilityMixin
{
	private ConfigMixinUnilateral m_Config;

	private Collider m_EntityCollider;

	private const float EnvironmentCastEndSkin = 0.05f;

	public AbilityMixinUnilateral(ConfigMixinUnilateral config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinUnilateral)config;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		ClearEntityCollider();
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		owner.GetCompAbility().AddListener(typeof(EvtAttackeeModifyDamage), this);
	}

	internal override void OnEvt(BaseEvt evt)
	{
		if (!(evt is EvtAttackeeModifyDamage { attackData: var attackData } evtAttackeeModifyDamage))
		{
			return;
		}
		Entity attacker = attackData.attacker;
		if (attacker.IsCharacter())
		{
			if (IsBlockedByEnvironment(attacker, out var touchPos))
			{
				attackData.finalPhaseMul = 0f;
				if (LuminApplication.LogEnabled)
				{
					Debug.Log($"单向门：攻击者{attacker}到受击点{touchPos}之间有环境碰撞，伤害不生效");
				}
				return;
			}
			Vector3 lhs = owner.GetRootTransform().position - attacker.GetRootTransform().position;
			float num = 0f;
			if (attacker.TryGetCompPhysics(out CompPhysics component))
			{
				num = Vector3.Dot(lhs, component.pathTangent);
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.Log($"单向门：攻击者{evtAttackeeModifyDamage.attackData.attacker}没有物理组件无法计算切线！");
			}
			evtAttackeeModifyDamage.attackData.finalPhaseMul = (((!m_Config.faceRight) ? (!(num < 0f)) : (!(num > 0f))) ? 1 : 0);
			if (evtAttackeeModifyDamage.attackData.finalPhaseMul == 0f)
			{
				GameUtility.OpenToolTip(400);
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.Log($"单向门位置{owner.GetRootTransform().position},攻击者位置{evtAttackeeModifyDamage.attackData.attacker.GetRootTransform().position}，攻击者切线{evtAttackeeModifyDamage.attackData.attacker.GetCompPhysics().pathTangent}，门的是否朝右{m_Config.faceRight}，result为{num}，攻击者{evtAttackeeModifyDamage.attackData.attacker}");
			}
		}
		else
		{
			evtAttackeeModifyDamage.attackData.finalPhaseMul = 0f;
		}
	}

	private bool IsBlockedByEnvironment(Entity attacker, out Vector3 touchPos)
	{
		touchPos = default;
		if (!attacker.IsValid)
		{
			return false;
		}
		Collider entityCollider = GetEntityCollider();
		if (entityCollider == null)
		{
			return false;
		}
		Vector3 vector = (attacker.TryGetCompTransform(out CompTransform component) ? component.colliderPosition : attacker.GetRootTransform().position);
		touchPos = entityCollider.ClosestPoint(vector);
		Vector3 vector2 = touchPos - vector;
		float magnitude = vector2.magnitude;
		if (magnitude <= 0.05f)
		{
			return false;
		}
		RaycastHit[] cacheHits = PhysicsUtility.cacheHits;
		try
		{
			int num = Physics.RaycastNonAlloc(vector, vector2 / magnitude, cacheHits, magnitude - 0.05f, BattleConsts.enviromentMask, QueryTriggerInteraction.Ignore);
			for (int i = 0; i < num; i++)
			{
				Collider collider = cacheHits[i].collider;
				if (!(collider == null) && !IsEntityCollider(collider, attacker) && !IsEntityCollider(collider, owner))
				{
					return true;
				}
			}
			return false;
		}
		finally
		{
			PhysicsUtility.Release(cacheHits);
		}
	}

	private bool IsEntityCollider(Collider collider, Entity entity)
	{
		if (!entity.IsValid)
		{
			return false;
		}
		MonoEntity monoEntity = PhysicsUtility.GetEntityRef(collider)?.GetMonoEntity();
		if (monoEntity != null)
		{
			return monoEntity.entity == entity;
		}
		return false;
	}

	private Collider GetEntityCollider()
	{
		if (m_EntityCollider != null || !owner.IsValid)
		{
			return m_EntityCollider;
		}
		MonoEntity mono = owner.GetMono();
		if (mono == null)
		{
			return null;
		}
		Collider component = mono.GetComponent<Collider>();
		if (component == null)
		{
			return null;
		}
		m_EntityCollider = component;
		return m_EntityCollider;
	}

	private void ClearEntityCollider()
	{
		m_EntityCollider = null;
	}

	internal override void OnRemove()
	{
		ClearEntityCollider();
		owner.GetCompAbility().RemoveListener(typeof(EvtAttackeeModifyDamage), this);
	}
}
