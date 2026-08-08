using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到全场抗性点最大点数(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("得到抗性点数量，反馈的实体id则返回第一个找到的持有最大抗性点的实体")]
public class GetMaxResistanceCount : FlowNode
{
	protected override void RegisterPorts()
	{
		int entityID = 0;
		AddValueOutput("实体ID", "entityID", () => entityID);
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput failedOut = AddFlowOutput("没找到", "failed");
		AddFlowOutput("Error", "error");
		int max = 0;
		AddValueOutput("最大点数", "max", () => max);
		AddFlowInput("In", "input", delegate(Flow f)
		{
			entityID = 0;
			max = int.MinValue;
			List<int> allEnemy = SpawnProcessor.GetAllEnemy(base.mSimContext);
			for (int num = allEnemy.Count - 1; num >= 0; num--)
			{
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(allEnemy[num]);
				if (entityWithEntityID != null && entityWithEntityID.hasEntityResistance && max < entityWithEntityID.entityResistance.maxValue)
				{
					max = entityWithEntityID.entityResistance.maxValue;
					entityID = entityWithEntityID.creationIndex;
				}
			}
			if (entityID == 0)
			{
				max = 0;
				f.Call(failedOut);
			}
			else
			{
				f.Call(output);
			}
		});
	}
}
