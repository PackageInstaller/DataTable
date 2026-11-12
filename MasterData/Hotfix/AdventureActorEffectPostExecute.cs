public class AdventureActorEffectPostExecute : BaseAdventureEvent
{
	public int effectId;

	public string effectTag;

	public static AdventureActorEffectPostExecute Generate()
	{
		if (ModuleController<AdventureModuleController>.Instance == null)
		{
			return null;
		}
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorEffectPostExecute>("ACTOR_EFFECT_POSTEXECUTE");
	}

	public AdventureActorEffectPostExecute()
		: base("ACTOR_EFFECT_POSTEXECUTE")
	{
	}

	public override void Clear()
	{
		effectId = 0;
		effectTag = "";
	}
}
