using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[Name("Check Parameter Bool", 0)]
[Category("Animator")]
public class MecanimCheckBool : ConditionTask<Animator>
{
	[RequiredField]
	public BBParameter<string> parameter;

	public BBParameter<bool> value;

	protected override string info => "Mec.Bool " + parameter.ToString() + " == " + value;

	protected override bool OnCheck()
	{
		return base.agent.GetBool(parameter.value) == value.value;
	}
}
