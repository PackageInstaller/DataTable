using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("敌人中心位置", 0)]
[Category("Logic/PosAndRot")]
[Description("计算敌人中心位置")]
public class CalcEnemyCenterPos : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("位置", delegate
		{
			Int3 zero = Int3.zero;
			int num = 0;
			List<int> allEnemy = SpawnProcessor.GetAllEnemy();
			for (int i = 0; i < allEnemy.Count; i++)
			{
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(allEnemy[i]);
				if (entityWithEntityID != null && entityWithEntityID.hasEntityPositon)
				{
					num++;
					zero += entityWithEntityID.entityPositon.mPosition;
				}
			}
			return zero / num;
		});
	}
}
