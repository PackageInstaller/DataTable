using System.Collections;

namespace System.Net;

[Serializable]
internal class PathList
{
	[Serializable]
	private class PathListComparer : IComparer
	{
		internal static readonly PathListComparer StaticInstance = new PathListComparer();

		int IComparer.Compare(object ol, object or)
		{
			string text = CookieParser.CheckQuoted((string)ol);
			string text2 = CookieParser.CheckQuoted((string)or);
			int length = text.Length;
			int length2 = text2.Length;
			int num = Math.Min(length, length2);
			for (int i = 0; i < num; i++)
			{
				if (text[i] != text2[i])
				{
					return text[i] - text2[i];
				}
			}
			return length2 - length;
		}
	}

	private SortedList m_list = SortedList.Synchronized(new SortedList(PathListComparer.StaticInstance));

	public int Count => m_list.Count;

	public ICollection Values => m_list.Values;

	public object this[string s]
	{
		get
		{
			return m_list[s];
		}
		set
		{
			lock (SyncRoot)
			{
				m_list[s] = value;
			}
		}
	}

	public object SyncRoot => m_list.SyncRoot;

	public int GetCookiesCount()
	{
		int num = 0;
		lock (SyncRoot)
		{
			foreach (CookieCollection value in m_list.Values)
			{
				num += value.Count;
			}
			return num;
		}
	}

	public IEnumerator GetEnumerator()
	{
		return m_list.GetEnumerator();
	}
}
