using System.Collections.Generic;
using System.Linq;
using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[Name("Any Target Within Distance 2D", 0)]
[Category("GameObject")]
public class CheckDistanceToGameObjectAny2D : ConditionTask<Transform>
{
	public BBParameter<List<GameObject>> targetObjects;

	public CompareMethod checkType = CompareMethod.LessThan;

	public BBParameter<float> distance = 10f;

	[SliderField(0f, 0.1f)]
	public float floatingPoint = 0.05f;

	[BlackboardOnly]
	public BBParameter<List<GameObject>> allResults;

	[BlackboardOnly]
	public BBParameter<GameObject> closerResult;

	protected override string info => "Distance Any" + OperationTools.GetCompareString(checkType) + distance?.ToString() + " in " + targetObjects;

	protected override bool OnCheck()
	{
		bool result = false;
		List<GameObject> list = new List<GameObject>();
		foreach (GameObject item in targetObjects.value)
		{
			if (!(item == base.agent.gameObject) && OperationTools.Compare(Vector2.Distance(base.agent.position, item.transform.position), distance.value, checkType, floatingPoint))
			{
				list.Add(item);
				result = true;
			}
		}
		if (!allResults.isNone || !closerResult.isNone)
		{
			IOrderedEnumerable<GameObject> source = list.OrderBy((GameObject x) => Vector2.Distance(base.agent.position, x.transform.position));
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
			Gizmos.DrawWireSphere((Vector2)base.agent.position, distance.value);
		}
	}
}
