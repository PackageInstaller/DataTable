using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取浮点数绝对值", 0)]
[Description("获取浮点数变量的绝对值，并将结果存储到指定的黑板浮点数变量中。")]
[Category("✫ DragonLost/Movement")]
public class GetFloatAbs : ActionTaskBase
{
	[Name("变量", 0)]
	[Description("要获取绝对值的浮点数变量。")]
	public BBParameter<float> Value;

	[Name("绝对值", 0)]
	[Description("用于存储绝对值结果的黑板浮点数变量。")]
	public BBParameter<float> AbsValue;

	protected override void OnExecute()
	{
		base.OnExecute();
		AbsValue.value = Mathf.Abs(Value.value);
		EndAction();
	}
}
