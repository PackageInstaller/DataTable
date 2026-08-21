using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;

namespace NodeCanvas.Tasks.Conditions;

[Category("✫ Blackboard")]
public class CheckFloat : ConditionTask
{
	[BlackboardOnly]
	public BBParameter<float> valueA;

	public CompareMethod checkType;

	public BBParameter<float> valueB;

	[SliderField(0f, 0.1f)]
	public float differenceThreshold = 0.05f;

	protected override string info => valueA?.ToString() + OperationTools.GetCompareString(checkType) + valueB;

	protected override bool OnCheck()
	{
		return OperationTools.Compare(valueA.value, valueB.value, checkType, differenceThreshold);
	}
}
