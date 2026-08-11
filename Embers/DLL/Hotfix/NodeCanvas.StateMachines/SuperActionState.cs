using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.StateMachines;

[Name("Action State (Super)", 99)]
[Description("The Super Action State provides finer control on when to execute actions. This state is never Finished by it's own if there is any Actions in the OnUpdate list and thus OnFinish transitions will never be called in that case. OnExit Actions are only called for 1 frame when the state exits.")]
public class SuperActionState : FSMState
{
	[SerializeField]
	private ActionList _onEnterList;

	[SerializeField]
	private ActionList _onUpdateList;

	[SerializeField]
	private ActionList _onExitList;

	private bool enterListFinished;

	public override void OnValidate(Graph assignedGraph)
	{
		if (_onEnterList == null)
		{
			_onEnterList = (ActionList)Task.Create(typeof(ActionList), assignedGraph);
			_onEnterList.executionMode = ActionList.ActionsExecutionMode.ActionsRunInParallel;
		}
		if (_onUpdateList == null)
		{
			_onUpdateList = (ActionList)Task.Create(typeof(ActionList), assignedGraph);
			_onUpdateList.executionMode = ActionList.ActionsExecutionMode.ActionsRunInParallel;
		}
		if (_onExitList == null)
		{
			_onExitList = (ActionList)Task.Create(typeof(ActionList), assignedGraph);
			_onExitList.executionMode = ActionList.ActionsExecutionMode.ActionsRunInParallel;
		}
	}

	protected override void OnEnter()
	{
		enterListFinished = false;
		OnUpdate();
	}

	protected override void OnUpdate()
	{
		if (!enterListFinished)
		{
			Status status = _onEnterList.Execute(base.graphAgent, base.graphBlackboard);
			if (status != Status.Running)
			{
				enterListFinished = true;
				if (_onUpdateList.actions.Count == 0)
				{
					Finish(status);
				}
			}
		}
		_onUpdateList.Execute(base.graphAgent, base.graphBlackboard);
	}

	protected override void OnExit()
	{
		_onEnterList.EndAction(null);
		_onUpdateList.EndAction(null);
		_onExitList.Execute(base.graphAgent, base.graphBlackboard);
		_onExitList.EndAction(null);
	}

	protected override void OnPause()
	{
		_onEnterList.Pause();
		_onUpdateList.Pause();
	}
}
