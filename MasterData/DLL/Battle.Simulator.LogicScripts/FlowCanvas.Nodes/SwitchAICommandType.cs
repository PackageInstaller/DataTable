using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断AI指令", 0)]
[Category("Logic/AI")]
[Description("判断AI指令状态")]
public class SwitchAICommandType : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput output1 = AddFlowOutput("集火");
		FlowOutput output2 = AddFlowOutput("集合");
		FlowOutput output3 = AddFlowOutput("分散");
		FlowOutput output4 = AddFlowOutput("求救");
		FlowOutput output5 = AddFlowOutput("其他");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityAIThink)
			{
				AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2204, out var baseValue, out var _, out var _);
				switch ((AICommandType)baseValue)
				{
				case AICommandType.Dispersed:
					output3.Call(f);
					break;
				case AICommandType.FocusOnMyTarget:
					output1.Call(f);
					break;
				case AICommandType.Follow:
					output2.Call(f);
					break;
				case AICommandType.Help:
					output4.Call(f);
					break;
				case AICommandType.None:
					output5.Call(f);
					break;
				}
			}
			else
			{
				output5.Call(f);
			}
		});
	}
}
