using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否是技能(包括子技能)", 0)]
[Category("Logic/Ability")]
[Description("判断是否为技能,对应 RoleConfig 中的 AllSkills 字段\n抛掷物ID不为0时以抛掷物TimelineID或其根源TimelineID为准\n输出的TimelineID仅传递输入值")]
public class IsInAllAbilitys2 : FlowControlNode
{
	private FlowOutput m_true;

	private FlowOutput m_false;

	private FlowOutput m_error;

	private ValueInput<int> m_entityIDInput;

	private ValueInput<int> m_timelineIDInput;

	private ValueInput<bool> m_isBannedUltimateSkill;

	private ValueInput<int> m_thrownIDInput;

	protected override void RegisterPorts()
	{
		m_true = AddFlowOutput("True", "true");
		m_false = AddFlowOutput("False", "false");
		m_error = AddFlowOutput("Error", "error");
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_timelineIDInput = AddValueInput<int>("TimelineID", "timelineIDInput");
		m_isBannedUltimateSkill = AddValueInput<bool>("过滤奥义", "isBannedUltimateSkill").SetDefaultAndSerializedValue(v: false);
		m_thrownIDInput = AddValueInput<int>("抛掷物ID(可选)", "thrownID");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			int num = 0;
			int id = 0;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(m_entityIDInput.value);
			if (m_thrownIDInput.value != 0 && ThrownProcessor.TryGetThrown(base.mSimContext, m_thrownIDInput.value, out var thrownState))
			{
				if (entityWithEntityID != null)
				{
					id = entityWithEntityID.entityConfig.mId;
				}
				num = thrownState.mCreatedRootTimelineID;
				if (!ConfigHelper.GetInstance().TryGetConfig<RoleConfig>(id, out var config))
				{
					m_error.Call(f);
					return;
				}
				if (config.AllSkills.Contains(thrownState.mAbilityID) || config.AllSkills.Contains(num))
				{
					UniqueSkill config2;
					if (!m_isBannedUltimateSkill.value)
					{
						m_true.Call(f);
					}
					else if (!ConfigHelper.GetInstance().TryGetConfig<UniqueSkill>(id, out config2))
					{
						m_error.Call(f);
					}
					else if (config2.Projectiles.Contains(thrownState.mAbilityID) || config2.AbilityId.Contains(num))
					{
						m_false.Call(f);
					}
					else
					{
						m_true.Call(f);
					}
					return;
				}
			}
			if (!ConfigHelper.GetInstance().TryGetConfig<RoleConfig>(m_timelineIDInput.value / 1000, out var config3))
			{
				m_error.Call(f);
			}
			else if (m_isBannedUltimateSkill.value && CommonProcessor.IsInUniqueSkillABility(entityWithEntityID, m_timelineIDInput.value))
			{
				m_false.Call(f);
			}
			else if (config3.AllSkills.Contains(m_timelineIDInput.GetValue()))
			{
				m_true.Call(f);
			}
			else
			{
				m_false.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
		AddValueOutput("TimelineID", "timelineID", () => m_timelineIDInput.GetValue());
	}
}
