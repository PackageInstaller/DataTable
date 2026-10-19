using System.Text;
using UnityEngine.Pool;

namespace UnityEngine.Localization.Pseudo;

public abstract class MessageFragment
{
	protected string m_OriginalString;

	protected int m_StartIndex;

	protected int m_EndIndex;

	private string m_CachedToString;

	public int Length
	{
		get
		{
			if (m_StartIndex != -1)
			{
				return m_EndIndex - m_StartIndex;
			}
			return m_OriginalString.Length;
		}
	}

	public Message Message { get; private set; }

	public char this[int index]
	{
		get
		{
			int num = ((m_StartIndex != -1) ? m_StartIndex : 0);
			return m_OriginalString[num + index];
		}
	}

	internal void Initialize(Message parent, string original, int start, int end)
	{
		Message = parent;
		m_OriginalString = original;
		m_StartIndex = start;
		m_EndIndex = end;
		m_CachedToString = null;
	}

	internal void Initialize(Message parent, string text)
	{
		Message = parent;
		m_OriginalString = text;
		m_StartIndex = -1;
		m_EndIndex = -1;
		m_CachedToString = null;
	}

	public WritableMessageFragment CreateTextFragment(int start, int end)
	{
		WritableMessageFragment writableMessageFragment = GenericPool<WritableMessageFragment>.Get();
		writableMessageFragment.Initialize(start: (m_StartIndex == -1) ? start : (m_StartIndex + start), end: (m_StartIndex == -1) ? end : (m_StartIndex + end), parent: Message, original: m_OriginalString);
		return writableMessageFragment;
	}

	public ReadOnlyMessageFragment CreateReadonlyTextFragment(int start, int end)
	{
		ReadOnlyMessageFragment readOnlyMessageFragment = GenericPool<ReadOnlyMessageFragment>.Get();
		readOnlyMessageFragment.Initialize(start: (m_StartIndex == -1) ? start : (m_StartIndex + start), end: (m_StartIndex == -1) ? end : (m_StartIndex + end), parent: Message, original: m_OriginalString);
		return readOnlyMessageFragment;
	}

	public override string ToString()
	{
		if (m_CachedToString == null)
		{
			m_CachedToString = ((m_StartIndex == -1) ? m_OriginalString : m_OriginalString.Substring(m_StartIndex, m_EndIndex - m_StartIndex));
		}
		return m_CachedToString;
	}

	internal void BuildString(StringBuilder builder)
	{
		if (m_StartIndex == -1)
		{
			builder.Append(m_OriginalString);
		}
		else
		{
			builder.Append(m_OriginalString, m_StartIndex, m_EndIndex - m_StartIndex);
		}
	}
}
