using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到实体阵营", 0)]
[Category("Logic/Trigger")]
[Description("得到实体阵营")]
public class GetRoleType : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	private RoleType m_roleType;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(m_entityIDInput.GetValue());
			if (entityWithEntityID == null)
			{
				m_error.Call(f);
			}
			else if (!entityWithEntityID.hasEntityCamp)
			{
				m_error.Call(f);
			}
			else
			{
				m_roleType = (RoleType)entityWithEntityID.entityCamp.mRoleTypeCamp;
				m_out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
		AddValueOutput("阵营", "roleType", () => m_roleType);
	}
}
