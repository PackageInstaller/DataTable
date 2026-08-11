using Ase;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace NodeCanvas.Tasks.Actions;

[Name("设置随机浮点数", 0)]
[Category("✫ Blackboard")]
[Description("在指定范围内随机设置黑板中的浮点数变量")]
public class SetFloatRandom : ActionTaskBase
{
	[BlackboardOnly]
	[Name("浮点数变量", 0)]
	[Description("要设置的黑板浮点数变量")]
	public BBParameter<float> floatVariable;

	[Name("最大值", 0)]
	[Description("随机值的最大范围")]
	public BBParameter<float> maxValue;

	[Name("最小值", 0)]
	[Description("随机值的最小范围")]
	public BBParameter<float> minValue;

	protected override string info => "设置 " + floatVariable?.ToString() + " 随机(" + minValue?.ToString() + ", " + maxValue?.ToString() + ")";

	protected override void OnExecute()
	{
		base.OnExecute();
		floatVariable.value = ownerEntity.RandomFloat(minValue.value, maxValue.value);
		EndAction();
	}
}
