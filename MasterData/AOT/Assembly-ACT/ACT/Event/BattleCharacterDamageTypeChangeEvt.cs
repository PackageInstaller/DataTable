namespace ACT.Event;

public class BattleCharacterDamageTypeChangeEvt : BaseEventContent
{
	public int oldCharacterDamageType;

	public int curCharacterDamageType;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		oldCharacterDamageType = (curCharacterDamageType = 0);
	}
}
