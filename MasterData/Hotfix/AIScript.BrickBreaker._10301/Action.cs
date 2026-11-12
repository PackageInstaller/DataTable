namespace AIScript.BrickBreaker._10301;

public class Action : BrickActorAction
{
	private readonly int addLife;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		if (ModuleController<AdventureModuleController>.Instance.levelInstance is BrickBreakerController brickBreakerController)
		{
			brickBreakerController.UpdateLife(addLife, addLife);
		}
		MonoSingleton<LuaManager>.Instance.FireEvent("BrickBreaker_Life_LimitFix", addLife);
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
