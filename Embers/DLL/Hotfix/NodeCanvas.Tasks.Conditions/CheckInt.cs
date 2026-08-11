using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;

namespace NodeCanvas.Tasks.Conditions;

[Category("✫ Blackboard")]
public class CheckInt : ConditionTask
{
	[BlackboardOnly]
	public BBParameter<int> valueA;

	public CompareMethod checkType;

	public BBParameter<int> valueB;

	protected override string info => valueA?.ToString() + OperationTools.GetCompareString(checkType) + valueB;

	protected override bool OnCheck()
	{
		return OperationTools.Compare(valueA.value, valueB.value, checkType);
	}
}
