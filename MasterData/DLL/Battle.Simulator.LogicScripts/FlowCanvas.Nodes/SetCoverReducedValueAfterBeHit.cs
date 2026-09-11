using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[修正模式]受击后调整临时减少值", 0)]
[Category("Logic/Attribute")]
[Description("该函数会调整修正恢复值的临时减少量,临时减少量存在期间,会使用该值作为修正恢复值进行处理")]
public class SetCoverReducedValueAfterBeHit : FlowControlNodeOfLogic
{
	private ValueInput<int> m_entityIDInput;

	private ValueInput<int> m_permillInput;

	private ValueInput<int> m_keepTime;

	private FlowOutput m_out;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_permillInput = AddValueInput<int>("千分之", "permill").SetDefaultAndSerializedValue(1);
		m_keepTime = AddValueInput<int>("持续时间(毫秒)", "keepTime").SetDefaultAndSerializedValue(5000);
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (!CommonProcessor.TryGetAliveRole(base.mSimContext, m_entityIDInput.GetValue(), out var simEntity))
			{
				m_error.Call(f);
			}
			else if (!simEntity.hasEntityExposedValue)
			{
				m_error.Call(f);
			}
			else
			{
				long newMReducedValue = simEntity.entityBlackboard.var.mMaxHP * m_permillInput.value / 1000;
				if (simEntity.hasEntityExposedValueCoverReducedValue)
				{
					simEntity.ReplaceEntityExposedValueCoverReducedValue(newMReducedValue, m_keepTime.value);
				}
				else
				{
					simEntity.AddEntityExposedValueCoverReducedValue(newMReducedValue, m_keepTime.value);
				}
				m_out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
	}
}
