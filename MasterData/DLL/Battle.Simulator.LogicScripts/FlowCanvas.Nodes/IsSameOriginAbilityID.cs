using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否是相同源技能(逻辑)", 0)]
[Category("Logic/Config")]
[Description("判断传入的两个后三位是否是相同的源技能")]
public class IsSameOriginAbilityID : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private ValueInput<int> m_actionID1;

	private ValueInput<int> m_actionID2;

	private FlowOutput m_true;

	private FlowOutput m_false;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_actionID1 = AddValueInput<int>("后三位1", "actionID1");
		m_actionID2 = AddValueInput<int>("后三位2", "actionID2");
		m_true = AddFlowOutput("相同", "true");
		m_false = AddFlowOutput("不同", "false");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(m_entityIDInput.GetValue());
			if (entityWithEntityID == null)
			{
				m_error.Call(f);
			}
			else
			{
				int num = entityWithEntityID.entityConfig.mId * 1000 + m_actionID1.GetValue();
				AbilityConfig config = ConfigHelper.GetInstance().GetConfig<AbilityConfig>(num);
				if (config == null)
				{
					m_error.Call(f);
				}
				else
				{
					num = ((config.OriginAbility == 0) ? num : config.OriginAbility);
					if (m_actionID2.GetValue() == 0)
					{
						m_false.Call(f);
					}
					else
					{
						int num2 = entityWithEntityID.entityConfig.mId * 1000 + m_actionID2.GetValue();
						AbilityConfig config2 = ConfigHelper.GetInstance().GetConfig<AbilityConfig>(num2);
						if (config2 == null)
						{
							m_false.Call(f);
						}
						else
						{
							num2 = ((config2.OriginAbility == 0) ? num2 : config2.OriginAbility);
							if (num == num2)
							{
								m_true.Call(f);
							}
							else
							{
								m_false.Call(f);
							}
						}
					}
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
	}
}
