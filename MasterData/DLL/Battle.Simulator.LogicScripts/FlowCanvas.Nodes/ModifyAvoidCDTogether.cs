using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[统合]修改闪避效果CD(逻辑)", 0)]
[Category("Logic/统合")]
[Description("修改实体闪避效果的CD，使用ax+b模式修改\n修改后CD不会小于0或超过最大值。单位ms\n\nError：实体不存在，或charactor_param表有误时")]
public class ModifyAvoidCDTogether : FlowNode
{
	private bool TrySetAvoidCD(int entityID, int permillageA, int fixedValueB, int valueModeX)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		int num = permillageA * valueModeX / 1000 + fixedValueB;
		if (num < 0)
		{
			num = 0;
		}
		if (!AttributeProcessor.TryGetUltimateAvoidCD(base.mSimContext, entityID, out var ultimateAvoidCD))
		{
			if (!ConfigHelper.GetInstance().TryGetConfig<charactor_param>(entityWithEntityID.ENTITY_CONFIG_ID, out var config))
			{
				return false;
			}
			if (num > config.UltimateAvoidCD)
			{
				num = config.UltimateAvoidCD;
			}
		}
		else if (num > ultimateAvoidCD)
		{
			num = ultimateAvoidCD;
		}
		entityWithEntityID.entityUltimateAvoidCD.mRuntime = num;
		return true;
	}

	private bool TryAddAvoidCD(int entityID, int permillageA, int fixedValueB, int valueModeX)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		int num = permillageA * valueModeX / 1000 + fixedValueB + entityWithEntityID.entityUltimateAvoidCD.mRuntime;
		if (num < 0)
		{
			num = 0;
		}
		if (!AttributeProcessor.TryGetUltimateAvoidCD(base.mSimContext, entityID, out var ultimateAvoidCD))
		{
			if (!ConfigHelper.GetInstance().TryGetConfig<charactor_param>(entityWithEntityID.ENTITY_CONFIG_ID, out var config))
			{
				return false;
			}
			if (num > config.UltimateAvoidCD)
			{
				num = config.UltimateAvoidCD;
			}
		}
		else if (num > ultimateAvoidCD)
		{
			num = ultimateAvoidCD;
		}
		entityWithEntityID.entityUltimateAvoidCD.mRuntime = num;
		return true;
	}

	protected override void RegisterPorts()
	{
		int B = 0;
		int entityID = 0;
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> permillageA = AddValueInput<int>("千分比倍率A修改量", "permillageA").SetDefaultAndSerializedValue(1000);
		ValueInput<int> fixedValueB = AddValueInput<int>("固定值B修改量", "fixedValueB");
		ValueInput<ValueModeX_AVOIDCD> valueModeX = AddValueInput<ValueModeX_AVOIDCD>("模式X", "valueModeX").SetDefaultAndSerializedValue(ValueModeX_AVOIDCD.CurrentValue);
		ValueInput<CalStyle> calWay = AddValueInput<CalStyle>("运算方式", "CalStyle").SetDefaultAndSerializedValue(CalStyle.Set);
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		int X;
		int A;
		AddFlowInput("In", "in", delegate(Flow f)
		{
			X = 0;
			A = 0;
			B = 0;
			entityID = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				error.Call(f);
			}
			else
			{
				A = permillageA.value;
				B = fixedValueB.value;
				if (!entityWithEntityID.hasEntityUltimateAvoidCD)
				{
					entityWithEntityID.AddEntityUltimateAvoidCD(0, 0);
				}
				switch (valueModeX.value)
				{
				case ValueModeX_AVOIDCD.CurrentValue:
					if (entityWithEntityID.entityUltimateAvoidCD == null)
					{
						X = 0;
					}
					else
					{
						X = entityWithEntityID.entityUltimateAvoidCD.mRuntime;
					}
					break;
				case ValueModeX_AVOIDCD.MaxValue:
				{
					if (!AttributeProcessor.TryGetUltimateAvoidCD(base.mSimContext, entityID, out var ultimateAvoidCD))
					{
						if (!ConfigHelper.GetInstance().TryGetConfig<charactor_param>(entityWithEntityID.ENTITY_CONFIG_ID, out var config2))
						{
							error.Call(f);
							return;
						}
						X = config2.UltimateAvoidCD;
					}
					else
					{
						X = ultimateAvoidCD;
					}
					break;
				}
				case ValueModeX_AVOIDCD.ConfigMaxValue:
				{
					if (!ConfigHelper.GetInstance().TryGetConfig<charactor_param>(entityWithEntityID.ENTITY_CONFIG_ID, out var config))
					{
						error.Call(f);
						return;
					}
					X = config.UltimateAvoidCD;
					break;
				}
				default:
					error.Call(f);
					return;
				}
				switch (calWay.value)
				{
				case CalStyle.Set:
					if (TrySetAvoidCD(entityID, A, B, X))
					{
						output.Call(f);
					}
					else
					{
						error.Call(f);
					}
					break;
				case CalStyle.Add:
					if (TryAddAvoidCD(entityID, A, B, X))
					{
						output.Call(f);
					}
					else
					{
						error.Call(f);
					}
					break;
				}
			}
		});
	}
}
