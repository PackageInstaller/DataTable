using ACT.UI;
using UnityEngine;

namespace ACT.DialogueSystem;

public class CustomSubtitleNode : DialogueNode
{
	public enum SubtitleWaitMode
	{
		[InspectorName("不等待")]
		NoWait = 2,
		[InspectorName("等到开始消失")]
		WaitUntilHideStarts = 1,
		[InspectorName("等到完全消失")]
		WaitUntilFullyHidden = 0
	}

	public long key;

	[Header("文字内容")]
	[TextArea(8, 8)]
	public string content;

	[Header("文字内容(男)")]
	[TextArea(8, 8)]
	public string content_male;

	[Header("自动下一句的延迟")]
	public float autoNextDelay = 1f;

	[Header("等待方式")]
	public SubtitleWaitMode waitMode;

	[Header("文字样式")]
	public MonoConversationNormal.SubtitlePosition textPosition = MonoConversationNormal.SubtitlePosition.Bottom;

	public float textFontSize = 36f;

	public Vector2 textPositionOffset;

	public float textRotation;

	public Color textColor = Color.white;

	[Header("出字方式")]
	public MonoConversationNormal.SubtitleAnimType animType = MonoConversationNormal.SubtitleAnimType.FadeInOut;

	[Header("渐隐渐现")]
	public float fadeInTime = 0.5f;

	public float fadeOutTime = 0.5f;

	[Header("打字机")]
	public int typeWriterInterval = 50;
}
