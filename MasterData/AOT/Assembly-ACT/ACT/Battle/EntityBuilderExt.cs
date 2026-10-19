using ACT.EventTrack;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle;

internal static class EntityBuilderExt
{
	public static Entity SpawnAndReport(this EntityBuilder builder)
	{
		Entity entity = builder.Build();
		SpawnReport(entity);
		return entity;
	}

	public static void SpawnReport(Entity entity)
	{
		Singleton<GameManager>.instance?.ecsManager.ReportEntityCreate(entity);
		TrackSpawnEntity evt = EventTrackSolver.Instance.GetEvt<TrackSpawnEntity>();
		evt.entity = entity;
		EventTrackSolver.Instance.Dispatch(evt);
	}
}
