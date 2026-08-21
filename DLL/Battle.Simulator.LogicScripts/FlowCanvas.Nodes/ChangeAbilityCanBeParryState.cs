using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[格挡]修改技能能否被格挡状态(逻辑)", 0)]
[Category("Logic/格挡")]
[Description("修改技能能否被格挡状态, 当前没有技能组件时走error")]
public class ChangeAbilityCanBeParryState : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<bool> valueInput = AddValueInput<bool>("CanBeParry");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("error");
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		int abilityID = 0;
		AddValueOutput("当前技能ID", () => abilityID);
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (!CommonProcessor.IsAliveRole(entityWithEntityID))
			{
				errorOut.Call(f);
			}
			else if (!entityWithEntityID.hasEntityActionAbility)
			{
				errorOut.Call(f);
			}
			else
			{
				entityWithEntityID.entityActionAbility.mCanBeParry = valueInput.value;
				abilityID = entityWithEntityID.entityActionAbility.mAbilityID;
				output.Call(f);
			}
		});
	}
}
