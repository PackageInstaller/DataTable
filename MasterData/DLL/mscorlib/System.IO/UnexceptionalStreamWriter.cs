using System.Text;

namespace System.IO;

internal class UnexceptionalStreamWriter : StreamWriter
{
	public UnexceptionalStreamWriter(Stream stream, Encoding encoding)
		: base(stream, encoding, 1024, leaveOpen: true)
	{
	}

	public override void Flush()
	{
		try
		{
			base.Flush();
		}
		catch (Exception)
		{
		}
	}

	public override void Write(char[] buffer, int index, int count)
	{
		try
		{
			base.Write(buffer, index, count);
		}
		catch (Exception)
		{
		}
	}

	public override void Write(char value)
	{
		try
		{
			base.Write(value);
		}
		catch (Exception)
		{
		}
	}

	public override void Write(char[] value)
	{
		try
		{
			base.Write(value);
		}
		catch (Exception)
		{
		}
	}

	public override void Write(string value)
	{
		try
		{
			base.Write(value);
		}
		catch (Exception)
		{
		}
	}
}
