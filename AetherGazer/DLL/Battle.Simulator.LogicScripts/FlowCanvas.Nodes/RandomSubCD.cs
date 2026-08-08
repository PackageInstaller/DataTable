using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("随机减一个技能CD", 0)]
[Category("Logic/Attribute")]
[Description("随机减一个技能CD")]
public class RandomSubCD : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> valueInput = AddValueInput<int>("百分比");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityCD || entityWithEntityID.entityCD.mAbilityCD.Count == 0)
			{
				f.Call(output);
			}
			else
			{
				int index = (int)DRandom.Random((uint)entityWithEntityID.entityCD.mAbilityCD.Count);
				AbilityCD value = entityWithEntityID.entityCD.mAbilityCD[index];
				int num = value.MaxCD * valueInput.value / 100;
				value.CD -= num;
				if (value.CD > 0)
				{
					entityWithEntityID.entityCD.mAbilityCD[index] = value;
				}
				else
				{
					entityWithEntityID.entityCD.mAbilityCD.RemoveAt(index);
				}
				f.Call(output);
			}
		});
	}
}
