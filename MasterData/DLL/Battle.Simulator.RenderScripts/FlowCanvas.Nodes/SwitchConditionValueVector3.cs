using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("二选一(Vector3)(渲染)", 0)]
[Category("Render/Math")]
[Description("True 返回 值1;\nFalse 返回 值2")]
public class SwitchConditionValueVector3 : FlowControlNode
{
	private ValueInput<bool> _conditionInput;

	private ValueInput<Vector3> _trueValue;

	private ValueInput<Vector3> _falseValue;

	private FlowOutput _output;

	private Vector3 _retValue;

	protected override void RegisterPorts()
	{
		_conditionInput = AddValueInput<bool>("Condition", "condition");
		_trueValue = AddValueInput<Vector3>("值1(True返回)", "value1");
		_falseValue = AddValueInput<Vector3>("值2(False返回)", "value2");
		_output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_retValue = (_conditionInput.value ? _trueValue.value : _falseValue.value);
			_output.Call(f);
		});
		AddValueOutput("返回值", "retValue", () => _retValue);
	}
}
