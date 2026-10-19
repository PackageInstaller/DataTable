using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinSetBreakPointPos : BaseAbilityMixin
{
	private ConfigMixinSetBreakPointPos m_Config;

	private TargetBounds targetBounds;

	public AbilityMixinSetBreakPointPos(ConfigMixinSetBreakPointPos config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
		targetBounds = m_Config.bounds;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinSetBreakPointPos)config;
		targetBounds = m_Config.bounds;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		targetBounds = default;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		owner.GetCompAbility().AddListener(typeof(EvtBreakPoint), this);
	}

	internal override void OnRemove()
	{
		owner.GetCompAbility().RemoveListener(typeof(EvtBreakPoint), this);
	}

	internal override void OnEvt(BaseEvt evt)
	{
		if (evt is EvtBreakPoint)
		{
			Entity mainEntity = evt.mainEntity;
			CompTransform compTransform = owner.GetCompTransform();
			CompPhysics compPhysics = owner.GetCompPhysics();
			var (raycastHit, vector) = CheckHit(mainEntity, targetBounds.center, compPhysics.characterMovement.position);
			if (raycastHit.collider != null && raycastHit.collider.gameObject.layer != 6)
			{
				compTransform.UpdatePosition(raycastHit.distance * vector + compPhysics.characterMovement.position);
				targetBounds.bounds.center += raycastHit.distance * vector;
			}
			List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
			BaseFindTargetsByArea.FindBoundsTargets(mainEntity, targetBounds, BattleConsts.hitMask | BattleConsts.entityMask, list);
			m_Config.where.FindTargets(list, ability.owner);
			if (list.Count <= 0)
			{
				mainEntity.SetFaceLeft(!owner.IsFaceLeft());
				mainEntity.GetCompPhysics().SetDirImmediately();
				mainEntity.GetCompTransform().UpdatePosition(targetBounds.center);
			}
			ListPool<FindTargetResult>.Release(list);
		}
	}

	private (RaycastHit, Vector3) CheckHit(Entity character, Vector3 from, Vector3 to)
	{
		Vector3 vector = to - from;
		float magnitude = vector.magnitude;
		vector /= magnitude;
		return (PhysicsUtility.CapsuleCast(from, character.GetCompTransform().size, vector, magnitude), vector);
	}
}
