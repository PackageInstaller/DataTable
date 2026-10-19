using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.DialogueSystem;

public class ChatOptionNode : DialogueNode
{
	[Header("AVG ID")]
	[DialogueAVGPicker]
	public long key;

	[Header("文字内容")]
	public string content;

	public int iconId = -1;

	public Func<UniTask> OnSelectCallback;

	[SerializeReference]
	public List<BaseCondition> conditions = new List<BaseCondition>();
}
