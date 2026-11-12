public class AdventureActorChangeBuffLaminatedNumEffectExecute : BaseAdventureEvent
{
	public int buffId;

	public int buffGroupId;

	public int buffTag;

	public int changeNum;

	public static AdventureActorChangeBuffLaminatedNumEffectExecute Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorChangeBuffLaminatedNumEffectExecute>("CHANGE_BUFF_LAMINATEDNUM_EFFECT_EXECUTE");
	}

	public AdventureActorChangeBuffLaminatedNumEffectExecute()
		: base("CHANGE_BUFF_LAMINATEDNUM_EFFECT_EXECUTE")
	{
	}

	public override void Clear()
	{
		buffId = 0;
		buffTag = 0;
		buffGroupId = 0;
		changeNum = 0;
	}
}
