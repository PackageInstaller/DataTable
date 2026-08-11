using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[Name("Target In View Angle 2D", 0)]
[Category("GameObject")]
[Description("Checks whether the target is in the view angle of the agent")]
public class IsInFront2D : ConditionTask<Transform>
{
	[RequiredField]
	public BBParameter<GameObject> checkTarget;

	[SliderField(1, 180)]
	public BBParameter<float> viewAngle = 70f;

	protected override string info => checkTarget?.ToString() + " in view angle";

	protected override bool OnCheck()
	{
		return Vector2.Angle((Vector2)checkTarget.value.transform.position - (Vector2)base.agent.position, base.agent.right) < viewAngle.value;
	}

	public override void OnDrawGizmosSelected()
	{
		if (base.agent != null)
		{
			Gizmos.matrix = Matrix4x4.TRS((Vector2)base.agent.position, base.agent.rotation, Vector3.one);
			Gizmos.DrawFrustum(Vector3.zero, viewAngle.value, 5f, 0f, 0f);
		}
	}
}
