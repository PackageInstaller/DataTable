using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否有Buff(子类型)(逻辑)", 0)]
[Category("Logic/Buff/通用")]
[Description("buff子类型是否存在(取出buff列表中第一个符合条件的Buff)")]
public class HasTargetSubTypeBuff : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "实体ID");
		ValueInput<string> subTypeIDInput = AddValueInput<string>("子类型", "Buff子类型");
		AddValueOutput("实体ID", "实体ID", () => entityIDInput.value);
		int index = 0;
		AddValueOutput("数组下标", "index", () => index);
		int buffConfigID = 0;
		AddValueOutput("配置ID", "configID", () => buffConfigID);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null)
			{
				if (entityWithEntityID.hasEntityBuff)
				{
					for (int i = 0; i < entityWithEntityID.entityBuff.mBuffConfigID.Count; i++)
					{
						int num = entityWithEntityID.entityBuff.mBuffConfigID[i];
						if (num != 0)
						{
							public_buff config = ConfigHelper.GetInstance().GetConfig<public_buff>(num);
							if (!entityWithEntityID.entityBuff.IsInPendingRemoveArray(entityWithEntityID.entityBuff.mBuffID[i]) && BuffSubTypeComparer.ContainsAny(subTypeIDInput.value, config.SubType) && !entityWithEntityID.entityBuff.IsInPendingRemoveArray(entityWithEntityID.entityBuff.mBuffID[i]))
							{
								index = i;
								buffConfigID = num;
								trueOut.Call(f);
								return;
							}
						}
					}
				}
				falseOut.Call(f);
			}
		});
	}
}
