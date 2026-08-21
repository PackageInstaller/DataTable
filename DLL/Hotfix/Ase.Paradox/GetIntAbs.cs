using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取整数绝对值", 0)]
[Description("获取整数变量的绝对值，并将结果存储到指定的黑板整数变量中。")]
[Category("✫ DragonLost/Movement")]
public class GetIntAbs : ActionTaskBase
{
	[Name("变量", 0)]
	[Description("要获取绝对值的整数变量。")]
	public BBParameter<int> Value;

	[Name("绝对值", 0)]
	[Description("用于存储绝对值结果的黑板整数变量。")]
	public BBParameter<int> AbsValue;

	protected override void OnExecute()
	{
		base.OnExecute();
		AbsValue.value = Mathf.Abs(Value.value);
		EndAction();
	}
}
