using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[统合]获取奥义能量(逻辑)", 0)]
[Category("Logic/统合")]
[Description("得到奥义能量\n当前奥义能量：当前值\n奥义能量最大值：当前奥义能量最大值，一般不允许修改\n当前奥义每跳增量：受buff12（属性1101）和210影响\n奥义配置每跳增量：不受影响\n奥义配置额外增量：不受影响\nError：当实体不存在，没有奥义组件，或UniqueSkill表有误时")]
public class GetUniqueSkillEnergyTogether : FlowNode
{
	protected override void RegisterPorts()
	{
		int result = 0;
		int entityID = 0;
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<ValueModeX_USKILL_ENGY> valueModeX = AddValueInput<ValueModeX_USKILL_ENGY>("模式X", "valueModeX").SetDefaultAndSerializedValue(ValueModeX_USKILL_ENGY.CurrentValue);
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		AddValueOutput("值", "value", () => result);
		AddFlowInput("In", "in", delegate(Flow f)
		{
			result = 0;
			entityID = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityUniqueSkillEnergy || !ConfigHelper.GetInstance().TryGetConfig<UniqueSkill>(entityWithEntityID.ENTITY_CONFIG_ID, out var _))
			{
				error.Call(f);
			}
			else
			{
				switch (valueModeX.value)
				{
				case ValueModeX_USKILL_ENGY.CurrentValue:
					result = entityWithEntityID.entityUniqueSkillEnergy.mValue;
					if (result < 0)
					{
						result = 0;
					}
					if (result > entityWithEntityID.entityUniqueSkillEnergy.mMaxValue)
					{
						result = entityWithEntityID.entityUniqueSkillEnergy.mMaxValue;
					}
					break;
				case ValueModeX_USKILL_ENGY.MaxValue:
					result = entityWithEntityID.entityUniqueSkillEnergy.mMaxValue;
					break;
				case ValueModeX_USKILL_ENGY.CurrentRecoverValue:
					result = entityWithEntityID.entityUniqueSkillEnergy.mAddValue;
					break;
				case ValueModeX_USKILL_ENGY.ConfigRecoverValue:
					result = ConfigHelper.GetInstance().GetConfig<UniqueSkill>(entityWithEntityID.ENTITY_CONFIG_ID).BaseAddValue;
					break;
				case ValueModeX_USKILL_ENGY.ConfigAdditionalValue:
					result = ConfigHelper.GetInstance().GetConfig<UniqueSkill>(entityWithEntityID.ENTITY_CONFIG_ID).AdditionalValue;
					break;
				default:
					result = 0;
					error.Call(f);
					return;
				}
				output.Call(f);
			}
		});
	}
}
