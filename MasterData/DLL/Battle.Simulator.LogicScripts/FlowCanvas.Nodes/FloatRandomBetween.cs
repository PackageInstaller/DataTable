using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("随机数值浮动(已过时)", 0)]
[Category("Logic/Math")]
[Description("随机数值浮动,下限和上限的标准是1")]
public class FloatRandomBetween : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<float> valueInput = AddValueInput<float>("基础值");
		ValueInput<float> minRatioInput = AddValueInput<float>("下限");
		ValueInput<float> maxRatioInput = AddValueInput<float>("上限");
		ValueInput<int> randomNumberInput = AddValueInput<int>("随机份数");
		AddValueOutput("结果", delegate
		{
			float value = valueInput.value;
			int num = randomNumberInput.value;
			if (num <= 0)
			{
				num = 1;
			}
			num = (int)DRandom.Random((uint)num);
			float value2 = minRatioInput.value;
			return ((maxRatioInput.value - value2) / (float)randomNumberInput.value * (float)num + value2) * value;
		});
	}
}
