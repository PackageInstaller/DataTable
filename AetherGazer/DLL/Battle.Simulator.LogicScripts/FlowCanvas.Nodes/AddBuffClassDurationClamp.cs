using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改Buff存活时长(毫秒)(上下限)(逻辑)", 0)]
[Category("Logic/Buff/通用")]
[Description("修改实体身上持有的指定类型的BUFF/DEBUFF的持续时长")]
public class AddBuffClassDurationClamp : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out");
		FlowOutput abnormalOut = AddFlowOutput("Error", "无效EntityID");
		ValueInput<int> entityIDVar = AddValueInput<int>("实体ID", "entityIDVar");
		ValueInput<int> buffClassVar = AddValueInput<int>("类型(处理逻辑)ID", "buffClassVar");
		ValueInput<int> addTimeVar = AddValueInput<int>("增量(毫秒)", "buffDurationVar");
		ValueInput<int> minVar = AddValueInput<int>("最小值(毫秒)", "min").SetDefaultAndSerializedValue(int.MinValue);
		ValueInput<int> maxVar = AddValueInput<int>("最大值(毫秒)", "max").SetDefaultAndSerializedValue(int.MaxValue);
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
						int a = entityWithEntityID.entityBuff.mDuringArray[i] + addTimeVar.value;
						entityWithEntityID.entityBuff.mDuringArray[i] = IntMath.Clamp(a, minVar.value, maxVar.value);
					}
				}
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "EntityID", () => entityIDVar.GetValue());
	}
}
