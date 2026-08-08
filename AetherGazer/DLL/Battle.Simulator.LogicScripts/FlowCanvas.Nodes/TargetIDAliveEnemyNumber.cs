using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("指定类型敌人数量", 0)]
[Category("Logic/Spawn")]
[Description("指定类型敌人数量")]
public class TargetIDAliveEnemyNumber : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> roleIDInput = AddValueInput<int>("敌人类型");
		AddValueOutput("数量", delegate
		{
			int num = 0;
			List<int> allEnemy = SpawnProcessor.GetAllEnemy();
			int value = roleIDInput.value;
			for (int i = 0; i < allEnemy.Count; i++)
			{
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(allEnemy[i]);
				if (value != 0 && value == (int)entityWithEntityID.ENTITY_CONFIG_ID && entityWithEntityID.hasEntityBlackboard && entityWithEntityID.entityBlackboard.var.creator == 0 && entityWithEntityID.entityBlackboard.var.mHP > 0)
				{
					num++;
				}
				else if (value == 0)
				{
					num++;
				}
			}
			return num;
		});
	}
}
