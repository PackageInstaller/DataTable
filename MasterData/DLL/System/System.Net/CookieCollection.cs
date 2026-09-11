using System.Collections;
using System.Runtime.Serialization;

namespace System.Net;

[Serializable]
public class CookieCollection : ICollection, IEnumerable
{
	internal enum Stamp
	{
		Check,
		Set,
		SetToUnused,
		SetToMaxUsed
	}

	private class CookieCollectionEnumerator : IEnumerator
	{
		private CookieCollection m_cookies;

		private int m_count;

		private int m_index = -1;

		private int m_version;

		object IEnumerator.Current
		{
			get
			{
				if (m_index < 0 || m_index >= m_count)
				{
					throw new InvalidOperationException(global::SR.GetString("Enumeration has either not started or has already finished."));
				}
				if (m_version != m_cookies.m_version)
				{
					throw new InvalidOperationException(global::SR.GetString("Collection was modified; enumeration operation may not execute."));
				}
				return m_cookies[m_index];
			}
		}

		internal CookieCollectionEnumerator(CookieCollection cookies)
		{
			m_cookies = cookies;
			m_count = cookies.Count;
			m_version = cookies.m_version;
		}

		bool IEnumerator.MoveNext()
		{
			if (m_version != m_cookies.m_version)
			{
				throw new InvalidOperationException(global::SR.GetString("Collection was modified; enumeration operation may not execute."));
			}
			if (++m_index < m_count)
			{
				return true;
			}
			m_index = m_count;
			return false;
		}

		void IEnumerator.Reset()
		{
			m_index = -1;
		}
	}

	internal int m_version;

	private ArrayList m_list = new ArrayList();

	private DateTime m_TimeStamp = DateTime.MinValue;

	private bool m_has_other_versions;

	[OptionalField]
	private bool m_IsReadOnly;

	public Cookie this[int index]
	{
		get
		{
			if (index < 0 || index >= m_list.Count)
			{
				throw new ArgumentOutOfRangeException("index");
			}
			return (Cookie)m_list[index];
		}
	}

	public int Count => m_list.Count;

	public bool IsSynchronized => false;

	public object SyncRoot => this;

	internal bool IsOtherVersionSeen => m_has_other_versions;

	public CookieCollection()
	{
		m_IsReadOnly = true;
	}

	public void Add(Cookie cookie)
	{
		if (cookie == null)
		{
			throw new ArgumentNullException("cookie");
		}
		m_version++;
		int num = IndexOf(cookie);
		if (num == -1)
		{
			m_list.Add(cookie);
		}
		else
		{
			m_list[num] = cookie;
		}
	}

	public void Add(CookieCollection cookies)
	{
		if (cookies == null)
		{
			throw new ArgumentNullException("cookies");
		}
		foreach (Cookie cookie in cookies)
		{
			Add(cookie);
		}
	}

	public void CopyTo(Array array, int index)
	{
		m_list.CopyTo(array, index);
	}

	internal DateTime TimeStamp(Stamp how)
	{
		switch (how)
		{
		case Stamp.Set:
			m_TimeStamp = DateTime.Now;
			break;
		case Stamp.SetToMaxUsed:
			m_TimeStamp = DateTime.MaxValue;
			break;
		case Stamp.SetToUnused:
			m_TimeStamp = DateTime.MinValue;
			break;
		}
		return m_TimeStamp;
	}

	internal int InternalAdd(Cookie cookie, bool isStrict)
	{
		int result = 1;
		if (isStrict)
		{
			IComparer comparer = Cookie.GetComparer();
			int num = 0;
			foreach (Cookie item in m_list)
			{
				if (comparer.Compare(cookie, item) == 0)
				{
					result = 0;
					if (item.Variant <= cookie.Variant)
					{
						m_list[num] = cookie;
					}
					break;
				}
				num++;
			}
			if (num == m_list.Count)
			{
				m_list.Add(cookie);
			}
		}
		else
		{
			m_list.Add(cookie);
		}
		if (cookie.Version != 1)
		{
			m_has_other_versions = true;
		}
		return result;
	}

	internal int IndexOf(Cookie cookie)
	{
		IComparer comparer = Cookie.GetComparer();
		int num = 0;
		foreach (Cookie item in m_list)
		{
			if (comparer.Compare(cookie, item) == 0)
			{
				return num;
			}
			num++;
		}
		return -1;
	}

	internal void RemoveAt(int idx)
	{
		m_list.RemoveAt(idx);
	}

	public IEnumerator GetEnumerator()
	{
		return new CookieCollectionEnumerator(this);
	}
}
