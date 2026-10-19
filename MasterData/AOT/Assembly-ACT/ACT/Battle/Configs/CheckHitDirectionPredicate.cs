using System;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断命中方向", "Predicate", new string[] { "check", "hit", "direction", "vector", "position", "rotation", "quaternion", "predicate", "condition" })]
public class CheckHitDirectionPredicate : ConfigPredicate
{
	[Tooltip("判断攻击者的的攻击方向处于受击者的前方或者后方")]
	public HitDirection hitDirection;

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is IGetAttackData)
		{
			AttackData attackData = (memory.evt as IGetAttackData).GetAttackData();
			Entity attackee = attackData.attackee;
			bool flag = attackee.GetCompTransform().physicsPosition.x > attackData.attacker.GetCompTransform().physicsPosition.x;
			switch (hitDirection)
			{
			case HitDirection.Forward:
				if (!attackee.IsFaceLeft())
				{
					return !flag;
				}
				return flag;
			case HitDirection.Back:
				if (!attackee.IsFaceLeft())
				{
					return flag;
				}
				return !flag;
			case HitDirection.All:
				return true;
			default:
				throw new NotImplementedException();
			}
		}
		return false;
	}
}
