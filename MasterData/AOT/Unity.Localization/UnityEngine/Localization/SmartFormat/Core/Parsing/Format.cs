using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using UnityEngine.Pool;

namespace UnityEngine.Localization.SmartFormat.Core.Parsing;

public class Format : FormatItem
{
	internal class SplitList : IList<Format>, ICollection<Format>, IEnumerable<Format>, IEnumerable
	{
		private Format m_Format;

		private List<int> m_Splits;

		private List<Format> m_FormatCache = new List<Format>();

		public Format this[int index]
		{
			get
			{
				if (index > m_Splits.Count)
				{
					throw new ArgumentOutOfRangeException("index");
				}
				if (m_Splits.Count == 0)
				{
					return m_Format;
				}
				if (m_FormatCache[index] != null)
				{
					return m_FormatCache[index];
				}
				if (index == 0)
				{
					Format format = m_Format.Substring(0, m_Splits[0]);
					m_FormatCache[index] = format;
					return format;
				}
				if (index == m_Splits.Count)
				{
					Format format2 = m_Format.Substring(m_Splits[index - 1] + 1);
					m_FormatCache[index] = format2;
					return format2;
				}
				int num = m_Splits[index - 1] + 1;
				Format format3 = m_Format.Substring(num, m_Splits[index] - num);
				m_FormatCache[index] = format3;
				return format3;
			}
			set
			{
				throw new NotSupportedException();
			}
		}

		public int Count => m_Splits.Count + 1;

		public bool IsReadOnly => true;

		public void Init(Format format, List<int> splits)
		{
			m_Format = format;
			m_Splits = splits;
			for (int i = 0; i < Count; i++)
			{
				m_FormatCache.Add(null);
			}
		}

		public void CopyTo(Format[] array, int arrayIndex)
		{
			int num = m_Splits.Count + 1;
			for (int i = 0; i < num; i++)
			{
				array[arrayIndex + i] = this[i];
			}
		}

		public int IndexOf(Format item)
		{
			throw new NotSupportedException();
		}

		public void Insert(int index, Format item)
		{
			throw new NotSupportedException();
		}

		public void RemoveAt(int index)
		{
			throw new NotSupportedException();
		}

		public void Add(Format item)
		{
			throw new NotSupportedException();
		}

		public void Clear()
		{
			m_Format = null;
			CollectionPool<List<int>, int>.Release(m_Splits);
			m_Splits = null;
			for (int i = 0; i < m_FormatCache.Count; i++)
			{
				if (m_FormatCache[i] != null)
				{
					FormatItemPool.ReleaseFormat(m_FormatCache[i]);
				}
			}
			m_FormatCache.Clear();
		}

		public bool Contains(Format item)
		{
			throw new NotSupportedException();
		}

		public bool Remove(Format item)
		{
			throw new NotSupportedException();
		}

		public IEnumerator<Format> GetEnumerator()
		{
			throw new NotSupportedException();
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			throw new NotSupportedException();
		}
	}

	public Placeholder parent;

	private List<SplitList> m_Splits = new List<SplitList>();

	private char splitCacheChar;

	private IList<Format> splitCache;

	public List<FormatItem> Items { get; } = new List<FormatItem>();

	public bool HasNested { get; set; }

	public void ReleaseToPool()
	{
		Clear();
		foreach (FormatItem item in Items)
		{
			if (this == item.Parent)
			{
				FormatItemPool.Release(item);
			}
		}
		foreach (SplitList split in m_Splits)
		{
			SplitListPool.Release(split);
		}
		parent = null;
		Items.Clear();
		HasNested = false;
		splitCache = null;
		m_Splits.Clear();
	}

	public Format Substring(int startIndex)
	{
		return Substring(startIndex, endIndex - base.startIndex - startIndex);
	}

	public Format Substring(int startIndex, int length)
	{
		startIndex = base.startIndex + startIndex;
		int num = startIndex + length;
		if (startIndex < base.startIndex || startIndex > endIndex)
		{
			throw new ArgumentOutOfRangeException("startIndex");
		}
		if (num > endIndex)
		{
			throw new ArgumentOutOfRangeException("length");
		}
		if (startIndex == base.startIndex && num == endIndex)
		{
			return this;
		}
		Format format = FormatItemPool.GetFormat(SmartSettings, baseString, startIndex, num);
		foreach (FormatItem item2 in Items)
		{
			if (item2.endIndex <= startIndex)
			{
				continue;
			}
			if (num <= item2.startIndex)
			{
				break;
			}
			FormatItem item = item2;
			if (item2 is LiteralText)
			{
				if (startIndex > item2.startIndex || item2.endIndex > num)
				{
					item = FormatItemPool.GetLiteralText(SmartSettings, format, Math.Max(startIndex, item2.startIndex), Math.Min(num, item2.endIndex));
				}
			}
			else
			{
				format.HasNested = true;
			}
			format.Items.Add(item);
		}
		return format;
	}

	public int IndexOf(char search)
	{
		return IndexOf(search, 0);
	}

	public int IndexOf(char search, int startIndex)
	{
		startIndex = base.startIndex + startIndex;
		foreach (FormatItem item in Items)
		{
			if (item.endIndex >= startIndex && item is LiteralText literalText)
			{
				if (startIndex < literalText.startIndex)
				{
					startIndex = literalText.startIndex;
				}
				int num = literalText.baseString.IndexOf(search, startIndex, literalText.endIndex - startIndex);
				if (num != -1)
				{
					return num - base.startIndex;
				}
			}
		}
		return -1;
	}

	private List<int> FindAll(char search)
	{
		return FindAll(search, -1);
	}

	private List<int> FindAll(char search, int maxCount)
	{
		List<int> list = CollectionPool<List<int>, int>.Get();
		int num = 0;
		while (maxCount != 0)
		{
			num = IndexOf(search, num);
			if (num == -1)
			{
				break;
			}
			list.Add(num);
			num++;
			maxCount--;
		}
		return list;
	}

	public IList<Format> Split(char search)
	{
		if (splitCache == null || splitCacheChar != search)
		{
			splitCacheChar = search;
			splitCache = Split(search, -1);
		}
		return splitCache;
	}

	public IList<Format> Split(char search, int maxCount)
	{
		List<int> splits = FindAll(search, maxCount);
		SplitList splitList = SplitListPool.Get(this, splits);
		m_Splits.Add(splitList);
		return splitList;
	}

	public string GetLiteralText()
	{
		StringBuilder value;
		using (StringBuilderPool.Get(out value))
		{
			foreach (FormatItem item in Items)
			{
				if (item is LiteralText value2)
				{
					value.Append(value2);
				}
			}
			return value.ToString();
		}
	}

	public override string ToString()
	{
		StringBuilder value;
		using (StringBuilderPool.Get(out value))
		{
			int num = endIndex - startIndex;
			if (value.Capacity < num)
			{
				value.Capacity = num;
			}
			foreach (FormatItem item in Items)
			{
				value.Append(item);
			}
			return value.ToString();
		}
	}
}
