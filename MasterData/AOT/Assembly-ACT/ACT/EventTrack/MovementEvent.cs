using ACT.Battle;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.EventTrack;

public class MovementEvent : TrackBaseEvt<MovementEvent>
{
	public float swid;

	public Vector3 pos;

	public string type;

	public int eventType;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("movement_event", out var value))
		{
			SetTransNo(value);
			value["world_id"] = Singleton<GameManager>.instance.worldManager.ActiveWorldId;
			value["swid"] = swid;
			value["character_id"] = MonoECS.instance.mainEntity.GetTableId();
			value["pos_x"] = pos.x;
			value["pos_y"] = pos.y;
			value["pos_z"] = pos.z;
			value["event_type"] = eventType;
			Send("movement_event", value);
		}
	}
}
