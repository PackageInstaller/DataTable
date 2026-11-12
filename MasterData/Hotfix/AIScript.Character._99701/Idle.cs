#define LOG_DEBUG
namespace AIScript.Character._99701;

public class Idle : AIBase
{
	public void OnStart()
	{
		NovaLogger.Debug("_99701 Idle OnStart");
		_actor.logicVariable.ToggleLogicTag("Idle", value: true);
	}

	public void OnStop()
	{
		NovaLogger.Debug("_99701 Idle OnStop");
		_actor.logicVariable.ToggleLogicTag("Idle", value: false);
	}
}
