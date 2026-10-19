using ACT.Battle.Configs;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/废弃")]
[TaskDescription("检查某个状态是否在某个状态机的子状态中")]
public class CheckStateMachines : Conditional
{
	public bool isCheckMoveMachine;

	public string stateMachineName;

	private Entity m_Entity;

	private ConfigMotionStateMachine m_MotionStateMachine;

	public override void OnAwake()
	{
		m_Entity = ((ActBehaviorTree)Owner).Entity;
		ConfigCharacter config = m_Entity.GetConfig();
		m_MotionStateMachine = (isCheckMoveMachine ? config.moveFSM : config.attackFSM);
	}

	public override TaskStatus OnUpdate()
	{
		string name = m_Entity.GetCompMotion().layer0Peak.state.value.name;
		ConfigAnimStateMachine[] stateMachines = m_MotionStateMachine.stateMachines;
		foreach (ConfigAnimStateMachine configAnimStateMachine in stateMachines)
		{
			if (!(configAnimStateMachine.name != stateMachineName))
			{
				int num = 0;
				if (num < configAnimStateMachine.sonStates.Length && configAnimStateMachine.sonStates[num] == name)
				{
					return TaskStatus.Success;
				}
			}
		}
		return TaskStatus.Failure;
	}
}
