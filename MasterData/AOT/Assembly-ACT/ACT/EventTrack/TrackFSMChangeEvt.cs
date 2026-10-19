using Bamboo.ECS;

namespace ACT.EventTrack;

public class TrackFSMChangeEvt : TrackBaseEvt<TrackFSMChangeEvt>
{
	public string stateName;

	public Entity entity;
}
