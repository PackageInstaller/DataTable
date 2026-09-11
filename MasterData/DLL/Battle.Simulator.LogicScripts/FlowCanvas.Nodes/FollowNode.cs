using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("集合(过时)", 0)]
[Category("Logic/AI")]
[Description("集合, 在里面设置时间")]
public class FollowNode : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> timeInput = AddValueInput<int>("时间");
		ValueInput<int> timeInput2 = AddValueInput<int>("时间2");
		ValueInput<int> distanceInput = AddValueInput<int>("距离");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			entityWithEntityID.entityAIThink.mThinkTimer += CommonProcessor.GetLogicConstTick();
			if (entityWithEntityID.entityAIThink.mThinkTimer > timeInput.value && entityWithEntityID.entityAIThink.mThinkTimer < timeInput2.value)
			{
				List<int> list = FrameListPool<int>.Claim();
				SimPhysics.Overlap(entityWithEntityID.entityPositon.mPosition, distanceInput.value, list, RoleCampProcessor.GetInterestCamp(entityWithEntityID.entityCamp.mRoleTypeCamp));
				if (list.Count > 0)
				{
					entityWithEntityID.entityAIThink.mThinkTimer = 0;
					AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2204, 0L, 0L, 0L);
				}
				FrameListPool<int>.Release(list);
			}
			else if (entityWithEntityID.entityAIThink.mThinkTimer > timeInput2.value)
			{
				entityWithEntityID.entityAIThink.mThinkTimer = 0;
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2204, 0L, 0L, 0L);
			}
			output.Call(f);
		});
	}
}
