namespace System.Linq.Expressions.Interpreter;

internal readonly struct InterpretedFrameInfo(string methodName, DebugInfo info)
{
	private readonly string _methodName = methodName;

	private readonly DebugInfo _debugInfo = info;

	public override string ToString()
	{
		if (_debugInfo == null)
		{
			return _methodName;
		}
		return _methodName + ": " + _debugInfo;
	}
}
