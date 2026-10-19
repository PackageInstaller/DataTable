namespace ACT.Event;

public class CharacterShieldChangeEvt : BaseEventContent
{
	public int characterId;

	public int preShield;

	public int curShield;

	public int maxShield;

	public float ShieldPercent => (float)curShield / (float)maxShield;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		characterId = 0;
		preShield = 0;
		curShield = 0;
		maxShield = 0;
	}
}
