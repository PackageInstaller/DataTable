using System;

namespace ACT.Config;

[Serializable]
public class MessageConversationGroup
{
	public readonly int id;

	public readonly int missionGroupId;

	public readonly int Type;

	public readonly int ContentType;

	public readonly int messageCharacterID;

	public readonly long[] conversationGroup = new long[0];

	public MessageConversationGroup(int id, int missionGroupId, int Type, int ContentType, int messageCharacterID, long[] conversationGroup)
	{
		this.id = id;
		this.missionGroupId = missionGroupId;
		this.Type = Type;
		this.ContentType = ContentType;
		this.messageCharacterID = messageCharacterID;
		this.conversationGroup = conversationGroup;
	}
}
