public sealed class DespawnThrownEntityEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int Caster;

	public int SpawnTimelineID;

	public int ThrownID;

	public DespawnThrownEntityEvent()
	{
	}

	public DespawnThrownEntityEvent(int caster, int spawnTimelineID, int creationIndex)
	{
		Caster = caster;
		SpawnTimelineID = spawnTimelineID;
		ThrownID = creationIndex;
	}

	public static DespawnThrownEntityEvent Claim(int caster, int spawnTimelineID, int creationIndex)
	{
		DespawnThrownEntityEvent despawnThrownEntityEvent = FrameObjectPool<DespawnThrownEntityEvent>.Claim();
		despawnThrownEntityEvent.Caster = caster;
		despawnThrownEntityEvent.SpawnTimelineID = spawnTimelineID;
		despawnThrownEntityEvent.ThrownID = creationIndex;
		return despawnThrownEntityEvent;
	}

	public override void OnEnterPool()
	{
		Caster = 0;
		SpawnTimelineID = 0;
		ThrownID = 0;
	}

	public override void Release()
	{
		FrameObjectPool<DespawnThrownEntityEvent>.Release(this);
	}
}
