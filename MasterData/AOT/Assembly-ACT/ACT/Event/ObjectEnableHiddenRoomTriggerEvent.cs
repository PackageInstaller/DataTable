using UnityEngine;

namespace ACT.Event;

public class ObjectEnableHiddenRoomTriggerEvent : BaseEventContent
{
	public bool enable;

	public Collider collider;

	public override void ReleaseEvt()
	{
		collider = null;
		base.ReleaseEvt();
	}
}
