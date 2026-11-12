#define LOG_DEBUG
namespace AIScript.Character._11701;

public class Idle_B2T1 : AIBase
{
	public void OnStart()
	{
		NovaLogger.Debug("11701 Idle_2_1 OnStart");
	}

	public void OnStop()
	{
		NovaLogger.Debug("11701 Idle_2_1 OnStop");
		_actor.logicVariable.SetLogicTagValue("skillUseCount", 0);
	}
}
