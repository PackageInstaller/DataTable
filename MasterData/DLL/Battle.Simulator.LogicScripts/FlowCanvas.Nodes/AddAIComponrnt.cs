using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("添加AI组件", 0)]
[Category("Logic/AI")]
[Description("添加AI组件")]
public class AddAIComponrnt : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> aiIdInput = AddValueInput<int>("AIID");
		int entityID = 0;
		AddValueOutput("实体ID", () => entityID);
		FlowOutput outputTrue = AddFlowOutput("true");
		FlowOutput outputFalse = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			entityID = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
			if (entityWithEntityID == null || entityWithEntityID.hasEntityAIThink || !entityWithEntityID.hasEntityBlackboard)
			{
				outputFalse.Call(f);
			}
			else
			{
				entityWithEntityID.AddEntityAIThink(0, new Dictionary<int, AICommand>(new IntComparer()), null, null, newMReevalute: false, newMForceMakeDecision: false, 0);
				entityWithEntityID.entityBlackboard.var.mAIID = aiIdInput.value;
				base.mSimContext.GetSimInterface().mAIAddedLogicEvent?.Invoke(entityID);
				outputTrue.Call(f);
			}
		});
	}
}
