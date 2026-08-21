using System;

namespace UnityEngine.InputSystem.Utilities;

internal struct PredictiveParser
{
	private int m_Position;

	public void ExpectSingleChar(ReadOnlySpan<char> str, char c)
	{
		if (str[m_Position] != c)
		{
			throw new InvalidOperationException($"Expected a '{c}' character at position {m_Position} in : {str.ToString()}");
		}
		m_Position++;
	}

	public int ExpectInt(ReadOnlySpan<char> str)
	{
		int num = m_Position;
		int num2 = 1;
		if (str[num] == '-')
		{
			num2 = -1;
			num++;
		}
		int num3 = 0;
		while (true)
		{
			char c = str[num];
			if (c < '0' || c > '9')
			{
				break;
			}
			num3 *= 10;
			num3 += c - 48;
			num++;
		}
		if (m_Position == num)
		{
			throw new InvalidOperationException($"Expected an int at position {m_Position} in {str.ToString()}");
		}
		m_Position = num;
		return num3 * num2;
	}

	public ReadOnlySpan<char> ExpectString(ReadOnlySpan<char> str)
	{
		int position = m_Position;
		if (str[position] != '"')
		{
			throw new InvalidOperationException($"Expected a '\"' character at position {m_Position} in {str.ToString()}");
		}
		m_Position++;
		while (true)
		{
			char c = str[m_Position];
			c = (char)(c | 0x20);
			if (c < 'a' || c > 'z')
			{
				break;
			}
			m_Position++;
		}
		if (str[m_Position] != '"')
		{
			throw new InvalidOperationException($"Expected a closing '\"' character at position {m_Position} in string: {str.ToString()}");
		}
		if (m_Position - position == 1)
		{
			return ReadOnlySpan<char>.Empty;
		}
		ReadOnlySpan<char> result = str.Slice(position + 1, m_Position - position - 1);
		m_Position++;
		return result;
	}

	public bool AcceptSingleChar(ReadOnlySpan<char> str, char c)
	{
		if (str[m_Position] != c)
		{
			return false;
		}
		m_Position++;
		return true;
	}

	public bool AcceptString(ReadOnlySpan<char> input, out ReadOnlySpan<char> output)
	{
		output = default(ReadOnlySpan<char>);
		int position = m_Position;
		int num = position;
		if (input[num] != '"')
		{
			return false;
		}
		num++;
		while (true)
		{
			char c = input[num];
			c = (char)(c | 0x20);
			if (c < 'a' || c > 'z')
			{
				break;
			}
			num++;
		}
		if (input[num] != '"')
		{
			return false;
		}
		if (m_Position - position == 1)
		{
			output = ReadOnlySpan<char>.Empty;
		}
		else
		{
			output = input.Slice(position + 1, num - position - 1);
		}
		m_Position = num + 1;
		return true;
	}

	public void AcceptInt(ReadOnlySpan<char> str)
	{
		if (str[m_Position] == '-')
		{
			m_Position++;
		}
		while (true)
		{
			char c = str[m_Position];
			if (c >= '0' && c <= '9')
			{
				m_Position++;
				continue;
			}
			break;
		}
	}
}
