using UnityEngine;

namespace ACT.DialogueSystem;

public class TextProviderNode : DialogueNode
{
	public long key;

	[Header("文字内容")]
	[TextArea(8, 8)]
	public string content;
}
