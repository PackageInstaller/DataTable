using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[Name("Target Within Distance", 0)]
[Category("GameObject")]
public class CheckDistanceToGameObject : ConditionTask<Transform>
{
	[RequiredField]
	public BBParameter<GameObject> checkTarget;

	public CompareMethod checkType = CompareMethod.LessThan;

	public BBParameter<float> distance = 10f;

	[SliderField(0f, 0.1f)]
	public float floatingPoint = 0.05f;

	protected override string info => "Distance" + OperationTools.GetCompareString(checkType) + distance?.ToString() + " to " + checkTarget;

	protected override bool OnCheck()
	{
		return OperationTools.Compare(Vector3.Distance(base.agent.position, checkTarget.value.transform.position), distance.value, checkType, floatingPoint);
	}

	public override void OnDrawGizmosSelected()
	{
		if (base.agent != null)
		{
			Gizmos.DrawWireSphere(base.agent.position, distance.value);
		}
	}
}
