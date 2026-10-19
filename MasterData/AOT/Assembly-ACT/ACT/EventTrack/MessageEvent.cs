namespace ACT.EventTrack;

public class MessageEvent : TrackBaseEvt<MessageEvent>
{
	public int conversationCharacterId;

	public int conversationType;

	public int conversationId;

	public int conversationStatus;

	public long messageId;

	public int messageType;

	public int messageChooseId;

	public int status;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("message_event", out var value))
		{
			value["conversation_character_id"] = conversationCharacterId;
			value["conversation_type"] = conversationType;
			value["conversation_id"] = conversationId;
			value["conversation_status"] = conversationStatus;
			value["message_id"] = messageId;
			value["message_type"] = messageType;
			value["message_choose_id"] = messageChooseId;
			value["status"] = status;
			Send("message_event", value);
		}
	}
}
