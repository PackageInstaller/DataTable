using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[统合]获取技能机制值消耗量(逻辑)", 0)]
[Category("Logic/统合")]
[Description("得到指定技能的机制值消耗量\n当前消耗量为即时计算，受一切加成影响\n\n值：得到的值。正数为增加，负数为消耗\nError：实体不存在，或对应表找不到条目时")]
public class GetAbilityConsumeTogether : FlowNode
{
	protected override void RegisterPorts()
	{
		int abilityID = 0;
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> abilityIDInput = AddValueInput<int>("技能ID", "abilityID");
		ValueInput<ValueModeX_ABILITY_ENGY> valueModeX = AddValueInput<ValueModeX_ABILITY_ENGY>("模式X", "valueModeX").SetDefaultAndSerializedValue(ValueModeX_ABILITY_ENGY.CurrentValue);
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		int value = 0;
		AddValueOutput("值", "value", () => value);
		int entityID;
		AddFlowInput("In", "in", delegate(Flow f)
		{
			entityID = entityIDInput.value;
			abilityID = abilityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
			if (entityWithEntityID == null)
			{
				error.Call(f);
			}
			else
			{
				switch (valueModeX.value)
				{
				case ValueModeX_ABILITY_ENGY.CurrentValue:
				{
					if (!AttributeProcessor.TryGetEnergyChangeValue(entityWithEntityID, abilityID, out var energyChangeValue, out var _))
					{
						error.Call(f);
					}
					else
					{
						value = energyChangeValue;
						output.Call(f);
					}
					break;
				}
				case ValueModeX_ABILITY_ENGY.ConfigValue:
				{
					if (!ConfigProcessor.TryGetSkillConsumeConfig(entityWithEntityID, abilityID, out var energyChange))
					{
						value = 0;
						error.Call(f);
					}
					else
					{
						value = energyChange;
						output.Call(f);
					}
					break;
				}
				default:
					value = 0;
					error.Call(f);
					break;
				}
			}
		});
	}
}
