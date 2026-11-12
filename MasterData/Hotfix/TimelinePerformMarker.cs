using UnityEngine;
using UnityEngine.Timeline;

public class TimelinePerformMarker : Marker
{
	public enum SignalType
	{
		None,
		[InspectorName("AVG气泡")]
		AVGBubble,
		[InspectorName("隐藏当前角色")]
		HideMainActor
	}

	public SignalType signalType;

	[HideInInspector]
	public string avgBubbleLuaFileName = "";

	[HideInInspector]
	public string avgBubbleGroupId = "";

	private bool _hasTriggered;

	private readonly string AVG_BUBBLE_SHOW = "AvgBubbleShow";

	public bool HasTriggered => _hasTriggered;

	private void OnEnable()
	{
		_hasTriggered = false;
	}

	private void OnValidate()
	{
		if (signalType != SignalType.AVGBubble)
		{
			avgBubbleLuaFileName = string.Empty;
			avgBubbleGroupId = string.Empty;
		}
	}

	private void OnDisable()
	{
		_hasTriggered = false;
	}

	public void Trigger()
	{
		if (_hasTriggered)
		{
			return;
		}
		switch (signalType)
		{
		case SignalType.AVGBubble:
			if (!string.IsNullOrEmpty(avgBubbleLuaFileName) && !string.IsNullOrEmpty(avgBubbleGroupId))
			{
				MonoSingleton<LuaManager>.Instance?.FireEvent(AVG_BUBBLE_SHOW, avgBubbleLuaFileName, avgBubbleGroupId);
			}
			break;
		case SignalType.HideMainActor:
			if (SceneSingleton<AdventurePlayerController>.Instance != null)
			{
				(SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as PlayerAdventureActor)?.Hide();
			}
			break;
		}
		_hasTriggered = true;
	}
}
