using BilliardGame.Runtime;
using UnityEngine;

namespace BilliardGame.Spell;

public class BTShootBullet : BActionNode
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

	public bool canColWall;

	public string dieAudio;

	private int addBulletNum;

	public override BTNodeStatus Run(BTEnv env)
	{
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
		else if (env.ContainKey("TargetEntity"))
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
		if (env.ContainKey("Caster") && env.GetPlayer<BilliardGameEntityBase>("Caster") is EntityEnemy)
		{
			EntityEnemy enemy = env.GetPlayer<BilliardGameEntityBase>("Caster") as EntityEnemy;
			enemy.logic.BeforeAttackPredictShoot(targetPos, bulletNum, angle);
			FuncTimerManager.inst.CreateFuncTimer(delegate
			{
				Shoot(env, targetPos, enemy);
			}, 0.5f, 1);
		}
		else if (env.ContainKey("Caster"))
		{
			Shoot(env, targetPos, env.GetPlayer<BilliardGameEntityBase>("Caster"));
		}
		return BTNodeStatus.Success;
	}

	private void Shoot(BTEnv env, Vector3 targetPos, BilliardGameEntityBase owner)
	{
		if (owner is EntityEnemy)
		{
			(owner as EntityEnemy).logic.ClearAttackPredict();
		}
		for (int i = 1; i <= bulletNum + addBulletNum; i++)
		{
			Vector3 vector = ((i == 1) ? targetPos : ((i % 2 != 0) ? (Quaternion.Euler(0f, 0f, -angle * ((i - 1) / 2)) * targetPos) : (Quaternion.Euler(0f, 0f, angle * (i / 2)) * targetPos)));
			GameObject gameObject = BilliardGameObjectPool.Instance.GetObject(prefabPath);
			gameObject.transform.position = owner.position;
			BilliardGameBullet component = gameObject.GetComponent<BilliardGameBullet>();
			int entityID = BilliardGameLogicManager.Instance.CreateBullet(gameObject, atk, colNum, buffID, owner, canColWall, effectName, dieAudio);
			if (component != null)
			{
				component.SetEntityID(entityID);
			}
			component.Shoot(vector, speed);
		}
		addBulletNum = 0;
	}
}
