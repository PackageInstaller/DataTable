using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("清除豆子机制值获得标志(技能)(逻辑)", 0)]
[Category("Logic/Abilities")]
[Description("")]
public class ClearMarkAddedFlag : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private ValueInput<int> m_actionIDInput;

	private ValueInput<int> m_abilityIDInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_actionIDInput = AddValueInput<int>("后三位", "actionID");
		m_abilityIDInput = AddValueInput<int>("TimelineID(过时)", "timelineID");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(m_entityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard || !entityWithEntityID.hasEntityConfig)
			{
				m_error.Call(f);
			}
			else if (ConfigHelper.GetInstance().GetConfig<charactor_param>(entityWithEntityID.ENTITY_CONFIG_ID).EnergyType != 3)
			{
				m_error.Call(f);
			}
			else
			{
				int abilityID = m_abilityIDInput.GetValue();
				if (abilityID == 0 && !CommonProcessor.TryGetAbilityID(entityWithEntityID, m_actionIDInput.GetValue(), out abilityID))
				{
					m_error.Call(f);
				}
				else
				{
					int index = -1;
					if (!ConfigProcessor.TryGetSkillIndex(entityWithEntityID, abilityID, out index))
					{
						m_error.Call(f);
					}
					else
					{
						switch (index)
						{
						case 0:
							index = 100020101;
							break;
						case 1:
							index = 100020201;
							break;
						case 2:
							index = 100020301;
							break;
						default:
							m_error.Call(f);
							return;
						}
						AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, index, 0L, 0L, 0L);
						m_out.Call(f);
					}
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
	}
}
