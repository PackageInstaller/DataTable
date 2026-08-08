using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("发送零时空间事件", 0)]
[Category("Logic/事件")]
[Description("不论零时空间的触发条件，该事件都会触发；包括进入和退出两个阶段事件，当零时空间覆盖时，上一个零时空间不会触发退出事件")]
public class PostZeroSpaceEvent : FlowControlNode
{
	private ValueInput<EnZeroSpaceStep> _StepInput;

	private ValueInput<int> _AvoiderIDInput;

	private ValueInput<int> _AttackerIDInput;

	private ValueInput<int> _ParamInput;

	private FlowOutput _Out;

	protected override void RegisterPorts()
	{
		_StepInput = AddValueInput<EnZeroSpaceStep>("阶段", "step");
		_AvoiderIDInput = AddValueInput<int>("闪避者ID", "avoiderID");
		_AttackerIDInput = AddValueInput<int>("攻击者ID", "attackerID");
		_ParamInput = AddValueInput<int>("参数", "param");
		_Out = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			base.mSimContext.PostEvent(ZeroSpaceEvent.Claim(_StepInput.GetValue(), _AvoiderIDInput.GetValue(), _AttackerIDInput.GetValue(), _ParamInput.GetValue()));
			_Out.Call(f);
		});
	}
}
