using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[Category("GameObject")]
[Description("A combination of line of sight and view angle check")]
public class CanSeeTarget : ConditionTask<Transform>
{
	[RequiredField]
	public BBParameter<GameObject> target;

	[Tooltip("Distance within which to look out for.")]
	public BBParameter<float> maxDistance = 50f;

	[Tooltip("A layer mask to use for line of sight check.")]
	public BBParameter<LayerMask> layerMask = (LayerMask)(-1);

	[Tooltip("Distance within which the target can be seen (or rather sensed) regardless of view angle.")]
	public BBParameter<float> awarnessDistance = 0f;

	[SliderField(1, 180)]
	public BBParameter<float> viewAngle = 70f;

	public Vector3 offset;

	private RaycastHit hit;

	protected override string info => "Can See " + target;

	protected override bool OnCheck()
	{
		Transform transform = target.value.transform;
		if (!transform.gameObject.activeInHierarchy)
		{
			return false;
		}
		if (Vector3.Distance(base.agent.position, transform.position) <= awarnessDistance.value)
		{
			if (Physics.Linecast(base.agent.position + offset, transform.position + offset, ref hit, (int)layerMask.value) && (Object)(object)((RaycastHit)(ref hit)).collider != (Object)(object)transform.GetComponent<Collider>())
			{
				return false;
			}
			return true;
		}
		if (Vector3.Distance(base.agent.position, transform.position) > maxDistance.value)
		{
			return false;
		}
		if (Vector3.Angle(transform.position - base.agent.position, base.agent.forward) > viewAngle.value)
		{
			return false;
		}
		if (Physics.Linecast(base.agent.position + offset, transform.position + offset, ref hit, (int)layerMask.value) && (Object)(object)((RaycastHit)(ref hit)).collider != (Object)(object)transform.GetComponent<Collider>())
		{
			return false;
		}
		return true;
	}

	public override void OnDrawGizmosSelected()
	{
		if (base.agent != null)
		{
			Gizmos.DrawLine(base.agent.position, base.agent.position + offset);
			Gizmos.DrawLine(base.agent.position + offset, base.agent.position + offset + base.agent.forward * maxDistance.value);
			Gizmos.DrawWireSphere(base.agent.position + offset + base.agent.forward * maxDistance.value, 0.1f);
			Gizmos.DrawWireSphere(base.agent.position, awarnessDistance.value);
			Gizmos.matrix = Matrix4x4.TRS(base.agent.position + offset, base.agent.rotation, Vector3.one);
			Gizmos.DrawFrustum(Vector3.zero, viewAngle.value, 5f, 0f, 1f);
		}
	}
}
