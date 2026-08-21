using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否为AI", 0)]
[Category("Logic/Spawn")]
[Description("是否为AI")]
public class IsAI : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityShape && entityWithEntityID.hasEntityBlackboard)
			{
				if (entityWithEntityID.hasEntityAIThink && entityWithEntityID.entityBlackboard.var.mAIID != 0)
				{
					f.Call(trueOut);
				}
				else
				{
					f.Call(falseOut);
				}
			}
			else
			{
				f.Call(falseOut);
			}
		});
	}
}
