using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]修改单个CD上限(千分比)", 0)]
[Category("Logic/Attribute")]
[Description("修改单个CD上限(千分比), 只能加减;\n减少传入【负数】")]
public class ModifyTargetAbilityMaxCDPercent : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> abilityIDInput = AddValueInput<int>("技能ID");
		ValueInput<int> valueInput = AddValueInput<int>("变化量");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityCD)
			{
				int value = abilityIDInput.value;
				int num = 0;
				if (!entityWithEntityID.entityCD.mAbilityMaxCD.TryGetValue(value, out var value2))
				{
					ConfigProcessor.TryGetCDConfig(entityWithEntityID, value, out var cd, out var _);
					num = 0;
					value2.baseValue = cd;
				}
				else
				{
					num = value2.deltaPercent;
				}
				num += valueInput.value;
				value2.deltaPercent = num;
				entityWithEntityID.entityCD.mAbilityMaxCD[value] = value2;
			}
			f.Call(output);
		});
	}
}
