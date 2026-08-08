namespace System.IO;

public class ErrorEventArgs : EventArgs
{
	private Exception exception;

	public virtual Exception GetException()
	{
		return exception;
	}
}
