namespace ACT.Event;

public class AccountDecorationChangedEvt : BaseEventContent
{
	public AccountDecorationChangeType ChangeType;

	public override void OnGet()
	{
		ChangeType = AccountDecorationChangeType.None;
	}
}
