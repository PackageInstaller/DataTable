using System.Runtime.InteropServices;
using System.Text;

namespace System.IO;

internal class CStreamReader : StreamReader
{
	private TermInfoDriver driver;

	public CStreamReader(Stream stream, Encoding encoding)
		: base(stream, encoding)
	{
		driver = (TermInfoDriver)ConsoleDriver.driver;
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
			return Console.ReadKey().KeyChar;
		}
		catch (IOException)
		{
		}
		return -1;
	}

	public override int Read([In][Out] char[] dest, int index, int count)
	{
		if (dest == null)
		{
			throw new ArgumentNullException("dest");
		}
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index", "< 0");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "< 0");
		}
		if (index > dest.Length - count)
		{
			throw new ArgumentException("index + count > dest.Length");
		}
		try
		{
			return driver.Read(dest, index, count);
		}
		catch (IOException)
		{
		}
		return 0;
	}

	public override string ReadLine()
	{
		try
		{
			return driver.ReadLine();
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
			return driver.ReadToEnd();
		}
		catch (IOException)
		{
		}
		return null;
	}
}
