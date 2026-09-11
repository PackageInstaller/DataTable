using System.Diagnostics;
using Unity;

namespace System.Runtime.ExceptionServices;

public sealed class ExceptionDispatchInfo
{
	private Exception m_Exception;

	private object m_stackTrace;

	internal object BinaryStackTraceArray => m_stackTrace;

	public Exception SourceException => m_Exception;

	private ExceptionDispatchInfo(Exception exception)
	{
		m_Exception = exception;
		StackTrace[] captured_traces = exception.captured_traces;
		int num = ((captured_traces != null) ? captured_traces.Length : 0);
		StackTrace[] array = new StackTrace[num + 1];
		if (num != 0)
		{
			Array.Copy(captured_traces, 0, array, 0, num);
		}
		array[num] = new StackTrace(exception, 0, fNeedFileInfo: true);
		m_stackTrace = array;
	}

	public static ExceptionDispatchInfo Capture(Exception source)
	{
		if (source == null)
		{
			throw new ArgumentNullException("source", Environment.GetResourceString("Object cannot be null."));
		}
		return new ExceptionDispatchInfo(source);
	}

	[StackTraceHidden]
	public void Throw()
	{
		m_Exception.RestoreExceptionDispatchInfo(this);
		throw m_Exception;
	}

	[StackTraceHidden]
	public static void Throw(Exception source)
	{
		Capture(source).Throw();
	}

	internal ExceptionDispatchInfo()
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
