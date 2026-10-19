using ACT.Battle.Configs;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/Group")]
[TaskDescription("判断有了攻击权限后，没有达成特定条件就返还攻击权限")]
public class CheckWhetherCanAttack : Conditional
{
	private Entity m_Entity;

	private bool beforeHasAttackToken;

	private bool curHasAttackToken;

	private bool inHit;

	private float inHitTime;

	public bool inAttack;

	private float curlastAttackTime;

	private MotionState beforeMotionState;

	public override void OnStart()
	{
		m_Entity = ((ActBehaviorTree)Owner).Entity;
		beforeHasAttackToken = m_Entity.GetCompAI().HasAttackToken();
		inHit = false;
		inHitTime = 0f;
		curlastAttackTime = 4f;
		beforeMotionState = m_Entity.GetCompMotion().curMotionState;
	}

	public override TaskStatus OnUpdate()
	{
		CompHatred compHatred = m_Entity.GetCompHatred();
		CompTransform compTransform = compHatred.GetHatred().GetCompTransform();
		CompAI compAI = m_Entity.GetCompAI();
		CompTransform compTransform2 = m_Entity.GetCompTransform();
		CompMotion compMotion = m_Entity.GetCompMotion();
		if (compTransform == null)
		{
			return TaskStatus.Running;
		}
		if (compHatred.GetHatred().IsValid && compTransform != null)
		{
			compAI.hatredTargetDisX = Mathf.Abs(compTransform2.physicsPosition.x - compHatred.GetHatred().GetCompTransform().physicsPosition.x);
		}
		if (!compAI.HasGroupAIControl(m_Entity))
		{
			return TaskStatus.Success;
		}
		if (compAI.HasAttackToken())
		{
			if (inHit || compMotion.curMotionState == MotionState.Hit)
			{
				compAI.SetCanAttack(res: false);
				inHit = true;
				inHitTime += Time.deltaTime;
				if (compMotion.curMotionState == MotionState.Attack)
				{
					inHit = false;
					inHitTime = 0f;
				}
				if (inHitTime > GameLoader.meta.enemyInfo.loseAttackTokenTimeByHit)
				{
					inHitTime = 0f;
					inHit = false;
					compAI.SetAttackToken(res: false);
				}
			}
			else
			{
				inHitTime = 0f;
			}
			if (compMotion.curMotionState != MotionState.Attack && Time.time - compAI.lastAttackTime > curlastAttackTime)
			{
				compAI.SetAttackToken(res: false);
			}
		}
		else
		{
			compAI.SetCanAttack(res: true);
		}
		return TaskStatus.Running;
	}
}
