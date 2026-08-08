using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[统合]获取机制值(逻辑)", 0)]
[Category("Logic/统合")]
[Description("得到实体指定的机制值\n当前机制值：实体当前拥有的机制值数量\n当前机制值最大值：实体当前的最大机制值，受战斗影响\n配置最大机制值：表中配的机制值最大值，不受战斗影响\n\nError：当实体不存在，或charactor_param表有问题时")]
public class GetEnergyTogether : FlowNode
{
	protected override void RegisterPorts()
	{
		int value = 0;
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<ValueModeX_ENERGY> valueModeX = AddValueInput<ValueModeX_ENERGY>("模式X", "valueModeX").SetDefaultAndSerializedValue(ValueModeX_ENERGY.CurrentValue);
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		AddValueOutput("值", "value", () => value);
		int entityID;
		AddFlowInput("In", "in", delegate(Flow f)
		{
			entityID = 0;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				error.Call(f);
			}
			else
			{
				entityID = entityIDInput.value;
				switch (valueModeX.value)
				{
				case ValueModeX_ENERGY.CurrentValue:
					value = AttributeProcessor.GetPowerValue(entityID);
					break;
				case ValueModeX_ENERGY.MaxValue:
				{
					if (!AttributeProcessor.TryGetEnergyMaxValue(entityWithEntityID, out var maxValue))
					{
						value = 0;
					}
					else
					{
						value = maxValue;
					}
					break;
				}
				case ValueModeX_ENERGY.ConfigMaxValue:
				{
					if (!ConfigHelper.GetInstance().TryGetConfig<charactor_param>(entityWithEntityID.ENTITY_CONFIG_ID, out var config))
					{
						value = 0;
						error.Call(f);
						return;
					}
					value = config.EnergyMaxValue;
					break;
				}
				default:
					value = 0;
					error.Call(f);
					return;
				}
				output.Call(f);
			}
		});
	}
}
