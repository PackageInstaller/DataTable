using System.Collections.Generic;
using ACT.UI;
using Sirenix.Serialization;
using UnityEngine;

namespace ACT;

public class TimelineConfig
{
	public bool canOperatRobot;

	public bool hasLetterBoxing;

	public float hasLetterBoxingDuration = 1f;

	public TimelineType timelineType;

	[OdinSerialize]
	public UI_TYPE openUIOnEnd = UI_TYPE.UI_BATTLEMAIN;

	public bool useNewAssetsBindings;

	[Header("Timeline绑定的Chunk")]
	[OdinSerialize]
	public List<TimelineBindingChunk> bindingChunkList = new List<TimelineBindingChunk>();

	[OdinSerialize]
	public Dictionary<string, string> assetsBindings = new Dictionary<string, string>();

	[OdinSerialize]
	public Dictionary<string, TrackData> newAssetsBindings = new Dictionary<string, TrackData>();

	[OdinSerialize]
	private bool _showMonster;

	public bool ShowMonster => _showMonster;
}
