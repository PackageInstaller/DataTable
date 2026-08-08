using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置全局时间缩放", 0)]
[Category("Logic/Control")]
[Description("设置全局时间缩放(0 - 100), 想要取消这个设置的话, 可以直接按ID移除")]
public class SetCommonWorldTimeScale : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> idInput = AddValueInput<int>("ID");
		ValueInput<int> valueInput = AddValueInput<int>("缩放值");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			CommonProcessor.GetWorldState().commonWorldTimeScaleFactor[idInput.value] = (short)valueInput.value;
			f.Call(output);
		});
	}
}
