using ACT.Battle;
using Bamboo.ECS;

namespace ACT.EventTrack;

public class TrackAbilityEvt : TrackBaseEvt<TrackAbilityEvt>
{
	public Entity owner;

	public Ability ability;
}
