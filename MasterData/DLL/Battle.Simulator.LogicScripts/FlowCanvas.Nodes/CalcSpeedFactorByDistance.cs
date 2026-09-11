using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("根据距离计算插值", 0)]
[Category("Logic/Math")]
[Description("根据距离计算速度, 在最小距离和最大距离之间返回一个插值")]
public class CalcSpeedFactorByDistance : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> targetIDInput = AddValueInput<int>("目标实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> minDistanceInput = AddValueInput<int>("最小距离");
		ValueInput<int> maxDistanceInput = AddValueInput<int>("最大距离");
		ValueInput<int> minValueInput = AddValueInput<int>("最小值");
		ValueInput<int> maxValueInput = AddValueInput<int>("最大值");
		int res = 0;
		AddValueOutput("结果", () => res);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			int num = AIProcessor.GetDistanceBetweenEntities(entityIDInput.value, targetIDInput.value);
			if (num < minDistanceInput.value)
			{
				num = minDistanceInput.value;
			}
			if (num > maxDistanceInput.value)
			{
				num = maxDistanceInput.value;
			}
			num -= minDistanceInput.value;
			res = IntMath.Lerp(minValueInput.value, maxValueInput.value, num, maxDistanceInput.value - minDistanceInput.value);
			output.Call(f);
		});
	}
}
