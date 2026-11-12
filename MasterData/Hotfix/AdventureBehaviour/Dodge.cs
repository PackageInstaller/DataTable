using System;
using TrueSync;

namespace AdventureBehaviour;

public class Dodge
{
	protected AdventureActor _actor;

	public void Begin(AdventureActor actor, TSVector2 direction, FP duration, FP distance, Action onComplete = null, bool comboWithAttack = false, bool notChangeForward = false, Action onLeave = null)
	{
		if (duration <= 0f || distance < 0f)
		{
			onComplete?.Invoke();
			onLeave?.Invoke();
			return;
		}
		_actor = actor;
		if (!actor.Dodge(direction, distance, duration, onComplete, onLeave, comboWithAttack, !notChangeForward))
		{
			onComplete?.Invoke();
			onLeave?.Invoke();
		}
	}

	public void Interrupte()
	{
		if (_actor != null && _actor.movementState == ActorState.Dodge)
		{
			_actor.StandBy();
		}
	}
}
