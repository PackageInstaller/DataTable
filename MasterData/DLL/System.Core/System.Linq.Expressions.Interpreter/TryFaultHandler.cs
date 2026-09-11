namespace System.Linq.Expressions.Interpreter;

internal sealed class TryFaultHandler
{
	internal readonly int TryStartIndex;

	internal readonly int TryEndIndex;

	internal readonly int FinallyStartIndex;

	internal readonly int FinallyEndIndex;

	internal TryFaultHandler(int tryStart, int tryEnd, int finallyStart, int finallyEnd)
	{
		TryStartIndex = tryStart;
		TryEndIndex = tryEnd;
		FinallyStartIndex = finallyStart;
		FinallyEndIndex = finallyEnd;
	}
}
