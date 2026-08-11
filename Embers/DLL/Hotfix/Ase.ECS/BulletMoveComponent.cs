using UnityEngine;

namespace Ase.ECS;

public class BulletMoveComponent : BaseComponent
{
	private BulletData _bulletData;

	private bool moveFlag;

	private bool isRayState;

	private float timer;

	private float moveTime = 1f;

	private MovementTrajectoryData _movementTrajectoryData;

	private MovementTrajectoryData _overrideTrajectoryData;

	public MovementTrajectoryData MovementTrajectoryData => _movementTrajectoryData;

	public override void OnAwake(object data = null)
	{
		_bulletData = GetData<BulletData>("bulletData");
		moveFlag = _bulletData.cfg.MovementTrajectoryTypeEnum != MovementTrajectoryTypeEnum.NoMove;
	}

	public void SetRayState(bool state = false)
	{
		isRayState = state;
	}

	public void SetPosition(Vector3 position)
	{
		position = position.FloorRound();
		base.transform.position = position;
	}

	public void SetPosition(Vector3 position, float stableMovementSharpness, float deltaTime)
	{
		position = position.Round2();
		base.transform.position = Vector3.Lerp(base.transform.position, position, 1f - Mathf.Exp((0f - stableMovementSharpness) * deltaTime));
	}

	public void SetRotation(Quaternion rotation)
	{
		base.transform.rotation = rotation;
	}

	public void SetRotation(Quaternion rotation, float stableRotationSharpness, float deltaTime)
	{
		base.transform.rotation = Quaternion.Lerp(base.transform.rotation, rotation, deltaTime * stableRotationSharpness);
	}

	public bool OverrideTrajectoryData()
	{
		if (_overrideTrajectoryData != null)
		{
			_movementTrajectoryData = _overrideTrajectoryData.CopySelf();
			return true;
		}
		return false;
	}

	public void ClearOverrideTrajectoryData()
	{
		if (_overrideTrajectoryData != null)
		{
			_overrideTrajectoryData = null;
		}
	}

	public void DoLinearMoveUpdate(float deltaTime)
	{
		if (!mBaseEntity.IsSurvival || !moveFlag)
		{
			return;
		}
		timer += deltaTime;
		if (timer >= _movementTrajectoryData.MoveTime)
		{
			moveFlag = false;
			timer = 0f;
			SetPosition(_movementTrajectoryData.TargetPoint);
			if (_bulletData.cfg.BulletLifeTypeEnum == BulletLifeTypeEnum.MoveTime)
			{
				mBaseEntity.DoEntityDead();
			}
		}
		else
		{
			SetPosition(_movementTrajectoryData.GetNextPoint(base.transform.position, deltaTime));
		}
	}

	public Vector3 GetLinearMovePoint(float deltaTime)
	{
		return _movementTrajectoryData.GetNextPoint(base.transform.position, deltaTime);
	}

	public void SetToLinearMove()
	{
		if (_bulletData.cfg.MotionParameter.Count >= 4)
		{
			moveTime = _bulletData.cfg.MotionParameter[3];
			moveTime = ((moveTime < 0f) ? mBaseEntity.GetComponent<BulletLifeComponent>().TotalLifeTime : moveTime);
			float num = _bulletData.cfg.MotionParameter[2];
			num = ((num < 0f) ? mBaseEntity.GetComponent<BulletLifeComponent>().TotalLifeTime : ((num >= moveTime) ? moveTime : num));
			num = ((num >= moveTime) ? moveTime : num);
			if (_bulletData.cfg.MovementTrajectoryTypeEnum == MovementTrajectoryTypeEnum.LinearMove)
			{
				_movementTrajectoryData = LinearMoveTrajectoryData.Create(base.transform.position, mBaseEntity.transform.rotation, _bulletData.cfg.MotionParameter[0], _bulletData.cfg.MotionParameter[1], num, moveTime);
			}
		}
	}

	public void SetToLinearMove(float velocity, float angle, bool isAbsolutely)
	{
		if (_movementTrajectoryData.TrajectoryTypeEnum == MovementTrajectoryTypeEnum.LinearMove)
		{
			LinearMoveTrajectoryData linearMoveTrajectoryData = LinearMoveTrajectoryData.Create((LinearMoveTrajectoryData)_movementTrajectoryData);
			linearMoveTrajectoryData.OverrideCurVel(velocity, angle, isAbsolutely, timer, base.transform.position);
			_overrideTrajectoryData?.Clear();
			_overrideTrajectoryData = linearMoveTrajectoryData;
			OverrideTrajectoryData();
			SetRotation(Quaternion.Euler(base.transform.eulerAngles + new Vector3(0f, angle, 0f)));
		}
	}

	public void SetToTrackedMove()
	{
		if (_bulletData.cfg.MotionParameter.Count >= 4)
		{
			moveTime = _bulletData.cfg.MotionParameter[3];
			moveTime = ((moveTime < 0f) ? mBaseEntity.GetComponent<BulletLifeComponent>().TotalLifeTime : moveTime);
			float num = _bulletData.cfg.MotionParameter[2];
			num = ((num < 0f) ? mBaseEntity.GetComponent<BulletLifeComponent>().TotalLifeTime : ((num >= moveTime) ? moveTime : num));
			num = ((num >= moveTime) ? moveTime : num);
			if (_bulletData.extraData.moveData is BulletTrackedData trackedData && _bulletData.cfg.MovementTrajectoryTypeEnum == MovementTrajectoryTypeEnum.Tracked)
			{
				_movementTrajectoryData = TrackedTrajectoryData.Create(mBaseEntity, base.transform.position, mBaseEntity.transform.rotation, _bulletData.cfg.MotionParameter[0], _bulletData.cfg.MotionParameter[1], num, moveTime, trackedData);
			}
		}
	}

	public void DoTrackedMoveUpdate(float deltaTime)
	{
		if (mBaseEntity.IsSurvival && moveFlag)
		{
			SetRotation(_movementTrajectoryData.GetNextQuaternion(base.transform.rotation, deltaTime));
			SetPosition(_movementTrajectoryData.GetNextPoint(base.transform.position, deltaTime));
		}
	}

	public void DoFollowMoveUpdate(float deltaTime)
	{
		if (!mBaseEntity.IsSurvival || isRayState || !moveFlag)
		{
			return;
		}
		timer += deltaTime;
		if (timer >= _movementTrajectoryData.MoveTime)
		{
			moveFlag = false;
			timer = 0f;
			SetPosition(_movementTrajectoryData.TargetPoint);
			if (_bulletData.cfg.BulletLifeTypeEnum == BulletLifeTypeEnum.MoveTime)
			{
				mBaseEntity.DoEntityDead();
			}
		}
		else
		{
			SetPosition(GetFollowMovePoint(deltaTime));
			SetRotation(_movementTrajectoryData.GetNextQuaternion(base.transform.rotation, deltaTime));
		}
	}

	public Vector3 GetFollowMovePoint(float deltaTime)
	{
		return _movementTrajectoryData.GetNextPoint(deltaTime);
	}

	public void SetToFollowMove()
	{
		moveTime = mBaseEntity.GetComponent<BulletLifeComponent>().TotalLifeTime;
		if (_bulletData.cfg.MovementTrajectoryTypeEnum == MovementTrajectoryTypeEnum.FollowMove)
		{
			BaseEntity baseEntity = mBaseEntity.Parent;
			if (_bulletData.extraData.moveData != null && _bulletData.extraData.moveData is BulletFollowMoveData bulletFollowMoveData)
			{
				baseEntity = mBaseEntity.GetSystem<EntitySystem>().GetEntity(bulletFollowMoveData.followTargetId);
				if (baseEntity == null)
				{
					mBaseEntity.DoEntityRelease();
					return;
				}
			}
			Vector3 moveOffset = Quaternion.Inverse(baseEntity.transform.rotation) * (mBaseEntity.transform.position - baseEntity.transform.position);
			_movementTrajectoryData = FollowMoveTrajectoryData.Create(moveOffset, new Vector3(0f, mBaseEntity.transform.eulerAngles.y - baseEntity.transform.eulerAngles.y, 0f), moveTime, baseEntity);
		}
		else
		{
			if (_bulletData.cfg.MotionParameter.Count < 3)
			{
				return;
			}
			_movementTrajectoryData = FollowMoveTrajectoryData.Create(base.transform.position, _bulletData.cfg.MotionParameter[1], _bulletData.cfg.MotionParameter[0], mBaseEntity.Parent.transform.position - base.transform.position, _bulletData.cfg.MotionParameter[2] != 0f, moveTime, mBaseEntity.Parent.transform.position, (_bulletData.cfg.MovementTrajectoryTypeEnum == MovementTrajectoryTypeEnum.RotateAround) ? null : mBaseEntity.Parent);
		}
		SetPosition(GetFollowMovePoint(0f));
	}

	public void SetToFollowTargetRotate(BaseEntity target, Vector3 worldOffset, Vector3 localOffset, float speed, float radius, bool isClockwise)
	{
		if (target != null)
		{
			moveTime = mBaseEntity.GetComponent<BulletLifeComponent>().TotalLifeTime;
			_overrideTrajectoryData?.Clear();
			FollowMoveTrajectoryData followMoveTrajectoryData = FollowMoveTrajectoryData.Create(base.transform.position, speed, radius, base.transform.position - target.transform.position, isClockwise, moveTime, Vector3.zero, target);
			followMoveTrajectoryData.OverrideTargetPoint(target, Vector3.zero, worldOffset, localOffset);
			_overrideTrajectoryData = followMoveTrajectoryData;
			OverrideTrajectoryData();
			SetPosition(GetFollowMovePoint(0f));
		}
	}

	public void SetToFollowFixedPointRotate(Vector3 followPoint, float speed, float radius, bool isClockwise)
	{
		moveTime = mBaseEntity.GetComponent<BulletLifeComponent>().TotalLifeTime;
		_overrideTrajectoryData?.Clear();
		_overrideTrajectoryData = FollowMoveTrajectoryData.Create(base.transform.position, speed, radius, base.transform.position - followPoint, isClockwise, moveTime, followPoint);
		OverrideTrajectoryData();
		SetPosition(GetFollowMovePoint(0f));
	}

	public void SetToFollowMove(float radius, float radiusAcTime, float speed, float lerpSpeed, float speedAcTime, bool isClockwise, BaseEntity target, Vector3 point, Vector3 worldOffset, Vector3 localOffset)
	{
		if (_movementTrajectoryData.TrajectoryTypeEnum == MovementTrajectoryTypeEnum.RotateAround || _movementTrajectoryData.TrajectoryTypeEnum == MovementTrajectoryTypeEnum.FollowAndRotateAround)
		{
			FollowMoveTrajectoryData followMoveTrajectoryData = FollowMoveTrajectoryData.Create((FollowMoveTrajectoryData)_movementTrajectoryData);
			followMoveTrajectoryData.OverrideAcAndTime(radiusAcTime, radius, speedAcTime, speed);
			followMoveTrajectoryData.OverrideClockwise(isClockwise);
			followMoveTrajectoryData.OverrideTargetPoint(target, point, worldOffset, localOffset);
			followMoveTrajectoryData.OverrideLerpSpeed(lerpSpeed);
			_overrideTrajectoryData?.Clear();
			_overrideTrajectoryData = followMoveTrajectoryData;
			OverrideTrajectoryData();
		}
	}

	public void DoParabolicMoveUpdate(float deltaTime)
	{
		if (!mBaseEntity.IsSurvival || !moveFlag)
		{
			return;
		}
		timer += deltaTime;
		if (timer >= _movementTrajectoryData.MoveTime)
		{
			moveFlag = false;
			timer = 0f;
			SetPosition(_movementTrajectoryData.TargetPoint);
			if (_bulletData.cfg.BulletLifeTypeEnum == BulletLifeTypeEnum.MoveTime)
			{
				mBaseEntity.DoEntityDead();
			}
		}
		else
		{
			SetPosition(_movementTrajectoryData.GetNextPoint(timer), 15f, deltaTime);
		}
	}

	public Vector3 GetParabolicMovePoint(float deltaTime)
	{
		return _movementTrajectoryData.GetNextPoint(timer);
	}

	public void SetToParabolaMove()
	{
		if (_bulletData.cfg.MotionParameter.Count >= 3)
		{
			moveTime = ((_bulletData.cfg.MotionParameter[2] < 0f) ? mBaseEntity.GetComponent<BulletLifeComponent>().TotalLifeTime : _bulletData.cfg.MotionParameter[2]);
			_movementTrajectoryData = ParabolaMoveTrajectoryData.Create(base.transform.position, base.transform.rotation * new Vector3(0f, 0f, _bulletData.cfg.MotionParameter[0]), base.transform.position + base.transform.rotation * new Vector3(0f, 0f, _bulletData.cfg.MotionParameter[0]), _bulletData.cfg.MotionParameter[1], moveTime);
		}
	}

	public void SetToParabolaMove(Vector3 targetPoint, float height, float time)
	{
		if (_movementTrajectoryData.TrajectoryTypeEnum == MovementTrajectoryTypeEnum.Parabola)
		{
			moveFlag = true;
			moveTime = ((time < 0f) ? mBaseEntity.GetComponent<BulletLifeComponent>().TotalLifeTime : time);
			_overrideTrajectoryData?.Clear();
			_overrideTrajectoryData = ParabolaMoveTrajectoryData.Create(base.transform.position, targetPoint - base.transform.position, targetPoint, height, moveTime);
			OverrideTrajectoryData();
		}
	}

	public void DoCurveMoveUpdate(float deltaTime)
	{
		if (!mBaseEntity.IsSurvival || !moveFlag)
		{
			return;
		}
		timer += deltaTime;
		if (timer >= _movementTrajectoryData.MoveTime)
		{
			moveFlag = false;
			timer = 0f;
			SetPosition(_movementTrajectoryData.TargetPoint);
			if (_bulletData.cfg.BulletLifeTypeEnum == BulletLifeTypeEnum.MoveTime)
			{
				mBaseEntity.DoEntityDead();
			}
		}
		else
		{
			SetPosition(_movementTrajectoryData.GetNextPoint(deltaTime));
			SetRotation(_movementTrajectoryData.GetNextQuaternion(base.transform.rotation, deltaTime));
		}
	}

	public void SetToCurveMove(AnimationCurveData curveX, AnimationCurveData curveY, AnimationCurveData curveZ, bool isFollowParent)
	{
		moveFlag = true;
		_overrideTrajectoryData?.Clear();
		_overrideTrajectoryData = CurveMoveTrajectoryData.Create(curveX, curveY, curveZ, isFollowParent ? mBaseEntity.Parent.transform.position : mBaseEntity.transform.position, isFollowParent ? mBaseEntity.Parent.transform.rotation : mBaseEntity.transform.rotation, isFollowParent, mBaseEntity.Parent);
		moveTime = _overrideTrajectoryData.MoveTime;
		OverrideTrajectoryData();
	}

	public void SetToCurveRotate(AnimationCurveRotateDataBase curveRotate)
	{
		CurveMoveTrajectoryData curveMoveTrajectoryData = (CurveMoveTrajectoryData)_overrideTrajectoryData.CopySelf();
		curveMoveTrajectoryData.OverrideCureveRotate(curveRotate);
		_overrideTrajectoryData = curveMoveTrajectoryData;
		OverrideTrajectoryData();
	}

	public override void OnDispose()
	{
		base.OnDispose();
		_bulletData = null;
		_movementTrajectoryData?.Dispose();
		_overrideTrajectoryData?.Dispose();
	}
}
