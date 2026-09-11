using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到Buff数量(类型(处理逻辑)ID)(逻辑)", 0)]
[Category("Logic/Buff/通用")]
[Description("得到EntityID对应的实体身上指定类型对应的BUFF/DEBUFF的数量")]
public class GetNumberOfSpecifiedBuffClass : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out");
		FlowOutput nullOutput = AddFlowOutput("无BUFF");
		FlowOutput abnormalOut = AddFlowOutput("Error", "无效实体ID");
		ValueInput<int> entityIDVar = AddValueInput<int>("持有者实体ID", "实体ID");
		ValueInput<int> buffClassVar = AddValueInput<int>("类型(处理逻辑)ID", "BUFF类型ID");
		int count = 0;
		AddFlowInput("In", delegate(Flow f)
		{
			count = 0;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDVar.GetValue());
			if (entityWithEntityID == null)
			{
				abnormalOut.Call(f);
			}
			else if (!entityWithEntityID.hasEntityBuff)
			{
				nullOutput.Call(f);
			}
			else
			{
				for (int i = 0; i < entityWithEntityID.entityBuff.mBuffClassIDArray.Count; i++)
				{
					if (entityWithEntityID.entityBuff.mBuffClassIDArray[i] == buffClassVar.value && !entityWithEntityID.entityBuff.IsInPendingRemoveArray(entityWithEntityID.entityBuff.mBuffID[i]))
					{
						count++;
					}
				}
				output.Call(f);
			}
		});
		AddValueOutput("持有者实体ID", "实体ID", () => entityIDVar.value);
		AddValueOutput("Buff数量", "数量", () => count);
	}
}
