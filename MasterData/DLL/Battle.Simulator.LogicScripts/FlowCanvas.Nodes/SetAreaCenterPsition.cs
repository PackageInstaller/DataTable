using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置战斗区域中心位置", 0)]
[Category("Logic/Trigger")]
[Description("设置战斗区域中心位置")]
public class SetAreaCenterPsition : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<Int3> targetPos = AddValueInput<Int3>("位置");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			CommonProcessor.GetWorldState().centerPosition = targetPos.value;
			f.Call(output);
		});
	}
}
