using System;
using System.Collections;
using TrueSync;

namespace AdventureBehaviour;

public class SpecialDodge
{
	private AdventureActor _actor;

	private Action _onComplete;

	private Action _onLeave;

	private CoroutineNode _dodgeCor;

	public void Begin(AdventureActor actor, TSVector2 direction, FP duration, FP distance, Action onComplete = null, Action onLeave = null)
	{
		if (actor == null || duration <= 0f || distance <= 0f)
		{
			onLeave?.Invoke();
			return;
		}
		_actor = actor;
		_onComplete = onComplete;
		_onLeave = onLeave;
		if (_actor.CheckPerfectDodge())
		{
			_actor.EnterPerfectDodge();
		}
		_dodgeCor = _actor.StartLogicCoroutine(DodgeMove(direction, duration, distance), runImmediately: true);
	}

	protected IEnumerator DodgeMove(TSVector2 direction, FP duration, FP distance)
	{
		_actor.specialDodgeMode = true;
		_actor.EnableSuperArmor();
		_actor.EnableInvincible();
		_actor.PauseMovementBlock();
		FP lastTime = duration;
		FP moveSpeed = distance / duration;
		while (lastTime > 0)
		{
			FP logicDeltaTime = _actor.LogicDeltaTime;
			_actor.velocitySpeed = moveSpeed;
			_actor.velocityDirection = direction;
			_actor.movAgent.Move(new TSVector(_actor.velocity.x * logicDeltaTime, 0, _actor.velocity.y * logicDeltaTime));
			lastTime -= logicDeltaTime;
			yield return null;
		}
		_actor.specialDodgeMode = false;
		_actor.DisableSuperArmor();
		_actor.DisableInvincible();
		_actor.ResumeMovementBlock();
		_onComplete?.Invoke();
		_onLeave?.Invoke();
		_dodgeCor = null;
	}

	public void Interrupte()
	{
		if (!(_actor == null) && _dodgeCor != null)
		{
			_actor.StopLogicCoroutine(_dodgeCor);
			_dodgeCor = null;
			_actor.specialDodgeMode = false;
			_actor.DisableSuperArmor();
			_actor.DisableInvincible();
			_actor.ResumeMovementBlock();
			_onLeave?.Invoke();
			_dodgeCor = null;
		}
	}

	public void Clear()
	{
		if (_actor != null && _actor.specialDodgeMode)
		{
			Interrupte();
		}
		_onComplete = null;
		_onLeave = null;
		_actor = null;
	}
}
