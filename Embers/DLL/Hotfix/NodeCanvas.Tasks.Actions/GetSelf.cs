using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("✫ Blackboard")]
[Description("Stores the agent gameobject on the blackboard.")]
public class GetSelf : ActionTask
{
	[BlackboardOnly]
	public BBParameter<GameObject> saveAs;

	protected override void OnExecute()
	{
		saveAs.value = base.agent?.gameObject;
		EndAction(success: true);
	}
}
