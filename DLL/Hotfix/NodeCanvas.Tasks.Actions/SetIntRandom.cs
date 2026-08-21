using Ase;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace NodeCanvas.Tasks.Actions;

[Name("随机设置整数", 0)]
[Category("✫ Blackboard")]
[Description("在指定范围内随机设置黑板中的整数变量")]
public class SetIntRandom : ActionTaskBase
{
	[BlackboardOnly]
	[Name("整数变量", 0)]
	[Description("要设置的黑板整数变量")]
	public BBParameter<int> intVariable;

	[Name("最大值", 0)]
	[Description("随机值的最大范围")]
	public BBParameter<int> maxValue;

	[Name("最小值", 0)]
	[Description("随机值的最小范围")]
	public BBParameter<int> minValue;

	protected override string info => "设置 " + intVariable?.ToString() + " 随机(" + minValue?.ToString() + ", " + maxValue?.ToString() + ")";

	protected override void OnExecute()
	{
		base.OnExecute();
		intVariable.value = ownerEntity.RandomInt(minValue.value, maxValue.value + 1);
		EndAction();
	}
}
