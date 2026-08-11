namespace GameFramework.Runtime;

public class DialogNotification : Notification
{
	private string confirmButtonText;

	private string neutralButtonText;

	private string cancelButtonText;

	private bool canceledOnTouchOutside;

	private int dialogResult;

	public string ConfirmButtonText => confirmButtonText;

	public string NeutralButtonText => neutralButtonText;

	public string CancelButtonText => cancelButtonText;

	public bool CanceledOnTouchOutside => canceledOnTouchOutside;

	public int DialogResult
	{
		get
		{
			return dialogResult;
		}
		set
		{
			dialogResult = value;
		}
	}

	public DialogNotification(string title, string message, string confirmButtonText, bool canceledOnTouchOutside = true)
		: this(title, message, confirmButtonText, null, null, canceledOnTouchOutside)
	{
	}

	public DialogNotification(string title, string message, string confirmButtonText, string cancelButtonText, bool canceledOnTouchOutside = true)
		: this(title, message, confirmButtonText, null, cancelButtonText, canceledOnTouchOutside)
	{
	}

	public DialogNotification(string title, string message, string confirmButtonText, string neutralButtonText, string cancelButtonText, bool canceledOnTouchOutside = true)
		: base(title, message)
	{
		this.confirmButtonText = confirmButtonText;
		this.neutralButtonText = neutralButtonText;
		this.cancelButtonText = cancelButtonText;
		this.canceledOnTouchOutside = canceledOnTouchOutside;
	}
}
