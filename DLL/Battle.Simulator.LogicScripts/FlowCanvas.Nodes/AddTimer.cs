using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("添加实体计时器(自动计时)", 0)]
[Category("Logic/Buff")]
[Description("添加实体计时器(自动计时)")]
public class AddTimer : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> nameInput = AddValueInput<int>("计时器编号");
		ValueInput<int> duringTimeInput = AddValueInput<int>("存在时间");
		ValueInput<int> delayTimeInput = AddValueInput<int>("延迟触发时间");
		ValueInput<int> intervalTimeInput = AddValueInput<int>("触发间隔");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			if (BuffProcessor.TryAddTimer(entityIDInput.value, nameInput.value, delayTimeInput.value, duringTimeInput.value, intervalTimeInput.value))
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
