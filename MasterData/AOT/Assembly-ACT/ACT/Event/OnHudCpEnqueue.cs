using ACT.Model;
using ACT.UI;
using UnityEngine;

namespace ACT.Event;

public class OnHudCpEnqueue : BaseEventContent
{
	public HudComponentType type;

	public UIPosition position;

	public object uiData;

	public int priorityInQueue;

	public float timeOutDuration;

	public bool ignorePriorityRule;

	public bool clearQueueByCpItemType;

	public Vector2 positionOffset;

	public override void ReleaseEvt()
	{
		type = HudComponentType.None;
		position = UIPosition.Center;
		uiData = null;
		priorityInQueue = 0;
		timeOutDuration = 0f;
		ignorePriorityRule = false;
		clearQueueByCpItemType = false;
		positionOffset = Vector2.zero;
	}
}
