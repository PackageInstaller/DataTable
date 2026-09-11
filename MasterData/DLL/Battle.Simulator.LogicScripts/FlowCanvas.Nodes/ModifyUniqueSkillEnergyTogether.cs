using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[统合]修改奥义能量(逻辑)", 0)]
[Category("Logic/统合")]
[Description("使用ax+b模式修改当前奥义能量，注意结果会小于0或超出最大值\n当前奥义能量：当前值\n奥义能量最大值：当前奥义能量最大值，一般不允许修改\n当前奥义每跳增量：受buff12（属性1101）和210影响\n奥义配置每跳增量：不受影响\n奥义配置额外增量：不受影响，但可选是否走增量公式\n增量公式：选择额外增量时，决定是否接受buff12（属性1101）加成。当计算变更值小于0时，公式无效（没有针对扣奥义能量的减免公式）\nError：当实体不存在，没有奥义组件，或UniqueSkill表有误时")]
public class ModifyUniqueSkillEnergyTogether : FlowNode
{
	protected override void RegisterPorts()
	{
		int X = 0;
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> permillageA = AddValueInput<int>("千分比倍率A", "permillageA").SetDefaultAndSerializedValue(1000);
		ValueInput<int> fixedValueB = AddValueInput<int>("固定值B", "fixedValueB");
		ValueInput<bool> isUseFormula = AddValueInput<bool>("增量公式", "isUseFormula").SetDefaultAndSerializedValue(v: true);
		ValueInput<ValueModeX_USKILL_ENGY> valueModeX = AddValueInput<ValueModeX_USKILL_ENGY>("模式X", "valueModeX").SetDefaultAndSerializedValue(ValueModeX_USKILL_ENGY.CurrentValue);
		ValueInput<CalStyle> calWay = AddValueInput<CalStyle>("运算", "calWay").SetDefaultAndSerializedValue(CalStyle.Set);
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		int entityID;
		int result;
		int A;
		int B;
		AddFlowInput("In", "in", delegate(Flow f)
		{
			entityID = entityIDInput.value;
			result = 0;
			A = permillageA.value;
			B = fixedValueB.value;
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
					X = entityWithEntityID.entityUniqueSkillEnergy.mValue;
					break;
				case ValueModeX_USKILL_ENGY.MaxValue:
					X = entityWithEntityID.entityUniqueSkillEnergy.mMaxValue;
					break;
				case ValueModeX_USKILL_ENGY.CurrentRecoverValue:
					X = entityWithEntityID.entityUniqueSkillEnergy.mAddValue;
					break;
				case ValueModeX_USKILL_ENGY.ConfigRecoverValue:
					X = ConfigHelper.GetInstance().GetConfig<UniqueSkill>(entityWithEntityID.ENTITY_CONFIG_ID).BaseAddValue;
					break;
				case ValueModeX_USKILL_ENGY.ConfigAdditionalValue:
					X = ConfigHelper.GetInstance().GetConfig<UniqueSkill>(entityWithEntityID.ENTITY_CONFIG_ID).AdditionalValue;
					break;
				default:
					error.Call(f);
					return;
				}
				if (isUseFormula.value && valueModeX.value == ValueModeX_USKILL_ENGY.ConfigAdditionalValue)
				{
					switch (calWay.value)
					{
					case CalStyle.Set:
						result = A * X / 1000 + B - entityWithEntityID.entityUniqueSkillEnergy.mValue;
						break;
					case CalStyle.Add:
						result = A * X / 1000 + B;
						break;
					default:
						error.Call(f);
						return;
					}
					if (result > 0)
					{
						result = CalcUniqueSkillEnergyAddtionalValueWithAttribute.CalcNewAddValue(entityWithEntityID.entityBlackboard.var.mAttributeID, result);
					}
					if (entityWithEntityID.entityUniqueSkillEnergy.mState == EntityActionStatus.E_SUCCESS && result < 0)
					{
						entityWithEntityID.entityUniqueSkillEnergy.mState = EntityActionStatus.E_ACTIVE;
						entityWithEntityID.entityUniqueSkillEnergy.mRuntime = entityWithEntityID.entityUniqueSkillEnergy.mTick;
					}
					entityWithEntityID.entityUniqueSkillEnergy.mValue += result;
					if (base.mSimContext.GetSimInterface().mUniqueSkillEnergyAdditionalValueEvent != null)
					{
						base.mSimContext.GetSimInterface().mUniqueSkillEnergyAdditionalValueEvent(entityID, result);
					}
					output.Call(f);
				}
				else
				{
					result = A * X / 1000 + B - entityWithEntityID.entityUniqueSkillEnergy.mValue;
					if (calWay.value == CalStyle.Add)
					{
						result += entityWithEntityID.entityUniqueSkillEnergy.mValue;
					}
					if (entityWithEntityID.entityUniqueSkillEnergy.mState == EntityActionStatus.E_SUCCESS && result < 0)
					{
						entityWithEntityID.entityUniqueSkillEnergy.mState = EntityActionStatus.E_ACTIVE;
						entityWithEntityID.entityUniqueSkillEnergy.mRuntime = entityWithEntityID.entityUniqueSkillEnergy.mTick;
					}
					entityWithEntityID.entityUniqueSkillEnergy.mValue += result;
					if (base.mSimContext.GetSimInterface().mUniqueSkillEnergyAdditionalValueEvent != null && valueModeX.value == ValueModeX_USKILL_ENGY.ConfigAdditionalValue)
					{
						base.mSimContext.GetSimInterface().mUniqueSkillEnergyAdditionalValueEvent(entityID, result);
					}
					output.Call(f);
				}
			}
		});
	}
}
