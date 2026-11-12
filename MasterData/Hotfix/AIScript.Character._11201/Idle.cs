#define LOG_DEBUG
namespace AIScript.Character._11201;

public class Idle : AIBase
{
	public void OnStart()
	{
		NovaLogger.Debug("_11201 Idle OnStart");
		_actor.logicVariable.ToggleLogicTag("Idle", value: true);
	}

	public void OnStop()
	{
		NovaLogger.Debug("_11201 Idle OnStop");
		_actor.logicVariable.ToggleLogicTag("Idle", value: false);
	}
}
