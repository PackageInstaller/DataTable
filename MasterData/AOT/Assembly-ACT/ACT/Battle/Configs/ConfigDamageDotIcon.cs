using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

public class ConfigDamageDotIcon : ScriptableObject
{
	public List<DamageDotIconItem> damageDotIconValues;

	public DamageDotIconItem GetDamageDotIconItem(int id)
	{
		foreach (DamageDotIconItem damageDotIconValue in damageDotIconValues)
		{
			if (damageDotIconValue.id == id)
			{
				return damageDotIconValue;
			}
		}
		return default;
	}

	public void SortList()
	{
		damageDotIconValues.Sort((DamageDotIconItem a, DamageDotIconItem b) => a.id.CompareTo(b.id));
	}
}
