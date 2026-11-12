namespace AIScript.Character._14101;

public class ParallelScript_Dragon : ParallelScript_Summoned
{
	public override void OnEnable()
	{
		base.OnEnable();
		_actor.EnableCloseBlock();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_actor.DisableCloseBlock();
	}
}
