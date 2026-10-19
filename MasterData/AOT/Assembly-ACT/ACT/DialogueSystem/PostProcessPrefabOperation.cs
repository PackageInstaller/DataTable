using UnityEngine;

namespace ACT.DialogueSystem;

public enum PostProcessPrefabOperation
{
	[InspectorName("加载并播放")]
	LoadAndPlay,
	[InspectorName("播放已有效果")]
	Play,
	[InspectorName("只调整强度")]
	SetWeight,
	[InspectorName("播放后释放")]
	PlayAndRelease,
	[InspectorName("立即释放")]
	Release
}
