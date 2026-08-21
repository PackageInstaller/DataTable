namespace GameFramework.Runtime;

public class Notification
{
	private string title;

	private string message;

	public string Title => title;

	public string Message => message;

	public Notification(string message)
		: this(null, message)
	{
	}

	public Notification(string title, string message)
	{
		this.title = title;
		this.message = message;
	}
}
