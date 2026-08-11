using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[Name("Target In View Angle", 0)]
[Category("GameObject")]
[Description("Checks whether the target is in the view angle of the agent")]
public class IsInFront : ConditionTask<Transform>
{
	[RequiredField]
	public BBParameter<GameObject> checkTarget;

	[SliderField(1, 180)]
	public BBParameter<float> viewAngle = 70f;

	protected override string info => checkTarget?.ToString() + " in view angle";

	protected override bool OnCheck()
	{
		return Vector3.Angle(checkTarget.value.transform.position - base.agent.position, base.agent.forward) < viewAngle.value;
	}

	public override void OnDrawGizmosSelected()
	{
		if (base.agent != null)
		{
			Gizmos.matrix = Matrix4x4.TRS(base.agent.position, base.agent.rotation, Vector3.one);
			Gizmos.DrawFrustum(Vector3.zero, viewAngle.value, 5f, 0f, 1f);
		}
	}
}
