using System.Collections.Generic;
using NetProcol;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("激活或者禁用触发器", 0)]
[Category("Render/Trigger")]
[Description("在表现层发激活或者禁用触发器的命令")]
public class ChangeTriggersStateCommand : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> triggerIDInput = AddValueInput<int>("触发器ID");
		ValueInput<List<int>> enableTriggersIDInput = AddValueInput<List<int>>("要激活的触发器");
		ValueInput<List<int>> disableTriggersIDInput = AddValueInput<List<int>>("要禁用的触发器");
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
				if (enableTriggersIDInput.value != null)
				{
					for (int i = 0; i < enableTriggersIDInput.value.Count; i++)
					{
						int targetTriggerID = enableTriggersIDInput.value[i];
						ChangeTriggerStateCommand changeTriggerStateCommand = CommandFactory.Create(NetprotoOperationCode.CmdModifyTriggerState) as ChangeTriggerStateCommand;
						changeTriggerStateCommand.SetData(agentManager.mPlayerAgentID, value, targetTriggerID, enable: true);
						ClientSimulator.Instance.SendLocalCommand(changeTriggerStateCommand);
					}
				}
				if (disableTriggersIDInput.value != null)
				{
					for (int j = 0; j < disableTriggersIDInput.value.Count; j++)
					{
						int targetTriggerID2 = disableTriggersIDInput.value[j];
						ChangeTriggerStateCommand changeTriggerStateCommand2 = CommandFactory.Create(NetprotoOperationCode.CmdModifyTriggerState) as ChangeTriggerStateCommand;
						changeTriggerStateCommand2.SetData(agentManager.mPlayerAgentID, value, targetTriggerID2, enable: false);
						ClientSimulator.Instance.SendLocalCommand(changeTriggerStateCommand2);
					}
				}
				output.Call(f);
			}
		});
	}
}
