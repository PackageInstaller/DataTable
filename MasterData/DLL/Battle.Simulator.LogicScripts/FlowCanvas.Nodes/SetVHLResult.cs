using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[VHL]写入VHL全局变量(逻辑)", 0)]
[Category("Logic/Config")]
[Description("向AI玩法的跨关卡全局变量写入新值。仅AI玩法可用。")]
[Color("ffffff")]
public class SetVHLResult : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		ValueInput<int> valueInput = AddValueInput<int>("Value");
		AddFlowInput("", delegate(Flow f)
		{
			CommonProcessor.GetWorldState().mVHLResult = valueInput.value;
			output.Call(f);
		});
	}
}
