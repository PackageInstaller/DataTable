using ParadoxNotion.Design;
using Services;

namespace FlowCanvas.Nodes;

[Name("得到黑板ID", 0)]
[Category("Logic/Attribute")]
[Description("得到实体绑定的属性ID")]
public class GetAttributeIDOfEntity : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	private int m_attributeID;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(m_entityIDInput.GetValue());
			bool flag = true;
			if (entityWithEntityID == null)
			{
				RuntimeAttributeService runtimeAttributeService = base.mSimContext.mService.mAttributeService as RuntimeAttributeService;
				m_attributeID = runtimeAttributeService.TryGetAttributeIDByEntityID(m_entityIDInput.value);
				if (m_attributeID == -1)
				{
					flag = false;
				}
			}
			else if (entityWithEntityID.hasEntityBlackboard)
			{
				m_attributeID = entityWithEntityID.entityBlackboard.var.mAttributeID;
			}
			else
			{
				flag = false;
			}
			if (flag)
			{
				m_out.Call(f);
			}
			else
			{
				m_error.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
		AddValueOutput("黑板ID", "attributeID", () => m_attributeID);
	}
}
