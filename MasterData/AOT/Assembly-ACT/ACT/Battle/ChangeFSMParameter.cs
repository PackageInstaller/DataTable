using ACT.Battle.Configs;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
[TaskDescription("给entity的状态机参数赋值，方便维护建议用SharedString变量传参")]
public class ChangeFSMParameter : Action
{
	protected Entity m_Entity;

	public string name;

	public bool useSharedValue;

	public SharedString FSMParameter;

	public ConfigAnimParameterType type;

	public float defaultFloat;

	public int defaultInt;

	public bool defaultBool;

	public override void OnStart()
	{
		m_Entity = ((ActBehaviorTree)Owner).Entity;
	}

	public override TaskStatus OnUpdate()
	{
		if (useSharedValue)
		{
			switch (type)
			{
			case ConfigAnimParameterType.Float:
				m_Entity.SetFloat(FSMParameter.Value, defaultFloat);
				break;
			case ConfigAnimParameterType.Int:
				m_Entity.SetInt(FSMParameter.Value, defaultInt);
				break;
			case ConfigAnimParameterType.Bool:
				m_Entity.SetBool(FSMParameter.Value, defaultBool);
				break;
			case ConfigAnimParameterType.Trigger:
				m_Entity.SetTrigger(FSMParameter.Value);
				break;
			}
		}
		else
		{
			switch (type)
			{
			case ConfigAnimParameterType.Float:
				m_Entity.SetFloat(name, defaultFloat);
				break;
			case ConfigAnimParameterType.Int:
				m_Entity.SetInt(name, defaultInt);
				break;
			case ConfigAnimParameterType.Bool:
				m_Entity.SetBool(name, defaultBool);
				break;
			case ConfigAnimParameterType.Trigger:
				m_Entity.SetTrigger(name);
				break;
			}
		}
		return TaskStatus.Success;
	}
}
