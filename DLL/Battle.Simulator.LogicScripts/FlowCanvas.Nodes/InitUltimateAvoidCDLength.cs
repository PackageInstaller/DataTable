using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("初始化闪避效果CD上限(逻辑)", 0)]
[Category("Logic/Attribute/闪避效果CD")]
[Description("对实体持有的闪避效果CD上限值进行增加,传入负数为减少")]
public class InitUltimateAvoidCDLength : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private ValueInput<int> m_addValueInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	private int m_ultimateAvoidCD;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_addValueInput = AddValueInput<int>("增量", "addValueInput");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			m_ultimateAvoidCD = 0;
			if (!CommonProcessor.TryGetAliveRole(base.mSimContext, m_entityIDInput.GetValue(), out var simEntity))
			{
				m_error.Call(f);
			}
			else
			{
				charactor_param config = ConfigHelper.GetInstance().GetConfig<charactor_param>(simEntity.ENTITY_CONFIG_ID);
				if (config == null)
				{
					m_error.Call(f);
				}
				else
				{
					m_ultimateAvoidCD = config.UltimateAvoidCD + m_addValueInput.GetValue();
					AttributeProcessor.TrySetUltimateAvoidCD(simEntity, m_ultimateAvoidCD);
					m_out.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
		AddValueOutput("闪避效果CD", "ultimateAvoidCD", () => m_ultimateAvoidCD);
	}
}
