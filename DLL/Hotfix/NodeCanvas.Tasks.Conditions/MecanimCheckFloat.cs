using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[Name("Check Parameter Float", 0)]
[Category("Animator")]
public class MecanimCheckFloat : ConditionTask<Animator>
{
	[RequiredField]
	public BBParameter<string> parameter;

	public CompareMethod comparison;

	public BBParameter<float> value;

	protected override string info => "Mec.Float " + parameter.ToString() + OperationTools.GetCompareString(comparison) + value;

	protected override bool OnCheck()
	{
		return OperationTools.Compare(base.agent.GetFloat(parameter.value), value.value, comparison, 0.1f);
	}
}
