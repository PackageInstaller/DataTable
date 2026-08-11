using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("Add Integer", 0)]
[Description("将两个整数相加并将结果存储到黑板中的整数变量中。")]
[Category("✫ Blackboard")]
public class AddInt : ActionTask
{
	[Name("被加数", 0)]
	[Description("要将其与另一个整数相加的黑板整数变量。")]
	[BlackboardOnly]
	public BBParameter<int> valueA;

	[Name("加数", 0)]
	[Description("要加到第一个整数上的值。")]
	public BBParameter<int> valueB;

	protected override string info => $"{valueA} + {valueB}";

	protected override void OnExecute()
	{
		valueA.value += valueB.value;
		EndAction();
	}
}
