using ACT.Battle.Configs;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class MonoEntityBePushed : MonoBehaviour, IPushCallBack, IHitWallCallBack
{
	public ConfigAction[] actions;

	public MonoEntity ownerEntity;

	public WhereTargets where;

	public void OnPush(Entity entity)
	{
		if (where.FindTarget(FindTargetResult.EntityOnly(entity)) && (bool)ownerEntity)
		{
			SystemAbility.DoActions(entity, ownerEntity.entity, FindTargetResult.EntityOnly(ownerEntity.entity), null, null, actions);
		}
	}

	public void OnHitWall(Entity entity)
	{
		OnPush(entity);
	}
}
