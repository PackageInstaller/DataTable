using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到技能阶段时间点(逻辑)", 0)]
[Category("Logic/Config")]
[Description("尝试得到对应Ability阶段的开始时间点;\n对应: Source\\动作ID与AbilityState\\AbilityState\\e_Ability_Stage_Class_动作阶段.csv 表中的配置")]
public class GetAbilityBackswingTime2 : FlowControlNode
{
	private ValueInput<int> m_EntityIDInput;

	private ValueInput<int> m_ActionIDInput;

	private FlowOutput m_Out;

	private FlowOutput m_Error;

	private int m_Length;

	protected override void RegisterPorts()
	{
		m_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_ActionIDInput = AddValueInput<int>("后三位", "actionID");
		ValueInput<AbilityStageClass> stageClassInput = AddValueInput<AbilityStageClass>("行为阶段", "stageClass");
		m_Out = AddFlowOutput("Out", "output");
		FlowOutput _unFoundOut = AddFlowOutput("未找到", "unFound");
		m_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			int id = (int)base.mSimContext.GetEntityWithEntityID(m_EntityIDInput.GetValue()).ENTITY_CONFIG_ID * 1000 + m_ActionIDInput.GetValue();
			Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(id);
			if (config == null)
			{
				m_Error.Call(f);
			}
			else
			{
				m_Length = config.Duration;
				for (int i = 0; i < config.AbilityStateInfoList.Count; i++)
				{
					AbilityStateInfo abilityStateInfo = config.AbilityStateInfoList.get_Item(i);
					if (abilityStateInfo.AbilityStateIndex % 100 == (int)stageClassInput.value)
					{
						m_Length = abilityStateInfo.Start;
						m_Out.Call(f);
						return;
					}
				}
				_unFoundOut.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_EntityIDInput.GetValue());
		AddValueOutput("后三位", "actionID", () => m_ActionIDInput.GetValue());
		AddValueOutput("时长", "length", () => m_Length);
	}
}
