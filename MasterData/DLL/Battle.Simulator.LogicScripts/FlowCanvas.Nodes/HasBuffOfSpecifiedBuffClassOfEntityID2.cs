using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("指定类型BUFF是否存在(指定释放者\\枚举)", 0)]
[Category("Logic/Buff/通用")]
[Description("检查EntityID对应的实体身上是否存在有指定释放者释放的指定类型的buff数据")]
public class HasBuffOfSpecifiedBuffClassOfEntityID2 : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput trueOutput = AddFlowOutput("存在");
		FlowOutput falseOutput = AddFlowOutput("不存在");
		FlowOutput abnormalOut = AddFlowOutput("无效实体ID");
		ValueInput<int> entityIDVar = AddValueInput<int>("检查实体ID", "HasBuffOfSpecifiedBuffClassOfEntityID2_entityIDVar");
		ValueInput<int> casterEntityIDVar = AddValueInput<int>("释放者实体ID", "HasBuffOfSpecifiedBuffClassOfEntityID2_casterEntityIDVar");
		ValueInput<BuffClass> buffClassVar = AddValueInput<BuffClass>("BUFF类型", "HasBuffOfSpecifiedBuffClassOfEntityID2_buffClassVar");
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
				int value = (int)buffClassVar.value;
				int value2 = casterEntityIDVar.GetValue();
				for (int i = 0; i < entityWithEntityID.entityBuff.mBuffClassIDArray.Count; i++)
				{
					if (!entityWithEntityID.entityBuff.IsInPendingRemoveArray(entityWithEntityID.entityBuff.mBuffID[i]) && entityWithEntityID.entityBuff.mBuffClassIDArray[i] == value && entityWithEntityID.entityBuff.mBuffCasterArray[i] == value2)
					{
						trueOutput.Call(f);
						return;
					}
				}
				falseOutput.Call(f);
			}
		});
		AddValueOutput("检查实体ID", () => entityIDVar.value, "getCheckEntityID");
		AddValueOutput("释放者实体ID", "casterID", () => casterEntityIDVar.GetValue());
	}
}
