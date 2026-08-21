using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("检查随机数值", 0)]
[Category("✫ DragonLost/Movement")]
[Description("检查随机生成的数字是否满足特定条件。")]
public class CheckRandomNum : ConditionTaskBase
{
	[Name("最小值", 0)]
	[Description("随机数范围的最小值。")]
	public int randomRangeMin = 1;

	[Name("最大值", 0)]
	[Description("随机数范围的最大值。")]
	public int randomRangeMax = 100;

	[Name("比较方式", 0)]
	[Description("用于比较随机数与目标值的方式。")]
	public CompareMethod checkType;

	[Name("目标值", 0)]
	[Description("与随机数进行比较的目标值。")]
	public BBParameter<int> valueB;

	protected override string info => $"随机数 {OperationTools.GetCompareString(checkType)} {valueB}";

	protected override bool OnCheck()
	{
		return OperationTools.Compare(ownerEntity.RandomInt(randomRangeMin, randomRangeMax), valueB.value, checkType);
	}
}
