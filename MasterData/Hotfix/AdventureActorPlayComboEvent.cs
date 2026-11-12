public class AdventureActorPlayComboEvent : BaseAdventureEvent
{
	public string comboTag;

	public ComboSkillType comboSkillType;

	public static AdventureActorPlayComboEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorPlayComboEvent>("ACTOR_PLAY_COMBO");
	}

	public AdventureActorPlayComboEvent()
		: base("ACTOR_PLAY_COMBO")
	{
	}

	public override void Clear()
	{
		comboTag = null;
		comboSkillType = ComboSkillType.None;
	}
}
