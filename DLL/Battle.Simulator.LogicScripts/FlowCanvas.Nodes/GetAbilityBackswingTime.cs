using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到Ability后摇时间点(逻辑)", 0)]
[Category("Logic/Config")]
[Description("返回第一个后摇的时间点，包含技能后摇、可移动后摇、可移动锁定后摇")]
public class GetAbilityBackswingTime : FlowControlNode
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
		m_Out = AddFlowOutput("Out", "output");
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
					AbilityStageClass abilityStageClass = (AbilityStageClass)(abilityStateInfo.AbilityStateIndex % 100);
					if (abilityStageClass == AbilityStageClass.CastBackswing || abilityStageClass == AbilityStageClass.CastMoveswing || abilityStageClass == AbilityStageClass.CastMoveLockBackswing)
					{
						m_Length = abilityStateInfo.Start;
						break;
					}
				}
				m_Out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_EntityIDInput.GetValue());
		AddValueOutput("后三位", "actionID", () => m_ActionIDInput.GetValue());
		AddValueOutput("时长", "length", () => m_Length);
	}

	public static bool TryGetCastBackswingPoint(Timeline timeline, out int point)
	{
		point = timeline.Duration;
		for (int i = 0; i < timeline.AbilityStateInfoList.Count; i++)
		{
			AbilityStateInfo abilityStateInfo = timeline.AbilityStateInfoList.get_Item(i);
			AbilityStageClass abilityStageClass = (AbilityStageClass)(abilityStateInfo.AbilityStateIndex % 100);
			if (abilityStageClass == AbilityStageClass.CastBackswing || abilityStageClass == AbilityStageClass.CastMoveswing || abilityStageClass == AbilityStageClass.CastMoveLockBackswing)
			{
				point = abilityStateInfo.Start;
				return true;
			}
		}
		return false;
	}
}
