using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("二选一(float)(渲染)", 0)]
[Category("Render/Math")]
[Description("True 返回 值1;\nFalse 返回 值2")]
public class SwitchConditionValueFloat : FlowControlNode
{
	private ValueInput<bool> _conditionInput;

	private ValueInput<float> _trueValue;

	private ValueInput<float> _falseValue;

	private FlowOutput _output;

	private float _retValue;

	protected override void RegisterPorts()
	{
		_conditionInput = AddValueInput<bool>("Condition", "condition");
		_trueValue = AddValueInput<float>("值1(True返回)", "value1");
		_falseValue = AddValueInput<float>("值2(False返回)", "value2");
		_output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_retValue = (_conditionInput.value ? _trueValue.value : _falseValue.value);
			_output.Call(f);
		});
		AddValueOutput("返回值", "retValue", () => _retValue);
	}
}
