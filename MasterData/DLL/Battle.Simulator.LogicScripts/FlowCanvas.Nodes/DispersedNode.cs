using System.Collections.Generic;
using ParadoxNotion.Design;
using Pathfinding.Util;

namespace FlowCanvas.Nodes;

[Name("分散(过时)", 0)]
[Category("Logic/AI")]
[Description("分散")]
public class DispersedNode : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> distanceInput = AddValueInput<int>("距离");
		ValueInput<int> timeInput = AddValueInput<int>("时间");
		Int3 resDir = Int3.zero;
		AddValueOutput("移动方向", () => resDir);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			entityWithEntityID.entityAIThink.mThinkTimer += CommonProcessor.GetLogicConstTick();
			List<int> list = ListPool<int>.Claim();
			SimPhysics.Overlap(entityWithEntityID.entityPositon.mPosition, distanceInput.value, list, entityWithEntityID.entityCamp.mRoleTypeCamp);
			Int3 zero = Int3.zero;
			int num = 0;
			for (int i = 0; i < list.Count; i++)
			{
				SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(list[i]);
				if (entityWithEntityID2 != null && entityWithEntityID2 != entityWithEntityID && !entityWithEntityID2.hasEntityActionDeath)
				{
					zero += entityWithEntityID2.entityPositon.mPosition;
					num++;
				}
			}
			ListPool<int>.Release(list);
			if (num != 0)
			{
				zero /= (float)num;
				resDir = entityWithEntityID.entityPositon.mPosition - zero;
				AIProcessor.MoveAIDirection(entityWithEntityID.creationIndex, entityWithEntityID.entityPositon.mPosition + resDir, VFactor.one);
			}
			else
			{
				AIProcessor.StopAIMovement(entityWithEntityID.creationIndex);
			}
			if (entityWithEntityID.entityAIThink.mThinkTimer > timeInput.value)
			{
				entityWithEntityID.entityAIThink.mThinkTimer = 0;
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2204, 0L, 0L, 0L);
			}
			output.Call(f);
		});
	}
}
