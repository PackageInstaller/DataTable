using System.Text;

namespace System.Security.Util;

internal sealed class Parser
{
	private SecurityDocument _doc;

	private Tokenizer _t;

	internal SecurityElement GetTopElement()
	{
		return _doc.GetRootElement();
	}

	private void GetRequiredSizes(TokenizerStream stream, ref int index)
	{
		bool flag = false;
		bool flag2 = false;
		bool flag3 = false;
		bool flag4 = false;
		int num = 1;
		SecurityElementType securityElementType = SecurityElementType.Regular;
		string text = null;
		bool flag5 = false;
		bool flag6 = false;
		int num2 = 0;
		do
		{
			short nextToken;
			for (nextToken = stream.GetNextToken(); nextToken != -1; nextToken = stream.GetNextToken())
			{
				switch (nextToken & 0xFF)
				{
				case 3:
					if (flag4)
					{
						if (securityElementType == SecurityElementType.Comment)
						{
							stream.ThrowAwayNextString();
							stream.TagLastToken(20480);
						}
						else if (text == null)
						{
							text = stream.GetNextString();
						}
						else
						{
							if (!flag5)
							{
								throw new XmlSyntaxException(_t.LineNo);
							}
							stream.TagLastToken(16896);
							index += SecurityDocument.EncodedStringSize(text) + SecurityDocument.EncodedStringSize(stream.GetNextString()) + 1;
							text = null;
							flag5 = false;
						}
					}
					else if (flag6)
					{
						stream.TagLastToken(25344);
						index += SecurityDocument.EncodedStringSize(stream.GetNextString()) + SecurityDocument.EncodedStringSize(" ");
					}
					else
					{
						stream.TagLastToken(17152);
						index += SecurityDocument.EncodedStringSize(stream.GetNextString()) + 1;
						flag6 = true;
					}
					goto IL_03b9;
				case 0:
					flag4 = true;
					flag6 = false;
					nextToken = stream.GetNextToken();
					switch (nextToken)
					{
					case 2:
						stream.TagLastToken(17408);
						while (true)
						{
							nextToken = stream.GetNextToken();
							switch (nextToken)
							{
							case 3:
								goto IL_0152;
							case -1:
								throw new XmlSyntaxException(_t.LineNo, Environment.GetResourceString("Unexpected end of file."));
							default:
								throw new XmlSyntaxException(_t.LineNo, Environment.GetResourceString("Expected > character."));
							case 1:
								break;
							}
							break;
							IL_0152:
							stream.ThrowAwayNextString();
							stream.TagLastToken(20480);
						}
						flag4 = false;
						index++;
						flag6 = false;
						num--;
						flag = true;
						break;
					case 3:
						flag3 = true;
						stream.TagLastToken(16640);
						index += SecurityDocument.EncodedStringSize(stream.GetNextString()) + 1;
						if (securityElementType != SecurityElementType.Regular)
						{
							throw new XmlSyntaxException(_t.LineNo);
						}
						flag = true;
						num++;
						break;
					case 6:
						num2 = 1;
						do
						{
							nextToken = stream.GetNextToken();
							switch (nextToken)
							{
							case 0:
								num2++;
								break;
							case 1:
								num2--;
								break;
							case 3:
								stream.ThrowAwayNextString();
								stream.TagLastToken(20480);
								break;
							}
						}
						while (num2 > 0);
						flag4 = false;
						flag6 = false;
						flag = true;
						break;
					case 5:
						nextToken = stream.GetNextToken();
						if (nextToken != 3)
						{
							throw new XmlSyntaxException(_t.LineNo);
						}
						flag3 = true;
						securityElementType = SecurityElementType.Format;
						stream.TagLastToken(16640);
						index += SecurityDocument.EncodedStringSize(stream.GetNextString()) + 1;
						num2 = 1;
						num++;
						flag = true;
						break;
					default:
						throw new XmlSyntaxException(_t.LineNo, Environment.GetResourceString("Expected / character or string."));
					}
					goto IL_03b9;
				case 4:
					flag5 = true;
					goto IL_03b9;
				case 1:
					if (flag4)
					{
						flag4 = false;
						continue;
					}
					throw new XmlSyntaxException(_t.LineNo, Environment.GetResourceString("Unexpected > character."));
				case 2:
					nextToken = stream.GetNextToken();
					if (nextToken == 1)
					{
						stream.TagLastToken(17408);
						index++;
						num--;
						flag6 = false;
						flag = true;
						goto IL_03b9;
					}
					throw new XmlSyntaxException(_t.LineNo, Environment.GetResourceString("Expected > character."));
				case 5:
					if (flag4 && securityElementType == SecurityElementType.Format && num2 == 1)
					{
						nextToken = stream.GetNextToken();
						if (nextToken == 1)
						{
							stream.TagLastToken(17408);
							index++;
							num--;
							flag6 = false;
							flag = true;
							goto IL_03b9;
						}
						throw new XmlSyntaxException(_t.LineNo, Environment.GetResourceString("Expected > character."));
					}
					throw new XmlSyntaxException(_t.LineNo);
				default:
					{
						throw new XmlSyntaxException(_t.LineNo);
					}
					IL_03b9:
					if (!flag)
					{
						flag2 = true;
						continue;
					}
					break;
				}
				flag = false;
				flag2 = false;
				break;
			}
			if (flag2)
			{
				index++;
				num--;
				flag6 = false;
			}
			else if (nextToken == -1 && (num != 1 || !flag3))
			{
				throw new XmlSyntaxException(_t.LineNo, Environment.GetResourceString("Unexpected end of file."));
			}
		}
		while (num > 1);
	}

	private int DetermineFormat(TokenizerStream stream)
	{
		if (stream.GetNextToken() == 0 && stream.GetNextToken() == 5)
		{
			_t.GetTokens(stream, -1, endAfterKet: true);
			stream.GoToPosition(2);
			bool flag = false;
			bool flag2 = false;
			short nextToken = stream.GetNextToken();
			while (true)
			{
				switch (nextToken)
				{
				case 3:
					if (flag & flag2)
					{
						_t.ChangeFormat(Encoding.GetEncoding(stream.GetNextString()));
						return 0;
					}
					if (!flag)
					{
						if (string.Compare(stream.GetNextString(), "encoding", StringComparison.Ordinal) == 0)
						{
							flag2 = true;
						}
					}
					else
					{
						flag = false;
						flag2 = false;
						stream.ThrowAwayNextString();
					}
					break;
				case 4:
					flag = true;
					break;
				default:
					throw new XmlSyntaxException(_t.LineNo, Environment.GetResourceString("Unexpected end of file."));
				case -1:
				case 1:
					return 0;
				}
				nextToken = stream.GetNextToken();
			}
		}
		return 2;
	}

	private void ParseContents()
	{
		TokenizerStream tokenizerStream = new TokenizerStream();
		_t.GetTokens(tokenizerStream, 2, endAfterKet: false);
		tokenizerStream.Reset();
		int position = DetermineFormat(tokenizerStream);
		tokenizerStream.GoToPosition(position);
		_t.GetTokens(tokenizerStream, -1, endAfterKet: false);
		tokenizerStream.Reset();
		int index = 0;
		GetRequiredSizes(tokenizerStream, ref index);
		_doc = new SecurityDocument(index);
		int position2 = 0;
		tokenizerStream.Reset();
		for (short nextFullToken = tokenizerStream.GetNextFullToken(); nextFullToken != -1; nextFullToken = tokenizerStream.GetNextFullToken())
		{
			if ((nextFullToken & 0x4000) == 16384)
			{
				switch ((short)(nextFullToken & 0xFF00))
				{
				case 16640:
					_doc.AddToken(1, ref position2);
					_doc.AddString(tokenizerStream.GetNextString(), ref position2);
					break;
				case 16896:
					_doc.AddToken(2, ref position2);
					_doc.AddString(tokenizerStream.GetNextString(), ref position2);
					_doc.AddString(tokenizerStream.GetNextString(), ref position2);
					break;
				case 17152:
					_doc.AddToken(3, ref position2);
					_doc.AddString(tokenizerStream.GetNextString(), ref position2);
					break;
				case 25344:
					_doc.AppendString(" ", ref position2);
					_doc.AppendString(tokenizerStream.GetNextString(), ref position2);
					break;
				case 17408:
					_doc.AddToken(4, ref position2);
					break;
				case 20480:
					tokenizerStream.ThrowAwayNextString();
					break;
				default:
					throw new XmlSyntaxException();
				}
			}
		}
	}

	private Parser(Tokenizer t)
	{
		_t = t;
		_doc = null;
		try
		{
			ParseContents();
		}
		finally
		{
			_t.Recycle();
		}
	}

	internal Parser(string input)
		: this(new Tokenizer(input))
	{
	}
}
