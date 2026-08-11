using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace NodeCanvas.Tasks.Conditions;

[Category("✫ Blackboard")]
[Description("Check whether or not a variable is null")]
public class CheckNull : ConditionTask
{
	[BlackboardOnly]
	public BBParameter<object> variable;

	protected override string info => variable?.ToString() + " == null";

	protected override bool OnCheck()
	{
		return variable.value == null;
	}
}
