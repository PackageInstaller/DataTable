using System;
using ACT.Game.Data;

namespace ACT.Game;

[Serializable]
public class LocalNPCInfo
{
	public int npcId;

	public int overrideStateId;

	public int baseStateId;

	public NPCInfo ToPB()
	{
		return new NPCInfo
		{
			NpcId = npcId,
			OverrideStateId = overrideStateId,
			BaseStateId = baseStateId
		};
	}
}
