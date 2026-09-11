using System.IO;

namespace System.Net.Security;

public abstract class AuthenticatedStream : Stream
{
	private Stream _InnerStream;

	private bool _LeaveStreamOpen;

	protected Stream InnerStream => _InnerStream;

	public abstract bool IsAuthenticated { get; }

	protected AuthenticatedStream(Stream innerStream, bool leaveInnerStreamOpen)
	{
		if (innerStream == null || innerStream == Stream.Null)
		{
			throw new ArgumentNullException("innerStream");
		}
		if (!innerStream.CanRead || !innerStream.CanWrite)
		{
			throw new ArgumentException(global::SR.GetString("The stream has to be read/write."), "innerStream");
		}
		_InnerStream = innerStream;
		_LeaveStreamOpen = leaveInnerStreamOpen;
	}

	protected override void Dispose(bool disposing)
	{
		try
		{
			if (disposing)
			{
				if (_LeaveStreamOpen)
				{
					_InnerStream.Flush();
				}
				else
				{
					_InnerStream.Close();
				}
			}
		}
		finally
		{
			base.Dispose(disposing);
		}
	}
}
