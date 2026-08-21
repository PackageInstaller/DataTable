using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace NodeCanvas.Tasks.Conditions;

[Category("✫ Blackboard")]
public class CheckBoolean : ConditionTask
{
	[BlackboardOnly]
	public BBParameter<bool> valueA;

	public BBParameter<bool> valueB = true;

	protected override string info => valueA?.ToString() + " == " + valueB;

	protected override bool OnCheck()
	{
		return valueA.value == valueB.value;
	}
}
