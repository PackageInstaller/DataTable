using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("GameObject")]
public class GetDistance : ActionTask<Transform>
{
	[RequiredField]
	public BBParameter<GameObject> target;

	[BlackboardOnly]
	public BBParameter<float> saveAs;

	protected override string info => $"Get Distance to {target.ToString()}";

	protected override void OnExecute()
	{
		saveAs.value = Vector3.Distance(base.agent.position, target.value.transform.position);
		EndAction();
	}
}
