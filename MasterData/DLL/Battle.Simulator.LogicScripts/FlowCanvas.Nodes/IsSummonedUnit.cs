using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否召唤兽", 0)]
[Category("Logic/SummonedUnit")]
[Description("是否召唤兽")]
public class IsSummonedUnit : FlowNode
{
	private int m_creatorID;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDVar = AddValueInput<int>("实体ID", "entityIDVar");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDVar.GetValue());
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
			{
				m_creatorID = entityWithEntityID.entityBlackboard.var.creator;
				if (entityWithEntityID.entityBlackboard.var.mRobotType == RobotType.SummonedUnit)
				{
					trueOut.Call(f);
				}
				else
				{
					falseOut.Call(f);
				}
			}
			else
			{
				falseOut.Call(f);
			}
		});
		AddValueOutput("召唤者实体ID", "EntityID", () => m_creatorID);
		AddValueOutput("召唤兽实体ID", "SummonedUnitEntityID", () => entityIDVar.GetValue());
	}
}
