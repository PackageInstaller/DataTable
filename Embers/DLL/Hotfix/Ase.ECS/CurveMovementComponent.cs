using Ase.Paradox;
using UnityEngine;

namespace Ase.ECS;

public class CurveMovementComponent : BaseComponent
{
	private bool _moveDirByRotate;

	private bool curveMovement;

	private Vector2 curveMultiple;

	private float curvePercent;

	private bool curveRotation;

	private AnimationCurve curveRotW;

	private AnimationCurve curveRotX;

	private AnimationCurve curveRotY;

	private AnimationCurve curveRotZ;

	private MovementTimeType _movementTimeType;

	private float _curveTime;

	private int _moveTick;

	private int _tempTick;

	private AnimationCurve curveX;

	private AnimationCurve curveZ;

	private bool isMoving;

	private float lastCurvePercent;

	private KinematicMoveComponent moveComponent;

	private Vector3 _originPos;

	private Vector3 _originRot;

	private bool isSkillMoveCancel;

	private bool isSkillMoveCancelXMove;

	private bool isSkillMoveCancelZMove;

	private Vector2 stopAngle;

	private float maxDistance;

	private float _checkRadius;

	private bool colliderPauseMove;

	private Vector2 resumeCurveMultiple;

	private bool _isFrozenMovementCommand;

	private bool _frozenState;

	public override void OnStart(object data = null)
	{
		moveComponent = mBaseEntity.GetComponent<KinematicMoveComponent>();
	}

	public override void OnEntityFrozen(bool isFrozen, bool isFrozenLogic = true)
	{
		base.OnEntityFrozen(isFrozen, isFrozenLogic);
		if (isFrozenLogic)
		{
			_frozenState = isFrozen;
		}
	}

	public void CurveMove(AnimationCurve x, AnimationCurve z, float length, int moveTick, Vector2 multiple, bool moveDirByRotate, bool isSkillMoveCancel, bool isSkillMoveCancelXMove, bool isSkillMoveCancelZMove, Vector2 stopAngle, float maxDistance, float checkRadius, bool isFrozenMovementCommand, MovementTimeType movementTimeType, bool isOpenInterpolation, bool isOpenAnimator, bool colliderPauseMove)
	{
		curveX = x;
		curveZ = z;
		_curveTime = length;
		_moveTick = moveTick;
		_movementTimeType = movementTimeType;
		_tempTick = 0;
		curvePercent = 0f;
		lastCurvePercent = 0f;
		_originPos = mBaseEntity.transform.position;
		_originRot = mBaseEntity.transform.eulerAngles;
		curveMultiple = multiple;
		curveMovement = true;
		curveRotation = false;
		isMoving = true;
		_moveDirByRotate = moveDirByRotate;
		this.isSkillMoveCancel = isSkillMoveCancel;
		this.isSkillMoveCancelXMove = isSkillMoveCancelXMove;
		this.isSkillMoveCancelZMove = isSkillMoveCancelZMove;
		this.stopAngle = stopAngle;
		this.maxDistance = maxDistance;
		_checkRadius = checkRadius;
		_isFrozenMovementCommand = isFrozenMovementCommand;
		this.colliderPauseMove = colliderPauseMove;
		resumeCurveMultiple = curveMultiple;
		RefreshCurveMove();
		mBaseEntity.GetComponent<EntityViewComponent>()?.IsOpenAnimatorMovement(isOpenAnimator);
	}

	public void CurveMove(AnimationCurve rotX, AnimationCurve rotY, AnimationCurve rotZ, AnimationCurve rotW, float length, int moveTick, Vector2 multiple, bool isSkillMoveCancel, bool isSkillMoveCancelXMove, bool isSkillMoveCancelZMove, Vector2 stopAngle, float maxDistance, float checkRadius, bool isFrozenMovementCommand, MovementTimeType movementTimeType, bool isOpenInterpolation, bool isOpenAnimator, bool colliderPauseMove)
	{
		curveRotX = rotX;
		curveRotY = rotY;
		curveRotZ = rotZ;
		curveRotW = rotW;
		_curveTime = length;
		_moveTick = moveTick;
		_movementTimeType = movementTimeType;
		_tempTick = 0;
		curvePercent = 0f;
		lastCurvePercent = 0f;
		_originPos = mBaseEntity.transform.position;
		_originRot = mBaseEntity.transform.eulerAngles;
		curveMultiple = multiple;
		curveMovement = false;
		curveRotation = true;
		isMoving = true;
		_moveDirByRotate = false;
		this.isSkillMoveCancel = isSkillMoveCancel;
		this.isSkillMoveCancelXMove = isSkillMoveCancelXMove;
		this.isSkillMoveCancelZMove = isSkillMoveCancelZMove;
		this.stopAngle = stopAngle;
		this.maxDistance = maxDistance;
		_checkRadius = checkRadius;
		_isFrozenMovementCommand = isFrozenMovementCommand;
		this.colliderPauseMove = colliderPauseMove;
		resumeCurveMultiple = curveMultiple;
		RefreshCurveMove();
		mBaseEntity.GetComponent<EntityViewComponent>()?.IsOpenAnimatorMovement(isOpenAnimator);
	}

	public void CurveMove(AnimationCurve x, AnimationCurve z, AnimationCurve rotX, AnimationCurve rotY, AnimationCurve rotZ, AnimationCurve rotW, float length, int moveTick, Vector2 multiple, bool moveDirByRotate, bool isSkillMoveCancel, bool isSkillMoveCancelXMove, bool isSkillMoveCancelZMove, Vector2 stopAngle, float maxDistance, float checkRadius, bool isFrozenMovementCommand, MovementTimeType movementTimeType, bool isOpenInterpolation, bool isOpenAnimator, bool colliderPauseMove)
	{
		curveX = x;
		curveZ = z;
		curveRotX = rotX;
		curveRotY = rotY;
		curveRotZ = rotZ;
		curveRotW = rotW;
		_curveTime = length;
		_moveTick = moveTick;
		_movementTimeType = movementTimeType;
		_tempTick = 0;
		curvePercent = 0f;
		lastCurvePercent = 0f;
		_originPos = mBaseEntity.transform.position;
		_originRot = mBaseEntity.transform.eulerAngles;
		curveMultiple = multiple;
		curveMovement = true;
		curveRotation = true;
		isMoving = true;
		_moveDirByRotate = moveDirByRotate;
		this.isSkillMoveCancel = isSkillMoveCancel;
		this.isSkillMoveCancelXMove = isSkillMoveCancelXMove;
		this.isSkillMoveCancelZMove = isSkillMoveCancelZMove;
		this.stopAngle = stopAngle;
		this.maxDistance = maxDistance;
		_checkRadius = checkRadius;
		_isFrozenMovementCommand = isFrozenMovementCommand;
		this.colliderPauseMove = colliderPauseMove;
		resumeCurveMultiple = curveMultiple;
		RefreshCurveMove();
		mBaseEntity.GetComponent<EntityViewComponent>()?.IsOpenAnimatorMovement(isOpenAnimator);
	}

	private void RefreshCurveMove()
	{
		_ = _isFrozenMovementCommand;
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		if (_frozenState && _isFrozenMovementCommand)
		{
			if (mBaseEntity.FrozenSpeed == 0f)
			{
				moveComponent.ImmediatelyMove(base.transform.position);
				return;
			}
			deltaTime *= mBaseEntity.FrozenSpeed;
		}
		if (!isMoving)
		{
			return;
		}
		Vector3 checkDir = GetCheckDir(deltaTime);
		Quaternion rotation = base.transform.rotation;
		Vector3 pos = base.transform.position;
		GetNextFrameTrans(deltaTime, ref curvePercent, ref _tempTick, rotation, ref pos, curveMultiple, setToEntity: true);
		if (_movementTimeType == MovementTimeType.Time)
		{
			if (curvePercent >= _curveTime)
			{
				OnCurveMoveEnd();
			}
		}
		else if (_tempTick >= _moveTick)
		{
			OnCurveMoveEnd();
		}
		if (isSkillMoveCancel)
		{
			if (moveComponent == null || !moveComponent.CheckMovementCollision(maxDistance, checkDir, out var raycastHit, _checkRadius))
			{
				return;
			}
			Vector3 vector = ((RaycastHit)(ref raycastHit)).transform.position - base.transform.position;
			vector.y = 0f;
			float num = Vector3.SignedAngle(vector, base.transform.rotation * Vector3.forward, Vector3.up);
			if (num > stopAngle.x && num < stopAngle.y)
			{
				moveComponent.SetPosition(base.transform.position, "碰撞矫正");
				moveComponent.SetRotation(base.transform.rotation, "碰撞矫正");
				if (isSkillMoveCancelXMove && isSkillMoveCancelZMove)
				{
					OnCurveMoveEnd();
				}
				else if (isSkillMoveCancelXMove)
				{
					curveMultiple.x = 0f;
				}
				else if (isSkillMoveCancelZMove)
				{
					curveMultiple.y = 0f;
				}
			}
		}
		else
		{
			if (!colliderPauseMove)
			{
				return;
			}
			if (moveComponent != null && moveComponent.CheckMovementCollision(maxDistance, checkDir, out var raycastHit2, _checkRadius))
			{
				Vector3 vector2 = ((RaycastHit)(ref raycastHit2)).transform.position - base.transform.position;
				vector2.y = 0f;
				float num2 = Vector3.SignedAngle(vector2, base.transform.rotation * Vector3.forward, Vector3.up);
				if (num2 > stopAngle.x && num2 < stopAngle.y)
				{
					moveComponent.SetPosition(base.transform.position, "碰撞矫正");
					moveComponent.SetRotation(base.transform.rotation, "碰撞矫正");
				}
				if (isSkillMoveCancelXMove)
				{
					curveMultiple.x = 0f;
				}
				if (isSkillMoveCancelZMove)
				{
					curveMultiple.y = 0f;
				}
			}
			else
			{
				curveMultiple = resumeCurveMultiple;
			}
		}
	}

	private void GetNextFrameTrans(float deltaTime, ref float percent, ref int tick, Quaternion quaternion, ref Vector3 pos, Vector2 multiple, bool setToEntity)
	{
		if (_movementTimeType == MovementTimeType.Time)
		{
			percent = Mathf.Clamp(percent + deltaTime, 0f, _curveTime);
		}
		else
		{
			tick = Mathf.Clamp(tick + 1, 0, _moveTick);
			percent = (float)tick * deltaTime;
		}
		if (curveRotation)
		{
			float animationCurveValue = GetAnimationCurveValue(curveRotX, percent);
			float animationCurveValue2 = GetAnimationCurveValue(curveRotY, percent);
			float animationCurveValue3 = GetAnimationCurveValue(curveRotZ, percent);
			Quaternion identity = Quaternion.identity;
			if (curveRotW != null)
			{
				float w = curveRotW.Evaluate(percent);
				identity = new Quaternion(animationCurveValue, animationCurveValue2, animationCurveValue3, w);
			}
			else
			{
				identity = Quaternion.Euler(animationCurveValue, animationCurveValue2, animationCurveValue3);
			}
			identity.Normalize();
			float y = ConvertToMinus180To180(_originRot.y + identity.eulerAngles.y);
			if (setToEntity)
			{
				moveComponent.SetRotation(Quaternion.Euler(new Vector3(0f, y, 0f)), "CurveMovementComponent");
			}
		}
		if (!curveMovement)
		{
			return;
		}
		if (_moveDirByRotate)
		{
			multiple = Utility.Math.Round(multiple);
			Vector3 value = new Vector3(Utility.Math.Round(GetAnimationCurveValue(curveX, percent) - GetAnimationCurveValue(curveX, lastCurvePercent)) * multiple.x, 0f, Utility.Math.Round(GetAnimationCurveValue(curveZ, percent) - GetAnimationCurveValue(curveZ, lastCurvePercent)) * multiple.y);
			value = Utility.Math.Round(value);
			Vector3 value2 = quaternion * value;
			value2 = Utility.Math.Round(value2);
			pos = base.transform.position + value2;
			if (setToEntity)
			{
				moveComponent.SetPosition(pos, "CurveMovementComponent._moveDirByRotate = true");
			}
		}
		else
		{
			Vector3 vector = new Vector3(Utility.Math.Round(GetAnimationCurveValue(curveX, percent) - GetAnimationCurveValue(curveX, lastCurvePercent)) * multiple.x, 0f, Utility.Math.Round(GetAnimationCurveValue(curveZ, percent) - GetAnimationCurveValue(curveZ, lastCurvePercent)) * multiple.y);
			Vector3 vector2 = Quaternion.Euler(_originRot) * vector;
			pos = base.transform.position + vector2;
			if (setToEntity)
			{
				moveComponent.SetPosition(pos, "CurveMovementComponent._moveDirByRotate = false");
				if (LockstepData.Instance != null)
				{
					LockstepData.Instance?.WriteAuthorityEntityId($"_moveDirByRotate = false  {_originPos}  distance  {vector2} ", mBaseEntity);
				}
			}
		}
		if (setToEntity)
		{
			lastCurvePercent = curvePercent;
		}
	}

	private Vector3 GetCheckDir(float deltaTime)
	{
		float percent = curvePercent;
		int tick = _tempTick;
		Quaternion rotation = base.transform.rotation;
		Vector3 pos = base.transform.position;
		GetNextFrameTrans(deltaTime, ref percent, ref tick, rotation, ref pos, resumeCurveMultiple, setToEntity: false);
		Vector3 vector = ((lastCurvePercent != 0f) ? (pos - base.transform.position) : (base.transform.rotation * Vector3.forward));
		if (vector.sqrMagnitude < 1E-06f)
		{
			vector = rotation * Vector3.forward;
		}
		return vector.normalized;
	}

	private float ConvertToMinus180To180(float angle)
	{
		angle %= 360f;
		if (angle > 180f)
		{
			angle -= 360f;
		}
		else if (angle < -180f)
		{
			angle += 360f;
		}
		return angle;
	}

	public void OnCurveMoveEnd()
	{
		isMoving = false;
		lastCurvePercent = 0f;
		mBaseEntity.GetComponent<EntityViewComponent>()?.IsOpenAnimatorMovement(isOpen: false);
	}

	private float GetAnimationCurveValue(AnimationCurve curve, float percent)
	{
		return curve?.Evaluate(percent) ?? 0f;
	}
}
