using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace NodeCanvas.Tasks.Conditions;

[Category("✫ Blackboard")]
public class StringContains : ConditionTask
{
	[RequiredField]
	[BlackboardOnly]
	public BBParameter<string> targetString;

	public BBParameter<string> checkString;

	protected override string info => $"{targetString} Contains {checkString}";

	protected override bool OnCheck()
	{
		return targetString.value.Contains(checkString.value);
	}
}
