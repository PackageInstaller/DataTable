using System.Runtime.CompilerServices;
using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Name("Set IK", 0)]
[Category("Animator")]
public class MecanimSetIK : ActionTask<Animator>
{
	public AvatarIKGoal IKGoal;

	[RequiredField]
	public BBParameter<GameObject> goal;

	public BBParameter<float> weight;

	protected override string info => "Set '" + ((object)Unsafe.As<AvatarIKGoal, AvatarIKGoal>(ref IKGoal)/*cast due to constrained. prefix*/).ToString() + "' " + goal;

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
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		base.agent.SetIKPositionWeight(IKGoal, weight.value);
		base.agent.SetIKPosition(IKGoal, goal.value.transform.position);
		EndAction();
	}
}
