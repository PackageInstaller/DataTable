using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到使用的连携奥义ID(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("如题")]
public class GetUsedCooperateUniqueSkillID : FlowControlNode
{
	private FlowOutput _Out;

	private int _CooperateUniqueSkillID;

	protected override void RegisterPorts()
	{
		_Out = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_CooperateUniqueSkillID = base.mSimContext.sEntityWorldState.status.m_CooperateUniqueSkillID;
			_Out.Call(f);
		});
		AddValueOutput("连携奥义ID", "cooperateUniqueSkillID", () => _CooperateUniqueSkillID);
	}
}
