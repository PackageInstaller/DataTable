using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[统合]获取闪避耐力(逻辑)", 0)]
[Category("Logic/统合")]
[Description("得到闪避耐力\n当前闪避耐力：当前闪避耐力值\n闪避耐力最大值：一般不会改动\n当前闪避消耗值：一次闪避消耗的耐力，会被多种buff影响\n配置闪避消耗值：不受战斗影响Error：当实体不存在，没有闪避组件，或charactor_param表有误时")]
public class GetAvoidEnduranceTogether : FlowNode
{
	protected override void RegisterPorts()
	{
		int entityID = 0;
		int result = 0;
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<ValueModeX_AVOID_ENGY> valueModeX = AddValueInput<ValueModeX_AVOID_ENGY>("模式X", "valueModeX").SetDefaultAndSerializedValue(ValueModeX_AVOID_ENGY.CurrentValue);
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		AddValueOutput("值", "value", () => result);
		AddFlowInput("In", "in", delegate(Flow f)
		{
			entityID = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
			if (entityWithEntityID == null || entityWithEntityID.entityEndurance == null || !ConfigHelper.GetInstance().TryGetConfig<charactor_param>(entityWithEntityID.ENTITY_CONFIG_ID, out var _))
			{
				error.Call(f);
			}
			else
			{
				switch (valueModeX.value)
				{
				case ValueModeX_AVOID_ENGY.CurrentValue:
					result = (int)(long)entityWithEntityID.entityEndurance.currentValue;
					break;
				case ValueModeX_AVOID_ENGY.MaxValue:
					result = (int)(long)entityWithEntityID.entityEndurance.maxValue;
					break;
				case ValueModeX_AVOID_ENGY.CurrentConsumeValue:
					result = (int)(long)entityWithEntityID.entityEndurance.consumeValue;
					break;
				case ValueModeX_AVOID_ENGY.ConfigConsumeValue:
					result = ConfigHelper.GetInstance().GetConfig<charactor_param>(entityWithEntityID.ENTITY_CONFIG_ID).ConsumeEnduranceValue * 1000;
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
