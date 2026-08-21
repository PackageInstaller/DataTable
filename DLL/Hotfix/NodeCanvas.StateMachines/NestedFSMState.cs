using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.StateMachines;

[Name("Sub FSM", 0)]
[Description("Execute a sub FSM OnEnter, and Stop that FSM OnExit. This state is Finished only when and if the sub FSM is finished as well.")]
[DropReferenceType(typeof(FSM))]
[Icon("FSM", false, "")]
public class NestedFSMState : FSMStateNested<FSM>
{
	public enum FSMExitMode
	{
		StopAndRestart,
		PauseAndResume
	}

	[SerializeField]
	[ExposeField]
	[Name("Sub FSM", 0)]
	private BBParameter<FSM> _nestedFSM;

	[Tooltip("What will happen to the sub FSM when this state exits.")]
	public FSMExitMode exitMode;

	public override FSM subGraph
	{
		get
		{
			return _nestedFSM.value;
		}
		set
		{
			_nestedFSM.value = value;
		}
	}

	public override BBParameter subGraphParameter => _nestedFSM;

	protected override void OnEnter()
	{
		if (subGraph == null)
		{
			Finish(inSuccess: false);
			return;
		}
		this.TryStartSubGraph(base.graphAgent, base.FrozenFrameIsPauseTree, Finish);
		OnUpdate();
	}

	protected override void OnUpdate()
	{
		base.currentInstance.UpdateGraph();
	}

	protected override void OnExit()
	{
		if (base.currentInstance != null)
		{
			if (base.status == Status.Running)
			{
				this.TryReadAndUnbindMappedVariables();
			}
			if (exitMode == FSMExitMode.StopAndRestart)
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
