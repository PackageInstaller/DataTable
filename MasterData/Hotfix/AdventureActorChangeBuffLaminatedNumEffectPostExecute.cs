public class AdventureActorChangeBuffLaminatedNumEffectPostExecute : BaseAdventureEvent
{
	public int buffId;

	public int buffGroupId;

	public int buffTag;

	public int changeNum;

	public static AdventureActorChangeBuffLaminatedNumEffectPostExecute Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorChangeBuffLaminatedNumEffectPostExecute>("CHANGE_BUFF_LAMINATEDNUM_EFFECT_POSTEXECUTE");
	}

	public AdventureActorChangeBuffLaminatedNumEffectPostExecute()
		: base("CHANGE_BUFF_LAMINATEDNUM_EFFECT_POSTEXECUTE")
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
