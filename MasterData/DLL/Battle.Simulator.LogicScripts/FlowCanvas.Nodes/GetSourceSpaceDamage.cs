using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到修正模式内总伤害值(逻辑)", 0)]
[Category("Logic/SourceSpace")]
[Description("得到修正模式中累积受到的全部伤害(仅减少值记录)")]
public class GetSourceSpaceDamage : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	private long m_damage;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(m_entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityExposedValueBreak)
			{
				m_error.Call(f);
			}
			else
			{
				long damage = entityWithEntityID.entityExposedValueBreak.Damage;
				m_damage = -damage;
				m_out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
		AddValueOutput("伤害值", "damage", () => m_damage);
	}
}
