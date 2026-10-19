using System;
using ACT.NPC;

namespace ACT.Config;

[Serializable]
public struct ReceiveMissionData
{
	public NpcCondition npcCondition;

	public int npcUid;

	public int missionId;

	public int optionIndex;
}
