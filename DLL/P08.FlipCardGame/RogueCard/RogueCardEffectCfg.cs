namespace RogueCard;

public class RogueCardEffectCfg
{
	public int id;

	public TriggerMoment moment;

	public ConditionType condition;

	public ActionType action;

	public int[] param1;

	public int[] param2;

	public int effective_reset_moment;

	public int effective_time;

	public int lifetime_grow_moment;

	public int max_lifetime;
}
