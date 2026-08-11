using UnityEngine;

namespace Ase.ECS;

public class EntityRotationComponent : BaseComponent
{
	private float rotationSpeed;

	private bool rotationEnable;

	private BaseEntity target;

	private float currentLimitTime;

	private Vector3 targetPosition;

	private bool finishImmediatelyEnd;

	private float rotationThreshold = 0.1f;

	private float angleOffset;

	private AnimatorComponent _animatorComponent;

	public Vector3 TargetPosition
	{
		get
		{
			if (target == null)
			{
				return targetPosition;
			}
			return target.transform.position;
		}
	}

	public bool RotationFinish => !rotationEnable;

	public override void OnAwake(object data = null)
	{
		rotationEnable = false;
		_animatorComponent = mBaseEntity.GetComponent<AnimatorComponent>();
	}

	private void OnTargetReached()
	{
		OnEndRotation();
	}

	public void OnEndRotation()
	{
		rotationEnable = false;
	}

	public void SetTarget(BaseEntity entity, float duration, bool immediatelyEnd)
	{
		currentLimitTime = duration;
		target = entity;
		targetPosition = Vector3.zero;
		finishImmediatelyEnd = immediatelyEnd;
		rotationSpeed = mBaseEntity.GetProperty("RotateSpeed");
		rotationEnable = true;
		angleOffset = 0f;
	}

	public void SetTarget(Vector3 targetPoint, float duration, bool immediatelyEnd)
	{
		currentLimitTime = duration;
		targetPosition = targetPoint;
		target = null;
		finishImmediatelyEnd = immediatelyEnd;
		rotationSpeed = mBaseEntity.GetProperty("RotateSpeed");
		rotationEnable = true;
		angleOffset = 0f;
	}

	public void SetTarget(Vector3 targetPoint, float duration, bool immediatelyEnd, float rotationSpeed)
	{
		currentLimitTime = duration;
		targetPosition = targetPoint;
		target = null;
		finishImmediatelyEnd = immediatelyEnd;
		this.rotationSpeed = rotationSpeed;
		rotationEnable = true;
		angleOffset = 0f;
	}

	public void SetTargetOffset(BaseEntity entity, float duration, bool immediatelyEnd, float angleOffset = 0f)
	{
		currentLimitTime = duration;
		target = entity;
		targetPosition = Vector3.zero;
		finishImmediatelyEnd = immediatelyEnd;
		rotationSpeed = mBaseEntity.GetProperty("RotateSpeed");
		rotationEnable = true;
		this.angleOffset = angleOffset;
	}

	public void SetTargetOffset(Vector3 targetPoint, float duration, bool immediatelyEnd, float angleOffset = 0f)
	{
		currentLimitTime = duration;
		targetPosition = targetPoint;
		target = null;
		finishImmediatelyEnd = immediatelyEnd;
		rotationSpeed = mBaseEntity.GetProperty("RotateSpeed");
		rotationEnable = true;
		this.angleOffset = angleOffset;
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		currentLimitTime -= deltaTime;
		if (rotationEnable)
		{
			LookAtTarget(TargetPosition, deltaTime);
		}
		if (currentLimitTime <= 0f)
		{
			OnTargetReached();
		}
	}

	public override void OnUpdate(float deltaTime)
	{
		base.OnUpdate(deltaTime);
		if (_animatorComponent == null)
		{
			return;
		}
		BaseEntity baseEntity = mBaseEntity;
		if (baseEntity != null && baseEntity.GetEntityType() == EntityType.MONSTER)
		{
			if (rotationEnable)
			{
				_animatorComponent.SetFloat(AnimationParameters.MonsterRotate, rotationSpeed);
			}
			else
			{
				_animatorComponent.SetFloat(AnimationParameters.MonsterRotate, 0f);
			}
		}
	}

	private void LookAtTarget(Vector3 targetPoint, float deltaTime)
	{
		Vector3 normalized = (targetPoint - base.transform.position).normalized;
		normalized.y = 0f;
		Quaternion quaternion = Quaternion.LookRotation(normalized);
		quaternion *= Quaternion.Euler(0f, angleOffset, 0f);
		Quaternion rotation = Quaternion.RotateTowards(base.transform.rotation, quaternion, rotationSpeed * deltaTime);
		mBaseEntity.GetComponent<KinematicMoveComponent>().SetRotation(rotation, "EntityRotationComponent");
		if (finishImmediatelyEnd && Quaternion.Angle(base.transform.rotation, quaternion) <= rotationThreshold)
		{
			OnTargetReached();
		}
	}

	public void ImmediatelyRotate(Vector3 targetPoint, float angleOffset = 0f)
	{
		Vector3 normalized = (targetPoint - base.transform.position).normalized;
		normalized.y = 0f;
		Quaternion rotation = Quaternion.LookRotation(normalized);
		if (angleOffset != 0f)
		{
			rotation *= Quaternion.Euler(0f, angleOffset, 0f);
		}
		mBaseEntity.GetComponent<KinematicMoveComponent>().ImmediatelyRotate(rotation);
	}
}
