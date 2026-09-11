namespace System;

[Serializable]
public class UnhandledExceptionEventArgs : EventArgs
{
	private object _exception;

	private bool _isTerminating;

	public object ExceptionObject => _exception;

	public bool IsTerminating => _isTerminating;

	public UnhandledExceptionEventArgs(object exception, bool isTerminating)
	{
		_exception = exception;
		_isTerminating = isTerminating;
	}
}
