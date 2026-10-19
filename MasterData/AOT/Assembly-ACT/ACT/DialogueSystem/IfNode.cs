using System.Collections.Generic;
using UnityEngine;

namespace ACT.DialogueSystem;

public class IfNode : DialogueNode
{
	public string description = "如果";

	[SerializeReference]
	public List<BaseCondition> conditions = new List<BaseCondition>();
}
