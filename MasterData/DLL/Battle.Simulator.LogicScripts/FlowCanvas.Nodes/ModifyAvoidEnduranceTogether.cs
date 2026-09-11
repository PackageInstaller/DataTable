using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[统合]修改闪避耐力(逻辑)", 0)]
[Category("Logic/统合")]
[Description("使用ax+b模式修改当前闪避耐力。耐力值均为千分数\n当前闪避耐力：当前闪避耐力值\n闪避耐力最大值：一般不会改动\n当前闪避消耗值：一次闪避消耗的耐力，会被多种buff影响\n配置闪避消耗值：不受战斗影响Error：当实体不存在，没有闪避组件，或charactor_param表有误时")]
public class ModifyAvoidEnduranceTogether : FlowNode
{
	protected override void RegisterPorts()
	{
		int result = 0;
		int X = 0;
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> permillageA = AddValueInput<int>("千分比倍率A", "permillageA").SetDefaultAndSerializedValue(1000);
		ValueInput<int> fixedValueB = AddValueInput<int>("固定值B", "fixedValueB");
		ValueInput<ValueModeX_AVOID_ENGY> valueModeX = AddValueInput<ValueModeX_AVOID_ENGY>("模式X", "valueModeX").SetDefaultAndSerializedValue(ValueModeX_AVOID_ENGY.CurrentValue);
		ValueInput<CalStyle> calWay = AddValueInput<CalStyle>("运算", "calWay").SetDefaultAndSerializedValue(CalStyle.Set);
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		int entityID;
		int A;
		int B;
		AddFlowInput("In", "in", delegate(Flow f)
		{
			entityID = entityIDInput.value;
			A = permillageA.value;
			B = fixedValueB.value;
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
					X = (int)(long)entityWithEntityID.entityEndurance.currentValue;
					break;
				case ValueModeX_AVOID_ENGY.MaxValue:
					X = (int)(long)entityWithEntityID.entityEndurance.maxValue;
					break;
				case ValueModeX_AVOID_ENGY.CurrentConsumeValue:
					X = (int)(long)entityWithEntityID.entityEndurance.consumeValue;
					break;
				case ValueModeX_AVOID_ENGY.ConfigConsumeValue:
					X = ConfigHelper.GetInstance().GetConfig<charactor_param>(entityWithEntityID.ENTITY_CONFIG_ID).ConsumeEnduranceValue * 1000;
					break;
				default:
					error.Call(f);
					return;
				}
				result = A * X / 1000 + B;
				if (calWay.value == CalStyle.Add)
				{
					result += (int)(long)entityWithEntityID.entityEndurance.currentValue;
				}
				Int obj = result;
				if (obj < 0)
				{
					obj = 0;
				}
				else if (obj > entityWithEntityID.entityEndurance.maxValue)
				{
					obj = entityWithEntityID.entityEndurance.maxValue;
				}
				entityWithEntityID.entityEndurance.currentValue = obj;
				output.Call(f);
			}
		});
	}
}
