using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

namespace BilliardGame.Runtime;

public class BilliardGamePhysicalBullet : BilliardGameBall
{
	protected float bulletRadius = 0.2f;

	public override void Init()
	{
		hitColliderList = new HashSet<Collider2D>();
		base.isShooting = false;
		rb = GetComponent<Rigidbody2D>();
		col = GetComponent<Collider2D>();
		object[] array = LuaHelper.CallFunction("GetBilliardGameCriticalSpeed");
		if (array != null && array.Length != 0)
		{
			object[] array2 = (array[0] as LuaTable).ToArray();
			normalDrag = (float)(double)array2[0];
			dragUpSpeed = (float)(double)array2[1];
			upDrag = (float)(double)array2[2];
			criticalSpeed = (float)(double)array2[3];
		}
		rb.mass = BilliardGameLogicManager.Instance.defaultMass;
	}

	public new void FixedUpdate()
	{
		if (base.isShooting)
		{
			CheckVelocityChangeBuff();
			if (isIgnoreEnemyCollision)
			{
				OnIgnoreEnemyCollision();
			}
		}
		if (rb.velocity.magnitude < criticalSpeed)
		{
			if (!base.isShooting && !readyShoot)
			{
				rb.velocity = Vector2.zero;
			}
			else if (readyShoot)
			{
				readyShoot = false;
				base.isShooting = true;
				rb.velocity = shootInfo;
			}
			else if (BilliardGameLogicManager.Instance.turnState == TurnState.PlayerAttackPhase)
			{
				rb.mass = BilliardGameLogicManager.Instance.defaultMass;
				base.isShooting = false;
				rb.velocity = Vector2.zero;
			}
		}
	}

	public override void InitNowPlayer()
	{
		rb.drag = normalDrag;
		nowPlayer = BilliardGameLogicManager.Instance.GetEntityPhysicalBullet(base.entityID);
		isIgnoreEnemyCollision = (nowPlayer as EntityPhysicalBullet).isIgnoreEnemyCollision;
		speedChangeBuffDic = (nowPlayer as EntityPhysicalBullet).SpeedChangeBuff;
		if (lastSpeedChangeByThreshold == null)
		{
			lastSpeedChangeByThreshold = new Dictionary<int, float>();
		}
	}

	public override void ShootBall(Vector3 dir, float force)
	{
		InitNowPlayer();
		CheckIgnoreCollision();
		readyShoot = true;
		rb.mass = BilliardGameLogicManager.Instance.shootingMass;
		float b = 2f;
		if (dir != Vector3.zero)
		{
			dir = dir.normalized * Mathf.Max(dir.magnitude, b);
		}
		shootInfo = dir * force * speedRatio * 0.1f;
		lastSpeedChangeByThreshold.Clear();
		speedRatio = 1f;
	}

	public override void CheckIgnoreCollision()
	{
		foreach (EntityEnemy allEnemyEntity in BilliardGameLogicManager.Instance.GetAllEnemyEntityList())
		{
			Collider2D component = allEnemyEntity.go.GetComponent<Collider2D>();
			Physics2D.IgnoreCollision(col, component, isIgnoreEnemyCollision);
		}
	}

	public override void OnHighSpeedPenetrate(Collider2D othercol)
	{
		othercol.transform.TryGetComponent<BilliardGameBehaviorBase>(out var component);
		if (component != null && component is BilliardGameEnemy)
		{
			BilliardGameLogicManager.Instance.DoPhysicalBulletHitEnemy(base.entityID, component.entityID);
			BilliardGameLogicManager.Instance.DoPhysicalBulletPenetrateEnemy(base.entityID, component.entityID);
		}
	}

	public override void CheckPererateExit()
	{
		removeList.Clear();
		foreach (Collider2D hitCollider in hitColliderList)
		{
			bool flag = false;
			for (int i = 0; i < lastOverlapCount; i++)
			{
				if (overlapResults[i] == hitCollider)
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				removeList.Add(hitCollider);
			}
		}
		foreach (Collider2D remove in removeList)
		{
			if (remove != null)
			{
				hitColliderList.Remove(remove);
				remove.transform.TryGetComponent<BilliardGameBehaviorBase>(out var component);
				if (component is BilliardGameEnemy)
				{
					BilliardGameLogicManager.Instance.DoPhysicalBulletPenetrateEnemy(base.entityID, component.entityID);
				}
			}
		}
	}

	public override void CheckPererateEnter()
	{
		for (int i = 0; i < lastOverlapCount; i++)
		{
			Collider2D collider2D = overlapResults[i];
			if (collider2D != null && !hitColliderList.Contains(collider2D))
			{
				collider2D.transform.TryGetComponent<BilliardGameBehaviorBase>(out var component);
				if (component is BilliardGameEnemy)
				{
					hitColliderList.Add(collider2D);
					BilliardGameLogicManager.Instance.DoPhysicalBulletHitEnemy(base.entityID, component.entityID);
				}
			}
		}
	}

	public void ClearVelocity()
	{
		rb.velocity = Vector3.zero;
	}

	public bool CheckStop()
	{
		return rb.velocity.magnitude <= 0.1f;
	}

	private void OnCollisionEnter2D(Collision2D collision)
	{
		if (BilliardGameLogicManager.Instance.IsOver || collision == null || BilliardGameLogicManager.Instance.turnState != TurnState.PlayerAttackPhase)
		{
			return;
		}
		collision.transform.TryGetComponent<BilliardGameBehaviorBase>(out var component);
		if (component != null)
		{
			if (component is BilliardGameEnemy)
			{
				BilliardGameLogicManager.Instance.DoPhysicalBulletHitEnemy(base.entityID, component.entityID);
			}
			if (component is BilliardGameMechanism)
			{
				BilliardGameLogicManager.Instance.DoPhysicalBulletHitMechanism(base.entityID, component.entityID);
			}
		}
	}

	private void OnTriggerEnter2D(Collider2D collision)
	{
		if (!BilliardGameLogicManager.Instance.IsOver && !(collision == null) && BilliardGameLogicManager.Instance.turnState == TurnState.PlayerAttackPhase && collision.transform.TryGetComponent<BilliardGameMechanism>(out var component))
		{
			BilliardGameLogicManager.Instance.DoPhysicalBulletHitMechanism(base.entityID, component.entityID);
		}
	}
}
