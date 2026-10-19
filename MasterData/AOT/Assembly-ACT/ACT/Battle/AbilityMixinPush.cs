using ACT.Battle.Configs;
using ACT.Utility;
using Bamboo.ECS;
using EasyCharacterMovement;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinPush : BaseAbilityMixin
{
	private ConfigMixinPush m_Config;

	public AbilityMixinPush(ConfigMixinPush config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinPush)config;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		base.ResetForPool();
	}

	internal override void FixedUpdate()
	{
		CompPhysics compPhysics = owner.GetCompPhysics();
		Vector3 center = compPhysics.characterMovement.collider.bounds.center;
		Vector3 extents = compPhysics.characterMovement.collider.bounds.extents;
		Vector3 halfExtents = new Vector3((extents.x + m_Config.offest) * m_Config.scaleColliderExtents.x, (extents.y + m_Config.offest) * m_Config.scaleColliderExtents.y, (extents.z + m_Config.offest) * m_Config.scaleColliderExtents.z);
		Collider[] cacheColliders = PhysicsUtility.cacheColliders;
		Quaternion orientation = (owner.IsFaceLeft() ? Quaternion.Euler(0f, 180f, 0f) : Quaternion.identity);
		int num = Physics.OverlapBoxNonAlloc(center, halfExtents, cacheColliders, orientation, BattleConsts.entityMask);
		Vector3 velocity = compPhysics.velocity;
		velocity.y = 0f;
		bool flag = velocity.sqrMagnitude > 0.0001f;
		for (int i = 0; i < num; i++)
		{
			bool flag2 = false;
			MonoEntity component = cacheColliders[i].GetComponent<MonoEntity>();
			if (component == null || component.entity == owner)
			{
				continue;
			}
			if (m_Config.configPredicateList != null)
			{
				ConfigPredicate[] configPredicateList = m_Config.configPredicateList;
				foreach (ConfigPredicate configPredicate in configPredicateList)
				{
					if (!(configPredicate.Inverse ? (!configPredicate.Check(new ActionMemory(caster, owner, component.entity, null, ability))) : configPredicate.Check(new ActionMemory(caster, owner, component.entity, null, ability))))
					{
						flag2 = true;
						break;
					}
				}
			}
			if (flag2 || component.entity.InTag(MotionTag_backUp.SuperArmor))
			{
				continue;
			}
			if (flag)
			{
				Vector3 lhs = cacheColliders[i].bounds.center - center;
				lhs.y = 0f;
				if (Vector3.Dot(lhs, velocity) < 0f)
				{
					continue;
				}
			}
			if (cacheColliders[i].TryGetComponent<CharacterMovement>(out var _))
			{
				Vector3 launchVelocity = (m_Config.useEntityVelocity ? compPhysics.velocity : VectorUtility.HorizontalDirection(owner.IsFaceLeft(), m_Config.velocity));
				component.entity.GetCompPhysics().LaunchCharacter(launchVelocity, overrideVerticalVelocity: true, overrideLateralVelocity: true);
			}
		}
		PhysicsUtility.Release(cacheColliders);
	}

	internal override void OnAdd()
	{
	}

	internal override void OnRemove()
	{
	}
}
