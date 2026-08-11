using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Name("Set Look At", 0)]
[Category("Animator")]
public class MecanimSetLookAt : ActionTask<Animator>
{
	public BBParameter<GameObject> targetPosition;

	public BBParameter<float> targetWeight;

	protected override string info => "Mec.SetLookAt " + targetPosition;

	protected override void OnExecute()
	{
		base.router.onAnimatorIK += OnAnimatorIK;
	}

	protected override void OnStop()
	{
		base.router.onAnimatorIK -= OnAnimatorIK;
	}

	private void OnAnimatorIK(EventData<int> msg)
	{
		base.agent.SetLookAtPosition(targetPosition.value.transform.position);
		base.agent.SetLookAtWeight(targetWeight.value);
		EndAction();
	}
}
