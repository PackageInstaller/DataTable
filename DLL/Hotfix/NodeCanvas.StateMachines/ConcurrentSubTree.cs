using NodeCanvas.BehaviourTrees;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.StateMachines;

[Name("Parallel Sub Behaviour Tree", -1)]
[Description("Execute a Sub Behaviour Tree in parallel and for as long as this FSM is running.")]
[Category("SubGraphs")]
[Color("ff64cb")]
public class ConcurrentSubTree : FSMNodeNested<BehaviourTree>, IUpdatable, IGraphElement
{
	[SerializeField]
	[ExposeField]
	[Name("Parallel Tree", 0)]
	protected BBParameter<BehaviourTree> _subTree;

	public override string name => base.name.ToUpper();

	public override int maxInConnections => 0;

	public override int maxOutConnections => 0;

	public override bool allowAsPrime => false;

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

	public override void OnGraphStarted()
	{
		if (!(subGraph == null))
		{
			base.status = Status.Running;
			this.TryStartSubGraph(base.graphAgent, base.FrozenFrameIsPauseTree, delegate(bool result)
			{
				base.status = (result ? Status.Success : Status.Failure);
			});
		}
	}

	void IUpdatable.Update()
	{
		this.TryUpdateSubGraph();
	}

	protected override void OnReset()
	{
		base.OnReset();
		if (base.currentInstance != null)
		{
			base.currentInstance.primeNode?.Reset();
		}
	}
}
