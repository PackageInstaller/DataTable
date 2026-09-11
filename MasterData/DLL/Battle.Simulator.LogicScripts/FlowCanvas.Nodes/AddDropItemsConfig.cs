using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("添加掉落配置", 0)]
[Category("Logic/Trigger")]
[Description("添加掉落配置")]
public class AddDropItemsConfig : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<List<int>> listInput = AddValueInput<List<int>>("掉落配置");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
			{
				List<int> value = listInput.value;
				if (value != null)
				{
					entityWithEntityID.entityBlackboard.var.mDropItems.Clear();
					for (int i = 0; i < value.Count; i++)
					{
						entityWithEntityID.entityBlackboard.var.mDropItems.Add(value[i]);
					}
				}
			}
			output.Call(f);
		});
	}
}
