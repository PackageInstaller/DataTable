using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI连招指令集ID", 0)]
[Category("Logic/AI")]
[Description("配置AI连招指令ID")]
public class AICommboActionID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> actionID = AddValueInput<int>("指令集ID");
		AddValueOutput("指令集ID", () => actionID.value);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			int value = actionID.value;
			SimEntity simEntity = (SimEntity)f.userData;
			if (simEntity.hasEntityAIThink && !simEntity.entityAIThink.mAICommandSet.ContainsKey(value))
			{
				AICommandSet value2 = new AICommandSet
				{
					mID = value
				};
				simEntity.entityAIThink.mAICommandSet.Add(value, value2);
			}
			f.Call(output);
		});
	}
}
