using ACT.Battle;
using ACT.Core;
using Bamboo.ECS;

namespace ACT.EventTrack;

public abstract class TrackHitedBaseEvt<T> : TrackBaseEvt<T> where T : TrackBaseEvt<T>, new()
{
	public Entity attacker;

	public Entity attackee;

	public AttackData attackData;

	public float postureDamage;

	public Element element;

	public int actualDamage;

	public float damage;

	public int tenacity;

	public int skillId;

	public override void ReleaseEvt()
	{
		attackee = default;
		attacker = default;
		attackData = null;
		element = Element.Owner;
		base.ReleaseEvt();
	}
}
