public class TriggerCharGamePlayLogicCommonEvent : BaseAdventureEvent
{
	public bool normalAttackTrigger;

	public bool dodgeTrigger;

	public bool skillTrigger;

	public bool ultimateTrigger;

	public static TriggerCharGamePlayLogicCommonEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<TriggerCharGamePlayLogicCommonEvent>("TRIGGER_CHAR_GAMEPLAYLOGIC_COMMON_EVENT");
	}

	public TriggerCharGamePlayLogicCommonEvent()
		: base("TRIGGER_CHAR_GAMEPLAYLOGIC_COMMON_EVENT")
	{
	}

	public override void Clear()
	{
		base.Clear();
		normalAttackTrigger = false;
		dodgeTrigger = false;
		skillTrigger = false;
		ultimateTrigger = false;
	}
}
