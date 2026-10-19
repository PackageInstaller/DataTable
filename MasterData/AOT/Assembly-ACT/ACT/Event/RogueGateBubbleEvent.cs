using ACT.Game.Data;
using UnityEngine;

namespace ACT.Event;

public class RogueGateBubbleEvent : BaseEventContent
{
	public int GateId;

	public Transform Target;

	public RogueRoomType RoomType;

	public Vector3 WorldOffset;

	public override void ReleaseEvt()
	{
		GateId = 0;
		Target = null;
		RoomType = RogueRoomType.Null;
		WorldOffset = default;
	}
}
