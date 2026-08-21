using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否是主技能", 0)]
[Category("Logic/Ability")]
[Description("判断是否为主技能,对应的是 RoleConfig 中的 Ability 字段,只能保留主技能")]
public class IsMainAbility : FlowControlNode
{
	private FlowOutput m_true;

	private FlowOutput m_false;

	private FlowOutput m_error;

	private ValueInput<int> m_timelineIDInput;

	protected override void RegisterPorts()
	{
		m_true = AddFlowOutput("True", "true");
		m_false = AddFlowOutput("False", "false");
		m_error = AddFlowOutput("Error", "error");
		m_timelineIDInput = AddValueInput<int>("TimelineID", "timelineIDInput");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			int id = m_timelineIDInput.GetValue() / 1000;
			RoleConfig config = ConfigHelper.GetInstance().GetConfig<RoleConfig>(id);
			if (config == null)
			{
				m_error.Call(f);
			}
			else if (config.Ability.Contains(m_timelineIDInput.GetValue()))
			{
				m_true.Call(f);
			}
			else
			{
				m_false.Call(f);
			}
		});
		AddValueOutput("TimelineID", "timelineID", () => m_timelineIDInput.GetValue());
	}
}
