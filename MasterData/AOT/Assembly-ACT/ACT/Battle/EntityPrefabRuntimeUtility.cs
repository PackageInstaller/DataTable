using EasyCharacterMovement;
using UnityEngine;

namespace ACT.Battle;

public static class EntityPrefabRuntimeUtility
{
	public static MonoEntity EnsureMonoEntity(GameObject root)
	{
		if (root == null)
		{
			return null;
		}
		MonoEntity monoEntity = root.GetComponent<MonoEntity>();
		if (monoEntity == null)
		{
			monoEntity = root.AddComponent<MonoEntity>();
		}
		root.GetComponent<MonoEntityConfig>()?.ApplyTo(monoEntity);
		return monoEntity;
	}

	public static CharacterMovement EnsureCharacterMovement(GameObject root)
	{
		if (root == null)
		{
			return null;
		}
		CharacterMovementConfig component = root.GetComponent<CharacterMovementConfig>();
		component?.EnsureRuntimePhysicsComponents(root);
		EnsureRootMotionController(root);
		CharacterMovement characterMovement = root.GetComponent<CharacterMovement>();
		if (characterMovement == null)
		{
			characterMovement = root.AddComponent<CharacterMovement>();
		}
		component?.ApplyTo(characterMovement);
		return characterMovement;
	}

	private static void EnsureRootMotionController(GameObject root)
	{
		if (!(root == null))
		{
			Animator componentInChildren = root.GetComponentInChildren<Animator>(includeInactive: true);
			if (!(componentInChildren == null) && !componentInChildren.GetComponent<RootMotionController>())
			{
				componentInChildren.gameObject.AddComponent<RootMotionController>();
			}
		}
	}

	public static T EnsureAttackableCollider<T>(MonoEntity mono) where T : Collider
	{
		GameObject gameObject = mono.gameObject;
		if (typeof(T) != typeof(BoxCollider) && gameObject.TryGetComponent<BoxCollider>(out var component))
		{
			component.enabled = false;
		}
		if (typeof(T) != typeof(SphereCollider) && gameObject.TryGetComponent<SphereCollider>(out var component2))
		{
			component2.enabled = false;
		}
		T val = gameObject.GetComponent<T>();
		if (val == null)
		{
			val = gameObject.AddComponent<T>();
		}
		val.enabled = true;
		return val;
	}
}
