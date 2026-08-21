using GameFramework;

namespace Ase.ECS;

public class PersistentLogicBullet : LogicBullet
{
	private BulletLifeComponent bulletLifeComponent;

	private BulletMoveComponent moveComponent;

	private BulletTriggerComponent bulletTriggerComponent;

	public override void OnInit(object data)
	{
		base.OnInit(data);
	}

	public override void OnStart()
	{
		bulletLifeComponent = bullet.GetComponent<BulletLifeComponent>();
		moveComponent = bullet.GetComponent<BulletMoveComponent>();
		bulletTriggerComponent = bullet.GetComponent<BulletTriggerComponent>();
		InitMovementComponent();
	}

	public override void OnFixedUpdate(float deltaTime)
	{
		if (bullet != null)
		{
			bulletLifeComponent?.DoUpdateLife(deltaTime);
			MovementComponentUpdate(deltaTime);
			bulletTriggerComponent?.DoTriggerUpdate(deltaTime);
		}
	}

	public override void OnDead()
	{
		base.OnDead();
		if (bullet != null)
		{
			bulletTriggerComponent?.OnNormalDead();
			bulletLifeComponent?.DoEndLife();
		}
		moveComponent = null;
	}

	private void InitMovementComponent()
	{
		if (moveComponent.OverrideTrajectoryData())
		{
			moveComponent.ClearOverrideTrajectoryData();
			return;
		}
		switch (_bulletData.cfg.MovementTrajectoryTypeEnum)
		{
		case MovementTrajectoryTypeEnum.Parabola:
			moveComponent.SetToParabolaMove();
			break;
		case MovementTrajectoryTypeEnum.FollowMove:
			moveComponent.SetToFollowMove();
			break;
		case MovementTrajectoryTypeEnum.FollowAndRotateAround:
			moveComponent.SetToFollowMove();
			break;
		case MovementTrajectoryTypeEnum.RotateAround:
			moveComponent.SetToFollowMove();
			break;
		case MovementTrajectoryTypeEnum.LinearMove:
			moveComponent.SetToLinearMove();
			break;
		case MovementTrajectoryTypeEnum.Tracked:
			moveComponent.SetToTrackedMove();
			break;
		case MovementTrajectoryTypeEnum.LinearMoveToPoint:
		case MovementTrajectoryTypeEnum.LinearMoveByDirect:
		case MovementTrajectoryTypeEnum.Curve:
			break;
		}
	}

	private void MovementComponentUpdate(float deltaTime)
	{
		if (moveComponent?.MovementTrajectoryData != null)
		{
			switch (moveComponent.MovementTrajectoryData.TrajectoryTypeEnum)
			{
			case MovementTrajectoryTypeEnum.Parabola:
				moveComponent.DoParabolicMoveUpdate(deltaTime);
				break;
			case MovementTrajectoryTypeEnum.FollowMove:
				moveComponent.DoFollowMoveUpdate(deltaTime);
				break;
			case MovementTrajectoryTypeEnum.FollowAndRotateAround:
				moveComponent.DoFollowMoveUpdate(deltaTime);
				break;
			case MovementTrajectoryTypeEnum.RotateAround:
				moveComponent.DoFollowMoveUpdate(deltaTime);
				break;
			case MovementTrajectoryTypeEnum.LinearMove:
				moveComponent.DoLinearMoveUpdate(deltaTime);
				break;
			case MovementTrajectoryTypeEnum.Curve:
				moveComponent.DoCurveMoveUpdate(deltaTime);
				break;
			case MovementTrajectoryTypeEnum.Tracked:
				moveComponent.DoTrackedMoveUpdate(deltaTime);
				break;
			case MovementTrajectoryTypeEnum.LinearMoveToPoint:
			case MovementTrajectoryTypeEnum.LinearMoveByDirect:
				break;
			}
		}
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
