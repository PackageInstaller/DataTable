using NodeCanvas.BehaviourTrees;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.StateMachines;

[Name("Sub BehaviourTree", 0)]
[Description("Execute a Behaviour Tree OnEnter. OnExit that Behavior Tree will be stoped or paused based on the relevant specified setting. You can optionaly specify a Success Event and a Failure Event which will be sent when the BT's root node status returns either of the two. If so, use alongside with a CheckEvent on a transition.")]
[DropReferenceType(typeof(BehaviourTree))]
[Icon("BT", false, "")]
public class NestedBTState : FSMStateNested<BehaviourTree>
{
	public enum BTExecutionMode
	{
		Once,
		Repeat
	}

	public enum BTExitMode
	{
		StopAndRestart,
		PauseAndResume
	}

	[SerializeField]
	[ExposeField]
	[Name("Sub Tree", 0)]
	private BBParameter<BehaviourTree> _nestedBT;

	[Tooltip("Sould the BT repeat?")]
	public BTExecutionMode executionMode = BTExecutionMode.Repeat;

	[Tooltip("What will happen to the BT when this state exits.")]
	public BTExitMode exitMode;

	[DimIfDefault]
	[Tooltip("The event to send when the BT finish in Failure.")]
	public string failureEvent;

	[DimIfDefault]
	[Tooltip("The event to send when the BT finish in Success.")]
	public string successEvent;

	public override BehaviourTree subGraph
	{
		get
		{
			return _nestedBT.value;
		}
		set
		{
			_nestedBT.value = value;
		}
	}

	public override BBParameter subGraphParameter => _nestedBT;

	protected override void OnEnter()
	{
		if (subGraph == null)
		{
			Finish(inSuccess: false);
			return;
		}
		base.currentInstance = (BehaviourTree)this.CheckInstance();
		base.currentInstance.repeat = executionMode == BTExecutionMode.Repeat;
		base.currentInstance.updateInterval = 0f;
		this.TryWriteAndBindMappedVariables();
		base.currentInstance.StartGraph(base.graph.agent, base.graph.blackboard.parent, base.FrozenFrameIsPauseTree, Graph.UpdateMode.Manual, OnFinish);
		OnUpdate();
	}

	protected override void OnUpdate()
	{
		base.OnUpdate();
		if (!(base.currentInstance == null))
		{
			base.currentInstance.UpdateGraph();
		}
	}

	private void OnFinish(bool success)
	{
		if (base.status == Status.Running)
		{
			this.TryReadAndUnbindMappedVariables();
			if (!string.IsNullOrEmpty(successEvent) & success)
			{
				SendEvent(successEvent);
			}
			if (!string.IsNullOrEmpty(failureEvent) && !success)
			{
				SendEvent(failureEvent);
			}
			Finish(success);
		}
	}

	protected override void OnExit()
	{
		if (base.currentInstance != null)
		{
			if (base.status == Status.Running)
			{
				this.TryReadAndUnbindMappedVariables();
			}
			if (exitMode == BTExitMode.StopAndRestart)
			{
				base.currentInstance.Stop(success: false);
			}
			else
			{
				base.currentInstance.Pause();
			}
		}
	}
}
