using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到战斗评分(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("得到战斗评分")]
public class GetCombatScore : FlowControlNode
{
	private int m_combatScore;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityIDInput");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			m_combatScore = 0;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				error.Call(f);
			}
			else
			{
				m_combatScore = entityWithEntityID.entityBlackboard.var.mCombatScore;
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.GetValue());
		AddValueOutput("战斗评分", "combatScore", () => m_combatScore);
	}
}
