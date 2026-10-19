namespace Fundamental;

public class Notify
{
	public int type;

	public object body;

	public Notify(int type, object body = null)
	{
		this.type = type;
		this.body = body;
	}
}
