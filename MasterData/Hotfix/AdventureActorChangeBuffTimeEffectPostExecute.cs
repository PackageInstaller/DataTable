public class AdventureActorChangeBuffTimeEffectPostExecute : BaseAdventureEvent
{
	public int buffId;

	public int buffGroupId;

	public int buffTag;

	public int changeTimeAbs;

	public int changeTimePercent;

	public static AdventureActorChangeBuffTimeEffectPostExecute Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorChangeBuffTimeEffectPostExecute>("CHANGE_BUFF_TIME_EFFECT_POSTEXECUTE");
	}

	public AdventureActorChangeBuffTimeEffectPostExecute()
		: base("CHANGE_BUFF_TIME_EFFECT_POSTEXECUTE")
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
