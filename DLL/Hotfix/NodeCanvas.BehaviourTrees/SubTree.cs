using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

[Name("Sub Tree", 0)]
[Description("Executes a sub Behaviour Tree. The status of the root node in the SubTree will be returned.")]
[Icon("BT", false, "")]
[DropReferenceType(typeof(BehaviourTree))]
public class SubTree : BTNodeNested<BehaviourTree>
{
	[SerializeField]
	[ExposeField]
	private BBParameter<BehaviourTree> _subTree;

	public override BehaviourTree subGraph
	{
		get
		{
			return _subTree.value;
		}
		set
		{
			_subTree.value = value;
		}
	}

	public override BBParameter subGraphParameter => _subTree;

	protected override Status OnExecute(Component agent, IBlackboard blackboard)
	{
		if (subGraph == null || subGraph.primeNode == null)
		{
			return Status.Optional;
		}
		if (base.status == Status.Resting)
		{
			this.TryStartSubGraph(agent, base.FrozenFrameIsPauseTree);
		}
		base.currentInstance.UpdateGraph();
		if (base.currentInstance.repeat && base.currentInstance.rootStatus != Status.Running)
		{
			this.TryReadAndUnbindMappedVariables();
		}
		return base.currentInstance.rootStatus;
	}

	protected override void OnReset()
	{
		if (base.currentInstance != null)
		{
			base.currentInstance.Stop(success: false);
		}
	}
}
