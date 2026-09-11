using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到Buff(类型(处理逻辑)ID)(逻辑)", 0)]
[Category("Logic/Buff/通用")]
[Description("得到EntityID对应的实体身上指定类型对应的第一个buffID")]
public class GetIDOfSpecifiedBuffClass : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out");
		FlowOutput abnormalOut = AddFlowOutput("Error", "无效EntityID");
		ValueInput<int> entityIDVar = AddValueInput<int>("持有者实体ID", "实体ID");
		ValueInput<int> buffClassVar = AddValueInput<int>("类型(处理逻辑)ID", "BUFF类型ID");
		int buffID = 0;
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDVar.GetValue());
			if (entityWithEntityID == null)
			{
				abnormalOut.Call(f);
			}
			else if (!entityWithEntityID.hasEntityBuff)
			{
				output.Call(f);
			}
			else
			{
				for (int i = 0; i < entityWithEntityID.entityBuff.mBuffClassIDArray.Count; i++)
				{
					if (entityWithEntityID.entityBuff.mBuffClassIDArray[i] == buffClassVar.value)
					{
						buffID = entityWithEntityID.entityBuff.mBuffID[i];
						output.Call(f);
						break;
					}
				}
			}
		});
		AddValueOutput("持有者实体ID", "实体ID", () => entityIDVar.value);
		AddValueOutput("创建ID", "BuffID", () => buffID);
	}
}
