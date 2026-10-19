using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.DialogueSystem;

[Serializable]
public abstract class DialogueNode
{
	public long id = DialogueIdGenerator.NextId();

	[SerializeReference]
	public List<DialogueNode> children = new List<DialogueNode>();
}
