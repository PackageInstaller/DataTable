using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到技能时长(逻辑)", 0)]
[Category("Logic/Config")]
[Description("得到技能时长")]
public class GetAbilityLength : FlowControlNode
{
	private ValueInput<int> m_EntityIDInput;

	private ValueInput<int> m_ActionIDInput;

	private FlowOutput m_Out;

	private FlowOutput m_Error;

	private int m_Length;

	protected override void RegisterPorts()
	{
		m_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_ActionIDInput = AddValueInput<int>("后三位", "actionID");
		m_Out = AddFlowOutput("Out", "output");
		m_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			int id = (int)base.mSimContext.GetEntityWithEntityID(m_EntityIDInput.GetValue()).ENTITY_CONFIG_ID * 1000 + m_ActionIDInput.GetValue();
			Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(id);
			if (config == null)
			{
				m_Error.Call(f);
			}
			else
			{
				m_Length = config.Duration;
				m_Out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_EntityIDInput.GetValue());
		AddValueOutput("后三位", "actionID", () => m_ActionIDInput.GetValue());
		AddValueOutput("时长", "length", () => m_Length);
	}
}
