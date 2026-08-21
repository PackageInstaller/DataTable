using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("存活的召唤兽数量", 0)]
[Category("Logic/Spawn")]
[Description("存活的召唤兽数量, 遍历查找(地方阵营), 不要每帧调用")]
public class SummonedUnitNumber : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> casterEntityIDInput = AddValueInput<int>("召唤者实体ID");
		AddValueOutput("存活数量", delegate
		{
			int num = 0;
			List<int> mEnemys = CommonProcessor.GetWorldState().mEnemys;
			int value = casterEntityIDInput.value;
			for (int i = 0; i < mEnemys.Count; i++)
			{
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(mEnemys[i]);
				if (entityWithEntityID != null && CommonProcessor.IsAliveRole(entityWithEntityID) && entityWithEntityID.entityBlackboard.var.mRobotType == RobotType.SummonedUnit && (value == 0 || entityWithEntityID.entityBlackboard.var.creator == value))
				{
					num++;
				}
			}
			return num;
		});
	}
}
