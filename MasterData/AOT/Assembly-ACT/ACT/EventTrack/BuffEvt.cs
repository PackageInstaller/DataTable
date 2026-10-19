using Bamboo.ECS;

namespace ACT.EventTrack;

public abstract class BuffEvt<T> : TrackBaseEvt<T> where T : TrackBaseEvt<T>, new()
{
	public int skillId;

	public Entity caster;

	public Entity owner;

	public int buffStackNum;

	public string buffName;
}
