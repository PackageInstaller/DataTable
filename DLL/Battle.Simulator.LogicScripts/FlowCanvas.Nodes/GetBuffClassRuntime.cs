using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到Buff剩余时长(逻辑)", 0)]
[Category("Logic/Buff/通用")]
[Description("得到实体身上指定类型BUFF的剩余调用时长,由于一个类型的buff可能有多个,故而需要用list来存放")]
public class GetBuffClassRuntime : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out");
		FlowOutput abnormalOut = AddFlowOutput("Error", "无效EntityID");
		ValueInput<int> entityIDVar = AddValueInput<int>("实体ID", "实体ID");
		ValueInput<int> buffClassVar = AddValueInput<int>("类型(处理逻辑)ID", "BUFF类型ID");
		ValueInput<List<int>> cdsVar = AddValueInput<List<int>>("存放cd数组");
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
						cdsVar.value.Add(entityWithEntityID.entityBuff.mBuffRuntime[i]);
					}
				}
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "实体ID", () => entityIDVar.value);
		AddValueOutput("存放cd数组", () => cdsVar.value);
	}
}
