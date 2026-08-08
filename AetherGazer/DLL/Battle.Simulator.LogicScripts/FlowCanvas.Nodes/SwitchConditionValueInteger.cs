using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("二选一(integer)", 0)]
[Category("Logic/Math")]
[Description("True 返回 值1;\nFalse 返回 值2")]
public class SwitchConditionValueInteger : FlowControlNode
{
	private ValueInput<bool> _conditionInput;

	private ValueInput<int> _trueValue;

	private ValueInput<int> _falseValue;

	private FlowOutput _output;

	private int _retValue;

	protected override void RegisterPorts()
	{
		_conditionInput = AddValueInput<bool>("Condition", "condition");
		_trueValue = AddValueInput<int>("值1(True返回)", "value1");
		_falseValue = AddValueInput<int>("值2(False返回)", "value2");
		_output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_retValue = (_conditionInput.value ? _trueValue.value : _falseValue.value);
			_output.Call(f);
		});
		AddValueOutput("返回值", "retValue", () => _retValue);
	}
}
