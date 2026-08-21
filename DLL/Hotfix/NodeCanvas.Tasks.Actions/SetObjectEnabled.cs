using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Name("Set Enabled", 0)]
[Category("GameObject")]
[Description("Set the monobehaviour's enabled state.")]
public class SetObjectEnabled : ActionTask<MonoBehaviour>
{
	public enum SetEnableMode
	{
		Disable,
		Enable,
		Toggle
	}

	public SetEnableMode setTo = SetEnableMode.Toggle;

	protected override string info => $"{setTo} {base.agentInfo}";

	protected override void OnExecute()
	{
		bool enabled = ((setTo != SetEnableMode.Toggle) ? (setTo == SetEnableMode.Enable) : (!base.agent.enabled));
		base.agent.enabled = enabled;
		EndAction();
	}
}
