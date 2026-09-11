using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("指定类型BUFF是否存在(待改名)", 0)]
[Category("Logic/Buff/通用")]
[Description("检查EntityID对应的实体身上是否存在指定类型的buff数据\n新名称:是否有Buff(类型(处理逻辑)ID)(逻辑)")]
public class HasBuffOfSpecifiedBuffClass : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput trueOutput = AddFlowOutput("存在");
		FlowOutput falseOutput = AddFlowOutput("不存在");
		FlowOutput abnormalOut = AddFlowOutput("Error", "无效实体ID");
		ValueInput<int> entityIDVar = AddValueInput<int>("持有者实体ID", "实体ID");
		ValueInput<int> buffClassVar = AddValueInput<int>("类型(处理逻辑)ID", "BUFF类型ID");
		int casterID = 0;
		int buffIndex = 0;
		AddValueOutput("释放者实体ID", "添加者ID", () => casterID);
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDVar.GetValue());
			if (entityWithEntityID == null)
			{
				abnormalOut.Call(f);
			}
			else if (!entityWithEntityID.hasEntityBuff)
			{
				falseOutput.Call(f);
			}
			else
			{
				int value = buffClassVar.value;
				for (int i = 0; i < entityWithEntityID.entityBuff.mBuffClassIDArray.Count; i++)
				{
					if (!entityWithEntityID.entityBuff.IsInPendingRemoveArray(entityWithEntityID.entityBuff.mBuffID[i]) && entityWithEntityID.entityBuff.mBuffClassIDArray[i] == value)
					{
						casterID = entityWithEntityID.entityBuff.mBuffCasterArray[i];
						buffIndex = i;
						trueOutput.Call(f);
						return;
					}
				}
				falseOutput.Call(f);
			}
		});
		AddValueOutput("持有者实体ID", "实体ID", () => entityIDVar.value);
		AddValueOutput("数组下标", "buffListIndex", () => buffIndex);
	}
}
