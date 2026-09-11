using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置战斗评分(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("设置战斗评分")]
public class SetCombatScore : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityIDInput");
		ValueInput<int> combatScoreInput = AddValueInput<int>("战斗评分", "combatScoreInput");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				error.Call(f);
			}
			else
			{
				entityWithEntityID.entityBlackboard.var.mCombatScore = combatScoreInput.GetValue();
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.GetValue());
		AddValueOutput("战斗评分", "combatScore", () => combatScoreInput.GetValue());
	}
}
