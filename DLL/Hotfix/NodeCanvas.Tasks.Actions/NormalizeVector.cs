using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("✫ Blackboard")]
public class NormalizeVector : ActionTask
{
	public BBParameter<Vector3> targetVector;

	public BBParameter<float> multiply = 1f;

	protected override void OnExecute()
	{
		targetVector.value = targetVector.value.normalized * multiply.value;
		EndAction(success: true);
	}
}
