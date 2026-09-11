using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否有内置CD或计时器", 0)]
[Category("Logic/Buff")]
[Description("判断指定实体当前是否拥有指定编号的内置CD或计时器，只要仍在持续时间内就算拥有")]
public class HasInternalCD : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private ValueInput<int> m_keyInput;

	private FlowOutput m_true;

	private FlowOutput m_false;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_keyInput = AddValueInput<int>("编号(=计时器编号)", "key");
		m_true = AddFlowOutput("内置CD中", "true");
		m_false = AddFlowOutput("CD刷新完成", "false");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(m_entityIDInput.GetValue());
			if (entityWithEntityID == null)
			{
				m_error.Call(f);
			}
			else if (entityWithEntityID.hasEntityTimer && entityWithEntityID.entityTimer.GetFirstIDByName(m_keyInput.GetValue()) != -1)
			{
				m_true.Call(f);
			}
			else
			{
				m_false.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
	}
}
