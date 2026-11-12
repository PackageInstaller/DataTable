namespace AIScript.Character._13701;

public class ActionScript_Support : ActionScript
{
	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		_actor.EnablePenetrate();
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		_actor.DisablePenetrate();
	}
}
