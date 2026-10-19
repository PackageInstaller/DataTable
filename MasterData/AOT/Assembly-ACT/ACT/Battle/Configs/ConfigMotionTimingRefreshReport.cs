using System.Collections.Generic;

namespace ACT.Battle.Configs;

public sealed class ConfigMotionTimingRefreshReport
{
	public int migratedItems;

	public int refreshedItems;

	public int skippedItems;

	public readonly List<string> details = new List<string>();

	public bool HasChanges
	{
		get
		{
			if (migratedItems <= 0)
			{
				return refreshedItems > 0;
			}
			return true;
		}
	}
}
