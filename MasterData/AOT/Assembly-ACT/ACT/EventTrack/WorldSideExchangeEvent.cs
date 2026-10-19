namespace ACT.EventTrack;

public class WorldSideExchangeEvent : TrackBaseEvt<WorldSideExchangeEvent>
{
	public int worldId;

	public string transNo;

	public int swid;

	public float posX;

	public float posY;

	public float posZ;

	public int worldSideType;

	public int triggerType;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("world_side_exchange", out var value))
		{
			value["world_id"] = worldId;
			value["trans_no"] = transNo ?? "-";
			value["swid"] = swid;
			value["pos_x"] = posX;
			value["pos_y"] = posY;
			value["pos_z"] = posZ;
			value["world_side_type"] = worldSideType;
			value["trigger_type"] = triggerType;
			Send("world_side_exchange", value);
		}
	}
}
