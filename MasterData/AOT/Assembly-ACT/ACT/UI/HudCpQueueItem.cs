using ACT.Model;
using UnityEngine;

namespace ACT.UI;

public class HudCpQueueItem
{
	public UIPosition Position;

	public float TimeoutSeconds;

	public float EnqueueTime;

	public bool IgnorePriorityRule;

	public HudComponentType HudComponentType;

	public int Priority;

	public object HudComponentUIData;

	public Vector2 ComponentPositionOffset;
}
