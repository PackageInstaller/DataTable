using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Name("Set Active", 0)]
[Category("GameObject")]
[Description("Set the gameobject active state.")]
public class SetObjectActive : ActionTask<Transform>
{
	public enum SetActiveMode
	{
		Deactivate,
		Activate,
		Toggle
	}

	public SetActiveMode setTo = SetActiveMode.Toggle;

	protected override string info => $"{setTo} {base.agentInfo}";

	protected override void OnExecute()
	{
		bool active = ((setTo != SetActiveMode.Toggle) ? (setTo == SetActiveMode.Activate) : (!base.agent.gameObject.activeSelf));
		base.agent.gameObject.SetActive(active);
		EndAction();
	}
}
