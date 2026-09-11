using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("按时长判断能否添加buff", 0)]
[Category("Logic/Buff")]
[Description("按时长判断能否添加buff, 根据传入的buff数组下标或者配置ID去拿时间，和buff类型下的第一个buff的剩余时长进行比较，如果比剩余的时间长走“可覆盖”，反之“不可覆盖”, 如果时间更长的话,会直接调移除时间短的那个")]
public class CanBuffAddedByTime : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		int entityID = 0;
		AddValueOutput("实体ID", () => entityID);
		FlowOutput trueOut = AddFlowOutput("True");
		FlowOutput falseOut = AddFlowOutput("False");
		FlowOutput errorOut = AddFlowOutput("异常");
		ValueInput<int> indexInput = AddValueInput<int>("buff数组下标");
		AddFlowInput("", delegate(Flow f)
		{
			entityID = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBuff)
			{
				errorOut.Call(f);
			}
			else
			{
				int value = indexInput.value;
				int num = entityWithEntityID.entityBuff.mBuffClassIDArray[value];
				int num2 = entityWithEntityID.entityBuff.mDuringArray[value];
				int num3 = -1;
				for (int i = 0; i < entityWithEntityID.entityBuff.mBuffClassIDArray.Count; i++)
				{
					if (i != value && num == entityWithEntityID.entityBuff.mBuffClassIDArray[i] && !entityWithEntityID.entityBuff.IsInPendingRemoveArray(entityWithEntityID.entityBuff.mBuffID[i]))
					{
						num3 = i;
						break;
					}
				}
				if (num3 == -1)
				{
					trueOut.Call(f);
				}
				else if (entityWithEntityID.entityBuff.mDuringArray[num3] >= num2)
				{
					BuffProcessor.RemoveBuffID(entityID, entityID, entityWithEntityID.entityBuff.mBuffID[value]);
					falseOut.Call(f);
				}
				else
				{
					BuffProcessor.RemoveBuffID(entityID, entityID, entityWithEntityID.entityBuff.mBuffID[num3]);
					trueOut.Call(f);
				}
			}
		});
	}
}
