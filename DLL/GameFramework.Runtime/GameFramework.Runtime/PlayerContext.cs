namespace GameFramework.Runtime;

public class PlayerContext : Context
{
	private string username;

	public string Username => username;

	public PlayerContext(string username)
		: this(username, null)
	{
		this.username = username;
	}

	public PlayerContext(string username, IServiceContainer container)
		: base(container, Context.GetApplicationContext())
	{
		this.username = username;
	}
}
