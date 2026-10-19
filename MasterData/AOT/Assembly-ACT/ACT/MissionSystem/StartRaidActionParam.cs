using System;
using UnityEngine;

namespace ACT.MissionSystem;

[Serializable]
public class StartRaidActionParam
{
	[Header("副本Id")]
	public int raidId;
}
