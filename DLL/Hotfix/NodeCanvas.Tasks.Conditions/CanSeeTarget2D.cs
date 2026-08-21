using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[Category("GameObject")]
[Description("A combination of line of sight and view angle check")]
public class CanSeeTarget2D : ConditionTask<Transform>
{
	[RequiredField]
	public BBParameter<GameObject> target;

	[Tooltip("Distance within which to look out for.")]
	public BBParameter<float> maxDistance = 50f;

	[Tooltip("A layer mask to use for the line of sight check.")]
	public BBParameter<LayerMask> layerMask = (LayerMask)(-1);

	[Tooltip("Distance within which the target can be seen (or rather sensed) regardless of view angle.")]
	public BBParameter<float> awarnessDistance = 0f;

	[SliderField(1, 180)]
	public BBParameter<float> viewAngle = 70f;

	public Vector2 offset;

	private RaycastHit2D hit;

	protected override string info => "Can See " + target;

	protected override bool OnCheck()
	{
		//IL_008e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0093: Unknown result type (might be due to invalid IL or missing references)
		//IL_0160: Unknown result type (might be due to invalid IL or missing references)
		//IL_0165: Unknown result type (might be due to invalid IL or missing references)
		Transform transform = target.value.transform;
		if (!transform.gameObject.activeInHierarchy)
		{
			return false;
		}
		if (Vector2.Distance(base.agent.position, transform.position) <= awarnessDistance.value)
		{
			RaycastHit2D val = Physics2D.Linecast((Vector2)base.agent.position + offset, (Vector2)transform.position + offset, (int)layerMask.value);
			if ((Object)(object)((RaycastHit2D)(ref val)).collider != (Object)(object)transform.GetComponent<Collider2D>())
			{
				return false;
			}
			return true;
		}
		if (Vector2.Distance(base.agent.position, transform.position) > maxDistance.value)
		{
			return false;
		}
		if (Vector2.Angle((Vector2)transform.position - (Vector2)base.agent.position, base.agent.right) > viewAngle.value)
		{
			return false;
		}
		RaycastHit2D val2 = Physics2D.Linecast((Vector2)base.agent.position + offset, (Vector2)transform.position + offset, (int)layerMask.value);
		if ((Object)(object)((RaycastHit2D)(ref val2)).collider != (Object)(object)transform.GetComponent<Collider2D>())
		{
			return false;
		}
		return true;
	}

	public override void OnDrawGizmosSelected()
	{
		if (base.agent != null)
		{
			Gizmos.DrawLine((Vector2)base.agent.position, (Vector2)base.agent.position + offset);
			Gizmos.DrawLine((Vector2)base.agent.position + offset, (Vector2)base.agent.position + offset + (Vector2)base.agent.right * maxDistance.value);
			Gizmos.DrawWireSphere((Vector2)base.agent.position + offset + (Vector2)base.agent.right * maxDistance.value, 0.1f);
			Gizmos.DrawWireSphere((Vector2)base.agent.position, awarnessDistance.value);
			Gizmos.matrix = Matrix4x4.TRS((Vector2)base.agent.position + offset, Quaternion.LookRotation(base.agent.right), Vector3.one);
			Gizmos.DrawFrustum(Vector3.zero, viewAngle.value, 5f, 0f, 1f);
		}
	}
}
