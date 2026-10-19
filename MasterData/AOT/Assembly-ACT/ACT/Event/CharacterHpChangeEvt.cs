namespace ACT.Event;

public class CharacterHpChangeEvt : BaseEventContent
{
	public int characterId;

	public int preHp;

	public int curHp;

	public int maxHp;

	public float HpPercent => (float)curHp / (float)maxHp;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		characterId = 0;
		preHp = 0;
		curHp = 0;
		maxHp = 0;
	}
}
