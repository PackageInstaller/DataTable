using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("移除所有buff(排除列表)(逻辑)", 0)]
[Category("Logic/Buff")]
[Description("移除所有不在列表中的buff")]
public class RemoveEntityAllBuffWithoutList : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<List<int>> listInput = AddValueInput<List<int>>("排除列表", "list");
		FlowOutput output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBuff)
			{
				List<int> mBuffClassIDArray = entityWithEntityID.entityBuff.mBuffClassIDArray;
				for (int num = mBuffClassIDArray.Count - 1; num >= 0; num--)
				{
					if (!listInput.value.Contains(mBuffClassIDArray[num]))
					{
						BuffProcessor.RemoveBuffByListIndex(entityWithEntityID, num);
					}
				}
			}
			output.Call(f);
		});
	}
}
