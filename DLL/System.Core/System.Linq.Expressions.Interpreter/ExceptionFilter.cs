namespace System.Linq.Expressions.Interpreter;

internal sealed class ExceptionFilter
{
	public readonly int LabelIndex;

	public readonly int StartIndex;

	public readonly int EndIndex;

	internal ExceptionFilter(int labelIndex, int start, int end)
	{
		LabelIndex = labelIndex;
		StartIndex = start;
		EndIndex = end;
	}
}
