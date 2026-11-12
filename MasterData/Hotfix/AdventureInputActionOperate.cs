public class AdventureInputActionOperate : BaseAdventureEvent
{
	public ActionKey key;

	public ButtonState buttonState;

	public bool isSimulative;

	public static AdventureInputActionOperate Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureInputActionOperate>("ADVENTURE_INPUT_ACTION_BUTTON_OPERATE");
	}

	public AdventureInputActionOperate()
		: base("ADVENTURE_INPUT_ACTION_BUTTON_OPERATE")
	{
	}

	public override void Clear()
	{
		buttonState = ButtonState.None;
		isSimulative = false;
	}
}
