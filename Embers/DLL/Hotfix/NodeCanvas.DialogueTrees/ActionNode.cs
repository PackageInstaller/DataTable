using System.Collections;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.DialogueTrees;

[Name("Task Action", 0)]
[Description("Execute an Action Task for the Dialogue Actor selected.")]
public class ActionNode : DTNode, ITaskAssignable<ActionTask>, ITaskAssignable, IGraphElement
{
	[SerializeField]
	private ActionTask _action;

	public ActionTask action
	{
		get
		{
			return _action;
		}
		set
		{
			_action = value;
		}
	}

	public Task task
	{
		get
		{
			return action;
		}
		set
		{
			action = (ActionTask)value;
		}
	}

	public override bool requireActorSelection => true;

	protected override Status OnExecute(Component agent, IBlackboard bb)
	{
		if (action == null)
		{
			return Error("Action is null on Dialogue Action Node");
		}
		base.status = Status.Running;
		StartCoroutine(UpdateAction(base.finalActor.transform));
		return base.status;
	}

	private IEnumerator UpdateAction(Component actionAgent)
	{
		while (base.status == Status.Running)
		{
			Status status = action.Execute(actionAgent, base.graphBlackboard);
			if (status != Status.Running)
			{
				OnActionEnd(status == Status.Success);
				break;
			}
			yield return null;
		}
	}

	private void OnActionEnd(bool success)
	{
		if (success)
		{
			base.status = Status.Success;
			base.DLGTree.Continue();
		}
		else
		{
			base.status = Status.Failure;
			base.DLGTree.Stop(success: false);
		}
	}

	protected override void OnReset()
	{
		if (action != null)
		{
			action.EndAction(null);
		}
	}

	public override void OnGraphPaused()
	{
		if (action != null)
		{
			action.Pause();
		}
	}
}
