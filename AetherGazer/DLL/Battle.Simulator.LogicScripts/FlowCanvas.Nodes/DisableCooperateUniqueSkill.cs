using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[连携奥义]禁用(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("如题")]
public class DisableCooperateUniqueSkill : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimWorldState simWorldState = base.mSimContext.sEntityWorldState.status;
			bool num = simWorldState.m_cooperateUniqueSkillIsActive > 0;
			simWorldState.m_cooperateUniqueSkillIsActive += -1;
			bool flag = simWorldState.m_cooperateUniqueSkillIsActive > 0;
			if (num != flag)
			{
				base.mSimContext.GetSimInterface().mCooperateUniqueSkillStatusChangeEvent?.Invoke(flag, simWorldState.m_CooperateUniqueSkillID);
			}
			output.Call(f);
		});
	}
}
