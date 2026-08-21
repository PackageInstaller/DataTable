using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

[Name("Override Agent", 0)]
[Category("Decorators")]
[Description("Set another Agent for the rest of the Tree dynamicaly from this point and on. All nodes under this will be executed with the new agent. You can also use this decorator to revert back to the original graph agent.")]
[Icon("Agent", false, "")]
public class Setter : BTDecorator
{
	[Tooltip("If enabled, will revert back to the original graph agent.")]
	public bool revertToOriginal;

	[ShowIf("revertToOriginal", 0)]
	[Tooltip("The new agent to use.")]
	public BBParameter<GameObject> newAgent;

	protected override Status OnExecute(Component agent, IBlackboard blackboard)
	{
		if (base.decoratedConnection == null)
		{
			return Status.Optional;
		}
		agent = (revertToOriginal ? base.graphAgent : newAgent.value.transform);
		return base.decoratedConnection.Execute(agent, blackboard);
	}
}
