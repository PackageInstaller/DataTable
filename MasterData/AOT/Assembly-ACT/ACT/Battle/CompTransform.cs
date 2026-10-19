using System;
using ACT.MultiPlayer;
using ACT.Utility;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class CompTransform : EcsComponent
{
	public Quaternion rotation;

	public float physicsRotateDegree;

	public Vector2 size;

	public Vector3 center;

	public Vector3 compensation;

	public float compensationProgress = 1f;

	public float compensationDuration;

	public Action onCompensationComplete;

	public AnimationCurve compensationCurve;

	public Vector2 tractionOffset;

	public float tractionDuration;

	public float tractionProgress = 1f;

	public Vector3 carryOffest;

	public Entity carrier;

	public Transform carryCenter;

	public Transform beCarryCenter;

	public Vector3 physicsPosition { get; protected set; }

	public Vector3 lastPhysicsPosition { get; protected set; }

	public Vector3 colliderPosition => physicsPosition + center;

	public FaceDir FaceDir { get; set; }

	public Quaternion PathRotation { get; set; }

	public Quaternion FaceRotation { get; set; }

	public Quaternion XFaceRotation => FaceRotation * Quaternion.Euler(0f, -90f, 0f);

	internal Vector3 FaceDirOffest(Vector3 offset)
	{
		return physicsPosition + FaceRotation * offset;
	}

	public void SetBaseCollider(CapsuleCollider collider)
	{
		size = collider.Size();
		center = collider.center;
	}

	public void SetBaseCollider(BoxCollider collider)
	{
		size = collider.size;
		center = collider.center;
	}

	public void SetBaseCollider(Collider collider)
	{
		size = collider.bounds.size;
		center = collider.bounds.center;
	}

	public void SetCompensation(Vector3 compensation, float compensationDuration, AnimationCurve compensationCurve = null, Action onCompensationComplete = null)
	{
		this.compensation = compensation;
		this.compensationDuration = compensationDuration;
		this.compensationCurve = compensationCurve;
		this.onCompensationComplete = onCompensationComplete;
		compensationProgress = 0f;
	}

	public void SetTraction(Vector2 tractionOffset, float duration)
	{
		this.tractionOffset = tractionOffset;
		tractionDuration = duration;
		tractionProgress = 0f;
	}

	public bool IsBeCarryed()
	{
		return carrier != null;
	}

	public void SetCarrier(Entity target, Transform transform, Vector3 offset, Transform center)
	{
		carrier = target;
		carryCenter = transform;
		carryOffest = offset;
		beCarryCenter = center;
	}

	protected override void OnGet()
	{
	}

	protected override void OnRelease()
	{
		center = Vector3.zero;
		size = Vector2.zero;
		physicsPosition = Vector3.zero;
		lastPhysicsPosition = Vector3.zero;
		physicsRotateDegree = 0f;
		rotation = Quaternion.identity;
		compensation = Vector2.zero;
		compensationProgress = 1f;
		compensationDuration = 0f;
		tractionOffset = Vector2.zero;
		tractionDuration = 0f;
		tractionProgress = 1f;
		carryOffest = Vector3.zero;
		carrier = Entity.Invalid;
		carryCenter = null;
		beCarryCenter = null;
		FaceDir = FaceDir.None;
	}

	public void UpdatePosition(Vector3 pos)
	{
		lastPhysicsPosition = physicsPosition;
		physicsPosition = pos;
		if (owner.TryGetCompPhysics(out CompPhysics component))
		{
			component.OnSetPosition(pos);
		}
	}

	internal void UpdatePositionFromPhysics(Vector3 pos)
	{
		lastPhysicsPosition = physicsPosition;
		physicsPosition = pos;
	}

	public void SetPositionImmediately(Vector3 pos)
	{
		Vector3 vector = (lastPhysicsPosition = pos);
		physicsPosition = vector;
		if (owner.TryGetCompPhysics(out CompPhysics component))
		{
			component.OnSetPosition(pos);
		}
	}

	public void InitPosition(Vector3 pos)
	{
		lastPhysicsPosition = pos;
		physicsPosition = pos;
	}
}
