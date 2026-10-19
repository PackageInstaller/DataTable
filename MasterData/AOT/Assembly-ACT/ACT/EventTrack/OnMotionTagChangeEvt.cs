using Bamboo.ECS;

namespace ACT.EventTrack;

public class OnMotionTagChangeEvt : TrackBaseEvt<OnMotionTagChangeEvt>
{
	public ulong lastTag;

	public ulong newTag;

	public Entity entity;
}
