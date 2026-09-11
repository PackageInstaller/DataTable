using System.Collections.Generic;
using BilliardGame.Runtime;
using UnityEngine;

namespace BilliardGame.Spell;

public class BTShootBall : BActionNode
{
	public string prefabPath;

	public Vector3 dir;

	public float speed;

	public int atk;

	public int colNum;

	public int buffID;

	public int bulletNum = 1;

	public int angle = 1;

	public string effectName;

	public string dieAudio;

	public int triggerRatio;

	public bool isInheritBuff;

	private int addBulletNum;

	public override BTNodeStatus Run(BTEnv env)
	{
		if (BilliardGameLogicManager.Instance.GetAllPhysicalBulletEntityList().Count >= 160)
		{
			return BTNodeStatus.Success;
		}
		if (Random.Range(0, 100) > triggerRatio)
		{
			return BTNodeStatus.Success;
		}
		if (env.ContainKey("damage"))
		{
			atk += env.GetStruct<int>("damage");
		}
		if (env.ContainKey("penerate_add_bullet"))
		{
			addBulletNum = env.GetStruct<int>("penerate_add_bullet");
		}
		Vector3 targetPos;
		if (env.ContainKey("shootDir"))
		{
			targetPos = env.GetStruct<Vector3>("shootDir");
		}
		else if (env.ContainKey("TargetEntity") && env.ContainKey("Caster"))
		{
			targetPos = env.GetPlayer<BilliardGameEntityBase>("TargetEntity").position - env.GetPlayer<BilliardGameEntityBase>("Caster").position;
		}
		else if (dir != Vector3.zero)
		{
			targetPos = dir;
		}
		else
		{
			if (!(env.GetPlayer<BilliardGameEntityBase>("Caster") is EntityEnemy))
			{
				return BTNodeStatus.Failure;
			}
			EntityEnemy entityEnemy = env.GetPlayer<BilliardGameEntityBase>("Caster") as EntityEnemy;
			Vector3 vector = BilliardGameLogicManager.Instance.GetNearestPlayer(entityEnemy.position)?.position ?? Vector3.zero;
			targetPos = vector - entityEnemy.position;
		}
		BilliardGameEntityBase billiardGameEntityBase = (env.ContainKey("Caster") ? env.GetPlayer<BilliardGameEntityBase>("Caster") : null);
		if (billiardGameEntityBase != null)
		{
			if (billiardGameEntityBase is EntityEnemy)
			{
				EntityEnemy enemy = env.GetPlayer<BilliardGameEntityBase>("Caster") as EntityEnemy;
				enemy.logic.BeforeAttackPredictShoot(targetPos, bulletNum, angle);
				FuncTimerManager.inst.CreateFuncTimer(delegate
				{
					Shoot(env, targetPos, enemy, atk);
				}, 0.5f, 1);
			}
			else if (billiardGameEntityBase is EntityPlayer)
			{
				int addHitRatioPercent = (billiardGameEntityBase as EntityPlayer).AddHitRatioPercent;
				int num = atk * addHitRatioPercent / 100;
				Shoot(env, targetPos, env.GetPlayer<BilliardGameEntityBase>("Caster"), num, isInheritBuff);
			}
			else
			{
				Shoot(env, targetPos, env.GetPlayer<BilliardGameEntityBase>("Caster"), atk);
			}
		}
		return BTNodeStatus.Success;
	}

	private void Shoot(BTEnv env, Vector3 targetPos, BilliardGameEntityBase owner, int atk, bool isInheritBuff = false)
	{
		if (owner is EntityEnemy)
		{
			(owner as EntityEnemy).logic.ClearAttackPredict();
		}
		EntityPlayer entityPlayer = owner as EntityPlayer;
		List<BTEnv> list = null;
		if ((entityPlayer != null) & isInheritBuff)
		{
			list = new List<BTEnv>(entityPlayer.GetAllBuff());
			int num = env.GetStruct<int>("BuffId");
			for (int num2 = list.Count - 1; num2 >= 0; num2--)
			{
				if (list[num2].GetStruct<int>("BuffId") == num)
				{
					list.RemoveAt(num2);
				}
			}
		}
		for (int i = 1; i <= bulletNum + addBulletNum; i++)
		{
			Vector3 vector = ((i == 1) ? targetPos : ((i % 2 != 0) ? (Quaternion.Euler(0f, 0f, -angle * ((i - 1) / 2)) * targetPos) : (Quaternion.Euler(0f, 0f, angle * (i / 2)) * targetPos)));
			GameObject gameObject = BilliardGameObjectPool.Instance.GetObject(prefabPath);
			gameObject.transform.position = owner.position;
			BilliardGamePhysicalBullet component = gameObject.GetComponent<BilliardGamePhysicalBullet>();
			int sourceBuffID = env.GetStruct<int>("BuffId");
			int entityID = BilliardGameLogicManager.Instance.CreatePhysicalBullet(gameObject, atk, colNum, buffID, sourceBuffID, owner, effectName, dieAudio);
			if (component != null)
			{
				component.SetEntityID(entityID);
			}
			if (entityPlayer != null)
			{
				EntityPhysicalBullet entityPhysicalBullet = BilliardGameLogicManager.Instance.GetEntityPhysicalBullet(entityID);
				if (list != null)
				{
					entityPhysicalBullet?.SetInheritedBuff(list);
				}
			}
			component.ShootBall(vector, speed);
		}
		addBulletNum = 0;
	}
}
