using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("指定位置是否在范围内", 0)]
[Category("Logic/PosAndRot")]
[Description("给定位置和范围确定是否在范围内")]
public class TargetInRange : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<Int3> position = AddValueInput<Int3>("position");
		ValueInput<int> range = AddValueInput<int>("range");
		ValueInput<Int3> center = AddValueInput<Int3>("center");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("In", delegate(Flow f)
		{
			try
			{
				if ((position.value - center.value).sqrMagnitude <= (float)(range.value * range.value))
				{
					f.Call(trueOut);
				}
				else
				{
					f.Call(falseOut);
				}
			}
			catch
			{
				f.Call(falseOut);
			}
		});
	}
}
