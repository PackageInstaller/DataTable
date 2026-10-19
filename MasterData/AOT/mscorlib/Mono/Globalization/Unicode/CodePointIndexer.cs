using System;

namespace Mono.Globalization.Unicode;

internal class CodePointIndexer
{
	[Serializable]
	internal struct TableRange
	{
		public readonly int Start;

		public readonly int End;

		public readonly int Count;

		public readonly int IndexStart;

		public readonly int IndexEnd;

		public TableRange(int start, int end, int indexStart)
		{
			Start = start;
			End = end;
			Count = End - Start;
			IndexStart = indexStart;
			IndexEnd = IndexStart + Count;
		}
	}

	private readonly TableRange[] ranges;

	public readonly int TotalCount;

	private int defaultIndex;

	private int defaultCP;

	public CodePointIndexer(int[] starts, int[] ends, int defaultIndex, int defaultCP)
	{
		this.defaultIndex = defaultIndex;
		this.defaultCP = defaultCP;
		ranges = new TableRange[starts.Length];
		for (int i = 0; i < ranges.Length; i++)
		{
			ranges[i] = new TableRange(starts[i], ends[i], (i != 0) ? (ranges[i - 1].IndexStart + ranges[i - 1].Count) : 0);
		}
		for (int j = 0; j < ranges.Length; j++)
		{
			TotalCount += ranges[j].Count;
		}
	}

	public int ToIndex(int cp)
	{
		for (int i = 0; i < ranges.Length; i++)
		{
			if (cp < ranges[i].Start)
			{
				return defaultIndex;
			}
			if (cp < ranges[i].End)
			{
				return cp - ranges[i].Start + ranges[i].IndexStart;
			}
		}
		return defaultIndex;
	}
}
