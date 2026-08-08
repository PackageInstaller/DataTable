using System.Runtime.Serialization;
using System.Threading;

namespace System;

[Serializable]
public class OperationCanceledException : SystemException
{
	[NonSerialized]
	private CancellationToken _cancellationToken;

	public CancellationToken CancellationToken
	{
		get
		{
			return _cancellationToken;
		}
		private set
		{
			_cancellationToken = value;
		}
	}

	public OperationCanceledException()
		: base("The operation was canceled.")
	{
		base.HResult = -2146233029;
	}

	public OperationCanceledException(string message)
		: base(message)
	{
		base.HResult = -2146233029;
	}

	public OperationCanceledException(string message, CancellationToken token)
		: this(message)
	{
		CancellationToken = token;
	}

	protected OperationCanceledException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
