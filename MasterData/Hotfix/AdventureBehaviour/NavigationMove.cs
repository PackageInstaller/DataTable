using System;
using TrueSync;

namespace AdventureBehaviour;

public class NavigationMove
{
	protected AdventureActor _actor;

	protected Action _onComplete;

	public void MoveTo(AdventureActor actor, TSVector2 targetPosition, FP stopDistance, Action onComplete = null, AdventureActor.MovementMode movmentMode = AdventureActor.MovementMode.Run)
	{
		_actor = actor;
		_onComplete = onComplete;
		if (stopDistance <= 0f)
		{
			stopDistance = actor.dtCollider.Radius;
		}
		if (!actor.MoveTo(targetPosition, stopDistance, enableNavigation: true, movmentMode, null, randomMove: false, forceMove: false, default, onComplete))
		{
			onComplete?.Invoke();
		}
	}

	public void Break()
	{
		if (_actor != null && _actor.movementState == ActorState.Move)
		{
			_actor.StandBy();
		}
		_onComplete?.Invoke();
	}

	public void Clear()
	{
		_actor = null;
		_onComplete = null;
	}
}
