using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[统合]修改机制值(逻辑)", 0)]
[Category("Logic/统合")]
[Description("以ax+b模式修改当前机制值，新值=公式(更改量)+旧值，更改量=ax+b-旧值。由输入值决定更改的行为\n\n发出事件：勾选后，会在变更结束后发出事件\n走公式：勾选后，更改量会进入公式计算。否则最终值会直接设置为ax+b的值\n\n当前机制值：实体当前拥有的机制值数量\n当前机制值最大值：实体当前的最大机制值，受战斗影响\n配置最大机制值：表中配的机制值最大值，不受战斗影响\n\nError：当实体不存在，或charactor_param表有问题时")]
public class ModifyEnergyTogether : FlowNode
{
	private bool CalResult(int entityID, SimEntity entity, bool isSendEvent, bool isUseFormula, int result)
	{
		ConfigHelper.GetInstance().TryGetConfig<charactor_param>(entity.ENTITY_CONFIG_ID, out var config);
		if (config.EnergyType == 0)
		{
			return true;
		}
		AttributeProcessor.TryGetEnergyMaxValue(entity, out var maxValue);
		result *= 1000;
		if (isUseFormula)
		{
			if (result < 0)
			{
				if (config.EnergyType == 3)
				{
					long finalAttributeByAttributeID = AttributeProcessor.GetFinalAttributeByAttributeID(entity.entityBlackboard.var.mAttributeID, 1108, AttributeCalcType.Add);
					if (DRandom.Random(1000u) < finalAttributeByAttributeID)
					{
						result++;
					}
				}
				AttributeProcessor.CalcConsumeByAttribute(result, entity.entityBlackboard.var.mAttributeID, (EnergyType)config.EnergyType, out var energyChangeValue, out var _);
				bool result2 = AttributeProcessor.TryAddPowerValue(entity, energyChangeValue, out var newValue, out var oldValue);
				if (isSendEvent && base.mSimContext.GetSimInterface().mOnPowerUpdate != null)
				{
					base.mSimContext.GetSimInterface().mOnPowerUpdate(entityID, newValue, oldValue, maxValue, maxValue, (EnergyType)config.EnergyType);
				}
				return result2;
			}
			if (result > 0)
			{
				AttributeProcessor.CalcConsumeByAttribute(result, entity.entityBlackboard.var.mAttributeID, (EnergyType)config.EnergyType, out var energyChangeValue2, out var fractionalPart2);
				if (config.EnergyType == 3)
				{
					long finalAttributeByAttributeID2 = AttributeProcessor.GetFinalAttributeByAttributeID(entity.entityBlackboard.var.mAttributeID, 1108, AttributeCalcType.Add);
					if (DRandom.Random(1000u) < finalAttributeByAttributeID2)
					{
						energyChangeValue2--;
					}
				}
				bool result3 = AttributeProcessor.TryAddPowerValue(entity, energyChangeValue2 + fractionalPart2, out var newValue2, out var oldValue2);
				if (isSendEvent && base.mSimContext.GetSimInterface().mOnPowerUpdate != null)
				{
					base.mSimContext.GetSimInterface().mOnPowerUpdate(entityID, newValue2, oldValue2, maxValue, maxValue, (EnergyType)config.EnergyType);
				}
				return result3;
			}
			if (result == 0)
			{
				AttributeProcessor.GetAttributeWithIntName(entity.entityBlackboard.var.mAttributeID, 2017, out var baseValue, out var _, out var _);
				if (isSendEvent && base.mSimContext.GetSimInterface().mOnPowerUpdate != null)
				{
					base.mSimContext.GetSimInterface().mOnPowerUpdate(entityID, (int)baseValue, (int)baseValue, maxValue, maxValue, (EnergyType)config.EnergyType);
				}
				return true;
			}
			return false;
		}
		bool result4 = AttributeProcessor.TryAddPowerValue(entity, result, out var newValue3, out var oldValue3);
		if (isSendEvent && base.mSimContext.GetSimInterface().mOnPowerUpdate != null)
		{
			base.mSimContext.GetSimInterface().mOnPowerUpdate(entityID, newValue3, oldValue3, maxValue, maxValue, (EnergyType)config.EnergyType);
		}
		return result4;
	}

	protected override void RegisterPorts()
	{
		int X = 0;
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> permillageA = AddValueInput<int>("千分比倍率A", "permillageA").SetDefaultAndSerializedValue(1000);
		ValueInput<int> fixedValueB = AddValueInput<int>("固定值B", "fixedValueB");
		ValueInput<bool> isSendEvent = AddValueInput<bool>("发出事件", "isSendEvent").SetDefaultAndSerializedValue(v: true);
		ValueInput<bool> isUseFormula = AddValueInput<bool>("走公式", "isUseFormula").SetDefaultAndSerializedValue(v: true);
		ValueInput<ValueModeX_ENERGY> valueModeX = AddValueInput<ValueModeX_ENERGY>("模式X", "valueModeX").SetDefaultAndSerializedValue(ValueModeX_ENERGY.CurrentValue);
		ValueInput<CalStyle> calWay = AddValueInput<CalStyle>("运算", "calWay").SetDefaultAndSerializedValue(CalStyle.Set);
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		int result;
		int entityID;
		int A;
		int B;
		AddFlowInput("In", "in", delegate(Flow f)
		{
			result = 0;
			entityID = 0;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				error.Call(f);
			}
			else
			{
				entityID = entityIDInput.value;
				A = permillageA.value;
				B = fixedValueB.value;
				switch (valueModeX.value)
				{
				case ValueModeX_ENERGY.CurrentValue:
					X = AttributeProcessor.GetPowerValue(entityID);
					break;
				case ValueModeX_ENERGY.MaxValue:
				{
					if (!AttributeProcessor.TryGetEnergyMaxValue(entityWithEntityID, out var maxValue))
					{
						X = 0;
					}
					else
					{
						X = maxValue;
					}
					break;
				}
				case ValueModeX_ENERGY.ConfigMaxValue:
				{
					if (!ConfigHelper.GetInstance().TryGetConfig<charactor_param>(entityWithEntityID.ENTITY_CONFIG_ID, out var config))
					{
						error.Call(f);
						return;
					}
					X = config.EnergyMaxValue;
					break;
				}
				default:
					error.Call(f);
					return;
				}
				switch (calWay.value)
				{
				case CalStyle.Set:
					result = A * X / 1000 + B - AttributeProcessor.GetPowerValue(entityID);
					if (!CalResult(entityID, entityWithEntityID, isSendEvent.value, isUseFormula.value, result))
					{
						error.Call(f);
					}
					else
					{
						output.Call(f);
					}
					break;
				case CalStyle.Add:
					result = A * X / 1000 + B;
					if (!CalResult(entityID, entityWithEntityID, isSendEvent.value, isUseFormula.value, result))
					{
						error.Call(f);
					}
					else
					{
						output.Call(f);
					}
					break;
				default:
					error.Call(f);
					break;
				}
			}
		});
	}
}
