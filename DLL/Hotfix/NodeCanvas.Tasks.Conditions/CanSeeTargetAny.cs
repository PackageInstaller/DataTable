using System.Collections.Generic;
using System.Linq;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[Category("GameObject")]
[Description("A combination of line of sight and view angle check")]
public class CanSeeTargetAny : ConditionTask<Transform>
{
	public BBParameter<List<GameObject>> targetObjects;

	public BBParameter<float> maxDistance = 50f;

	public BBParameter<LayerMask> layerMask = (LayerMask)(-1);

	public BBParameter<float> awarnessDistance = 0f;

	[SliderField(1, 180)]
	public BBParameter<float> viewAngle = 70f;

	public Vector3 offset;

	[BlackboardOnly]
	public BBParameter<List<GameObject>> allResults;

	[BlackboardOnly]
	public BBParameter<GameObject> closerResult;

	private RaycastHit hit;

	protected override string info => "Can See Any " + targetObjects;

	protected override bool OnCheck()
	{
		bool result = false;
		bool flag = !allResults.isNone || !closerResult.isNone;
		List<GameObject> list = (flag ? new List<GameObject>() : null);
		foreach (GameObject item in targetObjects.value)
		{
			if (item == base.agent.gameObject)
			{
				continue;
			}
			Transform transform = item.transform;
			if (!transform.gameObject.activeInHierarchy)
			{
				continue;
			}
			if (Vector3.Distance(base.agent.position, transform.position) < awarnessDistance.value)
			{
				if (!Physics.Linecast(base.agent.position + offset, transform.position + offset, ref hit, (int)layerMask.value) || !((Object)(object)((RaycastHit)(ref hit)).collider != (Object)(object)transform.GetComponent<Collider>()))
				{
					if (flag)
					{
						list.Add(item);
					}
					result = true;
				}
			}
			else if (!(Vector3.Distance(base.agent.position, transform.position) > maxDistance.value) && !(Vector3.Angle(transform.position - base.agent.position, base.agent.forward) > viewAngle.value) && (!Physics.Linecast(base.agent.position + offset, transform.position + offset, ref hit, (int)layerMask.value) || !((Object)(object)((RaycastHit)(ref hit)).collider != (Object)(object)transform.GetComponent<Collider>())))
			{
				if (flag)
				{
					list.Add(item);
				}
				result = true;
			}
		}
		if (flag)
		{
			IOrderedEnumerable<GameObject> source = list.OrderBy((GameObject x) => Vector3.Distance(base.agent.position, x.transform.position));
			if (!allResults.isNone)
			{
				allResults.value = source.ToList();
			}
			if (!closerResult.isNone)
			{
				closerResult.value = source.FirstOrDefault();
			}
		}
		return result;
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
