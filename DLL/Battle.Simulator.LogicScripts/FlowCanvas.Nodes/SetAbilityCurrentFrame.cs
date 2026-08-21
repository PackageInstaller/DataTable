using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能跳帧", 0)]
[Category("Logic/Abilities")]
[Description("技能跳帧(慎用)")]
public class SetAbilityCurrentFrame : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> frameInput = AddValueInput<int>("要跳转的帧数");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID.hasEntityActionAbility)
			{
				entityWithEntityID.entityActionAbility.mLogicTime = frameInput.value * CommonProcessor.GetConfigInterval();
			}
			output.Call(f);
		});
	}
}
