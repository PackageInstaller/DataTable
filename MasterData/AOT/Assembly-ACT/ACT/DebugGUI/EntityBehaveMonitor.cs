using Bamboo.ECS;

namespace ACT.DebugGUI;

public abstract class EntityBehaveMonitor : DebugMonitor
{
	protected EntityBehaveWindow ebwnd;

	protected Entity eb => ebwnd.eb;

	public static T Init<T>(EntityBehaveWindow ebwnd) where T : EntityBehaveMonitor, new()
	{
		if (DebugWindowManager.instance == null)
		{
			return null;
		}
		T val = new T
		{
			ebwnd = ebwnd
		};
		if (val.OnInit())
		{
			return val;
		}
		return null;
	}
}
