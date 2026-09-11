using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("遍历处理掉落配置", 0)]
[Category("Logic/Config")]
[Description("遍历处理掉落配置")]
public class GetDropItemConfig : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput doOut = AddFlowOutput("do");
		FlowOutput doneOut = AddFlowOutput("done");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		int configID = 0;
		AddValueOutput("配置ID", () => configID);
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
			{
				List<int> mDropItems = entityWithEntityID.entityBlackboard.var.mDropItems;
				for (int i = 0; i < mDropItems.Count; i++)
				{
					configID = mDropItems[i];
					if (configID != 0)
					{
						doOut.Call(f);
					}
				}
			}
			else
			{
				doneOut.Call(f);
			}
		});
	}
}
