using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[统合]修改技能CD(逻辑)", 0)]
[Category("Logic/统合")]
[Description("修改指定技能当前的CD，使用ax+b模式修改，单位ms\n减少cd时，若减少了多轮，也只会发出一次cd结束事件\n\n当前值：当前显示的cd时间\n当前总值：本技能当前cd以及待冷却的所有轮数之和\n当前最大值：当前技能cd最大值，受战斗影响\n配置最大值：当前技能配置的cd最大值，不受战斗影响\n\n超出计入轮数：为true，增加cd，且最终增加结果超出最大值时，大于最大值的部分会计入轮数，小于等于的部分设为当前cd；为false时，全部计入当前cd\n允许超出最大值：为true时，最终运算结果大于最大值的部分也会继续添加；为false时，最终运算结果必小于等于当前最大值\n\nError：实体不存在，或技能id不存在时")]
public class ModifyAbilityCDTogether : FlowNode
{
	private void SetResultWithAllowExceedCountAndMax(int entityID, int abilityID, int result)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		for (int i = 0; i < entityWithEntityID.entityCD.mAbilityCD.Count; i++)
		{
			if (entityWithEntityID.entityCD.mAbilityCD[i].AbilityID == abilityID)
			{
				AbilityCD value = entityWithEntityID.entityCD.mAbilityCD[i];
				int maxCD = value.MaxCD;
				if (result > maxCD)
				{
					int usedCount = result / maxCD;
					value.UsedCount = usedCount;
					result %= maxCD;
				}
				value.CD = result;
				entityWithEntityID.entityCD.mAbilityCD[i] = value;
				break;
			}
		}
	}

	private void SetResultWithoutExceedCount(int entityID, int abilityID, int result)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		for (int i = 0; i < entityWithEntityID.entityCD.mAbilityCD.Count; i++)
		{
			if (entityWithEntityID.entityCD.mAbilityCD[i].AbilityID == abilityID)
			{
				AbilityCD value = entityWithEntityID.entityCD.mAbilityCD[i];
				int maxCD = value.MaxCD;
				if (result > maxCD)
				{
					result = maxCD;
				}
				value.CD = result;
				entityWithEntityID.entityCD.mAbilityCD[i] = value;
				break;
			}
		}
	}

	private void SetResultWithAllowExceedMaxNotCount(int entityID, int abilityID, int result)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		for (int i = 0; i < entityWithEntityID.entityCD.mAbilityCD.Count; i++)
		{
			if (entityWithEntityID.entityCD.mAbilityCD[i].AbilityID == abilityID)
			{
				AbilityCD value = entityWithEntityID.entityCD.mAbilityCD[i];
				value.CD = result;
				entityWithEntityID.entityCD.mAbilityCD[i] = value;
				break;
			}
		}
	}

	protected override void RegisterPorts()
	{
		int X = 0;
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> abilityIDInput = AddValueInput<int>("技能ID", "abilityID");
		ValueInput<int> permillageA = AddValueInput<int>("千分比倍率A", "permillageA").SetDefaultAndSerializedValue(1000);
		ValueInput<int> fixedValueB = AddValueInput<int>("固定值B", "fixedValueB");
		ValueInput<CalStyle> calWay = AddValueInput<CalStyle>("运算方式", "CalStyle").SetDefaultAndSerializedValue(CalStyle.Set);
		ValueInput<ValueModeX_SKILLCD> valueModeX = AddValueInput<ValueModeX_SKILLCD>("模式X", "valueModeX").SetDefaultAndSerializedValue(ValueModeX_SKILLCD.CurrentValue);
		ValueInput<bool> isExceedCount = AddValueInput<bool>("超出计入轮数", "exceedCount").SetDefaultAndSerializedValue(v: true);
		ValueInput<bool> isAllowExceedMax = AddValueInput<bool>("允许超出最大值", "allowExceedMax");
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		int result;
		int abilityID;
		int entityID;
		int A;
		int B;
		AddFlowInput("In", "in", delegate(Flow f)
		{
			result = 0;
			abilityID = 0;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				error.Call(f);
			}
			else
			{
				abilityID = abilityIDInput.value;
				entityID = entityIDInput.value;
				A = permillageA.value;
				B = fixedValueB.value;
				AbilityCD abilityCD;
				int maxUseCount;
				switch (valueModeX.value)
				{
				case ValueModeX_SKILLCD.CurrentValue:
					if (CDProcessor.GetCD(entityWithEntityID, abilityID, out abilityCD))
					{
						X = abilityCD.CD;
					}
					else
					{
						X = 0;
					}
					break;
				case ValueModeX_SKILLCD.CurrentMaxValue:
				{
					AbilityMaxCDInfo value;
					if (CDProcessor.GetCD(entityWithEntityID, abilityID, out abilityCD))
					{
						X = abilityCD.MaxCD;
					}
					else if (!entityWithEntityID.entityCD.mAbilityMaxCD.TryGetValue(abilityID, out value))
					{
						if (!ConfigProcessor.TryGetCDConfig(entityWithEntityID, abilityID, out var cd2, out maxUseCount))
						{
							error.Call(f);
							return;
						}
						X = cd2;
					}
					else
					{
						X = (value.baseValue + value.deltaValue) * (1000 + value.deltaPercent) / 1000;
					}
					break;
				}
				case ValueModeX_SKILLCD.CurrentTotalValue:
				{
					if (CDProcessor.GetCD(entityWithEntityID, abilityID, out abilityCD))
					{
						X = abilityCD.CD;
					}
					else
					{
						X = 0;
					}
					CDProcessor.GetMaxCDAndMaxUseCount(entityWithEntityID, abilityID, out var maxCD, out maxUseCount);
					X = (abilityCD.UsedCount - 1) * maxCD + X;
					break;
				}
				case ValueModeX_SKILLCD.ConfigMaxValue:
				{
					CDProcessor.GetCD(entityWithEntityID, abilityID, out abilityCD);
					if (!ConfigProcessor.TryGetCDConfig(entityWithEntityID, abilityID, out var cd, out maxUseCount))
					{
						error.Call(f);
						return;
					}
					X = cd;
					break;
				}
				default:
					error.Call(f);
					return;
				}
				if (!CDProcessor.GetMaxCDAndMaxUseCount(entityWithEntityID, abilityID, out maxUseCount, out var _))
				{
					error.Call(f);
				}
				else
				{
					if (!CDProcessor.GetCD(entityWithEntityID, abilityID, out var _))
					{
						CDProcessor.AddCD(entityWithEntityID, abilityID);
					}
					if (calWay.value == CalStyle.Set)
					{
						result = A * X / 1000 + B;
						if (isExceedCount.value && isAllowExceedMax.value)
						{
							SetResultWithAllowExceedCountAndMax(entityID, abilityID, result);
							output.Call(f);
							return;
						}
						if (!isExceedCount.value && isAllowExceedMax.value)
						{
							SetResultWithAllowExceedMaxNotCount(entityID, abilityID, result);
							output.Call(f);
							return;
						}
						if (!isAllowExceedMax.value)
						{
							SetResultWithoutExceedCount(entityID, abilityID, result);
							output.Call(f);
							return;
						}
					}
					if (calWay.value == CalStyle.Add)
					{
						result = A * X / 1000 + B + abilityCD.CD;
						if (isExceedCount.value && isAllowExceedMax.value)
						{
							SetResultWithAllowExceedCountAndMax(entityID, abilityID, result);
							output.Call(f);
						}
						else if (!isExceedCount.value && isAllowExceedMax.value)
						{
							SetResultWithAllowExceedMaxNotCount(entityID, abilityID, result);
							output.Call(f);
						}
						else if (!isAllowExceedMax.value)
						{
							SetResultWithoutExceedCount(entityID, abilityID, result);
							output.Call(f);
						}
					}
				}
			}
		});
	}
}
