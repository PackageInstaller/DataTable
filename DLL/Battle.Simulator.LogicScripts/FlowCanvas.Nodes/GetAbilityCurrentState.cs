using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断当前技能状态", 0)]
[Category("Logic/Abilities")]
[Description("判断当前技能状态")]
public class GetAbilityCurrentState : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		FlowOutput output = AddFlowOutput("Out");
		AbilityDetailClass detailClass = AbilityDetailClass.None;
		AbilitySpaceClass spaceClass = AbilitySpaceClass.None;
		AbilityStageClass stageClass = AbilityStageClass.None;
		AddValueOutput("detail", () => detailClass);
		AddValueOutput("space", () => spaceClass);
		AddValueOutput("stage", () => stageClass);
		AddFlowInput("In", delegate(Flow f)
		{
			AbilityState abilityState = ConfigProcessor.GetAbilityState(base.mSimContext.GetEntityWithEntityID(entityIDInput.value));
			detailClass = abilityState.detailClass;
			spaceClass = abilityState.spaceClass;
			stageClass = abilityState.stageClass;
			output.Call(f);
		});
	}
}
