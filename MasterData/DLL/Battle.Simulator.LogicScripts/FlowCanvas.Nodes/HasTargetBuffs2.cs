using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("指定类型buff是否存在(多重)", 0)]
[Category("Logic/Buff")]
[Description("一次性判断多个指定类型Buff是否存在\n部分存在：至少有一种存在和一种不存在\n存在的种类数：每种存在的ClassID只会计一次")]
public class HasTargetBuffs2 : FlowNode
{
	private int count;

	public bool EntityHasBuffClass(SimEntity simEntity, int buffClassID)
	{
		for (int i = 0; i < simEntity.entityBuff.mBuffClassIDArray.Count; i++)
		{
			if (!simEntity.entityBuff.IsInPendingRemoveArray(simEntity.entityBuff.mBuffID[i]) && simEntity.entityBuff.mBuffClassIDArray[i] == buffClassID)
			{
				return true;
			}
		}
		return false;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<List<int>> buffListInput = AddValueInput<List<int>>("Buff类型ID(组)");
		FlowOutput allOut = AddFlowOutput("全部存在", "all");
		FlowOutput someOut = AddFlowOutput("部分存在", "some");
		FlowOutput noneOut = AddFlowOutput("都不存在", "None");
		FlowOutput errorOut = AddFlowOutput("error", "error");
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		AddValueOutput("存在的种类数", "count", () => count);
		AddFlowInput("", delegate(Flow f)
		{
			count = 0;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.GetValue());
			if (entityWithEntityID == null)
			{
				errorOut.Call(f);
			}
			else if (!entityWithEntityID.hasEntityBuff)
			{
				noneOut.Call(f);
			}
			else
			{
				for (int i = 0; i < buffListInput.value.Count; i++)
				{
					if (EntityHasBuffClass(entityWithEntityID, buffListInput.value[i]))
					{
						count++;
					}
				}
				if (count == buffListInput.value.Count)
				{
					allOut.Call(f);
				}
				else if (count > 0 && count < buffListInput.value.Count)
				{
					someOut.Call(f);
				}
				else if (count == 0)
				{
					noneOut.Call(f);
				}
			}
		});
	}
}
