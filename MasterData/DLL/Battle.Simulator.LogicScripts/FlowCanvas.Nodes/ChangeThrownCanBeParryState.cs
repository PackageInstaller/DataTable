using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[格挡]修改抛掷物能否被格挡状态(逻辑)", 0)]
[Category("Logic/格挡")]
[Description("修改抛掷物能否被格挡状态, 当前没有时走error")]
public class ChangeThrownCanBeParryState : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> thrownIDIDInput = AddValueInput<int>("抛掷物ID");
		ValueInput<bool> valueInput = AddValueInput<bool>("CanBeParry");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("error");
		AddValueOutput("抛掷物ID", () => thrownIDIDInput.value);
		AddFlowInput("", delegate(Flow f)
		{
			if (!ThrownProcessor.TryGetThrown(base.mSimContext, thrownIDIDInput.GetValue(), out var thrownState))
			{
				errorOut.Call(f);
			}
			else
			{
				thrownState.mCanBeParry = valueInput.value;
				output.Call(f);
			}
		});
	}
}
