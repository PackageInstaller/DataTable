#define LOG_DEBUG
namespace AIScript.Character._10101;

public class Idle : AIBase
{
	public void OnStart()
	{
		NovaLogger.Debug("_10101 Idle OnStart");
		_actor.logicVariable.ToggleLogicTag("Idle", value: true);
	}

	public void OnStop()
	{
		NovaLogger.Debug("_10101 Idle OnStop");
		_actor.logicVariable.ToggleLogicTag("Idle", value: false);
	}
}
