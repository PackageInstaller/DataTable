using ACT.Battle.Configs;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/待定要好好想想的")]
[TaskDescription("检查entity的状态机参数，一致为success，反之为failure，方便维护建议用SharedString变量传参")]
public class CheckFSMParameter : Conditional
{
	public string name;

	public bool useSharedValue;

	public SharedString FSMParameter;

	public ConfigAnimParameterType type;

	public float defaultFloat;

	public int defaultInt;

	public bool defaultBool;

	private Entity m_Entity;

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
				if (Mathf.Approximately(m_Entity.GetMotionFloat(FSMParameter.Value), defaultFloat))
				{
					return TaskStatus.Success;
				}
				break;
			case ConfigAnimParameterType.Int:
				if (Mathf.Approximately(m_Entity.GetMotionInt(FSMParameter.Value), defaultInt))
				{
					return TaskStatus.Success;
				}
				break;
			case ConfigAnimParameterType.Bool:
				if (m_Entity.GetMotionBool(FSMParameter.Value) == defaultBool)
				{
					return TaskStatus.Success;
				}
				break;
			}
		}
		else
		{
			switch (type)
			{
			case ConfigAnimParameterType.Float:
				if (Mathf.Approximately(m_Entity.GetMotionFloat(name), defaultFloat))
				{
					return TaskStatus.Success;
				}
				break;
			case ConfigAnimParameterType.Int:
				if (Mathf.Approximately(m_Entity.GetMotionInt(name), defaultInt))
				{
					return TaskStatus.Success;
				}
				break;
			case ConfigAnimParameterType.Bool:
				if (m_Entity.GetMotionBool(name) == defaultBool)
				{
					return TaskStatus.Success;
				}
				break;
			}
		}
		return TaskStatus.Failure;
	}
}
