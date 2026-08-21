using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("二选一(Int)", 0)]
[Category("Logic/Math")]
[Description("True 返回 值1;\nFalse 返回 值2")]
public class SwitchConditionValueInt : FlowControlNode
{
	private ValueInput<bool> _conditionInput;

	private ValueInput<Int> _trueValue;

	private ValueInput<Int> _falseValue;

	private FlowOutput _output;

	private Int _retValue;

	protected override void RegisterPorts()
	{
		_conditionInput = AddValueInput<bool>("Condition", "condition");
		_trueValue = AddValueInput<Int>("值1(True返回)", "value1");
		_falseValue = AddValueInput<Int>("值2(False返回)", "value2");
		_output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_retValue = (_conditionInput.value ? _trueValue.value : _falseValue.value);
			_output.Call(f);
		});
		AddValueOutput("返回值", "retValue", () => _retValue);
	}
}
