using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到奥义值配置(逻辑)", 0)]
[Category("Logic/Config")]
[Description("得到奥义值配置")]
public class GetUniqueSkillEnergyConfigValue : FlowControlNode
{
	private ValueInput<int> m_EntityIDInput;

	private ValueInput<int> m_ActionIDInput;

	private FlowOutput m_Out;

	private FlowOutput m_Error;

	private int _upperLimit;

	private int _baseAddValue;

	private int _tick;

	private int _additionaleValue;

	protected override void RegisterPorts()
	{
		m_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_Out = AddFlowOutput("Out", "output");
		m_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(m_EntityIDInput.GetValue());
			UniqueSkill config;
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				m_Error.Call(f);
			}
			else if (!ConfigHelper.GetInstance().TryGetConfig<UniqueSkill>(entityWithEntityID.entityConfig.mId, out config))
			{
				m_Error.Call(f);
			}
			else
			{
				_upperLimit = config.UpperLimit;
				_baseAddValue = config.BaseAddValue;
				_tick = config.Tick;
				_additionaleValue = config.AdditionalValue;
				m_Out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_EntityIDInput.GetValue());
		AddValueOutput("后三位", "actionID", () => m_ActionIDInput.GetValue());
		AddValueOutput("上限值（毫）", "UpperLimit", () => _upperLimit);
		AddValueOutput("基础增量（毫）", "baseAddValue", () => _baseAddValue);
		AddValueOutput("间隔（毫秒）", "tick", () => _tick);
		AddValueOutput("额外加成值（毫）", () => _additionaleValue);
	}
}
