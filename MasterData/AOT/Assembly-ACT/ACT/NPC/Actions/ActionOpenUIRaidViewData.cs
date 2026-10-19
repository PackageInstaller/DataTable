using System;
using ACT.UI;

namespace ACT.NPC.Actions;

[Serializable]
public struct ActionOpenUIRaidViewData
{
	public int raidEntranceId;

	public int raidId;

	public MonoRaidViewData ToUIViewData()
	{
		return new MonoRaidViewData
		{
			RaidEntranceId = raidEntranceId,
			RaidId = raidId
		};
	}
}
