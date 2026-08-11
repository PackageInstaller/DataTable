using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("GameObject")]
[Description("Find a transform child by name within the agent's transform")]
public class FindChildByName : ActionTask<Transform>
{
	[RequiredField]
	public BBParameter<string> childName;

	[BlackboardOnly]
	public BBParameter<Transform> saveAs;

	protected override string info => $"{saveAs} = {base.agentInfo}.FindChild({childName})";

	protected override void OnExecute()
	{
		Transform transform = base.agent.Find(childName.value);
		saveAs.value = transform;
		EndAction(transform != null);
	}
}
