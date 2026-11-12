namespace AIScript.Character._12001;

public class Idle : AIBase
{
	public void OnStart()
	{
		_actor.logicVariable.ToggleLogicTag("Idle", value: true);
	}

	public void OnStop()
	{
		_actor.logicVariable.ToggleLogicTag("Idle", value: false);
	}
}
