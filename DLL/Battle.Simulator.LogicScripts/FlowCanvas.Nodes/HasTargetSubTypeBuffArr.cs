using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否有Buff(子类型)(任一)(逻辑)", 0)]
[Category("Logic/Buff/通用")]
[Description("只要实体身上是否有传入组中任意一个buff子类型就走true,都没有走false")]
public class HasTargetSubTypeBuffArr : FlowNode
{
	private HashSet<string> subTypeHashSet = new HashSet<string>();

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "实体ID");
		ValueInput<List<string>> subTypeIDArrInput = AddValueInput<List<string>>("子类型组", "buffConfigSubTypeArr");
		AddValueOutput("实体ID", "实体ID", () => entityIDInput.value);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null)
			{
				if (entityWithEntityID.hasEntityBuff)
				{
					subTypeHashSet.Clear();
					List<string> value = subTypeIDArrInput.value;
					for (int i = 0; i < value.Count; i++)
					{
						subTypeHashSet.Add(value[i]);
					}
					for (int j = 0; j < entityWithEntityID.entityBuff.mBuffConfigID.Count; j++)
					{
						int num = entityWithEntityID.entityBuff.mBuffConfigID[j];
						if (num != 0)
						{
							public_buff config = ConfigHelper.GetInstance().GetConfig<public_buff>(num);
							if (!entityWithEntityID.entityBuff.IsInPendingRemoveArray(entityWithEntityID.entityBuff.mBuffID[j]) && BuffSubTypeComparer.ContainsAny(subTypeHashSet, config.SubType))
							{
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
