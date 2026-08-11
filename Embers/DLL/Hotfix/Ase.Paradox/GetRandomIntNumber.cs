using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取随机整数", 0)]
[Description("在指定的范围内获取一个随机整数，并将结果存储到指定的变量中。")]
[Category("✫ DragonLost/Movement")]
public class GetRandomIntNumber : ActionTaskBase
{
	[Name("最小值", 0)]
	[Description("生成随机整数的最小值（包含）")]
	public BBParameter<int> randomRangeMin;

	[Name("最大值", 0)]
	[Description("生成随机整数的最大值（不包含）")]
	public BBParameter<int> randomRangeMax;

	[Name("返回值", 0)]
	[Description("用于存储生成的随机整数的变量")]
	public BBParameter<int> returnNumber;

	protected override string info => $"获取随机数 [{randomRangeMin.value} , {randomRangeMax.value}]";

	protected override void OnExecute()
	{
		base.OnExecute();
		returnNumber.value = ownerEntity.RandomInt(randomRangeMin.value, randomRangeMax.value + 1);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"获取的随机数：{returnNumber.value}", ownerEntity);
		}
		OnActionFinish();
	}
}
