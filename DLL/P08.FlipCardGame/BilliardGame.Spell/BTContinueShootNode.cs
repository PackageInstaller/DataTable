using BilliardGame.Runtime;
using UnityEngine;

namespace BilliardGame.Spell;

public class BTContinueShootNode : BActionNode
{
	public string prefabPath;

	public Vector3 dir;

	public float speed;

	public int atk;

	public int colNum;

	public int buffID;

	public int bulletNum = 1;

	public float time = 0.1f;

	public string effectName;

	public bool canColWall;

	public override BTNodeStatus Run(BTEnv env)
	{
		if (env.ContainKey("damage"))
		{
			atk += env.GetStruct<int>("damage");
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
		BilliardGameEntityBase owner = env.GetPlayer<BilliardGameEntityBase>("Caster");
		Vector3 ownerPos = owner.position;
		FuncTimerManager.inst.CreateFuncTimer(delegate
		{
			GameObject gameObject = BilliardGameObjectPool.Instance.GetObject(prefabPath);
			gameObject.transform.position = ownerPos;
			BilliardGamePhysicalBullet component = gameObject.GetComponent<BilliardGamePhysicalBullet>();
			int entityID = BilliardGameLogicManager.Instance.CreateBullet(gameObject, atk, colNum, buffID, owner, canColWall, effectName);
			if (component != null)
			{
				component.SetEntityID(entityID);
			}
			component.ShootBall(targetPos, speed);
		}, time, bulletNum);
		return BTNodeStatus.Success;
	}
}
