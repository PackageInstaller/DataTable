using ACT.Battle.Configs;
using ACT.Utility;
using Bamboo.ECS;
using EasyCharacterMovement;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinSetSwitchSkillPos : BaseAbilityMixin
{
	private ConfigMixinSetSwitchSkillPos _config;

	private const float SWEEP_DISTANCE = 10f;

	public AbilityMixinSetSwitchSkillPos(ConfigMixinSetSwitchSkillPos config, Ability ab, byte index)
		: base(ab, index)
	{
		_config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		_config = (ConfigMixinSetSwitchSkillPos)config;
	}

	internal override void ResetForPool()
	{
		_config = null;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		CompAbility? compAbility = owner.GetCompAbility();
		compAbility.AddListener(typeof(EvtSetSwitchPos), this);
		compAbility.AddListener(typeof(EvtSetSwitchPosBaseOnCharacter), this);
	}

	internal override void OnRemove()
	{
		CompAbility? compAbility = owner.GetCompAbility();
		compAbility.RemoveListener(typeof(EvtSetSwitchPos), this);
		compAbility.RemoveListener(typeof(EvtSetSwitchPosBaseOnCharacter), this);
	}

	internal override void OnEvt(BaseEvt evt)
	{
		if (!(evt is EvtSetSwitchPos evtSetSwitchPos))
		{
			if (evt is EvtSetSwitchPosBaseOnCharacter { beforeEntity: var beforeEntity, mainEntity: var mainEntity, configPos: var configPos } evtSetSwitchPosBaseOnCharacter)
			{
				Vector3 physicsPosition = beforeEntity.GetCompTransform().physicsPosition;
				Vector3 positionImmediately = ResolvePosition(beforeEntity, physicsPosition, configPos, beforeEntity.IsFaceLeft());
				mainEntity.GetCompTransform().SetPositionImmediately(positionImmediately);
				if (evtSetSwitchPosBaseOnCharacter.target.IsValid)
				{
					Vector3 physicsPosition2 = evtSetSwitchPosBaseOnCharacter.target.GetCompTransform().physicsPosition;
					mainEntity.SetFaceLeft(positionImmediately.x - physicsPosition2.x > 0f);
				}
				else
				{
					mainEntity.SetFaceLeft(positionImmediately.x - physicsPosition.x > 0f);
				}
				mainEntity.GetCompPhysics().SetDirImmediately();
				UpdateGroundDistance(mainEntity);
				DoActions(owner, null, _config.actionlist);
			}
			return;
		}
		Vector2 offset = evtSetSwitchPos.configPos;
		Entity mainEntity2 = evtSetSwitchPos.mainEntity;
		Entity beforeEntity2 = evtSetSwitchPos.beforeEntity;
		CompTransform? compTransform = beforeEntity2.GetCompTransform();
		Entity target = evtSetSwitchPos.data.target;
		Vector3 physicsPosition3 = compTransform.physicsPosition;
		Vector3 vector = evtSetSwitchPos.data.foundPos;
		int num;
		CompPhysics compPhysics;
		if (!(evtSetSwitchPos.data.uncrossableOffsetX > 0f))
		{
			compPhysics = target.GetCompPhysics();
			if (compPhysics == null || compPhysics.overlapEntityMode != OverlapEntityMode.Uncrossable)
			{
				num = (target.InTag(MotionTag_backUp.Uncrossable) ? 1 : 0);
				goto IL_0090;
			}
		}
		num = 1;
		goto IL_0090;
		IL_0090:
		compPhysics = target.GetCompPhysics();
		if (compPhysics == null || compPhysics.overlapEntityMode != OverlapEntityMode.Uncrossable)
		{
			vector = GetNearestBodyPartPosition(target, physicsPosition3, vector);
		}
		vector.z = physicsPosition3.z;
		bool flag = (physicsPosition3.x - vector.x > 0f && !target.IsFaceLeft()) || (physicsPosition3.x - vector.x < 0f && target.IsFaceLeft());
		if ((num != 0 && offset.x < 0f) & flag)
		{
			offset.x = 0f - offset.x;
		}
		Vector3 positionImmediately2 = ResolvePosition(beforeEntity2, vector, offset, evtSetSwitchPos.data.target.IsFaceLeft());
		mainEntity2.GetCompTransform().SetPositionImmediately(positionImmediately2);
		mainEntity2.SetFaceLeft(positionImmediately2.x - vector.x > 0f);
		mainEntity2.GetCompPhysics().SetDirImmediately();
		UpdateGroundDistance(mainEntity2);
		DoActions(owner, null, _config.actionlist);
	}

	private static Vector3 GetNearestBodyPartPosition(Entity target, Vector3 referencePosition, Vector3 fallbackPosition)
	{
		MonoEntity mono = target.GetMono();
		if (mono == null || mono.bodyParts == null)
		{
			return fallbackPosition;
		}
		MonoBodyPart[] bodyParts = mono.bodyParts;
		int num = -1;
		float num2 = float.PositiveInfinity;
		foreach (MonoBodyPart monoBodyPart in bodyParts)
		{
			if (monoBodyPart == null || !monoBodyPart.isActiveAndEnabled || monoBodyPart.parryOnly || monoBodyPart.entity != target)
			{
				continue;
			}
			Collider myCollider = monoBodyPart.myCollider;
			if (!(myCollider == null) && myCollider.enabled && myCollider.gameObject.activeInHierarchy)
			{
				Vector3 center = myCollider.bounds.center;
				float sqrMagnitude = (center - referencePosition).sqrMagnitude;
				if (monoBodyPart.priority >= num && (monoBodyPart.priority != num || !(sqrMagnitude >= num2)))
				{
					num = monoBodyPart.priority;
					num2 = sqrMagnitude;
					fallbackPosition = center;
				}
			}
		}
		return fallbackPosition;
	}

	private Vector3 ResolvePosition(Entity beforeEntity, Vector3 basePos, Vector2 offset, bool faceLeft)
	{
		float num = (faceLeft ? (-1f) : 1f);
		Vector3 physicsPosition = beforeEntity.GetCompTransform().physicsPosition;
		Vector3 vector = basePos;
		vector.x += num * offset.x;
		vector.y += offset.y;
		var (raycastHit, vector2) = CheckHit(beforeEntity, vector);
		if (raycastHit.collider == null || raycastHit.collider.gameObject.layer == 6)
		{
			return vector;
		}
		Vector3 result = raycastHit.distance * vector2 + physicsPosition;
		Vector3 vector3 = basePos;
		vector3.x -= num * offset.x;
		vector3.y += offset.y;
		RaycastHit item = CheckHit(beforeEntity, vector3).Item1;
		if (item.collider == null || item.collider.gameObject.layer == 6)
		{
			return vector3;
		}
		return result;
	}

	private (RaycastHit, Vector3) CheckHit(Entity hideEntity, Vector3 position)
	{
		CompTransform compTransform = hideEntity.GetCompTransform();
		Vector3 physicsPosition = compTransform.physicsPosition;
		Vector3 vector = position - physicsPosition;
		float magnitude = vector.magnitude;
		vector /= magnitude;
		return (PhysicsUtility.CapsuleCast(compTransform.colliderPosition, compTransform.size, vector, magnitude), vector);
	}

	private void UpdateGroundDistance(Entity entity)
	{
		CompPhysics? compPhysics = entity.GetCompPhysics();
		CharacterMovement characterMovement = compPhysics.characterMovement;
		compPhysics.ExternalComputeGroundDistance(capsuleCenter: characterMovement.height * 0.5f * Vector3.up, characterPosition: characterMovement.position, height: characterMovement.height, radius: characterMovement.radius, rotation: entity.GetCompTransform().rotation, sweepDistance: 20f, castDistance: 20f, outGroundResult: out var outGroundResult, groundDistanceLayerMask: BattleConsts.enviromentMask);
		float value = (outGroundResult.hitGround ? outGroundResult.GetDistanceToGround() : 10f);
		entity.SetFloat("GroundDistance", value);
	}
}
