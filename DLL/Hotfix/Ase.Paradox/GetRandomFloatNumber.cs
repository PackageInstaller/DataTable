using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取随机浮点数", 0)]
[Description("在指定的范围内获取一个随机浮点数，并将结果存储到指定的变量中。")]
[Category("✫ DragonLost/Movement")]
public class GetRandomFloatNumber : ActionTaskBase
{
	[Name("最小值", 0)]
	[Description("生成随机浮点数的最小值（包含）")]
	public BBParameter<float> randomRangeMin;

	[Name("最大值", 0)]
	[Description("生成随机浮点数的最大值（包含）")]
	public BBParameter<float> randomRangeMax;

	[Name("返回值", 0)]
	[Description("用于存储生成的随机浮点数的变量")]
	public BBParameter<float> returnNumber;

	protected override string info => $"获取随机数 [{randomRangeMin.value} , {randomRangeMax.value}]";

	protected override void OnExecute()
	{
		base.OnExecute();
		returnNumber.value = ownerEntity.RandomFloat(randomRangeMin.value, randomRangeMax.value);
		OnActionFinish();
	}
}
