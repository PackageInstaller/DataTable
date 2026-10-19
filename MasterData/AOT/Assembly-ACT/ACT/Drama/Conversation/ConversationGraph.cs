using System;
using UnityEngine;
using XNode;

namespace ACT.Drama.Conversation;

[Serializable]
[CreateAssetMenu(fileName = "New Conversion Graph", menuName = "xNode Examples/Dialog Graph")]
public class ConversationGraph : NodeGraph
{
	public ConversationBaseNode startNode;

	public ConversationBaseNode curNode;

	public object Context { get; set; }
}
