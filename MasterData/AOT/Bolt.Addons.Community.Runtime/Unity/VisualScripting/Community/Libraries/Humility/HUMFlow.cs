using System;

namespace Unity.VisualScripting.Community.Libraries.Humility;

public static class HUMFlow
{
	public static void AfterTicks(ref int counter, int requiredTicks, bool autoReset = false, Action afterTicks = null)
	{
		if (counter >= requiredTicks)
		{
			afterTicks?.Invoke();
			if (autoReset)
			{
				counter = -1;
			}
		}
		counter++;
	}
}
