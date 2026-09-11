using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断当前技能是不是闪避(过时)", 0)]
[Category("Logic/Abilities")]
[Description("判断当前技能是不是闪避，请使用【是否处于闪避行为】节点")]
public class IsCurrentAbilityAvoidAbility : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			RoleConfig roleConfig = entityWithEntityID.entityConfig.mConfig as RoleConfig;
			if (entityWithEntityID != null && entityWithEntityID.hasEntityActionAbility && roleConfig.AvoidAbility.Contains(entityWithEntityID.entityActionAbility.mAbilityID))
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
