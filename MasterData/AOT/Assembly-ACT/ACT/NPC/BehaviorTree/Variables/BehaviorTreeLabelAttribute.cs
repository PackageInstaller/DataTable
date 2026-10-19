using System;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.NPC.BehaviorTree.Variables;

[AttributeUsage(AttributeTargets.Field)]
public sealed class BehaviorTreeLabelAttribute : ObjectDrawerAttribute
{
	public readonly string Label;

	public BehaviorTreeLabelAttribute(string label)
	{
		Label = label;
	}
}
