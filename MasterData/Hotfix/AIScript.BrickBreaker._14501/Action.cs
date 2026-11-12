using AdventureBehaviour;
using TrueSync;

namespace AIScript.BrickBreaker._14501;

public class Action : BrickActorAction
{
	private readonly string bullet_kw = "Bullet_145_Ultra_BreakOut_1";

	private readonly TSVector2 offeset = new TSVector2(0, 2f);

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		Singleton<BrickBreakerManager>.Instance.SetSkillTips(iUse: true);
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
	}

	public override void OnStart()
	{
		base.OnStart();
	}

	public override void OnStop()
	{
		base.OnStop();
	}

	protected override bool SkillCheck()
	{
		return Singleton<BrickBreakerManager>.Instance.IsLaunched;
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		if ((evt as AdventureActorCustomEvent).eventHashCode == 145010001)
		{
			TSVector2 position = _actor.tsTransform.TransformLocalPointToWorldSpace(offeset);
			ILRuntimeAPI.ShootByDirection(bullet_kw, _actor, 0, TSVector2.up, position, 1.6);
		}
	}
}
