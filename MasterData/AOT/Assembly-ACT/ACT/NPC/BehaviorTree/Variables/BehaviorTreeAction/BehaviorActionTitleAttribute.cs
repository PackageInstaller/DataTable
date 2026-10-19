using System;

namespace ACT.NPC.BehaviorTree.Variables.BehaviorTreeAction;

[AttributeUsage(AttributeTargets.Class, Inherited = true)]
public sealed class BehaviorActionTitleAttribute : Attribute
{
	public string Title { get; }

	public BehaviorActionTitleAttribute(string title)
	{
		Title = title;
	}
}
