using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否有闪避效果CD(逻辑)", 0)]
[Category("Logic/Attribute/闪避效果CD")]
[Description("用来判断是否有闪避效果CD")]
public class HasUltimateAvoidCD : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private FlowOutput m_true;

	private FlowOutput m_false;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_true = AddFlowOutput("CD中", "true");
		m_false = AddFlowOutput("可使用", "false");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(m_entityIDInput.GetValue());
			if (entityWithEntityID == null)
			{
				m_error.Call(f);
			}
			else if (entityWithEntityID.hasEntityUltimateAvoidCD && entityWithEntityID.entityUltimateAvoidCD.mLeftUseCount <= 0)
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
