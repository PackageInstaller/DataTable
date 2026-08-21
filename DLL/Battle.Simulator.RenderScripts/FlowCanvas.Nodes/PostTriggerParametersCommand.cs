using NetProcol;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("发送触发器传递参数命令(渲染)", 0)]
[Category("Render/Trigger")]
[Description("触发器从渲染层向逻辑层发送带参数的命令")]
public class PostTriggerParametersCommand : FlowControlNodeOfRender
{
	protected override void RegisterPorts()
	{
		ValueInput<int> triggerAgentIDInput = AddValueInput<int>("触发的实体ID", "triggerAgentID");
		ValueInput<int> triggerIDInput = AddValueInput<int>("触发器ID", "triggerID");
		ValueInput<int> param1Input = AddValueInput<int>("参数1", "param1");
		ValueInput<int> param2Input = AddValueInput<int>("参数2", "param2");
		ValueInput<int> param3Input = AddValueInput<int>("参数3", "param3");
		ValueInput<int> param4Input = AddValueInput<int>("参数4", "param4");
		FlowOutput output = AddFlowOutput("Out", "output");
		AddValueOutput("触发器ID", "triggerID", () => triggerIDInput.value);
		AddFlowInput("In", delegate(Flow f)
		{
			int value = triggerIDInput.value;
			TriggerParametersCommand triggerParametersCommand = CommandFactory.Create(NetprotoOperationCode.CmdTriggerParameters) as TriggerParametersCommand;
			triggerParametersCommand.SetData(triggerAgentIDInput.value, value, param1Input.value, param2Input.value, param3Input.value, param4Input.value);
			ClientSimulator.Instance.SendLocalCommand(triggerParametersCommand);
			output.Call(f);
		});
	}
}
