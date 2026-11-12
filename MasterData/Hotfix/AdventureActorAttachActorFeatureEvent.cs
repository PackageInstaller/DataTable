using LitJson;

public class AdventureActorAttachActorFeatureEvent : BaseAdventureEvent
{
	public string featureID;

	public JsonData skillData;

	public bool isUpgradeLevel;

	public static AdventureActorAttachActorFeatureEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorAttachActorFeatureEvent>("ADVENTURE_ACTOR_ATTACH_FEATURE");
	}

	public AdventureActorAttachActorFeatureEvent()
		: base("ADVENTURE_ACTOR_ATTACH_FEATURE")
	{
	}

	public override void Clear()
	{
		featureID = null;
		skillData = null;
		isUpgradeLevel = false;
	}
}
