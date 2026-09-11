using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断连携奥义ID(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("如题")]
public class IsCooperateUniqueSkillID : FlowControlNode
{
	private int _skillID;

	protected override void RegisterPorts()
	{
		ValueInput<int> skillIDInput = AddValueInput<int>("比较的连携ID", "skillID");
		FlowOutput trueOut = AddFlowOutput("True", "true");
		FlowOutput falseOut = AddFlowOutput("False", "false");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_skillID = base.mSimContext.sEntityWorldState.status.m_CooperateUniqueSkillID;
			if (skillIDInput.value == _skillID)
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
		AddValueOutput("使用的连携ID", "skillID", () => _skillID);
	}
}
