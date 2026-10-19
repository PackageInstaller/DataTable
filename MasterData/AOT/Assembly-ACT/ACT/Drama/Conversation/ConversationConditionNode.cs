using System.Collections.Generic;
using XNode;

namespace ACT.Drama.Conversation;

public class ConversationConditionNode : ConversationBaseNode
{
	[Input(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public string pre;

	public List<BaseCondition> conditions = new List<BaseCondition>();

	public ConversationInteractEvent trueInteract;

	[Output(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public int TrueExit;

	public ConversationInteractEvent falseInteract;

	[Output(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public int FalseExit;

	public ConversationInteractEvent GetInteractEvent()
	{
		for (int i = 0; i < conditions.Count; i++)
		{
			if (!conditions[i].Check())
			{
				if (falseInteract == null)
				{
					return null;
				}
				falseInteract.nextNodes = GetOutputPort("FalseExit").GetConnections();
				return falseInteract;
			}
		}
		if (trueInteract == null)
		{
			return null;
		}
		trueInteract.nextNodes = GetOutputPort("TrueExit").GetConnections();
		return trueInteract;
	}
}
