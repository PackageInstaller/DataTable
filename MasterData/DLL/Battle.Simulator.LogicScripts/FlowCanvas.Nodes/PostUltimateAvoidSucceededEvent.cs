using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("发送闪避效果触发事件", 0)]
[Category("Logic/事件")]
[Description("需要考虑极限闪避是否CD，词缀是否关闭了极限闪避等，都满足的情况下闪成功了就会触发，和触发的什么效果没有关系")]
public class PostUltimateAvoidSucceededEvent : FlowControlNode
{
	private ValueInput<int> _AvoiderIDInput;

	private ValueInput<int> _AttackerIDInput;

	private FlowOutput _Out;

	protected override void RegisterPorts()
	{
		_AvoiderIDInput = AddValueInput<int>("闪避者ID", "avoiderID");
		_AttackerIDInput = AddValueInput<int>("攻击者ID", "attackerID");
		_Out = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			base.mSimContext.PostEvent(UltimateAvoidSucceededEvent.Claim(_AvoiderIDInput.GetValue(), _AttackerIDInput.GetValue()));
			_Out.Call(f);
		});
	}
}
