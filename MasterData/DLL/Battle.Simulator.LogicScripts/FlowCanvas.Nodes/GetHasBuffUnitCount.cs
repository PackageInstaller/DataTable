using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获得拥有指定Buff的敌人个数", 0)]
[Category("Logic/Control")]
[Description("将敌人往指定位置聚集")]
[ExposeAsDefinition]
public class GetHasBuffUnitCount : PureFunctionNode<int, int>
{
	public override int Invoke(int buffID)
	{
		int num = 0;
		List<int> allEnemy = SpawnProcessor.GetAllEnemy();
		for (int i = 0; i < allEnemy.Count; i++)
		{
			SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(allEnemy[i]);
			if (entityWithEntityID.hasEntityBuff)
			{
				num += (entityWithEntityID.entityBuff.Contain(buffID) ? 1 : 0);
			}
		}
		return num;
	}
}
