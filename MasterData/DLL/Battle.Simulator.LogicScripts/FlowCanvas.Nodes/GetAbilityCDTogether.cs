using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[统合]获取技能CD(逻辑)", 0)]
[Category("Logic/统合")]
[Description("得到指定技能的CD信息。单位ms\n\n当前值：当前正在转的CD值\n当前总值：当前正在转的CD加上后台的CD总值\n当前最大值：当前的技能最大CD，受战斗影响\n配置最大值：该技能配置的最大CD，不受战斗影响\n\nError：实体不存在，或技能id不存在时")]
public class GetAbilityCDTogether : FlowNode
{
	protected override void RegisterPorts()
	{
		int cdResult = 0;
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> abilityIDInput = AddValueInput<int>("技能ID", "abilityID");
		ValueInput<ValueModeX_SKILLCD> valueModeX = AddValueInput<ValueModeX_SKILLCD>("模式X", "valueModeX").SetDefaultAndSerializedValue(ValueModeX_SKILLCD.CurrentValue);
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		AddValueOutput("值", "value", () => cdResult);
		int abilityID;
		int entityID;
		AddFlowInput("In", "in", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				error.Call(f);
			}
			else
			{
				abilityID = abilityIDInput.value;
				entityID = entityIDInput.value;
				AbilityCD abilityCD;
				int maxUseCount;
				switch (valueModeX.value)
				{
				case ValueModeX_SKILLCD.CurrentValue:
					if (CDProcessor.GetCD(entityWithEntityID, abilityID, out abilityCD))
					{
						cdResult = abilityCD.CD;
					}
					else
					{
						cdResult = 0;
					}
					break;
				case ValueModeX_SKILLCD.CurrentMaxValue:
				{
					AbilityMaxCDInfo value;
					if (CDProcessor.GetCD(entityWithEntityID, abilityID, out abilityCD))
					{
						cdResult = abilityCD.MaxCD;
					}
					else if (!entityWithEntityID.entityCD.mAbilityMaxCD.TryGetValue(abilityID, out value))
					{
						if (!ConfigProcessor.TryGetCDConfig(entityWithEntityID, abilityID, out var cd2, out maxUseCount))
						{
							error.Call(f);
							return;
						}
						cdResult = cd2;
					}
					else
					{
						cdResult = (value.baseValue + value.deltaValue) * (1000 + value.deltaPercent) / 1000;
					}
					break;
				}
				case ValueModeX_SKILLCD.CurrentTotalValue:
				{
					if (CDProcessor.GetCD(entityWithEntityID, abilityID, out abilityCD))
					{
						cdResult = abilityCD.CD;
					}
					else
					{
						cdResult = 0;
					}
					CDProcessor.GetMaxCDAndMaxUseCount(entityWithEntityID, abilityID, out var maxCD, out maxUseCount);
					if (abilityCD.UsedCount > 0)
					{
						cdResult = (abilityCD.UsedCount - 1) * maxCD + cdResult;
					}
					break;
				}
				case ValueModeX_SKILLCD.ConfigMaxValue:
				{
					CDProcessor.GetCD(entityWithEntityID, abilityID, out abilityCD);
					if (!ConfigProcessor.TryGetCDConfig(entityWithEntityID, abilityID, out var cd, out maxUseCount))
					{
						cdResult = 0;
						error.Call(f);
						return;
					}
					cdResult = cd;
					break;
				}
				default:
					cdResult = 0;
					error.Call(f);
					return;
				}
				output.Call(f);
			}
		});
	}
}
