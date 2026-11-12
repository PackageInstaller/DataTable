using TrueSync;

namespace AIScript.BrickBreaker._11201;

public class Action : BrickActorAction
{
	private FP recoveryEnerey_rate = 1.5f;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		actor.skillMgr?.SetRecoveryEnerey_Rate(recoveryEnerey_rate);
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
	}

	public override void OnStart()
	{
		base.OnStart();
	}

	public override void OnStop()
	{
		base.OnStop();
	}

	public void OnUpdate()
	{
	}
}
