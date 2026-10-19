using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinFollowTarget : BaseAbilityMixin
{
	private ConfigMixinFollowTarget config;

	private EntityReference m_Target;

	private bool isFollowed;

	private Vector3 offset;

	public AbilityMixinFollowTarget(ConfigMixinFollowTarget config, Ability ab, byte index)
		: base(ab, index)
	{
		this.config = config;
	}

	internal override void RebindForPool(ConfigMixin configMixin, Ability ab, byte newIndex)
	{
		base.RebindForPool(configMixin, ab, newIndex);
		config = (ConfigMixinFollowTarget)configMixin;
	}

	internal override void ResetForPool()
	{
		config = null;
		m_Target = default;
		isFollowed = false;
		offset = default;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		isFollowed = false;
		ActionMemory memory = new ActionMemory(owner, owner, owner, null, ability);
		if (config.offset != null)
		{
			offset = config.offset.Return(memory);
		}
		else
		{
			offset = Vector3.zero;
		}
		if (config.findTarget != null)
		{
			List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
			config.findTarget.FindTargets(memory, list);
			if (list.Count > 0)
			{
				m_Target = list[0].entity;
				ListPool<FindTargetResult>.Release(list);
			}
			else
			{
				ListPool<FindTargetResult>.Release(list);
			}
		}
		else
		{
			Entity hatred = owner.GetCompHatred().GetHatred();
			if (hatred.IsValid)
			{
				m_Target = hatred;
			}
		}
	}

	internal override void Update()
	{
		if (isFollowed || m_Target == null || !m_Target.IsValid)
		{
			return;
		}
		Vector3 vector = m_Target.entity.GetCompTransform().physicsPosition + VectorUtility.HorizontalDirection(m_Target.entity.IsFaceLeft(), offset);
		Vector3 physicsPosition = owner.GetCompTransform().physicsPosition;
		Vector3 vector2 = vector - physicsPosition;
		if (config.followMode == ConfigMixinFollowTarget.FollowMode.X)
		{
			vector2.y = 0f;
		}
		if (!owner.TryGetCompPhysics(out CompPhysics component))
		{
			return;
		}
		CompInput compInput = owner.GetCompInput();
		float magnitude = vector2.magnitude;
		if (magnitude <= config.followAppend)
		{
			FinishFollow(compInput);
			return;
		}
		Vector3 normalized = component.WorldToPathLocal(vector2).normalized;
		float num = Vector3.Dot(component.rawVelocity, normalized);
		float magnitude2 = component.rawVelocity.magnitude;
		float brakingDeceleration = component.BrakingDeceleration;
		if (((num > 0f && magnitude2 > 0f && brakingDeceleration > 0f) ? (num * magnitude2 / (2f * brakingDeceleration)) : 0f) + config.followAppend >= magnitude)
		{
			compInput.inputDir = EInputDir.None;
		}
		else if (config.followMode == ConfigMixinFollowTarget.FollowMode.X)
		{
			if (Vector3.Dot(component.pathTangent, vector2) > 0f)
			{
				compInput.inputDir = EInputDir.Right;
			}
			else
			{
				compInput.inputDir = EInputDir.Left;
			}
		}
		else
		{
			compInput.dir = vector2;
		}
	}

	private void FinishFollow(CompInput compInput)
	{
		compInput.inputDir = EInputDir.None;
		if (config.followType != ConfigMixinFollowTarget.ConfigMixinFollowTargetType.onlyOnce)
		{
			return;
		}
		isFollowed = true;
		if (config.onEndActions != null)
		{
			ActionMemory memory = new ActionMemory(owner, owner, owner, null, ability);
			ConfigAction[] onEndActions = config.onEndActions;
			for (int i = 0; i < onEndActions.Length; i++)
			{
				onEndActions[i].Do(memory);
			}
		}
	}

	internal override void OnRemove()
	{
		owner.GetCompInput().inputDir = EInputDir.None;
	}
}
