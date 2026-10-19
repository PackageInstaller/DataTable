using System;

namespace ACT.Config;

[Serializable]
public class MessageConversation
{
	public readonly long id;

	public readonly int conversationType;

	public readonly int speaker;

	public readonly int content;

	public readonly int[] conversationParm = new int[0];

	public readonly long[] nextConversation = new long[0];

	public readonly int messageDynamicEffectExtra;

	public MessageConversation(long id, int conversationType, int speaker, int content, int[] conversationParm, long[] nextConversation, int messageDynamicEffectExtra)
	{
		this.id = id;
		this.conversationType = conversationType;
		this.speaker = speaker;
		this.content = content;
		this.conversationParm = conversationParm;
		this.nextConversation = nextConversation;
		this.messageDynamicEffectExtra = messageDynamicEffectExtra;
	}
}
