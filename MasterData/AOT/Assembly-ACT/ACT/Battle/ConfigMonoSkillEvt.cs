using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle;

public class ConfigMonoSkillEvt : ScriptableObject
{
	[Serializable]
	public struct MonoSkillEvtItem
	{
		public int id;
	}

	public List<MonoSkillEvtItem> list = new List<MonoSkillEvtItem>();

	public MonoSkillEvtItem GetPropertyItem(int goalValue)
	{
		foreach (MonoSkillEvtItem item in list)
		{
			if (item.id == goalValue)
			{
				return item;
			}
		}
		return default;
	}

	public void sortList()
	{
		list.Sort((MonoSkillEvtItem a, MonoSkillEvtItem b) => a.id.CompareTo(b.id));
	}
}
