using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("Vector3运算", 0)]
[Description("执行 Vector3 类型的运算，并将结果存储到指定的变量中。")]
[Category("✫ DragonLost/Movement")]
public class Vector3Operation : ActionTaskBase
{
	[Name("操作数A", 0)]
	[Description("用于运算的第一个 Vector3 类型的操作数。")]
	[RequiredField]
	public BBParameter<Vector3> a;

	[Name("操作数B", 0)]
	[Description("用于运算的第二个 Vector3 类型的操作数。")]
	[RequiredField]
	public BBParameter<Vector3> b;

	[Name("操作", 0)]
	[Description("指定要执行的运算操作。")]
	public Operation operation;

	[Name("结果", 0)]
	[Description("用于存储运算结果的 Vector3 类型的变量。")]
	public BBParameter<Vector3> result;

	protected override void OnExecute()
	{
		base.OnExecute();
		switch (operation)
		{
		case Operation.Add:
			result.value = a.value + b.value;
			break;
		case Operation.Sub:
			result.value = a.value - b.value;
			break;
		}
		EndAction();
	}
}
