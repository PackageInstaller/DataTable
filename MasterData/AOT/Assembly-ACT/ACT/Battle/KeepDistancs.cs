using ACT.Battle.Configs;
using ACT.MultiPlayer;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/废弃节点")]
[TaskDescription("地面敌人与仇恨目标保持一个相对距离，参数多具体见文档—— ‘各种移动节点’")]
public class KeepDistancs : Action
{
	public SharedGroundEnemyUpdatePos attackToken;

	public SharedGroundEnemyUpdatePos noAttackToken;

	private Entity m_Entity;

	private CompNav m_CompNav;

	private EnemyUpdatePos haveTokenUpdatePos;

	private EnemyUpdatePos dontHaveTokenUpdatePos;

	private Vector2 CD;

	private float curTime;

	private bool canmove = true;

	private Vector3 hatredPos;

	private Vector3 m_pos;

	private float realDis;

	private bool left;

	private bool disupdated;

	private float moveTime;

	private float dis;

	private float tempsize = 0.2f;

	private bool m_BackMove;

	private const string MOVE_BACK = "move_back";

	public override void OnStart()
	{
		m_Entity = ((ActBehaviorTree)Owner).Entity;
		ConfigCharacter config = m_Entity.GetConfig();
		m_CompNav = m_Entity.GetCompNav();
		Vector2 waitTimeRandomRange = GameLoader.meta.enemyInfo.waitTimeRandomRange;
		CD.x = Random.Range(waitTimeRandomRange.x, waitTimeRandomRange.y);
		CD.y = CD.x;
		disupdated = false;
		dis = 0f;
		if (attackToken.Value != null)
		{
			haveTokenUpdatePos.minHoldDis = attackToken.Value.groundMinHoldDis;
			haveTokenUpdatePos.maxHoldDis = attackToken.Value.groundMaxHoldDis;
			haveTokenUpdatePos.minUpdateDis = attackToken.Value.groundMinUpdateDis;
			haveTokenUpdatePos.maxUpdateDis = attackToken.Value.groundMaxHoldDis;
		}
		else
		{
			haveTokenUpdatePos = default;
		}
		if (noAttackToken.Value != null)
		{
			dontHaveTokenUpdatePos.minHoldDis = noAttackToken.Value.groundMinHoldDis;
			dontHaveTokenUpdatePos.maxHoldDis = noAttackToken.Value.groundMaxHoldDis;
			dontHaveTokenUpdatePos.minUpdateDis = noAttackToken.Value.groundMinUpdateDis;
			dontHaveTokenUpdatePos.maxUpdateDis = noAttackToken.Value.groundMaxUpdateDis;
		}
		else
		{
			dontHaveTokenUpdatePos = default;
		}
		for (int i = 0; i < config.moveMotions.Length; i++)
		{
			OverrideMotion overrideMotion = config.moveMotions[i];
			if (overrideMotion.motion != null && overrideMotion.motion.name == "move_back" && !overrideMotion.IsForbidden)
			{
				m_BackMove = true;
			}
		}
	}

	public override TaskStatus OnUpdate()
	{
		return TaskStatus.Running;
	}

	public void moveFunc(EnemyUpdatePos updatePos)
	{
		hatredPos = m_Entity.GetCompHatred().hatredTarget.GetCompTransform().physicsPosition;
		m_pos = m_Entity.GetCompTransform().physicsPosition;
		realDis = Mathf.Abs(hatredPos.x - m_pos.x);
		dis = Mathf.Max(dis, GameLoader.meta.enemyInfo.enemyMinMoveDis);
		if (dis == 0f)
		{
			dis = Random.Range(updatePos.minHoldDis, updatePos.maxHoldDis);
			canmove = true;
		}
		if (curTime - CD.y >= CD.x)
		{
			if (!disupdated && (realDis > updatePos.maxUpdateDis || realDis < updatePos.minUpdateDis))
			{
				dis = Random.Range(updatePos.minHoldDis, updatePos.maxHoldDis);
				disupdated = true;
				moveTime = 0f;
			}
			else
			{
				if (!canmove && !(realDis > updatePos.maxUpdateDis) && !(realDis < updatePos.minUpdateDis))
				{
					return;
				}
				if (Move2Pos(dis, updatePos))
				{
					disupdated = false;
					canmove = false;
					moveTime = 0f;
					CD.y = curTime + Random.Range(0.1f, 0.5f);
					CD.x = Random.Range(GameLoader.meta.enemyInfo.waitTimeRandomRange.x, GameLoader.meta.enemyInfo.waitTimeRandomRange.y);
					return;
				}
				moveTime += Time.deltaTime;
				CompAI compAI = m_Entity.GetCompAI();
				if (moveTime > GameLoader.meta.enemyInfo.loseAttackTokenTimeByMove && compAI.hasAttackToken && m_Entity.GetEntityType() == EntityType.Monster && compAI.groupUid != -1)
				{
					compAI.hasAttackToken = false;
					disupdated = false;
					canmove = false;
					moveTime = 0f;
					CD.y = curTime;
					CD.x = Random.Range(GameLoader.meta.enemyInfo.waitTimeRandomRange.x, GameLoader.meta.enemyInfo.waitTimeRandomRange.y);
				}
				disupdated = true;
				canmove = true;
			}
		}
		else
		{
			m_Entity.SetBool("move_back", value: false);
			m_Entity.SetBool("Move", value: false);
		}
	}

	public bool Move2Pos(float keepDistance, EnemyUpdatePos updatePos)
	{
		if (Mathf.Abs(keepDistance - realDis) < GameLoader.meta.enemyInfo.enemyStopMoveDisRange)
		{
			m_Entity.SetBool("move_back", value: false);
			m_Entity.SetBool("Move", value: false);
			return true;
		}
		if (realDis < keepDistance)
		{
			Vector3 attachPointPosition = m_Entity.GetMono().GetAttachPointPosition(BattleConsts.AIM_ATTACH_POINT);
			CompTransform compTransform = m_Entity.GetCompTransform();
			bool flag = compTransform.FaceDir == FaceDir.Left;
			attachPointPosition.x += (flag ? (compTransform.size.x - tempsize) : (0f - compTransform.size.x + tempsize));
			Vector3 direction = (flag ? (attachPointPosition + Vector3.left) : (attachPointPosition + Vector3.right));
			if (!Physics.Raycast(attachPointPosition, direction, 1f, BattleConsts.enviromentMask) && m_BackMove)
			{
				m_Entity.SetBool("move_back", value: true);
				m_Entity.SetBool("Move", value: true);
			}
			else
			{
				m_Entity.SetBool("move_back", value: false);
				m_Entity.SetBool("Move", value: false);
			}
		}
		else if (realDis > keepDistance)
		{
			Vector3 attachPointPosition2 = m_Entity.GetMono().GetAttachPointPosition(BattleConsts.AIM_ATTACH_POINT);
			CompTransform compTransform2 = m_Entity.GetCompTransform();
			bool flag2 = compTransform2.FaceDir == FaceDir.Left;
			attachPointPosition2.x += (flag2 ? (0f - compTransform2.size.x + tempsize) : (compTransform2.size.x - tempsize));
			Vector3 direction2 = (flag2 ? (attachPointPosition2 + Vector3.left) : (attachPointPosition2 + Vector3.right));
			if (!Physics.Raycast(attachPointPosition2, direction2, 1f, BattleConsts.enviromentMask))
			{
				m_Entity.SetBool("move_back", value: false);
				m_Entity.SetBool("Move", value: true);
			}
			else
			{
				m_Entity.SetBool("move_back", value: false);
				m_Entity.SetBool("Move", value: false);
			}
		}
		return false;
	}

	public override void OnEnd()
	{
		m_CompNav.isStopped = true;
		m_Entity.SetBool("move_back", value: false);
		m_Entity.SetBool("Move", value: false);
	}
}
