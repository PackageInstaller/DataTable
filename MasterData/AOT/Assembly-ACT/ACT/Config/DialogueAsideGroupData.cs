using System;

namespace ACT.Config;

[Serializable]
public class DialogueAsideGroupData
{
	public readonly long id;

	public readonly int type;

	public readonly long[] content = new long[0];

	public readonly string eventAddress = "";

	public DialogueAsideGroupData(long id, int type, long[] content, string eventAddress)
	{
		this.id = id;
		this.type = type;
		this.content = content;
		this.eventAddress = eventAddress;
	}
}
