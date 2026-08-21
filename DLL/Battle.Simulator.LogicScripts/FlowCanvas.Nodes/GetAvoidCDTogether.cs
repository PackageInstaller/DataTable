using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[统合]获取闪避效果CD(逻辑)", 0)]
[Category("Logic/统合")]
[Description("得到实体的闪避效果CD值\n当前最大值受战斗影响。单位ms\nError：实体不存在，或charactor_param表有误时")]
public class GetAvoidCDTogether : FlowNode
{
	private int cdValue;

	private int entityID;

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<ValueModeX_AVOIDCD> valueModeX = AddValueInput<ValueModeX_AVOIDCD>("模式X", "valueModeX").SetDefaultAndSerializedValue(ValueModeX_AVOIDCD.CurrentValue);
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		AddValueOutput("值", "cdValue", () => cdValue);
		AddFlowInput("In", "in", delegate(Flow f)
		{
			cdValue = 0;
			entityID = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
			if (entityWithEntityID == null)
			{
				error.Call(f);
			}
			else
			{
				switch (valueModeX.value)
				{
				case ValueModeX_AVOIDCD.CurrentValue:
					if (!entityWithEntityID.hasEntityUltimateAvoidCD)
					{
						cdValue = 0;
					}
					else
					{
						cdValue = entityWithEntityID.entityUltimateAvoidCD.mRuntime;
					}
					break;
				case ValueModeX_AVOIDCD.MaxValue:
				{
					if (!AttributeProcessor.TryGetUltimateAvoidCD(base.mSimContext, entityID, out var ultimateAvoidCD))
					{
						if (!ConfigHelper.GetInstance().TryGetConfig<charactor_param>(entityWithEntityID.ENTITY_CONFIG_ID, out var config2))
						{
							cdValue = 0;
							error.Call(f);
							return;
						}
						cdValue = config2.UltimateAvoidCD;
					}
					else
					{
						cdValue = ultimateAvoidCD;
					}
					break;
				}
				case ValueModeX_AVOIDCD.ConfigMaxValue:
				{
					if (!ConfigHelper.GetInstance().TryGetConfig<charactor_param>(entityWithEntityID.ENTITY_CONFIG_ID, out var config))
					{
						cdValue = 0;
						error.Call(f);
						return;
					}
					cdValue = config.UltimateAvoidCD;
					break;
				}
				default:
					cdValue = 0;
					error.Call(f);
					return;
				}
				output.Call(f);
			}
		});
	}
}
