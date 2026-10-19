using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

public class ConfigBuffIcon : ScriptableObject
{
	public List<BuffIconItem> buffIconValues;

	public BuffIconItem GetBuffIconItem(int id)
	{
		foreach (BuffIconItem buffIconValue in buffIconValues)
		{
			if (buffIconValue.id == id)
			{
				return buffIconValue;
			}
		}
		return default;
	}

	public void SortList()
	{
		buffIconValues.Sort((BuffIconItem a, BuffIconItem b) => a.id.CompareTo(b.id));
	}
}
