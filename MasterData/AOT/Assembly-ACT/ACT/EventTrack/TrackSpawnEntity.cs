using Bamboo.ECS;

namespace ACT.EventTrack;

public class TrackSpawnEntity : TrackBaseEvt<TrackSpawnEntity>
{
	public Entity entity;

	public override bool SkipIfWorldNotStart => false;

	public override void ReleaseEvt()
	{
		entity = default;
		base.ReleaseEvt();
	}
}
