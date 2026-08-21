using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI重新决策", 0)]
[Category("Logic/AI")]
[Description("AI重新决策")]
public class AIForceMakeDecisionAction : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityID = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityID.value);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityAIThink)
			{
				entityWithEntityID.entityAIThink.mForceMakeDecision = true;
				f.Call(output);
			}
		});
	}
}
