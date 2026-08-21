namespace FlowCanvas.Nodes;

public abstract class PostUniqueSkillEventBase : FlowControlNode
{
	private ValueInput<int> _casterIDInput;

	private ValueInput<int> _targetIDInput;

	private ValueInput<int> _paramInput;

	private FlowOutput _out;

	protected override void RegisterPorts()
	{
		AddBaseFlowInput();
		AddBaseFlowOutput();
		AddBaseValueInput();
		AddCustomValueInput();
		AddBaseValueOutput();
		AddCustomValueOutput();
	}

	private void AddBaseFlowInput()
	{
		AddFlowInput("In", "input", delegate(Flow f)
		{
			base.mSimContext.PostEvent(UniqueSkillEvent.Claim(GetStep(), _casterIDInput.value, _targetIDInput.value, GetIsCooperating(), _paramInput.value));
			_out.Call(f);
		});
	}

	private void AddBaseFlowOutput()
	{
		_out = AddFlowOutput("Out", "output");
	}

	private void AddBaseValueInput()
	{
		_casterIDInput = AddValueInput<int>("释放者ID", "casteerID");
		_targetIDInput = AddValueInput<int>("目标ID", "targetID");
		_paramInput = AddValueInput<int>("参数", "param");
	}

	protected abstract void AddCustomValueInput();

	private void AddBaseValueOutput()
	{
	}

	protected abstract void AddCustomValueOutput();

	protected abstract int GetStep();

	protected abstract bool GetIsCooperating();
}
