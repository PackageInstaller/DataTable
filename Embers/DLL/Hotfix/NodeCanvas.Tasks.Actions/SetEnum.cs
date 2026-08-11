using System;
using NodeCanvas.Framework;
using NodeCanvas.Framework.Internal;
using ParadoxNotion.Design;

namespace NodeCanvas.Tasks.Actions;

[Category("✫ Blackboard")]
public class SetEnum : ActionTask
{
	[BlackboardOnly]
	[RequiredField]
	public BBObjectParameter valueA = new BBObjectParameter(typeof(Enum));

	public BBObjectParameter valueB = new BBObjectParameter(typeof(Enum));

	protected override string info => valueA?.ToString() + " = " + valueB;

	protected override void OnExecute()
	{
		valueA.value = valueB.value;
		EndAction();
	}
}
