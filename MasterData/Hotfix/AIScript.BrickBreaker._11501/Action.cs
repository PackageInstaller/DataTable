using TrueSync;

namespace AIScript.BrickBreaker._11501;

public class Action : BrickActorAction
{
	private readonly FP inTime = 15;

	private readonly string infx = "fx_11501_loop_Shield_breakout";

	private FP time_inv;

	private AdventureFXPlayer currentFx;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		time_inv = 0;
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		currentFx?.Stop();
		currentFx = null;
	}

	public override void OnStart()
	{
		base.OnStart();
	}

	public override void OnStop()
	{
		base.OnStop();
	}

	protected override void ActorCastSkill()
	{
		base.ActorCastSkill();
		time_inv = inTime;
	}

	public void OnUpdate()
	{
		time_inv -= _actor.LogicDeltaTime;
		if (time_inv > 0)
		{
			if (!Singleton<BrickBreakerManager>.Instance.actorInv)
			{
				currentFx = Singleton<BrickBreakerManager>.Instance.PlayBrickFx(infx, _actor.transform.position, _actor.transform, _actor);
				Singleton<BrickBreakerManager>.Instance.actorInv = true;
			}
		}
		else if (Singleton<BrickBreakerManager>.Instance.actorInv)
		{
			Singleton<BrickBreakerManager>.Instance.actorInv = false;
			currentFx?.Stop();
			currentFx = null;
		}
	}
}
