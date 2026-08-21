using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否分身", 0)]
[Category("Logic/Spawn")]
[Description("是否分身")]
public class IsDoppelganger : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		int creatorID = 0;
		AddValueOutput("创建者ID", () => creatorID);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
			{
				creatorID = entityWithEntityID.entityBlackboard.var.creator;
				if (entityWithEntityID.entityBlackboard.var.mRobotType == RobotType.Doppelganger)
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
	}
}
