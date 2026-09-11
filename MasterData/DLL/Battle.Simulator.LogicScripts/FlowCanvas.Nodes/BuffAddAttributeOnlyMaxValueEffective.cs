using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("buff加属性(只生效数值最大的一个)", 0)]
[Category("Logic/Buff")]
[Description("buff加属性(只生效数值最大的一个), \nbuff 数值有两个, 第一个是属性id, 第二个是属性值\nbuff参数1是额外提升比例\n会把 数值1 + 数值1 * 额外比例 / 1000 的结果存在参数4上\n把属性id存在参数3上面\n然后只生效参数4最大的一个buff\n")]
public class BuffAddAttributeOnlyMaxValueEffective : FlowNode
{
	public static int GetBuffValue(int buffConfigID, int buffLevel, SimVar factor)
	{
		public_buff config = ConfigHelper.GetInstance().GetConfig<public_buff>(buffConfigID);
		config.BuffparamBase.get_Item(0);
		config.BuffparamFactor.get_Item(0);
		int num = config.BuffparamBase.get_Item(1) + (buffLevel - 1) * config.BuffparamFactor.get_Item(1);
		return num + (int)((long)factor.intVar * (long)num / 1000);
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		int entityID = 0;
		AddValueOutput("实体ID", () => entityID);
		ValueInput<int> buffConfigIDInput = AddValueInput<int>("buff配置ID");
		ValueInput<int> buffLevelInput = AddValueInput<int>("buff等级");
		ValueInput<SimVar> factorInput = AddValueInput<SimVar>("额外提升比例");
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
				int value = buffConfigIDInput.value;
				int value2 = buffLevelInput.value;
				public_buff config = ConfigHelper.GetInstance().GetConfig<public_buff>(value);
				int num = config.BuffparamBase.get_Item(0) + (value2 - 1) * config.BuffparamFactor.get_Item(0);
				int num2 = config.BuffparamBase.get_Item(1) + (value2 - 1) * config.BuffparamFactor.get_Item(1);
				num2 += (int)((long)factorInput.value.intVar * (long)num2 / 1000);
				int value3 = buffIndexInput.value;
				BuffParams value4 = entityWithEntityID.entityBuff.mBuffParamsArray[value3];
				value4.v4 = num2;
				value4.v3 = num;
				entityWithEntityID.entityBuff.mBuffParamsArray[value3] = value4;
				int num3 = entityWithEntityID.entityBuff.mBuffClassIDArray[value3];
				SimVar simVar = int.MinValue;
				int num4 = -1;
				for (int i = 0; i < entityWithEntityID.entityBuff.mBuffClassIDArray.Count; i++)
				{
					if (!entityWithEntityID.entityBuff.IsInPendingRemoveArray(entityWithEntityID.entityBuff.mBuffID[i]) && i != value3 && entityWithEntityID.entityBuff.mBuffClassIDArray[i] == num3)
					{
						int num5 = int.MinValue;
						num5 = entityWithEntityID.entityBuff.mBuffParamsArray[i].v4;
						if (num5 > (int)simVar && entityWithEntityID.entityBuff.mBuffParamsArray[i].v3 == num)
						{
							simVar = num5;
							_ = entityWithEntityID.entityBuff.mBuffID[i];
							num4 = i;
						}
					}
				}
				AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, num, out var baseValue, out var plusValue, out var tempPlusValue);
				if (num4 == -1)
				{
					plusValue += num2;
				}
				else if (num2 > (int)simVar)
				{
					plusValue -= (long)simVar;
					plusValue += num2;
				}
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, num, baseValue, plusValue, tempPlusValue);
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
				int value = buffIndexInput.value;
				int num = entityWithEntityID.entityBuff.mBuffClassIDArray[value];
				int num2 = entityWithEntityID.entityBuff.mBuffParamsArray[value].v3;
				int num3 = entityWithEntityID.entityBuff.mBuffParamsArray[value].v4;
				SimVar simVar = int.MinValue;
				int num4 = -1;
				for (int i = 0; i < entityWithEntityID.entityBuff.mBuffClassIDArray.Count; i++)
				{
					if (!entityWithEntityID.entityBuff.IsInPendingRemoveArray(entityWithEntityID.entityBuff.mBuffID[i]) && i != value && entityWithEntityID.entityBuff.mBuffClassIDArray[i] == num)
					{
						int num5 = int.MinValue;
						num5 = entityWithEntityID.entityBuff.mBuffParamsArray[i].v4;
						if (num5 > (int)simVar && entityWithEntityID.entityBuff.mBuffParamsArray[i].v3 == num2)
						{
							simVar = num5;
							_ = entityWithEntityID.entityBuff.mBuffID[i];
							num4 = i;
						}
					}
				}
				AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, num2, out var baseValue, out var plusValue, out var tempPlusValue);
				if (num4 == -1)
				{
					plusValue -= num3;
				}
				else if (num3 > (int)simVar)
				{
					plusValue -= num3;
					plusValue += (long)simVar;
				}
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, num2, baseValue, plusValue, tempPlusValue);
				output.Call(f);
			}
		});
	}
}
