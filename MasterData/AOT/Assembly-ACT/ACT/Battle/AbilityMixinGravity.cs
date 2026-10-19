using System.Collections.Generic;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinGravity : BaseAbilityMixin
{
	private ConfigFindRangeTargets findCondition = new ConfigFindRangeTargets();

	private ConfigMixinGravity m_Config;

	private List<FindTargetResult> m_Targets;

	private List<Entity> m_AffectTargets;

	private float m_TimeFlag;

	private const string WAIST = "waist";

	private Vector3 boundsCenter;

	private Vector3 realCenterPos;

	private Vector3 realOffset;

	public AbilityMixinGravity(ConfigMixinGravity config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
		findCondition.targetBounds = m_Config.targetBounds;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinGravity)config;
		findCondition.targetBounds = m_Config.targetBounds;
	}

	internal override void ResetForPool()
	{
		ClearPool();
		m_Config = null;
		m_TimeFlag = 0f;
		boundsCenter = default;
		realCenterPos = default;
		realOffset = default;
		findCondition.targetBounds = default;
		base.ResetForPool();
	}

	internal override void FixedUpdate()
	{
		m_Targets.Clear();
		findCondition.FindTargets(owner, m_Targets);
		m_AffectTargets.Clear();
		if (m_Config.cd != 0f && Time.time - m_TimeFlag < m_Config.cd)
		{
			return;
		}
		realOffset = owner.GetCompTransform().FaceRotation.normalized * m_Config.offset;
		m_TimeFlag = Time.time;
		if (m_Targets.Count <= 0)
		{
			return;
		}
		foreach (FindTargetResult target in m_Targets)
		{
			bool flag = true;
			Entity entity = target.entity;
			if (!entity.IsAlive() || !entity.HasCompAbility())
			{
				continue;
			}
			ConfigPredicate[] configPredicateList = m_Config.configPredicateList;
			foreach (ConfigPredicate configPredicate in configPredicateList)
			{
				if (!(configPredicate.Inverse ? (!configPredicate.Check(new ActionMemory(caster, owner, target, null, ability))) : configPredicate.Check(new ActionMemory(caster, owner, target, null, ability))))
				{
					flag = false;
					break;
				}
			}
			if (!flag || target.entity.GetConfig().monsterWeigtType == MonsterWeigtType.Giant)
			{
				continue;
			}
			Vector3 attachPointPosition = target.entity.GetMono().GetAttachPointPosition("waist");
			BaseFindTargetsByArea.TargetBoundsLocalToWorld(owner, findCondition.targetBounds, out var bounds, out var _, out var _);
			boundsCenter = bounds.center;
			bounds.extents = new Vector3(findCondition.targetBounds.bounds.extents.z, findCondition.targetBounds.bounds.extents.y, findCondition.targetBounds.bounds.extents.x);
			attachPointPosition.z = 0f;
			boundsCenter.z = 0f;
			realCenterPos = boundsCenter + realOffset;
			Vector3 direction = attachPointPosition - realCenterPos;
			float magnitude = direction.magnitude;
			switch (m_Config.mixinGravityType)
			{
			case ConfigMixinGravity.MixinGravityType.NoGrabAfterFinish:
				if (magnitude < m_Config.stopDistance)
				{
					continue;
				}
				break;
			}
			Ray ray = new Ray(realCenterPos, direction);
			Vector3 vector = default;
			if (bounds.IntersectRay(ray, out var distance))
			{
				vector = realCenterPos + direction.normalized * Mathf.Abs(distance);
			}
			float magnitude2 = (vector - realCenterPos).magnitude;
			float time = Mathf.Min(magnitude / magnitude2, 1f);
			float num = GameLoader.meta.curveLibrary.GetCurve(m_Config.animationCurve).Evaluate(time);
			CompPhysics compPhysics = target.entity.GetCompPhysics();
			compPhysics.compositeVelocity += -direction.normalized * Mathf.Max(0.01f, m_Config.pushImpetus * num / compPhysics.Mass);
			m_AffectTargets.Add(entity);
		}
	}

	internal override void OnAdd()
	{
		m_TimeFlag = 0f;
		m_Targets = ListPool<FindTargetResult>.Get();
		m_AffectTargets = ListPool<Entity>.Get();
	}

	internal override void OnRemove()
	{
		RemoveAndClearVelocity();
		ClearPool();
	}

	internal override void OnSilentRemove()
	{
		RemoveAndClearVelocity();
		ClearPool();
	}

	private void RemoveAndClearVelocity()
	{
		if (m_AffectTargets == null)
		{
			return;
		}
		foreach (Entity affectTarget in m_AffectTargets)
		{
			if (affectTarget.IsValid)
			{
				affectTarget.GetCompPhysics().ClearVelocity();
			}
		}
	}

	private void ClearPool()
	{
		if (m_Targets != null)
		{
			ListPool<FindTargetResult>.Release(m_Targets);
			m_Targets = null;
		}
		if (m_AffectTargets != null)
		{
			ListPool<Entity>.Release(m_AffectTargets);
			m_AffectTargets = null;
		}
	}
}
