using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("GameObject")]
[Description("Checks the current speed of the agent against a value based on it's Rigidbody velocity")]
public class CheckSpeed : ConditionTask<Rigidbody>
{
	public CompareMethod checkType;

	public BBParameter<float> value;

	[SliderField(0f, 0.1f)]
	public float differenceThreshold = 0.05f;

	protected override string info => "Speed" + OperationTools.GetCompareString(checkType) + value;

	protected override bool OnCheck()
	{
		return OperationTools.Compare(base.agent.velocity.magnitude, value.value, checkType, differenceThreshold);
	}
}
