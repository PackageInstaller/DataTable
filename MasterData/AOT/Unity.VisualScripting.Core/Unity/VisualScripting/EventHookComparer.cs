using System.Collections.Generic;

namespace Unity.VisualScripting;

public class EventHookComparer : IEqualityComparer<EventHook>
{
	public bool Equals(EventHook x, EventHook y)
	{
		return x.Equals(y);
	}

	public int GetHashCode(EventHook obj)
	{
		return obj.GetHashCode();
	}
}
