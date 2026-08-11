using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("Int计算", 0)]
[Description("对两个整数执行指定的算术操作，并将结果存储到黑板中的整数变量中。")]
[Category("✫ DragonLost/Movement")]
public class IntCalculate : ActionTask
{
	[Name("第一个值", 0)]
	[Description("要参与计算的第一个整数值。")]
	public BBParameter<int> valueA;

	[Name("第二个值", 0)]
	[Description("要参与计算的第二个整数值。")]
	public BBParameter<int> valueB;

	[Name("操作方法", 0)]
	[Description("要执行的算术操作方法。")]
	public OperationMethod Operation;

	[Name("结果存储", 0)]
	[Description("用于存储计算结果的黑板整数变量。")]
	public BBParameter<int> returnValue;

	protected override string info => $"{valueA} {OperationTools.GetOperationString(Operation)} {valueB}";

	protected override void OnExecute()
	{
		returnValue.value = OperationTools.Operate(valueA.value, valueB.value, Operation);
		EndAction();
	}
}
