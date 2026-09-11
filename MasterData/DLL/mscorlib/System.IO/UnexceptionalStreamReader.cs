using System.Runtime.InteropServices;
using System.Text;

namespace System.IO;

internal class UnexceptionalStreamReader : StreamReader
{
	private static bool[] newline;

	private static char newlineChar;

	static UnexceptionalStreamReader()
	{
		newline = new bool[Environment.NewLine.Length];
		string newLine = Environment.NewLine;
		if (newLine.Length == 1)
		{
			newlineChar = newLine[0];
		}
	}

	public UnexceptionalStreamReader(Stream stream, Encoding encoding)
		: base(stream, encoding)
	{
	}

	public override int Peek()
	{
		try
		{
			return base.Peek();
		}
		catch (IOException)
		{
		}
		return -1;
	}

	public override int Read()
	{
		try
		{
			return base.Read();
		}
		catch (IOException)
		{
		}
		return -1;
	}

	public override int Read([In][Out] char[] dest_buffer, int index, int count)
	{
		if (dest_buffer == null)
		{
			throw new ArgumentNullException("dest_buffer");
		}
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index", "< 0");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "< 0");
		}
		if (index > dest_buffer.Length - count)
		{
			throw new ArgumentException("index + count > dest_buffer.Length");
		}
		int num = 0;
		char c = newlineChar;
		try
		{
			while (count > 0)
			{
				int num2 = base.Read();
				if (num2 < 0)
				{
					break;
				}
				num++;
				count--;
				dest_buffer[index] = (char)num2;
				if (c != 0)
				{
					if ((ushort)num2 == c)
					{
						return num;
					}
				}
				else if (CheckEOL((char)num2))
				{
					return num;
				}
				index++;
			}
		}
		catch (IOException)
		{
		}
		return num;
	}

	private bool CheckEOL(char current)
	{
		for (int i = 0; i < newline.Length; i++)
		{
			if (!newline[i])
			{
				if (current != Environment.NewLine[i])
				{
					break;
				}
				newline[i] = true;
				return i == newline.Length - 1;
			}
		}
		for (int j = 0; j < newline.Length; j++)
		{
			newline[j] = false;
		}
		return false;
	}

	public override string ReadLine()
	{
		try
		{
			return base.ReadLine();
		}
		catch (IOException)
		{
		}
		return null;
	}

	public override string ReadToEnd()
	{
		try
		{
			return base.ReadToEnd();
		}
		catch (IOException)
		{
		}
		return null;
	}
}
