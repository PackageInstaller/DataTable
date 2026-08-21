using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("求救(过时)", 0)]
[Category("Logic/AI")]
[Description("求救, 在里面设置目标而已")]
public class HelpPlayerNode : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> timeInput = AddValueInput<int>("时间");
		FlowOutput output = AddFlowOutput("");
		FlowOutput noTargetOutput = AddFlowOutput("没有目标");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			int localPlayerID = SpawnProcessor.GetLocalPlayerID();
			SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(localPlayerID);
			List<int> allEnemy = SpawnProcessor.GetAllEnemy();
			int num = 0;
			long num2 = long.MaxValue;
			int num3 = 0;
			long num4 = long.MaxValue;
			for (int i = 0; i < allEnemy.Count; i++)
			{
				SimEntity entityWithEntityID3 = base.mSimContext.GetEntityWithEntityID(allEnemy[i]);
				if (entityWithEntityID3 != null && entityWithEntityID3.hasEntityBlackboard && entityWithEntityID3.entityBlackboard.var.mHP > 0)
				{
					AttributeProcessor.GetAttributeWithIntName(entityWithEntityID3.entityBlackboard.var.mAttributeID, 2209, out var baseValue, out var _, out var _);
					long num5 = MovementProcessor.SqrDistance(entityWithEntityID2, entityWithEntityID3);
					if (entityWithEntityID3.entityBlackboard.var.mAimTarget == localPlayerID && (baseValue > 2 || entityWithEntityID3.hasEntityActionAbility) && num5 < num2)
					{
						num2 = num5;
						num = allEnemy[i];
					}
					if (num5 < num4)
					{
						num4 = num5;
						num3 = allEnemy[i];
					}
				}
			}
			bool flag = true;
			if (num != 0)
			{
				AIProcessor.ChangeTarget(entityWithEntityID, num);
			}
			else
			{
				num = entityWithEntityID2.entityBlackboard.var.mAimTarget;
				SimEntity entityWithEntityID4 = base.mSimContext.GetEntityWithEntityID(num);
				if (entityWithEntityID4 != null && entityWithEntityID4.hasEntityBlackboard && entityWithEntityID4.entityBlackboard.var.mHP > 0)
				{
					AIProcessor.ChangeTarget(entityWithEntityID, num);
				}
				else if (num3 != 0)
				{
					AIProcessor.ChangeTarget(entityWithEntityID, num3);
				}
				else
				{
					flag = false;
				}
			}
			entityWithEntityID.entityAIThink.mThinkTimer += CommonProcessor.GetLogicConstTick();
			if (entityWithEntityID.entityAIThink.mThinkTimer > timeInput.value)
			{
				entityWithEntityID.entityAIThink.mThinkTimer = 0;
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2204, 0L, 0L, 0L);
			}
			if (flag)
			{
				output.Call(f);
			}
			else
			{
				noTargetOutput.Call(f);
			}
		});
	}
}
