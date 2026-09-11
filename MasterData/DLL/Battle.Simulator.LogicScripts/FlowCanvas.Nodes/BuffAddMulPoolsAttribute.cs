using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("buff加连乘属性", 0)]
[Category("Logic/Buff")]
[Description("buff加连乘属性,(1 + x1)(1 + x2)... \n第一个是属性id, 第二个是属性值, 一般是buff数值里面来\nbuff参数1是额外提升比例\n会把结果存在参数4上\n把属性id存在参数3上面\n然后生效时把所有相同的算一遍\n")]
public class BuffAddMulPoolsAttribute : FlowNode
{
	public static void CalcMulPoolsAttribute(SimEntity simEntity, int buffIndex, int attributeID, bool includeSelf)
	{
		int num = simEntity.entityBuff.mBuffClassIDArray[buffIndex];
		int num2 = 1000;
		for (int i = 0; i < simEntity.entityBuff.mBuffClassIDArray.Count; i++)
		{
			if (!simEntity.entityBuff.IsInPendingRemoveArray(simEntity.entityBuff.mBuffID[i]) && (i != buffIndex || includeSelf) && simEntity.entityBuff.mBuffClassIDArray[i] == num)
			{
				int num3 = int.MinValue;
				num3 = simEntity.entityBuff.mBuffParamsArray[i].v4;
				if (simEntity.entityBuff.mBuffParamsArray[i].v3 == attributeID)
				{
					num2 *= 1000 + num3;
					num2 /= 1000;
				}
			}
		}
		int num4 = num2 - 1000;
		int attributeIDByEntityID = AttributeProcessor.GetAttributeIDByEntityID(simEntity.creationIndex);
		AttributeProcessor.GetAttributeWithIntName(attributeIDByEntityID, attributeID, out var baseValue, out var _, out var tempPlusValue);
		AttributeProcessor.SetAttributeWithIntName(attributeIDByEntityID, attributeID, baseValue, num4, tempPlusValue);
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		int entityID = 0;
		AddValueOutput("实体ID", () => entityID);
		ValueInput<int> attributeIDInput = AddValueInput<int>("属性ID");
		ValueInput<int> attributeValueInput = AddValueInput<int>("属性值");
		ValueInput<int> buffIndexInput = AddValueInput<int>("buff数组下标");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("生效时调用", delegate(Flow f)
		{
			entityID = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBuff || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else
			{
				int value = buffIndexInput.value;
				int value2 = attributeIDInput.value;
				int value3 = attributeValueInput.value;
				BuffParams value4 = entityWithEntityID.entityBuff.mBuffParamsArray[value];
				value4.v3 = value2;
				value4.v4 = value3;
				entityWithEntityID.entityBuff.mBuffParamsArray[value] = value4;
				CalcMulPoolsAttribute(entityWithEntityID, value, value2, includeSelf: true);
				output.Call(f);
			}
		});
		AddFlowInput("移除时调用", delegate(Flow f)
		{
			entityID = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBuff || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else
			{
				CalcMulPoolsAttribute(entityWithEntityID, buffIndexInput.value, attributeIDInput.value, includeSelf: false);
				output.Call(f);
			}
		});
	}
}
