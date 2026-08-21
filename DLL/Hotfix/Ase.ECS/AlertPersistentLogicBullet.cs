using GameFramework;

namespace Ase.ECS;

public class AlertPersistentLogicBullet : LogicBullet
{
	private BulletMoveComponent _moveComponent;

	private BulletLifeComponent bulletLifeComponent;

	private BulletTriggerComponent bulletTriggerComponent;

	public override void OnStart()
	{
		_moveComponent = bullet.GetComponent<BulletMoveComponent>();
		bulletLifeComponent = bullet.GetComponent<BulletLifeComponent>();
		bulletTriggerComponent = bullet.GetComponent<BulletTriggerComponent>();
		InitMovementComponent();
	}

	public override void OnFixedUpdate(float deltaTime)
	{
		bulletLifeComponent?.DoUpdateLife(deltaTime);
		MovementComponentUpdate(deltaTime);
		bulletTriggerComponent?.DoAlertTriggerUpdate(deltaTime);
	}

	private void InitMovementComponent()
	{
		if (bullet.GetComponent<BulletMoveComponent>().OverrideTrajectoryData())
		{
			bullet.GetComponent<BulletMoveComponent>().ClearOverrideTrajectoryData();
			return;
		}
		switch (_bulletData.cfg.MovementTrajectoryTypeEnum)
		{
		case MovementTrajectoryTypeEnum.Parabola:
			_moveComponent?.SetToParabolaMove();
			break;
		case MovementTrajectoryTypeEnum.FollowMove:
			_moveComponent?.SetToFollowMove();
			break;
		case MovementTrajectoryTypeEnum.FollowAndRotateAround:
			_moveComponent?.SetToFollowMove();
			break;
		case MovementTrajectoryTypeEnum.RotateAround:
			_moveComponent?.SetToFollowMove();
			break;
		case MovementTrajectoryTypeEnum.LinearMove:
			_moveComponent?.SetToLinearMove();
			break;
		case MovementTrajectoryTypeEnum.LinearMoveToPoint:
		case MovementTrajectoryTypeEnum.LinearMoveByDirect:
			break;
		}
	}

	private void MovementComponentUpdate(float deltaTime)
	{
		if (_moveComponent?.MovementTrajectoryData != null)
		{
			switch (_moveComponent.MovementTrajectoryData.TrajectoryTypeEnum)
			{
			case MovementTrajectoryTypeEnum.Parabola:
				_moveComponent.DoParabolicMoveUpdate(deltaTime);
				break;
			case MovementTrajectoryTypeEnum.FollowMove:
				_moveComponent.DoFollowMoveUpdate(deltaTime);
				break;
			case MovementTrajectoryTypeEnum.FollowAndRotateAround:
				_moveComponent?.DoFollowMoveUpdate(deltaTime);
				break;
			case MovementTrajectoryTypeEnum.RotateAround:
				_moveComponent.DoFollowMoveUpdate(deltaTime);
				break;
			case MovementTrajectoryTypeEnum.LinearMove:
				_moveComponent.DoLinearMoveUpdate(deltaTime);
				break;
			case MovementTrajectoryTypeEnum.Curve:
				_moveComponent.DoCurveMoveUpdate(deltaTime);
				break;
			case MovementTrajectoryTypeEnum.LinearMoveToPoint:
			case MovementTrajectoryTypeEnum.LinearMoveByDirect:
				break;
			}
		}
	}

	public override void OnDead()
	{
		base.OnDead();
		_moveComponent = null;
		bulletTriggerComponent?.OnNormalDead();
	}

	public override void OnDispose()
	{
		ReferencePool.Release(this);
	}

	protected override void OnClear()
	{
		bulletLifeComponent = null;
		bulletTriggerComponent = null;
	}
}
