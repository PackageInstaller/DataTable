using System.Collections.Generic;
using BilliardGame.Runtime;
using UnityEngine;

namespace BilliardGame.Spell;

public class BTAoe : BActionNode
{
	public int Damage;

	public float radius;

	public EntityType battleType;

	public override BTNodeStatus Run(BTEnv env)
	{
		int targetDamage = Damage;
		float targetRad = radius;
		if (env.ContainKey("damage"))
		{
			targetDamage += env.GetStruct<int>("damage");
		}
		if (env.ContainKey("add_aoe_damage"))
		{
			targetDamage += env.GetStruct<int>("add_aoe_damage");
		}
		if (env.ContainKey("add_aoe_damage_ratio"))
		{
			targetDamage = Mathf.FloorToInt((float)targetDamage * env.GetStruct<float>("add_aoe_damage_ratio"));
		}
		if (env.ContainKey("bubble_radius"))
		{
			targetRad += env.GetStruct<float>("bubble_radius");
		}
		BilliardGameEntityBase player = env.GetPlayer<BilliardGameEntityBase>("Caster");
		BilliardGameEntityBase billiardGameEntityBase = (env.ContainKey("TargetEntity") ? env.GetPlayer<BilliardGameEntityBase>("TargetEntity") : player);
		Vector3 pos = billiardGameEntityBase.position;
		if (battleType == EntityType.Enemy)
		{
			List<EntityEnemy> tempEnemyList = QueryCache.TempEnemyList;
			BilliardGameLogicManager.Instance.GetCircleEnemy(pos, targetRad, tempEnemyList);
			if (player is EntityPlayer)
			{
				EntityPlayer obj = player as EntityPlayer;
				int addAoeDamage = obj.AddAoeDamage;
				int addComboDamage = obj.AddComboDamage;
				float addAoeRatio = obj.AddAoeRatio;
				targetDamage += addComboDamage;
				targetDamage += addAoeDamage;
				targetDamage = Mathf.FloorToInt((float)targetDamage * addAoeRatio);
				obj.OnAOEDamage(env.GetStruct<int>("BuffId"), tempEnemyList);
			}
			for (int i = 0; i < tempEnemyList.Count; i++)
			{
				tempEnemyList[i].TakeDamage(targetDamage);
			}
			BilliardGameLogicManager.Instance.AddCurRoundHitNumber(tempEnemyList.Count);
			return BTNodeStatus.Success;
		}
		if (env.ContainKey("Caster") && env.GetPlayer<BilliardGameEntityBase>("Caster") is EntityEnemy)
		{
			EntityEnemy enemy = env.GetPlayer<BilliardGameEntityBase>("Caster") as EntityEnemy;
			enemy.logic.BeforeAttackPredictAoe(radius);
			FuncTimerManager.inst.CreateFuncTimer(delegate
			{
				enemy.logic.ClearAttackPredict();
				List<EntityPlayer> circlePlayer = BilliardGameLogicManager.Instance.GetCirclePlayer(pos, targetRad);
				for (int j = 0; j < circlePlayer.Count; j++)
				{
					circlePlayer[j].TakeDamage(targetDamage);
				}
				EntityMechanism target2 = null;
				if (BilliardGameLogicManager.Instance.GetCirclePot(pos, targetRad, out target2))
				{
					target2.TakeDamage(targetDamage);
				}
			}, 0.5f, 1);
		}
		else
		{
			List<EntityPlayer> tempPlayerList = QueryCache.TempPlayerList;
			BilliardGameLogicManager.Instance.GetCirclePlayer(pos, targetRad, tempPlayerList);
			for (int num = 0; num < tempPlayerList.Count; num++)
			{
				tempPlayerList[num].TakeDamage(targetDamage);
			}
			EntityMechanism target = null;
			if (BilliardGameLogicManager.Instance.GetCirclePot(pos, targetRad, out target))
			{
				target.TakeDamage(targetDamage);
			}
		}
		return BTNodeStatus.Success;
	}
}
