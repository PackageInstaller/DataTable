using System.Collections.Generic;
using System.Globalization;

namespace System.Linq.Expressions.Interpreter;

internal sealed class DebugInfo
{
	private class DebugInfoComparer : IComparer<DebugInfo>
	{
		int IComparer<DebugInfo>.Compare(DebugInfo d1, DebugInfo d2)
		{
			if (d1.Index > d2.Index)
			{
				return 1;
			}
			if (d1.Index == d2.Index)
			{
				return 0;
			}
			return -1;
		}
	}

	public int StartLine;

	public int EndLine;

	public int Index;

	public string FileName;

	public bool IsClear;

	private static readonly DebugInfoComparer s_debugComparer = new DebugInfoComparer();

	public static DebugInfo GetMatchingDebugInfo(DebugInfo[] debugInfos, int index)
	{
		DebugInfo value = new DebugInfo
		{
			Index = index
		};
		int num = Array.BinarySearch(debugInfos, value, s_debugComparer);
		if (num < 0)
		{
			num = ~num;
			if (num == 0)
			{
				return null;
			}
			num--;
		}
		return debugInfos[num];
	}

	public override string ToString()
	{
		if (IsClear)
		{
			return string.Format(CultureInfo.InvariantCulture, "{0}: clear", Index);
		}
		return string.Format(CultureInfo.InvariantCulture, "{0}: [{1}-{2}] '{3}'", Index, StartLine, EndLine, FileName);
	}
}
