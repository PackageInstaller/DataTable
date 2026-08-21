using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[Name("Check Parameter Int", 0)]
[Category("Animator")]
public class MecanimCheckInt : ConditionTask<Animator>
{
	[RequiredField]
	public BBParameter<string> parameter;

	public CompareMethod comparison;

	public BBParameter<int> value;

	protected override string info => "Mec.Int " + parameter.ToString() + OperationTools.GetCompareString(comparison) + value;

	protected override bool OnCheck()
	{
		return OperationTools.Compare(base.agent.GetInteger(parameter.value), value.value, comparison);
	}
}
