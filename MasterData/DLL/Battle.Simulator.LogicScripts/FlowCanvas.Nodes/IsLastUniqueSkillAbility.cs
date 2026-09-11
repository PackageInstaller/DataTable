using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否奥义最后一段", 0)]
[Category("Logic/奥义")]
[Description("实体为空的话, 走false")]
public class IsLastUniqueSkillAbility : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> abilityIDInput = AddValueInput<int>("技能ID");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityConfig || !ConfigHelper.GetInstance().TryGetConfig<UniqueSkill>(entityWithEntityID.entityConfig.mId, out var config))
			{
				falseOut.Call(f);
			}
			else if (config.AbilityId.Count > 0 && config.AbilityId.get_Item(config.AbilityId.Count - 1) == abilityIDInput.value)
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
