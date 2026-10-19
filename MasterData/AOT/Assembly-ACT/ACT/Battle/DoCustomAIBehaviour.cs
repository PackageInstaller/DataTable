using ACT.Battle.Configs;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT")]
[TaskDescription("执行自定义行为")]
public class DoCustomAIBehaviour : Action
{
	public SharedString allBehaviourList;

	private Entity m_Entity;

	private string committedActionName;

	public override void OnStart()
	{
		m_Entity = ((ActBehaviorTree)Owner).Entity;
		if (!m_Entity.IsValid || !m_Entity.GetCompAI().TryCommitAttackRequest(out var request))
		{
			committedActionName = string.Empty;
			return;
		}
		committedActionName = request.behaviourName;
		CompMotion? compMotion = m_Entity.GetCompMotion();
		compMotion.SetBool(committedActionName, b: true);
		compMotion.SetTrigger("UseSkill");
		m_Entity.GetCompAI().behaviorDepth = 0;
	}

	public override TaskStatus OnUpdate()
	{
		if (string.IsNullOrEmpty(committedActionName))
		{
			return TaskStatus.Failure;
		}
		CompMotion compMotion = m_Entity.GetCompMotion();
		compMotion.parameters.TryGetValue("UseSkill", out var value);
		if (!value.defaultBool && compMotion.curMotionState != MotionState.Attack)
		{
			return TaskStatus.Success;
		}
		if (compMotion.curMotionState == MotionState.Hit)
		{
			m_Entity.ResetTrigger("UseSkill");
			return TaskStatus.Success;
		}
		compMotion.SetBool(committedActionName, b: true);
		return TaskStatus.Running;
	}

	public override void OnEnd()
	{
		if (!string.IsNullOrEmpty(committedActionName))
		{
			m_Entity.GetCompMotion().SetBool(committedActionName, b: false);
			m_Entity.GetCompAI().ReleaseAttackBody(committedActionName);
			committedActionName = string.Empty;
		}
	}
}
