namespace System.Net.Sockets;

public class LingerOption
{
	private bool enabled;

	private int lingerTime;

	public bool Enabled
	{
		set
		{
			enabled = value;
		}
	}

	public int LingerTime
	{
		set
		{
			lingerTime = value;
		}
	}

	public LingerOption(bool enable, int seconds)
	{
		Enabled = enable;
		LingerTime = seconds;
	}
}
