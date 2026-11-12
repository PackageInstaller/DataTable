namespace AIScript.BrickBreaker._11101;

public class Action : BrickActorAction
{
	private readonly int exceptDropScro = 20;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		Singleton<BrickBreakerManager>.Instance?.SetExceptDropScro(exceptDropScro);
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
}
