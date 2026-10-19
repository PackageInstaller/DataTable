using System;
using ACT.Battle.Configs;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT")]
[TaskDescription("在动作执行结算时返回success，否则running\n勾选useSharedInt则会执行sharedSkillIndex的技能\n不勾选useSharedInt则会执行skillIndex的技能")]
public class UseSkill : BehaviorDesigner.Runtime.Tasks.Action
{
	public bool useSharedInt = true;

	public SharedInt sharedSkillIndex;

	[Obsolete]
	[BehaviorDesigner.Runtime.Tasks.Tooltip("别用这个了，勾上shared int，用shared int")]
	public int skillIndex;

	public bool postSwingOut;

	private bool m_Running;

	private Entity m_Baheve;

	private int m_SkillIndex;

	[BehaviorDesigner.Runtime.Tasks.Tooltip("是否是攻击技能")]
	public bool isAttackSkill = true;

	public override void OnStart()
	{
		m_Baheve = (Owner as ActBehaviorTree)?.Entity ?? default(Entity);
		if (isAttackSkill)
		{
			m_Baheve.GetCompAI().lastAttackTime = Time.time;
		}
		if (useSharedInt)
		{
			m_SkillIndex = sharedSkillIndex.Value;
		}
		else
		{
			m_SkillIndex = skillIndex;
		}
		CompMotion? compMotion = m_Baheve.GetCompMotion();
		compMotion.SetInt("SkillIndex", m_SkillIndex);
		compMotion.SetTrigger("UseSkill");
		m_Running = false;
	}

	public override TaskStatus OnUpdate()
	{
		CompMotion compMotion = m_Baheve.GetCompMotion();
		if (compMotion.curMotionState == MotionState.Hit && m_Running)
		{
			return TaskStatus.Failure;
		}
		int continueousSkillMark = compMotion.layer0PeakConfig.continueousSkillMark;
		compMotion.parameters.TryGetValue("UseSkill", out var value);
		if (!value.defaultBool && continueousSkillMark != m_SkillIndex)
		{
			return TaskStatus.Success;
		}
		if (!m_Running && continueousSkillMark == m_SkillIndex)
		{
			m_Running = true;
		}
		if (m_Running && continueousSkillMark != m_SkillIndex)
		{
			if (isAttackSkill)
			{
				m_Baheve.GetCompAI().lastAttackTime = Time.time;
			}
			return TaskStatus.Success;
		}
		return TaskStatus.Running;
	}
}
