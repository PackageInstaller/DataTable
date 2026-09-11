using System.Collections.Generic;

namespace Mono.Globalization.Unicode;

internal class ContractionComparer : IComparer<Contraction>
{
	public static readonly ContractionComparer Instance = new ContractionComparer();

	public int Compare(Contraction c1, Contraction c2)
	{
		char[] source = c1.Source;
		char[] source2 = c2.Source;
		int num = ((source.Length > source2.Length) ? source2.Length : source.Length);
		for (int i = 0; i < num; i++)
		{
			if (source[i] != source2[i])
			{
				return source[i] - source2[i];
			}
		}
		if (source.Length != source2.Length)
		{
			return source.Length - source2.Length;
		}
		return c1.Index - c2.Index;
	}
}
