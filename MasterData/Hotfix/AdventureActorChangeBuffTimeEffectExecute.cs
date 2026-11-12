public class AdventureActorChangeBuffTimeEffectExecute : BaseAdventureEvent
{
	public int buffId;

	public int buffGroupId;

	public int buffTag;

	public int changeTimeAbs;

	public int changeTimePercent;

	public static AdventureActorChangeBuffTimeEffectExecute Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorChangeBuffTimeEffectExecute>("CHANGE_BUFF_TIME_EFFECT_EXECUTE");
	}

	public AdventureActorChangeBuffTimeEffectExecute()
		: base("CHANGE_BUFF_TIME_EFFECT_EXECUTE")
	{
	}

	public override void Clear()
	{
		buffId = 0;
		buffTag = 0;
		buffGroupId = 0;
		changeTimeAbs = 0;
		changeTimePercent = 0;
	}
}
