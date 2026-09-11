using UnityEngine;

public class TimeProcessor
{
	public static void SetEntityTimeScale(SimContext context, int entityID, int scale)
	{
		SimEntity entityWithEntityID = context.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			entityWithEntityID.entityBlackboard.var.mEntityTimeScale = scale;
		}
	}

	public static int GetEntityTimeScale(SimContext context, int entityID)
	{
		SimEntity entityWithEntityID = context.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			return entityWithEntityID.entityBlackboard.var.mEntityTimeScale;
		}
		return 100;
	}

	public static void ModifyMovementTimeScale(SimContext context, int entityID, int scale)
	{
	}

	public static void ModifyAbilityTimeScale(SimContext context, int entityID, int scale)
	{
		SimEntity entityWithEntityID = context.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityActionAbility)
		{
			entityWithEntityID.entityActionAbility.mAbilitySpeed = scale;
		}
	}

	public static void ModifyHitRecoverTimeSacle(SimContext context, int entityID, int scale)
	{
		SimEntity entityWithEntityID = context.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityHitRecover)
		{
			Debug.Log((object)$" entity.entityHitRecover.mTimeScale {entityWithEntityID.entityHitRecover.mTimeScale}");
			entityWithEntityID.entityHitRecover.mTimeScale = 100;
		}
	}
}
