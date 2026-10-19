using Bamboo.ECS;

namespace ACT.DebugGUI;

public abstract class EntityBehaveHitBoxAbMonitor : DebugMonitor
{
	protected EntityHitAndAbilityBoxWindow ebwnd;

	protected Entity eb => ebwnd.eb;

	public static T Init<T>(EntityHitAndAbilityBoxWindow ebwnd) where T : EntityBehaveHitBoxAbMonitor, new()
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
