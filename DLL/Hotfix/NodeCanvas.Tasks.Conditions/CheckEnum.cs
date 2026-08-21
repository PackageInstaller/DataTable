using System;
using NodeCanvas.Framework;
using NodeCanvas.Framework.Internal;
using ParadoxNotion.Design;

namespace NodeCanvas.Tasks.Conditions;

[Category("✫ Blackboard")]
public class CheckEnum : ConditionTask
{
	[BlackboardOnly]
	public BBObjectParameter valueA = new BBObjectParameter(typeof(Enum));

	public BBObjectParameter valueB = new BBObjectParameter(typeof(Enum));

	protected override string info => valueA?.ToString() + " == " + valueB;

	protected override bool OnCheck()
	{
		return object.Equals(valueA.value, valueB.value);
	}
}
