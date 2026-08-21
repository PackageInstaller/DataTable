using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Name("Set Visibility", 0)]
[Category("GameObject")]
[Description("Set the Renderer active state, thus making the object visible or invisible.")]
public class SetObjectVisibility : ActionTask<Renderer>
{
	public enum SetVisibleMode
	{
		Hide,
		Show,
		Toggle
	}

	public SetVisibleMode setTo = SetVisibleMode.Toggle;

	protected override string info => $"{setTo} {base.agentInfo}";

	protected override void OnExecute()
	{
		bool enabled = ((setTo != SetVisibleMode.Toggle) ? (setTo == SetVisibleMode.Show) : (!base.agent.enabled));
		base.agent.enabled = enabled;
		EndAction();
	}
}
