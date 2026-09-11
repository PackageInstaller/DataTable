using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置逻辑暂停标志", 0)]
[Category("Logic/Control")]
[Description("设置逻辑暂停标志")]
public class SetLogicPauseFlag : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<bool> valueInput = AddValueInput<bool>("值");
		ValueInput<LogicTimerPauseReason> reasonInput = AddValueInput<LogicTimerPauseReason>("原因");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			CommonProcessor.GetWorldState()?.SetLogicTimerPauseFlag(valueInput.value, reasonInput.value);
			f.Call(output);
		});
	}
}
