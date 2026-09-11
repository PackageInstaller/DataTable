using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("根据AIID获取实体ID", 0)]
[Category("Logic/Trigger")]
[Description("根据触发器ID获取实体ID")]
public class GetEntityIDByTriggerID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> triggerIDInput = AddValueInput<int>("触发器ID");
		int res = 0;
		AddValueOutput("实体ID", () => res);
		FlowOutput trueOut = AddFlowOutput("获取成功");
		FlowOutput falseOut = AddFlowOutput("获取失败");
		AddFlowInput("In", delegate(Flow f)
		{
			List<int> allEnemy = SpawnProcessor.GetAllEnemy();
			for (int i = 0; i < allEnemy.Count; i++)
			{
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(allEnemy[i]);
				if (entityWithEntityID.hasEntityBlackboard && entityWithEntityID.entityBlackboard.var.mAIID == triggerIDInput.value)
				{
					res = entityWithEntityID.creationIndex;
					trueOut.Call(f);
					return;
				}
			}
			falseOut.Call(f);
		});
	}
}
