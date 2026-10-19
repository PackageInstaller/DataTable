using UnityEngine;

namespace ACT.DialogueSystem;

public class ShowAVGCaptionPrefabNode : DialogueNode
{
	[Header("字幕演出Prefab")]
	public YooAssetReference captionPrefab;

	[Header("字幕退场时同步退出黑屏")]
	public bool hideBlackScreenWithCaption;

	[Header("同步退出黑屏速度")]
	public float blackScreenHideSpeed = 0.25f;

	[Header("点击时补全当前行")]
	public bool completeCurrentOnClick;
}
