using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("遍历处理所有Buff(子类型)", 0)]
[Category("Logic/Buff/通用")]
[Color("FFA500")]
[Description("buff子类型是否存在(输出buff列表中所有符合条件的Buff)\n<color=red>高消耗节点\n该节点同时涉及遍历、查表、字符串匹配操作，尽量不要频繁调用</color>")]
public class GetTargetSubTypeBuffOfAll : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "实体ID");
		ValueInput<string> subTypeIDInput = AddValueInput<string>("子类型", "Buff子类型");
		AddValueOutput("实体ID", "实体ID", () => entityIDInput.value);
		int casterID = 0;
		AddValueOutput("释放者实体ID", "释放者ID", () => casterID);
		int index = 0;
		AddValueOutput("数组下标", "index", () => index);
		int buffID = 0;
		AddValueOutput("buffID", "buffID", () => buffID);
		int buffConfigID = 0;
		AddValueOutput("配置ID", "configID", () => buffConfigID);
		FlowOutput doOut = AddFlowOutput("Do");
		FlowOutput doneOut = AddFlowOutput("Done");
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
								casterID = entityWithEntityID.entityBuff.mBuffCasterArray[i];
								buffID = entityWithEntityID.entityBuff.mBuffID[i];
								doOut.Call(f);
							}
						}
					}
				}
				doneOut.Call(f);
			}
		});
	}
}
