using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("增加修正模式中的伤害累积(逻辑)", 0)]
[Category("Logic/SourceSpace")]
[Description("记录修正模式中累积受到的全部伤害(仅减少值记录)")]
public class AddSourceSpaceDamage : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private ValueInput<long> m_addValueInput;

	private ValueInput<int> m_damagePecInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_addValueInput = AddValueInput<long>("增量(负数有效)", "addValue");
		m_damagePecInput = AddValueInput<int>("伤害百分比", "damagePec").SetDefaultAndSerializedValue(50);
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			long value = m_addValueInput.GetValue();
			SimEntity simEntity;
			if (value >= 0)
			{
				m_error.Call(f);
			}
			else if (!CommonProcessor.TryGetAliveRole(base.mSimContext, m_entityIDInput.GetValue(), out simEntity))
			{
				m_error.Call(f);
			}
			else if (!simEntity.hasEntityExposedValueBreak)
			{
				m_error.Call(f);
			}
			else
			{
				simEntity.entityExposedValueBreak.Damage += value * m_damagePecInput.GetValue() / 100;
				m_out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
	}
}
