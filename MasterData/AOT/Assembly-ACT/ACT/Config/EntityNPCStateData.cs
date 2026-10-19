using System;

namespace ACT.Config;

[Serializable]
public class EntityNPCStateData
{
	public readonly int id;

	public readonly int npcid;

	public readonly int pos;

	public readonly int dialogueID;

	public readonly string ai = "";

	public EntityNPCStateData(int id, int npcid, int pos, int dialogueID, string ai)
	{
		this.id = id;
		this.npcid = npcid;
		this.pos = pos;
		this.dialogueID = dialogueID;
		this.ai = ai;
	}
}
