using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GameFramework.Runtime;

public class TextPathParser : IEnumerator<char>, IDisposable, IEnumerator
{
	protected string text;

	protected int total = 0;

	protected int pos = -1;

	protected Path path = null;

	public char Current => text[pos];

	object IEnumerator.Current => text[pos];

	public TextPathParser(string text)
	{
		if (string.IsNullOrEmpty(text))
		{
			throw new ArgumentException("Invalid argument", "text");
		}
		this.text = text.Replace(" ", "");
		if (string.IsNullOrEmpty(this.text) || this.text.StartsWith("."))
		{
			throw new ArgumentException("Invalid argument", "text");
		}
		total = this.text.Length;
		pos = -1;
	}

	public void Dispose()
	{
		text = null;
		pos = -1;
	}

	public bool MoveNext()
	{
		if (pos++ < total - 1)
		{
			return true;
		}
		return false;
	}

	public void Reset()
	{
		pos = -1;
	}

	protected bool IsEOF()
	{
		return pos >= total;
	}

	public Path Parse()
	{
		if (path != null)
		{
			return path;
		}
		path = new Path();
		MoveNext();
		do
		{
			SkipWhiteSpaceAndCharacters('.');
			if (IsEOF())
			{
				break;
			}
			if (Current.Equals('['))
			{
				ReadIndex();
				SkipWhiteSpace();
				if (!Current.Equals(']'))
				{
					throw new BindingException("Error parsing indexer , unterminated in text {0}", text);
				}
				if (MoveNext() && !Current.Equals('.'))
				{
					throw new BindingException("Error parsing path , unterminated in text {0}", text);
				}
			}
			else
			{
				if (!char.IsLetter(Current) && Current != '_')
				{
					throw new BindingException("Error parsing path , unterminated in text {0}", text);
				}
				ParseMemberName();
				if (!IsEOF() && !Current.Equals('.') && !Current.Equals('[') && !char.IsWhiteSpace(Current))
				{
					throw new BindingException("Error parsing path , unterminated in text {0}", text);
				}
			}
		}
		while (!IsEOF());
		return path;
	}

	protected void ReadIndex()
	{
		if (!MoveNext())
		{
			throw new BindingException("Error parsing string indexer , unterminated in text {0}", text);
		}
		char current = Current;
		if (current == '\'' || current == '"')
		{
			string indexValue = ReadQuotedString();
			path.AppendIndexed(indexValue);
			MoveNext();
			return;
		}
		if (char.IsDigit(current))
		{
			uint indexValue2 = ReadUnsignedInteger();
			path.AppendIndexed((int)indexValue2);
			return;
		}
		throw new BindingException("Error parsing indexer , unterminated in text {0}", text);
	}

	protected void ParseMemberName()
	{
		StringBuilder stringBuilder = new StringBuilder();
		do
		{
			char current = Current;
			if (!char.IsLetterOrDigit(current) && current != '_')
			{
				break;
			}
			stringBuilder.Append(current);
		}
		while (MoveNext());
		if (stringBuilder.Length <= 0)
		{
			throw new BindingException("Error parsing member name , unterminated in text {0}", text);
		}
		path.Append(new MemberNode(stringBuilder.ToString()));
	}

	protected uint ReadUnsignedInteger()
	{
		StringBuilder stringBuilder = new StringBuilder();
		while (char.IsDigit(Current))
		{
			stringBuilder.Append(Current);
			if (!MoveNext())
			{
				break;
			}
		}
		if (!uint.TryParse(stringBuilder.ToString(), out var result))
		{
			throw new BindingException("Unable to parse integer text from {0} in {1}", stringBuilder.ToString(), text);
		}
		return result;
	}

	protected string ReadQuotedString()
	{
		char current = Current;
		if (current != '\'' && current != '"')
		{
			throw new BindingException("Error parsing string indexer , unexpected quote character {0} in text {1}", current, text);
		}
		if (!MoveNext())
		{
			throw new BindingException("Error parsing string indexer , unterminated in text {0}", text);
		}
		StringBuilder stringBuilder = new StringBuilder();
		do
		{
			current = Current;
			if (!char.IsLetterOrDigit(current) && current != '_' && current != '-')
			{
				break;
			}
			stringBuilder.Append(current);
		}
		while (MoveNext());
		if (stringBuilder.Length <= 0 || (current != '\'' && current != '"'))
		{
			throw new BindingException("Error parsing string indexer , unexpected quote character {0} in text {1}", current, text);
		}
		return stringBuilder.ToString();
	}

	protected void SkipWhiteSpace()
	{
		while (char.IsWhiteSpace(Current) && MoveNext())
		{
		}
	}

	protected bool IsWhiteSpaceOrCharacter(char ch, params char[] characters)
	{
		return char.IsWhiteSpace(ch) || characters.Contains(ch);
	}

	protected void SkipWhiteSpaceAndCharacters(params char[] characters)
	{
		while (IsWhiteSpaceOrCharacter(Current, characters) && MoveNext())
		{
		}
	}
}
