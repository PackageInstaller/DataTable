using System;
using System.Collections.Generic;

public class SimEntityConfig
{
	private Dictionary<Type, List<int>> mConfigs = new Dictionary<Type, List<int>>();

	public void Add(Type configType, int id)
	{
		if (!mConfigs.ContainsKey(configType))
		{
			mConfigs[configType] = new List<int>();
		}
		if (!mConfigs[configType].Contains(id))
		{
			mConfigs[configType].Add(id);
		}
	}
}
