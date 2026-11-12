using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Utils;

public class Skill_Free
{
	protected AdventureActor _actor;

	private AdventureSkill skill;

	private DeterministicShape _shape;

	protected CoroutineNode _waitCoroutine;

	protected LookAtTarget _lookAtTarget;

	protected FP maxTime;

	public void _onStart(AdventureActor actor, bool _playerCenter, FP _radius, FP _innerRadius, FP _angle, FP _rotation, FP _maxTime, AdventureSkill _skill, bool useLineRotate = false)
	{
		_actor = actor;
		_shape.shapeType = DeterministicShape.ShapeType.Fan;
		_shape.angle = _angle;
		_shape.radius = _radius;
		_shape.innerRadius = _innerRadius;
		skill = _skill;
		maxTime = _maxTime;
		_actor.logicVariable?.ToggleLogicTag("ExecutingCanBreakSkill", value: true);
		if (_playerCenter)
		{
			LogicEntity monsterTarget = _actor.monsterTarget;
			if (monsterTarget == null)
			{
				skill.Clear();
				return;
			}
			_shape.position = monsterTarget.tsTransform.Position;
			if (!useLineRotate)
			{
				_shape.rotation = monsterTarget.tsTransform.Rotation360 + _rotation;
			}
			else
			{
				_shape.rotation = (_actor.tsTransform.Position - monsterTarget.tsTransform.Position).GetAngle() + _rotation;
			}
		}
		else
		{
			_shape.position = _actor.tsTransform.Position;
			if (!useLineRotate)
			{
				_shape.rotation = _actor.tsTransform.Rotation360 + _rotation;
			}
			else
			{
				LogicEntity monsterTarget2 = _actor.monsterTarget;
				if (monsterTarget2 == null)
				{
					skill.Clear();
					return;
				}
				_shape.rotation = (monsterTarget2.tsTransform.Position - _actor.tsTransform.Position).GetAngle() + _rotation;
			}
		}
		toRandomPoint();
		_waitCoroutine = _actor.StartLogicCoroutine(waitCoroutine());
	}

	public void clear()
	{
		_actor.logicVariable?.ToggleLogicTag("ExecutingCanBreakSkill", value: false);
		if (_waitCoroutine != null)
		{
			_actor.StopLogicCoroutine(_waitCoroutine);
			_waitCoroutine = null;
		}
		_lookAtTarget?.Clear();
	}

	protected void toRandomPoint()
	{
		TSVector2 targetPosition = _actor.RandomActorReachablePointInsideShape(_shape);
		_actor.MoveTo(targetPosition, 0.1, enableNavigation: true, AdventureActor.MovementMode.Run, () =>
		{
			LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
			if (activedPlayerActor != null)
			{
				if (_lookAtTarget == null)
				{
					_lookAtTarget = new LookAtTarget();
				}
				_lookAtTarget.BeginLookAtByPos(_actor, activedPlayerActor.tsTransform.Position, 0, 0, () =>
				{
					skill.Clear();
				});
			}
		});
	}

	private IEnumerator waitCoroutine()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(maxTime));
		skill.Clear();
	}
}
