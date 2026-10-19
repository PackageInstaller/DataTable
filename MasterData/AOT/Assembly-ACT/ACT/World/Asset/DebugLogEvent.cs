using ACT.World.Behave;

namespace ACT.World.Asset;

public class DebugLogEvent : DoActionBase
{
	public string log;

	public override bool Do(BehaveControlBaseBehaveEvent behave)
	{
		return true;
	}
}
