using System.Collections.Generic;
using System.Linq;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[Category("GameObject")]
[Description("A combination of line of sight and view angle check")]
public class CanSeeTargetAny2D : ConditionTask<Transform>
{
	public BBParameter<List<GameObject>> targetObjects;

	public BBParameter<float> maxDistance = 50f;

	public BBParameter<LayerMask> layerMask = (LayerMask)(-1);

	public BBParameter<float> awarnessDistance = 0f;

	[SliderField(1, 180)]
	public BBParameter<float> viewAngle = 70f;

	public Vector2 offset;

	[BlackboardOnly]
	public BBParameter<List<GameObject>> allResults;

	[BlackboardOnly]
	public BBParameter<GameObject> closerResult;

	protected override string info => "Can See Any " + targetObjects;

	protected override bool OnCheck()
	{
		//IL_00ed: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f2: Unknown result type (might be due to invalid IL or missing references)
		//IL_01d4: Unknown result type (might be due to invalid IL or missing references)
		//IL_01d9: Unknown result type (might be due to invalid IL or missing references)
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
			if (Vector2.Distance(base.agent.position, transform.position) < awarnessDistance.value)
			{
				RaycastHit2D val = Physics2D.Linecast((Vector2)base.agent.position + offset, (Vector2)transform.position + offset, (int)layerMask.value);
				if (!((Object)(object)((RaycastHit2D)(ref val)).collider != (Object)(object)transform.GetComponent<Collider2D>()))
				{
					if (flag)
					{
						list.Add(item);
					}
					result = true;
				}
			}
			else
			{
				if (Vector2.Distance(base.agent.position, transform.position) > maxDistance.value || Vector2.Angle((Vector2)transform.position - (Vector2)base.agent.position, base.agent.right) > viewAngle.value)
				{
					continue;
				}
				RaycastHit2D val2 = Physics2D.Linecast((Vector2)base.agent.position + offset, (Vector2)transform.position + offset, (int)layerMask.value);
				if (!((Object)(object)((RaycastHit2D)(ref val2)).collider != (Object)(object)transform.GetComponent<Collider2D>()))
				{
					if (flag)
					{
						list.Add(item);
					}
					result = true;
				}
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
			Gizmos.DrawLine((Vector2)base.agent.position, (Vector2)base.agent.position + offset);
			Gizmos.DrawLine((Vector2)base.agent.position + offset, (Vector2)base.agent.position + offset + (Vector2)base.agent.right * maxDistance.value);
			Gizmos.DrawWireSphere((Vector2)base.agent.position + offset + (Vector2)base.agent.right * maxDistance.value, 0.1f);
			Gizmos.DrawWireSphere((Vector2)base.agent.position, awarnessDistance.value);
			Gizmos.matrix = Matrix4x4.TRS((Vector2)base.agent.position + offset, base.agent.rotation, Vector3.one);
			Gizmos.DrawFrustum(Vector3.zero, viewAngle.value, 5f, 0f, 1f);
		}
	}
}
