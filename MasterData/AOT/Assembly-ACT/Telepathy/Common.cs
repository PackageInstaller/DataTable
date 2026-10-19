namespace Telepathy;

public abstract class Common
{
	public bool NoDelay = true;

	public readonly int MaxMessageSize;

	public int SendTimeout = 5000;

	public int ReceiveTimeout;

	protected Common(int MaxMessageSize)
	{
		this.MaxMessageSize = MaxMessageSize;
	}
}
