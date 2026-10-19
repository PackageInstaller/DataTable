using System;
using System.Collections.Generic;
using ACT.DialogueSystem;
using UnityEngine;

namespace ACT.Drama;

[Serializable]
public class TimelineConversationData
{
	[DialogueCharacterPicker]
	public int speaker;

	public bool hideLeftModel;

	public bool hideLeftModelOnEnd;

	public int content;

	public int emoji;

	public EmotionPitch emotionPitch = EmotionPitch.Mid;

	public bool needClick = true;

	[Obsolete("没用了")]
	[HideInInspector]
	public float delayTime;

	public bool hasBranch;

	public bool branchHasContent;

	public List<TimelineConversationBranch> branchs = new List<TimelineConversationBranch>();

	public string jumpMarker;

	public bool isEnd;

	public bool canSkip = true;

	[Header("自动下一句的延迟(若自动播放), 单位秒, <0表示默认值, 在Prefab上配置的")]
	public float autoNextDelay = -1f;

	[Header("出字间隔, 单位毫秒, 小于默认值则使用默认值, 在Prefab上配置的")]
	public int contentTypeSpeed = -1;
}
