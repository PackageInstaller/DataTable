using Newtonsoft.Json.Linq;

namespace ACT.EventTrack;

public class ItemObtainJumpEvent : TrackBaseEvt<ItemObtainJumpEvent>
{
	public int itemId;

	public int systemId;

	public int toSystemId;

	public int jumpType;

	public int jumpId;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("item_obtain_jump", out var value))
		{
			value["item_id"] = itemId;
			value["system_id"] = systemId;
			value["to_system_id"] = toSystemId;
			value["jump_info"] = new JObject
			{
				["type"] = jumpType,
				["id"] = jumpId
			};
			Send("item_obtain_jump", value);
		}
	}
}
