using ACT.UI;
using UnityEngine;

namespace ACT.DialogueSystem;

public class CommsChatNode : DialogueNode
{
	public long key;

	[Header("文字内容")]
	[TextArea(8, 8)]
	public string content;

	[Header("文字内容(男)")]
	[TextArea(8, 8)]
	public string content_male;

	[Header("位置")]
	public MonoCommsChatItems.CommsChatPosition position;

	[Header("相对位置预设的偏移")]
	public Vector2 positionOffset;

	[Header("完整显示后的停留时间")]
	[Min(0f)]
	public float duration = 3f;

	[Header("是否等待完全消失后再执行下一节点")]
	public bool waitUntilHidden = true;
}
