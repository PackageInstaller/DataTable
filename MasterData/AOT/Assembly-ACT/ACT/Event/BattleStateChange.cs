namespace ACT.Event;

public class BattleStateChange : BaseEventContent
{
	public BattleState from;

	public BattleState to;
}
