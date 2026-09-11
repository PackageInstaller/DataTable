namespace FlowCanvas.Nodes;

public class SetButtonEffectEnable : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<AbilityButtonEffect> buttonEffectInput = AddValueInput<AbilityButtonEffect>("技能动效");
		ValueInput<bool> buttonEffectEnalbeInput = AddValueInput<bool>("是否启用");
		FlowOutput output = AddFlowOutput("OUT");
		AddFlowInput("IN", delegate(Flow f)
		{
			Invoke(buttonEffectInput.value, buttonEffectEnalbeInput.value);
			output.Call(f);
		});
	}

	protected virtual void Invoke(AbilityButtonEffect abilityButtonEffect, bool enable)
	{
		abilityButtonEffect.enabled = enable;
	}
}
