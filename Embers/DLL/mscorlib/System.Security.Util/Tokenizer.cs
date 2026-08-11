using System.IO;
using System.Text;

namespace System.Security.Util;

internal sealed class Tokenizer
{
	private enum TokenSource
	{
		UnicodeByteArray,
		UTF8ByteArray,
		ASCIIByteArray,
		CharArray,
		String,
		NestedStrings,
		Other
	}

	[Serializable]
	internal sealed class StringMaker
	{
		private string[] aStrings;

		private uint cStringsMax;

		private uint cStringsUsed;

		public StringBuilder _outStringBuilder;

		public char[] _outChars;

		public int _outIndex;

		private static uint HashString(string str)
		{
			uint num = 0u;
			int length = str.Length;
			for (int i = 0; i < length; i++)
			{
				num = (num << 3) ^ str[i] ^ (num >> 29);
			}
			return num;
		}

		private static uint HashCharArray(char[] a, int l)
		{
			uint num = 0u;
			for (int i = 0; i < l; i++)
			{
				num = (num << 3) ^ a[i] ^ (num >> 29);
			}
			return num;
		}

		public StringMaker()
		{
			cStringsMax = 2048u;
			cStringsUsed = 0u;
			aStrings = new string[cStringsMax];
			_outChars = new char[512];
		}

		private bool CompareStringAndChars(string str, char[] a, int l)
		{
			if (str.Length != l)
			{
				return false;
			}
			for (int i = 0; i < l; i++)
			{
				if (a[i] != str[i])
				{
					return false;
				}
			}
			return true;
		}

		public string MakeString()
		{
			char[] outChars = _outChars;
			int outIndex = _outIndex;
			if (_outStringBuilder != null)
			{
				_outStringBuilder.Append(_outChars, 0, _outIndex);
				return _outStringBuilder.ToString();
			}
			uint num2;
			if (cStringsUsed > cStringsMax / 4 * 3)
			{
				uint num = cStringsMax * 2;
				string[] array = new string[num];
				for (int i = 0; i < cStringsMax; i++)
				{
					if (aStrings[i] == null)
					{
						continue;
					}
					num2 = HashString(aStrings[i]) % num;
					while (array[num2] != null)
					{
						if (++num2 >= num)
						{
							num2 = 0u;
						}
					}
					array[num2] = aStrings[i];
				}
				cStringsMax = num;
				aStrings = array;
			}
			num2 = HashCharArray(outChars, outIndex) % cStringsMax;
			string text;
			while ((text = aStrings[num2]) != null)
			{
				if (CompareStringAndChars(text, outChars, outIndex))
				{
					return text;
				}
				if (++num2 >= cStringsMax)
				{
					num2 = 0u;
				}
			}
			text = new string(outChars, 0, outIndex);
			aStrings[num2] = text;
			cStringsUsed++;
			return text;
		}
	}

	internal interface ITokenReader
	{
		int Read();
	}

	internal class StreamTokenReader : ITokenReader
	{
		internal StreamReader _in;

		internal int _numCharRead;

		internal int NumCharEncountered => _numCharRead;

		internal StreamTokenReader(StreamReader input)
		{
			_in = input;
			_numCharRead = 0;
		}

		public virtual int Read()
		{
			int num = _in.Read();
			if (num != -1)
			{
				_numCharRead++;
			}
			return num;
		}
	}

	public int LineNo;

	private int _inProcessingTag;

	private byte[] _inBytes;

	private char[] _inChars;

	private string _inString;

	private int _inIndex;

	private int _inSize;

	private int _inSavedCharacter;

	private TokenSource _inTokenSource;

	private ITokenReader _inTokenReader;

	private StringMaker _maker;

	private string[] _searchStrings;

	private string[] _replaceStrings;

	private int _inNestedIndex;

	private int _inNestedSize;

	private string _inNestedString;

	internal void BasicInitialization()
	{
		LineNo = 1;
		_inProcessingTag = 0;
		_inSavedCharacter = -1;
		_inIndex = 0;
		_inSize = 0;
		_inNestedSize = 0;
		_inNestedIndex = 0;
		_inTokenSource = TokenSource.Other;
		_maker = SharedStatics.GetSharedStringMaker();
	}

	public void Recycle()
	{
		SharedStatics.ReleaseSharedStringMaker(ref _maker);
	}

	internal Tokenizer(string input)
	{
		BasicInitialization();
		_inString = input;
		_inSize = input.Length;
		_inTokenSource = TokenSource.String;
	}

	internal void ChangeFormat(Encoding encoding)
	{
		if (encoding == null)
		{
			return;
		}
		switch (_inTokenSource)
		{
		case TokenSource.UnicodeByteArray:
		case TokenSource.UTF8ByteArray:
		case TokenSource.ASCIIByteArray:
			if (encoding == Encoding.Unicode)
			{
				_inTokenSource = TokenSource.UnicodeByteArray;
				return;
			}
			if (encoding == Encoding.UTF8)
			{
				_inTokenSource = TokenSource.UTF8ByteArray;
				return;
			}
			if (encoding == Encoding.ASCII)
			{
				_inTokenSource = TokenSource.ASCIIByteArray;
				return;
			}
			break;
		case TokenSource.CharArray:
		case TokenSource.String:
		case TokenSource.NestedStrings:
			return;
		}
		Stream stream = null;
		switch (_inTokenSource)
		{
		case TokenSource.UnicodeByteArray:
		case TokenSource.UTF8ByteArray:
		case TokenSource.ASCIIByteArray:
			stream = new MemoryStream(_inBytes, _inIndex, _inSize - _inIndex);
			break;
		case TokenSource.CharArray:
		case TokenSource.String:
		case TokenSource.NestedStrings:
			return;
		default:
		{
			if (!(_inTokenReader is StreamTokenReader streamTokenReader))
			{
				return;
			}
			stream = streamTokenReader._in.BaseStream;
			string s = new string(' ', streamTokenReader.NumCharEncountered);
			stream.Position = streamTokenReader._in.CurrentEncoding.GetByteCount(s);
			break;
		}
		}
		_inTokenReader = new StreamTokenReader(new StreamReader(stream, encoding));
		_inTokenSource = TokenSource.Other;
	}

	internal void GetTokens(TokenizerStream stream, int maxNum, bool endAfterKet)
	{
		while (maxNum == -1 || stream.GetTokenCount() < maxNum)
		{
			int num = -1;
			int num2 = 0;
			bool flag = false;
			bool flag2 = false;
			StringMaker maker = _maker;
			maker._outStringBuilder = null;
			maker._outIndex = 0;
			while (true)
			{
				if (_inSavedCharacter != -1)
				{
					num = _inSavedCharacter;
					_inSavedCharacter = -1;
				}
				else
				{
					switch (_inTokenSource)
					{
					case TokenSource.UnicodeByteArray:
						if (_inIndex + 1 >= _inSize)
						{
							stream.AddToken(-1);
							return;
						}
						num = (_inBytes[_inIndex + 1] << 8) + _inBytes[_inIndex];
						_inIndex += 2;
						break;
					case TokenSource.UTF8ByteArray:
					{
						if (_inIndex >= _inSize)
						{
							stream.AddToken(-1);
							return;
						}
						num = _inBytes[_inIndex++];
						if ((num & 0x80) == 0)
						{
							break;
						}
						switch ((num & 0xF0) >> 4)
						{
						case 8:
						case 9:
						case 10:
						case 11:
							throw new XmlSyntaxException(LineNo);
						case 12:
						case 13:
							num &= 0x1F;
							num2 = 2;
							break;
						case 14:
							num &= 0xF;
							num2 = 3;
							break;
						case 15:
							throw new XmlSyntaxException(LineNo);
						}
						if (_inIndex >= _inSize)
						{
							throw new XmlSyntaxException(LineNo, Environment.GetResourceString("Unexpected end of file."));
						}
						byte b = _inBytes[_inIndex++];
						if ((b & 0xC0) != 128)
						{
							throw new XmlSyntaxException(LineNo);
						}
						num = (num << 6) | (b & 0x3F);
						if (num2 != 2)
						{
							if (_inIndex >= _inSize)
							{
								throw new XmlSyntaxException(LineNo, Environment.GetResourceString("Unexpected end of file."));
							}
							b = _inBytes[_inIndex++];
							if ((b & 0xC0) != 128)
							{
								throw new XmlSyntaxException(LineNo);
							}
							num = (num << 6) | (b & 0x3F);
						}
						break;
					}
					case TokenSource.ASCIIByteArray:
						if (_inIndex >= _inSize)
						{
							stream.AddToken(-1);
							return;
						}
						num = _inBytes[_inIndex++];
						break;
					case TokenSource.CharArray:
						if (_inIndex >= _inSize)
						{
							stream.AddToken(-1);
							return;
						}
						num = _inChars[_inIndex++];
						break;
					case TokenSource.String:
						if (_inIndex >= _inSize)
						{
							stream.AddToken(-1);
							return;
						}
						num = _inString[_inIndex++];
						break;
					case TokenSource.NestedStrings:
					{
						if (_inNestedSize != 0)
						{
							if (_inNestedIndex < _inNestedSize)
							{
								num = _inNestedString[_inNestedIndex++];
								break;
							}
							_inNestedSize = 0;
						}
						if (_inIndex >= _inSize)
						{
							stream.AddToken(-1);
							return;
						}
						num = _inString[_inIndex++];
						if (num != 123)
						{
							break;
						}
						for (int i = 0; i < _searchStrings.Length; i++)
						{
							if (string.Compare(_searchStrings[i], 0, _inString, _inIndex - 1, _searchStrings[i].Length, StringComparison.Ordinal) == 0)
							{
								_inNestedString = _replaceStrings[i];
								_inNestedSize = _inNestedString.Length;
								_inNestedIndex = 1;
								num = _inNestedString[0];
								_inIndex += _searchStrings[i].Length - 1;
								break;
							}
						}
						break;
					}
					default:
						num = _inTokenReader.Read();
						if (num == -1)
						{
							stream.AddToken(-1);
							return;
						}
						break;
					}
				}
				if (!flag)
				{
					switch (num)
					{
					case 9:
					case 13:
					case 32:
						break;
					case 10:
						LineNo++;
						break;
					case 60:
						goto IL_048a;
					case 62:
						goto IL_04a4;
					case 61:
						goto IL_04c0;
					case 47:
						goto IL_04cc;
					case 63:
						goto IL_04e3;
					case 33:
						goto IL_04fa;
					case 45:
						goto IL_0511;
					case 34:
						flag = true;
						flag2 = true;
						break;
					default:
						goto IL_062f;
					}
					continue;
				}
				switch (num)
				{
				case 60:
					break;
				case 47:
				case 61:
				case 62:
					goto IL_05a2;
				case 34:
					goto IL_05d0;
				case 9:
				case 13:
				case 32:
					goto IL_05ec;
				case 10:
					goto IL_0608;
				default:
					goto IL_062f;
				}
				if (!flag2)
				{
					_inSavedCharacter = num;
					stream.AddToken(3);
					stream.AddString(GetStringToken());
					break;
				}
				goto IL_062f;
				IL_04a4:
				_inProcessingTag--;
				stream.AddToken(1);
				if (!endAfterKet)
				{
					break;
				}
				return;
				IL_048a:
				_inProcessingTag++;
				stream.AddToken(0);
				break;
				IL_04c0:
				stream.AddToken(4);
				break;
				IL_0608:
				LineNo++;
				if (!flag2)
				{
					stream.AddToken(3);
					stream.AddString(GetStringToken());
					break;
				}
				goto IL_062f;
				IL_0511:
				if (_inProcessingTag != 0)
				{
					stream.AddToken(7);
					break;
				}
				goto IL_062f;
				IL_05a2:
				if (!flag2 && _inProcessingTag != 0)
				{
					_inSavedCharacter = num;
					stream.AddToken(3);
					stream.AddString(GetStringToken());
					break;
				}
				goto IL_062f;
				IL_04fa:
				if (_inProcessingTag != 0)
				{
					stream.AddToken(6);
					break;
				}
				goto IL_062f;
				IL_05ec:
				if (!flag2)
				{
					stream.AddToken(3);
					stream.AddString(GetStringToken());
					break;
				}
				goto IL_062f;
				IL_04e3:
				if (_inProcessingTag != 0)
				{
					stream.AddToken(5);
					break;
				}
				goto IL_062f;
				IL_062f:
				flag = true;
				if (maker._outIndex < 512)
				{
					maker._outChars[maker._outIndex++] = (char)num;
					continue;
				}
				if (maker._outStringBuilder == null)
				{
					maker._outStringBuilder = new StringBuilder();
				}
				maker._outStringBuilder.Append(maker._outChars, 0, 512);
				maker._outChars[0] = (char)num;
				maker._outIndex = 1;
				continue;
				IL_04cc:
				if (_inProcessingTag != 0)
				{
					stream.AddToken(2);
					break;
				}
				goto IL_062f;
				IL_05d0:
				if (flag2)
				{
					stream.AddToken(3);
					stream.AddString(GetStringToken());
					break;
				}
				goto IL_062f;
			}
		}
	}

	private string GetStringToken()
	{
		return _maker.MakeString();
	}
}
