using Bamboo.ECS;

namespace ACT.EventTrack;

public class TrackWeakStart : TrackBaseEvt<TrackWeakStart>
{
	public Entity owner;

	public override void OnDispatch()
	{
	}
}
