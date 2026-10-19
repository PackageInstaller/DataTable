using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

public class ConfigDebuff : ScriptableObject
{
	public List<DebuffItem> debuffs;

	public DebuffItem GetDebuffItem(uint debuffId)
	{
		foreach (DebuffItem debuff in debuffs)
		{
			if (debuff.id == debuffId)
			{
				return debuff;
			}
		}
		return default;
	}

	public void SortList()
	{
		debuffs.Sort((DebuffItem a, DebuffItem b) => a.id.CompareTo(b.id));
	}
}
