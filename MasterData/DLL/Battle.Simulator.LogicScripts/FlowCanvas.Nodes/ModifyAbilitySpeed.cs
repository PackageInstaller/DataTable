using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能速度", 0)]
[Category("Logic/Abilities")]
[Description("修改当前正在执行的技能的执行速度,百分比")]
public class ModifyAbilitySpeed : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityInput = AddValueInput<int>("EntityID");
		ValueInput<int> speedInput = AddValueInput<int>("速度");
		FlowOutput output = AddFlowOutput("out");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityActionAbility)
			{
				entityWithEntityID.entityActionAbility.mAbilitySpeed = speedInput.value;
			}
			output.Call(f);
		});
	}
}
