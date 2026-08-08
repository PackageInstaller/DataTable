using UnityEngine;

namespace Dorm.Character;

public class DormPlayerEntity
{
	internal DormComplexEntity entity;

	internal CharacterController RoleController { get; private set; }

	internal DormEntityTrigger Trigger { get; private set; }

	private GameObject ModelObj => entity.model;

	internal Collider MainCollider { get; private set; }

	internal DormPlayerEntity(DormComplexEntity entity)
	{
		this.entity = entity;
		ModelObj.tag = "Player";
		CharacterController characterController = entity.InitComponent<CharacterController>();
		characterController.skinWidth = 0.002f;
		characterController.radius = entity.radius;
		characterController.height = entity.height;
		characterController.center = new Vector3(0f, 0.5f + characterController.skinWidth, 0f);
		characterController.enabled = false;
		characterController.stepOffset = 0.1f;
		RoleController = characterController;
		GameObject gameObject = entity.FindAttachPoint("gua_Hit").gameObject;
		MainCollider = gameObject.GetComponent<Collider>();
		if (MainCollider == null)
		{
			CapsuleCollider capsuleCollider = gameObject.AddComponent<CapsuleCollider>();
			capsuleCollider.center = new Vector3(0f, 0f, 0f);
			capsuleCollider.radius = entity.radius;
			capsuleCollider.height = entity.height;
			capsuleCollider.direction = 1;
			capsuleCollider.enabled = true;
			MainCollider = capsuleCollider;
		}
		gameObject.layer = DormConst.CHARA_LAYER_ID;
		Rigidbody rigidbody = U3DUtil.Get<Rigidbody>(gameObject);
		rigidbody.isKinematic = true;
		rigidbody.useGravity = false;
		DormEntityTrigger dormEntityTrigger = entity.InitComponent<DormEntityTrigger>();
		dormEntityTrigger.player = this;
		Trigger = dormEntityTrigger;
	}
}
