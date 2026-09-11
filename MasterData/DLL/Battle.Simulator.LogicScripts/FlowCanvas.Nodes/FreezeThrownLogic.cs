using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("冻结抛掷物逻辑", 0)]
[Category("Logic/抛掷物")]
[Description("冻结抛掷物逻辑,将抛掷物从逻辑循环中调过")]
public class FreezeThrownLogic : FlowControlNodeOfLogic
{
	private FlowOutput _output;

	protected override void RegisterPorts()
	{
		ValueInput<bool> freezeInput = AddValueInput<bool>("冻结", "freeze").SetDefaultAndSerializedValue(v: true);
		_output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			base.mSimContext.sEntityWorldState.status.mFreezeThrownLogic = freezeInput.value;
			_output.Call(f);
		});
	}
}
