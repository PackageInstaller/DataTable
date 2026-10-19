namespace ACT.Event;

public class PayEvent : BaseEventContent
{
	public string orderID = "";

	public string message = "";

	public bool isSuccess;

	public bool isFail;

	public bool isCancel;

	public bool isRetry;

	public override void OnGet()
	{
		base.OnGet();
		orderID = "";
		message = "";
		isSuccess = (isFail = (isCancel = (isRetry = false)));
	}
}
