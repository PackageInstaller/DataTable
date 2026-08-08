using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("增加释放QTE的玩家计数(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("该计数用于阻挡进入修正模式，注意：boss转阶段也会增加该计数以阻挡进入修正模式")]
public class AddInQTEPlayerCount : FlowControlNode
{
	private ValueInput<int> _AddValue;

	private FlowOutput _Out;

	protected override void RegisterPorts()
	{
		_AddValue = AddValueInput<int>("增量", "addValue");
		_Out = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SEntityWorldState sEntityWorldState = base.mSimContext.sEntityWorldState;
			sEntityWorldState.status.m_InQTERoleCount += _AddValue.GetValue();
			if (sEntityWorldState.status.m_InQTERoleCount < 0)
			{
				sEntityWorldState.status.m_InQTERoleCount = 0;
			}
			_Out.Call(f);
		});
	}
}
