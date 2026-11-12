namespace AIScript.Character._14401;

public class ParallelScript_Summon : AIBase
{
	public void OnEnable()
	{
		_actor.EnableUnparalleled();
	}

	public void OnDisable()
	{
		_actor.DisableUnparalleled();
	}
}
