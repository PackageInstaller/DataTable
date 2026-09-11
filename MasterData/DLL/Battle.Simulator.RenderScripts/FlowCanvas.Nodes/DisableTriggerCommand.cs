using NetProcol;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("禁用单个触发器的命令", 0)]
[Category("Render/Trigger")]
[Description("在表现层发禁用触发器的命令")]
public class DisableTriggerCommand : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> triggerIDInput = AddValueInput<int>("触发器ID");
		ValueInput<int> disableTriggerIDInput = AddValueInput<int>("要禁用的触发器").SetDefaultAndSerializedValue(-1);
		FlowOutput output = AddFlowOutput("Out");
		AddValueOutput("触发器ID", () => triggerIDInput.value);
		AddFlowInput("In", delegate(Flow f)
		{
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (agentManager == null)
			{
				output.Call(f);
			}
			else
			{
				int value = triggerIDInput.value;
				if (disableTriggerIDInput.value != -1)
				{
					int value2 = disableTriggerIDInput.value;
					ChangeTriggerStateCommand changeTriggerStateCommand = CommandFactory.Create(NetprotoOperationCode.CmdModifyTriggerState) as ChangeTriggerStateCommand;
					changeTriggerStateCommand.SetData(agentManager.mPlayerAgentID, value, value2, enable: false);
					ClientSimulator.Instance.SendLocalCommand(changeTriggerStateCommand);
				}
				output.Call(f);
			}
		});
	}
}
