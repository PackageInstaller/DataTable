using TrueSync;

namespace AIScript.Utils;

public class Skill_Wander
{
	private FP _skillDuration = 10;

	private FP _moveTime = 2;

	private FP _moveCd = 0.5;

	private FP _nearDistance = 4;

	private FP _farDistance = 8;

	private FP _angle = 30;

	private FP _rotation = 30;

	private FP _aimSpeed = 30;

	private FP _changeAngle = 60;

	private FP _newAimSpeed = 180;

	private AdventureActor _actor;

	private AdventureSkill _skill;

	private DeterministicShape _shape;

	private int step;

	private bool isStepChange;

	private FP stepWalkTime;

	private FP waitTime;

	private FP rotateCD;

	public void clear()
	{
		_actor.logicVariable?.ToggleLogicTag("ExecutingCanBreakSkill", value: false);
		_actor.StandBy();
		_actor.CancelAiming();
		_actor = null;
		_skill = null;
	}

	public void _onStart(AdventureActor actor, FP skillDuration, FP moveTime, FP moveCd, FP nearDistance, FP farDistance, FP angle, FP rotation, FP aimSpeed, FP changeAngle, FP newAimSpeed, AdventureSkill skill)
	{
		_actor = actor;
		_skill = skill;
		_skillDuration = skillDuration;
		_moveTime = moveTime;
		_moveCd = moveCd;
		_farDistance = farDistance * farDistance;
		_angle = angle;
		_rotation = rotation;
		_aimSpeed = aimSpeed;
		_changeAngle = changeAngle;
		_newAimSpeed = newAimSpeed;
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		stepWalkTime = moveTime;
		_actor.logicVariable?.ToggleLogicTag("ExecutingCanBreakSkill", value: true);
		if (_actor != null && activedPlayerActor != null)
		{
			_shape.shapeType = DeterministicShape.ShapeType.Fan;
			_shape.angle = _angle;
			_shape.radius = farDistance;
			_nearDistance = _actor.actorInfo.walkSpeed * 2;
			_nearDistance = ((_nearDistance < nearDistance) ? _nearDistance : nearDistance);
			_shape.innerRadius = _nearDistance;
			_nearDistance *= _nearDistance;
			_actor.AimAtTarget(activedPlayerActor, _aimSpeed);
			step = 0;
		}
		FP fP = TSVector2.DistanceSquared(activedPlayerActor.tsTransform.Position, _actor.tsTransform.Position);
		if (fP < _nearDistance)
		{
			step = 1;
		}
		else if (fP < _farDistance)
		{
			step = 2;
		}
		else
		{
			step = 3;
		}
	}

	protected void toRandomPoint()
	{
		TSVector2 targetPosition = _actor.RandomActorReachablePointInsideShape(_shape);
		_actor.MoveTo(targetPosition, 0.1, enableNavigation: true, AdventureActor.MovementMode.Walk, () =>
		{
			if (SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor != null)
			{
				stepWalkTime = _moveTime;
			}
		});
	}

	private bool isAngleMax()
	{
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		if (activedPlayerActor == null)
		{
			return false;
		}
		return TSVector2.Angle(_actor.tsTransform.Forward, _actor.tsTransform.Position - activedPlayerActor.tsTransform.Position) > _changeAngle;
	}

	public void OnUpdate()
	{
		if (_actor == null || _skill == null)
		{
			return;
		}
		_skillDuration -= _actor.LogicDeltaTime;
		stepWalkTime += _actor.LogicDeltaTime;
		waitTime -= _actor.LogicDeltaTime;
		rotateCD -= _actor.LogicDeltaTime;
		if (_skillDuration < 0)
		{
			_skill.Clear();
			return;
		}
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		if (activedPlayerActor == null)
		{
			return;
		}
		if (rotateCD <= 0 && isAngleMax())
		{
			_actor.CancelAiming();
			_actor.AimAtTarget(activedPlayerActor, _newAimSpeed);
			rotateCD = 0.5;
		}
		if (stepWalkTime <= _moveTime)
		{
			return;
		}
		FP fP = TSVector2.DistanceSquared(activedPlayerActor.tsTransform.Position, _actor.tsTransform.Position);
		if ((fP < _nearDistance) & (stepWalkTime > _moveTime))
		{
			if (step == 1)
			{
				isStepChange = false;
			}
			else
			{
				isStepChange = true;
			}
			waitTime = _moveCd;
			stepWalkTime = 0;
			step = 1;
			TSVector2 normalized = (_actor.tsTransform.Position - activedPlayerActor.tsTransform.Position).normalized;
			_actor.Move(normalized);
		}
		else if ((fP < _farDistance) & (stepWalkTime > _moveTime))
		{
			if (step == 2)
			{
				isStepChange = false;
			}
			else
			{
				isStepChange = true;
			}
			waitTime = _moveCd;
			stepWalkTime = 0;
			step = 2;
			_shape.position = activedPlayerActor.tsTransform.Position;
			FP angle = (_actor.tsTransform.Position - activedPlayerActor.tsTransform.Position).GetAngle();
			if (TSRandom.Range(0, 10) <= 5)
			{
				_shape.rotation = angle + _rotation;
			}
			else
			{
				_shape.rotation = angle - _rotation;
			}
			toRandomPoint();
		}
		else
		{
			if (step == 3)
			{
				isStepChange = false;
			}
			else
			{
				isStepChange = true;
			}
			waitTime = _moveCd;
			stepWalkTime = 0;
			step = 3;
			TSVector2 normalized2 = (activedPlayerActor.tsTransform.Position - _actor.tsTransform.Position).normalized;
			_actor.Move(normalized2);
		}
	}
}
