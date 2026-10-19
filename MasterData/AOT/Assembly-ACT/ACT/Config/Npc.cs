using System;

namespace ACT.Config;

[Serializable]
public class Npc
{
	public readonly int id;

	public readonly string editorName = "";

	public readonly string npcModelPath = "";

	public Npc(int id, string editorName, string npcModelPath)
	{
		this.id = id;
		this.editorName = editorName;
		this.npcModelPath = npcModelPath;
	}
}
