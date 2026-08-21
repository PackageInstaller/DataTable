using UnityEngine;

namespace Ase.ECS;

public class SurroundRotateComponent : BaseComponent
{
	private float lookAtLerpSpeed;

	private bool openLerpLookAt;

	private bool openImmediateLookAt;

	private bool openSurroundRotate;

	private float surroundRotateSpeed;

	private AnimatorComponent animatorComponent;

	private Vector3 currentVelocity = Vector3.zero;

	private KinematicMoveComponent moveComponent;

	private StateComponent stateComponent;

	private Vector3 fixedSurroundPointPosition;

	private BaseEntity surroundedEntity;

	private SurroundRotateType surroundRotateType;

	private float totalRotationAngle;

	private float forecastingAngle;

	private Vector3 startPos;

	private Vector3 relativeStartPos;

	public override void OnStart(object data = null)
	{
		animatorComponent = mBaseEntity.GetComponent<AnimatorComponent>();
		moveComponent = mBaseEntity.GetComponent<KinematicMoveComponent>();
		stateComponent = mBaseEntity.GetComponent<StateComponent>();
	}

	public void SetForecastingAngle(float time)
	{
		forecastingAngle = time * surroundRotateSpeed;
	}

	public void OpenSurroundEntity(BaseEntity surroundedEntity, float surroundRotateSpeed, bool openImmediateLookAt = true, bool openLerpLookAt = false, float lookAtLerpSpeed = 10f)
	{
		openSurroundRotate = true;
		this.surroundedEntity = surroundedEntity;
		this.surroundRotateSpeed = surroundRotateSpeed;
		this.openImmediateLookAt = openImmediateLookAt;
		this.openLerpLookAt = openLerpLookAt;
		this.lookAtLerpSpeed = lookAtLerpSpeed;
		surroundRotateType = SurroundRotateType.Entity;
		totalRotationAngle = 0f;
	}

	public void OpenSurroundFixedPoint(Vector3 fixedSurroundPointPosition, float surroundRotateSpeed, bool openImmediateLookAt = true, bool openLerpLookAt = false, float lookAtLerpSpeed = 10f)
	{
		openSurroundRotate = true;
		this.fixedSurroundPointPosition = fixedSurroundPointPosition;
		this.surroundRotateSpeed = surroundRotateSpeed;
		this.openImmediateLookAt = openImmediateLookAt;
		this.openLerpLookAt = openLerpLookAt;
		this.lookAtLerpSpeed = lookAtLerpSpeed;
		surroundRotateType = SurroundRotateType.FixedPoint;
		totalRotationAngle = 0f;
	}

	public void ShieldLerpLookAt(bool openLerpLookAt = false)
	{
		this.openLerpLookAt = openLerpLookAt;
	}

	public void ShieldImmediateLookAt(bool openImmediateLookAt = false)
	{
		this.openImmediateLookAt = openImmediateLookAt;
	}

	public void ShieldSurroundRotate(bool openSurroundRotate = false)
	{
		this.openSurroundRotate = openSurroundRotate;
	}

	public void ShieldAll()
	{
		ShieldLerpLookAt();
		ShieldImmediateLookAt();
		ShieldSurroundRotate();
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		if (openSurroundRotate)
		{
			Vector3 vector = Vector3.zero;
			switch (surroundRotateType)
			{
			case SurroundRotateType.Entity:
				vector = surroundedEntity.transform.position;
				break;
			case SurroundRotateType.FixedPoint:
				vector = fixedSurroundPointPosition;
				break;
			}
			Vector3 directionToTarget = vector - mBaseEntity.transform.position;
			UpdateLookAt(directionToTarget, deltaTime);
			UpdateSurroundRotate(mBaseEntity.transform.position, vector, deltaTime, out var targetPosition);
			FinishSurroundRotate(targetPosition);
		}
	}

	private void UpdateLookAt(Vector3 directionToTarget, float deltaTime)
	{
		if (openImmediateLookAt)
		{
			UpdateImmediateLookAt(directionToTarget);
		}
		else if (openLerpLookAt)
		{
			UpdateLerpLookAt(deltaTime, directionToTarget, out var nextRotation);
			FinishLerpLookAt(nextRotation);
		}
	}

	public void UpdateSurroundRotate(Vector3 rotateEntityPosition, Vector3 surroundedTargetPosition, float deltaTime, out Vector3 targetPosition)
	{
		float num = surroundRotateSpeed * deltaTime;
		totalRotationAngle += num;
		Vector3 up = Vector3.up;
		Vector3 normalized = (rotateEntityPosition - surroundedTargetPosition).normalized;
		Vector3 vector = Quaternion.AngleAxis(num, up) * normalized;
		float num2 = Vector3.Distance(rotateEntityPosition, surroundedTargetPosition);
		targetPosition = surroundedTargetPosition + vector * num2;
	}

	public void UpdateLerpLookAt(float deltaTime, Vector3 directionToTarget, out Quaternion nextRotation)
	{
		Quaternion b = Quaternion.LookRotation(directionToTarget.normalized, Vector3.up);
		if (directionToTarget.magnitude > 0.01f)
		{
			if (openLerpLookAt)
			{
				nextRotation = Quaternion.Lerp(mBaseEntity.transform.rotation, b, lookAtLerpSpeed * deltaTime);
			}
			else
			{
				nextRotation = Quaternion.LookRotation(currentVelocity, Vector3.up);
			}
		}
		else
		{
			nextRotation = base.transform.rotation;
		}
	}

	public void UpdateImmediateLookAt(Vector3 velocity)
	{
		if (velocity.magnitude > 0.01f)
		{
			base.transform.rotation = Quaternion.LookRotation(velocity.normalized, Vector3.up);
		}
	}

	private void FinishLerpLookAt(Quaternion nextRotation)
	{
		moveComponent.SetRotation(nextRotation, "环绕面朝组件 MoveComponent");
	}

	private void FinishSurroundRotate(Vector3 targetPosition)
	{
		moveComponent.SetPosition(targetPosition, "环绕旋转组件 MoveComponent");
	}

	public void SetErrorFix(Vector3 startPos, Vector3 relativeStartPos)
	{
		this.startPos = startPos;
		this.relativeStartPos = relativeStartPos;
	}

	public Vector3 CalculateSurroundEndPosition(Vector3 startPos, Vector3 relativeStartPos, Vector3 endPos, float forecastingAngle)
	{
		Vector3 vector = relativeStartPos - startPos;
		Vector3 vector2 = Quaternion.AngleAxis(forecastingAngle, Vector3.up) * vector;
		float num = Vector3.Distance(startPos, endPos);
		return endPos - vector2.normalized * num;
	}

	public void CorrectionError(Vector3 endPos, float time)
	{
		FinishSurroundRotate(CalculateSurroundEndPosition(startPos, relativeStartPos, endPos, time * surroundRotateSpeed));
	}

	public override void OnPause()
	{
		currentVelocity = Vector3.zero;
		animatorComponent.SetBool(AnimationParameters.Moving, value: false);
	}
}
