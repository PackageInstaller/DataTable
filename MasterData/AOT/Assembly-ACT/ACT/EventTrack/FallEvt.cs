using ACT.Battle;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.EventTrack;

public class FallEvt : TrackBaseEvt<FallEvt>
{
	public override void OnDispatch()
	{
		base.OnDispatch();
		if (EventConfigs.EventDictionary.TryGetValue("fall_event", out var value))
		{
			Vector3 physicsPosition = MonoECS.instance.mainEntity.GetCompTransform().physicsPosition;
			value["world_id"] = Singleton<GameManager>.instance.worldManager.ActiveWorldId;
			value["pos_x"] = physicsPosition.x;
			value["pos_y"] = physicsPosition.y;
			value["pos_z"] = physicsPosition.z;
			value["is_abnormal"] = true;
			_ = LuminApplication.LogEnabled;
			Send("fall_event", value);
		}
	}
}
