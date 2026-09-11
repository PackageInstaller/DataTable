using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("激活逻辑输入", 0)]
[Category("Logic/Abilities")]
[Description("将本次输入激活并可选销毁,默认销毁;\n可用于接在输入【逻辑输入事件】后面进行处理;\n如果找不到实体或者实体无输入,则走error流")]
public class ActiveManualInput : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private ValueInput<bool> m_destroyInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_destroyInput = AddValueInput<bool>("销毁输入", "destroy").SetDefaultAndSerializedValue(v: true);
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(m_entityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityActionManualInput)
			{
				m_error.Call(f);
			}
			else
			{
				entityWithEntityID.entityActionManualInput.mStatus = EntityActionStatus.E_ACTIVE;
				entityWithEntityID.entityActionManualInput.mCanDestroy = m_destroyInput.GetValue();
				m_out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
	}
}
