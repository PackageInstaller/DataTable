using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("集火(过时)", 0)]
[Category("Logic/AI")]
[Description("集火, 在里面设置目标而已")]
public class FocusOnMyTargetNode : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> timeInput = AddValueInput<int>("时间");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			int localPlayerID = SpawnProcessor.GetLocalPlayerID();
			SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(localPlayerID);
			SimEntity entityWithEntityID3 = base.mSimContext.GetEntityWithEntityID(entityWithEntityID2.entityBlackboard.var.mAimTarget);
			if (entityWithEntityID3 != null && entityWithEntityID3.hasEntityBlackboard && entityWithEntityID3.entityBlackboard.var.mHP > 0)
			{
				AbilitiesProcessor.SetAimTargetAndNearestPart(entityWithEntityID, entityWithEntityID2.entityBlackboard.var.mAimTarget);
				entityWithEntityID.entityAIThink.mThinkTimer += CommonProcessor.GetLogicConstTick();
				if (entityWithEntityID.entityAIThink.mThinkTimer > timeInput.value)
				{
					entityWithEntityID.entityAIThink.mThinkTimer = 0;
					AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2204, 0L, 0L, 0L);
				}
				output.Call(f);
			}
			else
			{
				entityWithEntityID.entityAIThink.mThinkTimer = 0;
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2204, 0L, 0L, 0L);
			}
		});
	}
}
