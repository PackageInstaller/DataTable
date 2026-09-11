using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("存活的敌人数量", 0)]
[Category("Logic/Spawn")]
[Description("存活的敌人数量")]
public class AliveEnemyNumber : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("", delegate
		{
			int num = 0;
			List<int> mEnemys = CommonProcessor.GetWorldState().mEnemys;
			for (int i = 0; i < mEnemys.Count; i++)
			{
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(mEnemys[i]);
				if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard && entityWithEntityID.entityBlackboard.var.mHP > 0)
				{
					num++;
				}
			}
			return num;
		});
	}
}
