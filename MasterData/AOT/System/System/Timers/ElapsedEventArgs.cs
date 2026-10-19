namespace System.Timers;

public class ElapsedEventArgs : EventArgs
{
	private DateTime time;

	internal ElapsedEventArgs(DateTime time)
	{
		this.time = time;
	}
}
