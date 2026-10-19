using System.Collections.Generic;
using ACT.World.Asset;
using UnityEngine;

namespace ACT.Config;

public class RaidMonsterInfo : ScriptableObject
{
	[SerializeReference]
	private Dictionary<int, Dictionary<int, List<MonsterPointData>>> m_MonsterPointInfo = new Dictionary<int, Dictionary<int, List<MonsterPointData>>>();

	public Dictionary<int, Dictionary<int, List<MonsterPointData>>> MonsterPointInfo => m_MonsterPointInfo;
}
