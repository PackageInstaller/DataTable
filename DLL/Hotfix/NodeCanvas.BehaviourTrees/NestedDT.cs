using NodeCanvas.DialogueTrees;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

[Name("Sub Dialogue", 0)]
[Description("Executes a sub Dialogue Tree. Returns Running while the sub Dialogue Tree is active. You can Finish the Dialogue Tree with the 'Finish' node and return Success or Failure.")]
[Icon("Dialogue", false, "")]
[DropReferenceType(typeof(DialogueTree))]
public class NestedDT : BTNodeNested<DialogueTree>
{
	[SerializeField]
	[ExposeField]
	[Name("Sub Tree", 0)]
	private BBParameter<DialogueTree> _nestedDialogueTree;

	public override DialogueTree subGraph
	{
		get
		{
			return _nestedDialogueTree.value;
		}
		set
		{
			_nestedDialogueTree.value = value;
		}
	}

	public override BBParameter subGraphParameter => _nestedDialogueTree;

	protected override Status OnExecute(Component agent, IBlackboard blackboard)
	{
		if (subGraph == null || subGraph.primeNode == null)
		{
			return Status.Optional;
		}
		if (base.status == Status.Resting)
		{
			base.status = Status.Running;
			this.TryStartSubGraph(agent, base.FrozenFrameIsPauseTree, OnDLGFinished);
		}
		if (base.status == Status.Running)
		{
			base.currentInstance.UpdateGraph();
		}
		return base.status;
	}

	private void OnDLGFinished(bool success)
	{
		if (base.status == Status.Running)
		{
			base.status = (success ? Status.Success : Status.Failure);
		}
	}

	protected override void OnReset()
	{
		if (base.currentInstance != null)
		{
			base.currentInstance.Stop(success: false);
		}
	}
}
