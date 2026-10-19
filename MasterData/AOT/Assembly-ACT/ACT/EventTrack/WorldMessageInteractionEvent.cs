namespace ACT.EventTrack;

public class WorldMessageInteractionEvent : TrackBaseEvt<WorldMessageInteractionEvent>
{
	public string content;

	public int status;

	public int worldId;

	public float posX;

	public float posY;

	public float posZ;

	public int worldSideType;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("world_message_interaction", out var value))
		{
			value["content"] = content ?? "-";
			value["status"] = status;
			value["world_id"] = worldId;
			value["pos_x"] = posX;
			value["pos_y"] = posY;
			value["pos_z"] = posZ;
			value["world_side_type"] = worldSideType;
			Send("world_message_interaction", value);
		}
	}
}
