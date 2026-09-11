using System.Globalization;

namespace System.Text;

public abstract class DecoderFallbackBuffer
{
	internal unsafe byte* byteStart;

	internal unsafe char* charEnd;

	public abstract int Remaining { get; }

	public abstract bool Fallback(byte[] bytesUnknown, int index);

	public abstract char GetNextChar();

	public virtual void Reset()
	{
		while (GetNextChar() != 0)
		{
		}
	}

	internal unsafe void InternalReset()
	{
		byteStart = null;
		Reset();
	}

	internal unsafe void InternalInitialize(byte* byteStart, char* charEnd)
	{
		this.byteStart = byteStart;
		this.charEnd = charEnd;
	}

	internal unsafe virtual bool InternalFallback(byte[] bytes, byte* pBytes, ref char* chars)
	{
		if (Fallback(bytes, (int)(pBytes - byteStart - bytes.Length)))
		{
			char* ptr = chars;
			bool flag = false;
			char nextChar;
			while ((nextChar = GetNextChar()) != 0)
			{
				if (char.IsSurrogate(nextChar))
				{
					if (char.IsHighSurrogate(nextChar))
					{
						if (flag)
						{
							throw new ArgumentException("String contains invalid Unicode code points.");
						}
						flag = true;
					}
					else
					{
						if (!flag)
						{
							throw new ArgumentException("String contains invalid Unicode code points.");
						}
						flag = false;
					}
				}
				if (ptr >= charEnd)
				{
					return false;
				}
				*(ptr++) = nextChar;
			}
			if (flag)
			{
				throw new ArgumentException("String contains invalid Unicode code points.");
			}
			chars = ptr;
		}
		return true;
	}

	internal unsafe virtual int InternalFallback(byte[] bytes, byte* pBytes)
	{
		if (Fallback(bytes, (int)(pBytes - byteStart - bytes.Length)))
		{
			int num = 0;
			bool flag = false;
			char nextChar;
			while ((nextChar = GetNextChar()) != 0)
			{
				if (char.IsSurrogate(nextChar))
				{
					if (char.IsHighSurrogate(nextChar))
					{
						if (flag)
						{
							throw new ArgumentException("String contains invalid Unicode code points.");
						}
						flag = true;
					}
					else
					{
						if (!flag)
						{
							throw new ArgumentException("String contains invalid Unicode code points.");
						}
						flag = false;
					}
				}
				num++;
			}
			if (flag)
			{
				throw new ArgumentException("String contains invalid Unicode code points.");
			}
			return num;
		}
		return 0;
	}

	internal void ThrowLastBytesRecursive(byte[] bytesUnknown)
	{
		StringBuilder stringBuilder = new StringBuilder(bytesUnknown.Length * 3);
		int i;
		for (i = 0; i < bytesUnknown.Length && i < 20; i++)
		{
			if (stringBuilder.Length > 0)
			{
				stringBuilder.Append(' ');
			}
			stringBuilder.AppendFormat(CultureInfo.InvariantCulture, "\\x{0:X2}", bytesUnknown[i]);
		}
		if (i == 20)
		{
			stringBuilder.Append(" ...");
		}
		throw new ArgumentException(SR.Format("Recursive fallback not allowed for bytes {0}.", stringBuilder.ToString()), "bytesUnknown");
	}
}
