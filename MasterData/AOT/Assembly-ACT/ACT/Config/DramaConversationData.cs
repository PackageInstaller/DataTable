using System;

namespace ACT.Config;

[Serializable]
public class DramaConversationData
{
	public readonly int id;

	public readonly string conversationContent = "";

	public readonly string eventAddress = "";

	public DramaConversationData(int id, string conversationContent, string eventAddress)
	{
		this.id = id;
		this.conversationContent = conversationContent;
		this.eventAddress = eventAddress;
	}
}
