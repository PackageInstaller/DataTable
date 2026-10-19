using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

public class ConfigBattleTimeline : ScriptableObject
{
	public List<BattleTimelineItem> battleTimelineItems = new List<BattleTimelineItem>();

	public static ConfigBattleTimeline m_Instance;

	public static ConfigBattleTimeline Instance
	{
		get
		{
			if (m_Instance == null)
			{
				m_Instance = GameLoader.meta.battleTimelineConfig;
			}
			return m_Instance;
		}
	}

	private void AddItem()
	{
		HashSet<uint> hashSet = new HashSet<uint>();
		foreach (BattleTimelineItem battleTimelineItem in battleTimelineItems)
		{
			hashSet.Add(battleTimelineItem.id);
		}
		uint num;
		for (num = 0u; hashSet.Contains(num); num++)
		{
		}
		battleTimelineItems.Add(new BattleTimelineItem
		{
			id = num
		});
	}
}
