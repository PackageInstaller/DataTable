using System.Globalization;

namespace System.Linq.Expressions.Interpreter;

internal readonly struct RuntimeLabel(int index, int continuationStackDepth, int stackDepth)
{
	public readonly int Index = index;

	public readonly int StackDepth = stackDepth;

	public readonly int ContinuationStackDepth = continuationStackDepth;

	public override string ToString()
	{
		return string.Format(CultureInfo.InvariantCulture, "->{0} C({1}) S({2})", Index, ContinuationStackDepth, StackDepth);
	}
}
