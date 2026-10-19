using System.Collections;
using System.Globalization;

namespace System;

[Serializable]
internal class InvariantComparer : IComparer
{
	private CompareInfo m_compareInfo;

	internal static readonly InvariantComparer Default = new InvariantComparer();

	internal InvariantComparer()
	{
		m_compareInfo = CultureInfo.InvariantCulture.CompareInfo;
	}

	public int Compare(object a, object b)
	{
		string text = a as string;
		string text2 = b as string;
		if (text != null && text2 != null)
		{
			return m_compareInfo.Compare(text, text2);
		}
		return Comparer.Default.Compare(a, b);
	}
}
