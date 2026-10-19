using System;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.NPC.BehaviorTree.Variables;

[AttributeUsage(AttributeTargets.Field)]
public sealed class BehaviorTreeActionListAttribute : ObjectDrawerAttribute
{
	public readonly string Label;

	public BehaviorTreeActionListAttribute(string label)
	{
		Label = label;
	}
}
