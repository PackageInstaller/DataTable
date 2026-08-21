namespace System.Diagnostics;

internal class ProcessThreadTimes
{
	internal long create;

	internal long exit;

	internal long kernel;

	internal long user;

	public DateTime StartTime => DateTime.FromFileTime(create);

	public DateTime ExitTime => DateTime.FromFileTime(exit);

	public TimeSpan PrivilegedProcessorTime => new TimeSpan(kernel);

	public TimeSpan UserProcessorTime => new TimeSpan(user);

	public TimeSpan TotalProcessorTime => new TimeSpan(user + kernel);
}
