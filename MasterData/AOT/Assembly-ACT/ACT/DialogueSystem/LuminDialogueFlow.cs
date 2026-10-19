using System;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.DialogueSystem;

[Serializable]
public class LuminDialogueFlow : DialogueFlow
{
	[Header("对话组Id")]
	[FormerlySerializedAs("avgId")]
	[DialogueStoryGroupPicker]
	public int storyGroupId;

	[Header("剧情简介")]
	[TextArea]
	public string storySummary;

	[Header("对话类型")]
	public LuminDialogueFlowType dialogueType;

	[Header("AVG模式场景画面当默认背景")]
	public bool useSceneBg;

	[Header("AVG模式静音对话外的BGM")]
	public bool muteBGM = true;

	[Header("隐藏操控的角色")]
	public bool hideControlRoles;

	[Header("开始时黑屏")]
	public bool blackScreenOnStart = true;

	[Header("开始时黑屏等待全亮")]
	public bool blackScreenOnStartWait = true;

	[Header("开始时黑屏速度")]
	public float blackScreenOnStartTime = 1f;

	[Header("开始时时黑屏持续时间")]
	public float blackScreenOnStartDuration;

	[Header("结束时黑屏")]
	public bool blackScreenOnStop = true;

	[Header("结束时黑屏速度")]
	public float blackScreenOnStopTime = 1f;

	[Header("自动隐藏结束时黑屏")]
	public bool autoHideBlackScreenOnStop = true;

	[Header("结束时黑屏持续时间")]
	public float blackScreenOnEndDuration;
}
