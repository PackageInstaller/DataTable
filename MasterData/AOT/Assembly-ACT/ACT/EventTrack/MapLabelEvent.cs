using UnityEngine;

namespace ACT.EventTrack;

public class MapLabelEvent : TrackBaseEvt<MapLabelEvent>
{
	public int areaId;

	public int subAreaId;

	public int labelId;

	public Vector3 pos;

	public int status;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("map_label", out var value))
		{
			value["area_id"] = areaId;
			value["sub_area_id"] = subAreaId;
			value["label_id"] = labelId;
			value["pos_x"] = pos.x;
			value["pos_y"] = pos.y;
			value["pos_z"] = pos.z;
			value["status"] = status;
			Send("map_label", value);
		}
	}
}
