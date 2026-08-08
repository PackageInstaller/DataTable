using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断当前技能的detail状态", 0)]
[Category("Logic/Abilities")]
[Description("判断当前技能状态是不是处于某个detail")]
public class IsAbilityCurrentStateInTargetDetail : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<AbilityDetailClass> targetStageInput = AddValueInput<AbilityDetailClass>("detail");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("In", delegate(Flow f)
		{
			AbilityState abilityState = ConfigProcessor.GetAbilityState(base.mSimContext.GetEntityWithEntityID(entityIDInput.value));
			if (targetStageInput.value == abilityState.detailClass)
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
