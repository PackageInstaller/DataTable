using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("取消全局时间缩放", 0)]
[Category("Logic/Control")]
[Description("取消全局时间缩放")]
public class RemoveCommonWorldTimeScale : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> idInput = AddValueInput<int>("ID");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			CommonProcessor.GetWorldState().commonWorldTimeScaleFactor.Remove(idInput.value);
			f.Call(output);
		});
	}
}
