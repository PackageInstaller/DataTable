using System;
using System.Collections.Generic;

namespace Bamboo.ECS;

public static class Filter_Extension
{
	public static List<Entity> FindAll(this Filter filter, Func<Entity, bool> action, List<Entity> results = null)
	{
		if (results == null)
		{
			results = new List<Entity>();
		}
		if (action == null)
		{
			results.AddRange(filter);
			return results;
		}
		foreach (Entity item in filter)
		{
			if (action(item))
			{
				results.Add(item);
			}
		}
		return results;
	}
}
