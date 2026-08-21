using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[统合]修改技能CD最大值(逻辑)", 0)]
[Category("Logic/统合")]
[Description("修改指定技能的最大CD，使用dadb规则，以技能最大CD公式规则修改，先加减后乘除。单位ms\n\nError：实体不存在，或技能id不存在时")]
public class ModifyAbilityMaxCDTogether : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> abilityIDInput = AddValueInput<int>("技能ID", "abilityID");
		ValueInput<int> permillageA = AddValueInput<int>("千分比倍率A修改量", "permillageA");
		ValueInput<int> fixedValueB = AddValueInput<int>("固定值B修改量", "fixedValueB");
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		AddFlowInput("In", "in", delegate(Flow f)
		{
			int value = entityIDInput.value;
			int value2 = abilityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(value);
			AbilityMaxCDInfo value3;
			if (entityWithEntityID == null)
			{
				error.Call(f);
			}
			else if (!entityWithEntityID.entityCD.mAbilityMaxCD.TryGetValue(value2, out value3))
			{
				if (!ConfigProcessor.TryGetCDConfig(entityWithEntityID, value2, out var cd, out var _))
				{
					error.Call(f);
				}
				else
				{
					CDProcessor.GetCD(entityWithEntityID, value2, out var abilityCD);
					value3.baseValue = cd;
					value3.deltaPercent += permillageA.value;
					value3.deltaValue += fixedValueB.value;
					entityWithEntityID.entityCD.mAbilityMaxCD[value2] = value3;
					abilityCD.MaxCD = (value3.baseValue + value3.deltaValue) * (1000 + value3.deltaPercent) / 1000;
					output.Call(f);
				}
			}
			else
			{
				CDProcessor.GetCD(entityWithEntityID, value2, out var abilityCD2);
				value3.deltaPercent += permillageA.value;
				value3.deltaValue += fixedValueB.value;
				entityWithEntityID.entityCD.mAbilityMaxCD[value2] = value3;
				abilityCD2.MaxCD = (value3.baseValue + value3.deltaValue) * (1000 + value3.deltaPercent) / 1000;
				output.Call(f);
			}
		});
	}
}
