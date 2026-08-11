namespace Ase;

public class SDKLoginResult
{
	private string uid;

	private string token;

	private string username;

	private long channel;

	private string state;

	public string Uid => uid;

	public string Token => token;

	public string Username => username;

	public string State => state;

	public long ChannelID => channel;

	public SDKLoginResult(string uid, string token, string username, string state, long channel)
	{
		this.uid = uid;
		this.token = token;
		this.username = username;
		this.state = state;
		this.channel = channel;
	}
}
