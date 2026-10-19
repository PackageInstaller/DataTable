using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

public class ConfigDynamicValue : ScriptableObject
{
	public List<DynamicValueItem> dynamicValues;

	public DynamicValueItem GetDynamicValueItem(int dynamicValueId)
	{
		foreach (DynamicValueItem dynamicValue in dynamicValues)
		{
			if (dynamicValue.id == dynamicValueId)
			{
				return dynamicValue;
			}
		}
		return default;
	}

	public void SortList()
	{
		dynamicValues.Sort((DynamicValueItem a, DynamicValueItem b) => a.id.CompareTo(b.id));
	}
}
