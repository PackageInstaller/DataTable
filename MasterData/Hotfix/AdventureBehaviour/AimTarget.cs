using System;
using TrueSync;

namespace AdventureBehaviour;

public class AimTarget
{
	protected AdventureActor _actor;

	private Action _onAimAnimEnd;

	private Action _onAnimInterrupted;

	public bool IsAimFinish
	{
		get
		{
			if (_actor == null)
			{
				return false;
			}
			if (_actor.aimWithStartAnim && _actor.comboGroup.aimStartAnimClip != null)
			{
				return false;
			}
			return _actor.aimMode != AdventureActor.AimMode.Forward;
		}
	}

	public void Aim(AdventureActor actor, AdventureActor target = null, TSVector2 direction = default(TSVector2), bool playStartAnim = false, Action onAimAnimEnd = null, Action onAnimInterrupted = null, int aimIndex = -1)
	{
		_actor = actor;
		if (target != null)
		{
			actor.AimAtTarget(target, default, aimIndex);
		}
		else
		{
			actor.Aim(direction);
		}
		actor.aimWithStartAnim = playStartAnim;
		if (playStartAnim)
		{
			_onAimAnimEnd = onAimAnimEnd;
			_onAnimInterrupted = onAnimInterrupted;
			ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_AIM_START_ANIM_PLAY_END", OnStartAnimPlayEnd);
			ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_AIM_START_ANIM_INTERRUPTED", OnStartAnimInterrupted);
		}
	}

	protected void OnStartAnimPlayEnd(IEvent e)
	{
		_onAimAnimEnd?.Invoke();
		_actor.aimWithStartAnim = false;
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_AIM_START_ANIM_PLAY_END", OnStartAnimPlayEnd);
	}

	protected void OnStartAnimInterrupted(IEvent e)
	{
		_onAnimInterrupted?.Invoke();
		_actor.aimWithStartAnim = false;
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_AIM_START_ANIM_INTERRUPTED", OnStartAnimInterrupted);
	}

	public void AimTargetEntity(AdventureActor actor, LogicEntity target = null, int aimIndex = -1)
	{
		_actor = actor;
		if (actor != null)
		{
			actor.AimAtTarget(target, default, aimIndex);
		}
	}

	public void Cancel()
	{
		if (_actor != null)
		{
			_actor.CancelAiming();
			_actor.aimWithStartAnim = false;
		}
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_AIM_START_ANIM_PLAY_END", OnStartAnimPlayEnd);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_AIM_START_ANIM_INTERRUPTED", OnStartAnimInterrupted);
	}

	public void Clear()
	{
		_actor = null;
	}
}
