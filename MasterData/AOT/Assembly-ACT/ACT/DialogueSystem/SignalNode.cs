using System.Collections.Generic;
using UnityEngine;

namespace ACT.DialogueSystem;

public class SignalNode : DialogueNode
{
	public string description;

	[Header("必定触发(跳过时也触发)")]
	public bool mustDo;

	[Header("信号行为列表")]
	[SerializeReference]
	public List<SignalAction> actions = new List<SignalAction>();
}
