namespace System.Security.Util;

internal sealed class TokenizerStream
{
	private int m_countTokens;

	private TokenizerShortBlock m_headTokens;

	private TokenizerShortBlock m_lastTokens;

	private TokenizerShortBlock m_currentTokens;

	private int m_indexTokens;

	private TokenizerStringBlock m_headStrings;

	private TokenizerStringBlock m_currentStrings;

	private int m_indexStrings;

	internal TokenizerStream()
	{
		m_countTokens = 0;
		m_headTokens = new TokenizerShortBlock();
		m_headStrings = new TokenizerStringBlock();
		Reset();
	}

	internal void AddToken(short token)
	{
		if (m_currentTokens.m_block.Length <= m_indexTokens)
		{
			m_currentTokens.m_next = new TokenizerShortBlock();
			m_currentTokens = m_currentTokens.m_next;
			m_indexTokens = 0;
		}
		m_countTokens++;
		m_currentTokens.m_block[m_indexTokens++] = token;
	}

	internal void AddString(string str)
	{
		if (m_currentStrings.m_block.Length <= m_indexStrings)
		{
			m_currentStrings.m_next = new TokenizerStringBlock();
			m_currentStrings = m_currentStrings.m_next;
			m_indexStrings = 0;
		}
		m_currentStrings.m_block[m_indexStrings++] = str;
	}

	internal void Reset()
	{
		m_lastTokens = null;
		m_currentTokens = m_headTokens;
		m_currentStrings = m_headStrings;
		m_indexTokens = 0;
		m_indexStrings = 0;
	}

	internal short GetNextFullToken()
	{
		if (m_currentTokens.m_block.Length <= m_indexTokens)
		{
			m_lastTokens = m_currentTokens;
			m_currentTokens = m_currentTokens.m_next;
			m_indexTokens = 0;
		}
		return m_currentTokens.m_block[m_indexTokens++];
	}

	internal short GetNextToken()
	{
		return (short)(GetNextFullToken() & 0xFF);
	}

	internal string GetNextString()
	{
		if (m_currentStrings.m_block.Length <= m_indexStrings)
		{
			m_currentStrings = m_currentStrings.m_next;
			m_indexStrings = 0;
		}
		return m_currentStrings.m_block[m_indexStrings++];
	}

	internal void ThrowAwayNextString()
	{
		GetNextString();
	}

	internal void TagLastToken(short tag)
	{
		if (m_indexTokens == 0)
		{
			m_lastTokens.m_block[m_lastTokens.m_block.Length - 1] = (short)((ushort)m_lastTokens.m_block[m_lastTokens.m_block.Length - 1] | (ushort)tag);
		}
		else
		{
			m_currentTokens.m_block[m_indexTokens - 1] = (short)((ushort)m_currentTokens.m_block[m_indexTokens - 1] | (ushort)tag);
		}
	}

	internal int GetTokenCount()
	{
		return m_countTokens;
	}

	internal void GoToPosition(int position)
	{
		Reset();
		for (int i = 0; i < position; i++)
		{
			if (GetNextToken() == 3)
			{
				ThrowAwayNextString();
			}
		}
	}
}
