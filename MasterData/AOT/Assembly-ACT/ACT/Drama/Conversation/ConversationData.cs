using Sirenix.Serialization;

namespace ACT.Drama.Conversation;

public class ConversationData
{
	[OdinSerialize]
	public BaseEvent[] eventsBefore;

	[OdinSerialize]
	public BaseEvent[] eventsStart;

	[OdinSerialize]
	public BaseEvent[] eventsEnd;

	public int content;

	public int emoji;

	public EmotionPitch emotionPitch = EmotionPitch.Mid;
}
