using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("清除怒气机制值获得标志(逻辑)", 0)]
[Category("Logic/Abilities")]
[Description("")]
public class CleanRageAddedFlag : FlowControlNode
{
	public int varName = 100010101;

	private ValueInput<int> m_entityIDInput;

	private FlowOutput m_succeeded;

	private FlowOutput m_failed;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_succeeded = AddFlowOutput("成功", "succeeded");
		m_failed = AddFlowOutput("失败", "failed");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(m_entityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityConfig)
			{
				m_error.Call(f);
			}
			else if (ConfigHelper.GetInstance().GetConfig<charactor_param>(entityWithEntityID.entityConfig.mId).EnergyType != 1)
			{
				m_error.Call(f);
			}
			else
			{
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, varName, 0L, 0L, 0L);
				m_succeeded.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
	}
}
