using Entitas;

internal static class ModifyHealthProcessor
{
	public static SimContext mSimContext;

	internal static void Initialize(SimContext simContext)
	{
		mSimContext = simContext;
	}

	internal static void Shutdown()
	{
		mSimContext = null;
	}

	private static Int3 CalculateDamageAngleRelativeToTarget(Int3 worldShotTravelDirection, Entity entityToDamage)
	{
		return Int3.forward;
	}

	internal static void DamageOrHealEntity(Entity sourceEntity, Entity entityToDamage, int amount, DamageType damageType)
	{
	}

	internal static bool DestroyCommanderEliminatedEntity(Entity entity)
	{
		return DestroyEntity(CommanderID.None, null, entity, UnitRemoveReason.Destroy, skipDeathSequence: false, isByCommanderEliminated: true);
	}

	internal static bool DestroyEntity(Entity entity, UnitRemoveReason reason)
	{
		return DestroyEntity(CommanderID.None, null, entity, reason, skipDeathSequence: false, isByCommanderEliminated: false);
	}

	internal static bool DestroyEntity(CommanderID killedByCommanderID, Entity killedByEntity, Entity entity, UnitRemoveReason reason, bool skipDeathSequence, bool isByCommanderEliminated)
	{
		return false;
	}

	internal static void ProcessDead(Entity entity)
	{
	}

	internal static void ProcessModifyHealth(Entity entity)
	{
	}

	private static void SendDeathEvents(Entity dyingEntity, Entity killedByEntity, CommanderID killedByCommanderID, UnitRemoveReason reason, bool skipDeathSequence, bool isByCommanderEliminated)
	{
	}
}
