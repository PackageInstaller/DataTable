using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[连携奥义]是否启用(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("连携奥义是否处于启用状态")]
public class IsEanbleCooperateUniqueSkill : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput trueOut = AddFlowOutput("True", "true");
		FlowOutput falseOut = AddFlowOutput("False", "false");
		AddFlowOutput("Error", "error");
		AddFlowInput("Out", "output", delegate(Flow f)
		{
			if (base.mSimContext.sEntityWorldState.status.m_cooperateUniqueSkillIsActive > 0)
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
