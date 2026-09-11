using System.Text;

namespace System.IO;

internal class CStreamWriter : StreamWriter
{
	private TermInfoDriver driver;

	public CStreamWriter(Stream stream, Encoding encoding, bool leaveOpen)
		: base(stream, encoding, 1024, leaveOpen)
	{
		driver = (TermInfoDriver)ConsoleDriver.driver;
	}

	public override void Write(char[] buffer, int index, int count)
	{
		if (count <= 0)
		{
			return;
		}
		if (!driver.Initialized)
		{
			try
			{
				base.Write(buffer, index, count);
				return;
			}
			catch (IOException)
			{
				return;
			}
		}
		lock (this)
		{
			int num = index + count;
			int num2 = index;
			int num3 = 0;
			do
			{
				char c = buffer[num2++];
				if (driver.IsSpecialKey(c))
				{
					if (num3 > 0)
					{
						try
						{
							base.Write(buffer, index, num3);
						}
						catch (IOException)
						{
						}
						num3 = 0;
					}
					driver.WriteSpecialKey(c);
					index = num2;
				}
				else
				{
					num3++;
				}
			}
			while (num2 < num);
			if (num3 > 0)
			{
				try
				{
					base.Write(buffer, index, num3);
					return;
				}
				catch (IOException)
				{
					return;
				}
			}
		}
	}

	public override void Write(char val)
	{
		lock (this)
		{
			try
			{
				if (driver.IsSpecialKey(val))
				{
					driver.WriteSpecialKey(val);
				}
				else
				{
					InternalWriteChar(val);
				}
			}
			catch (IOException)
			{
			}
		}
	}

	public void InternalWriteString(string val)
	{
		try
		{
			base.Write(val);
		}
		catch (IOException)
		{
		}
	}

	public void InternalWriteChar(char val)
	{
		try
		{
			base.Write(val);
		}
		catch (IOException)
		{
		}
	}

	public void InternalWriteChars(char[] buffer, int n)
	{
		try
		{
			base.Write(buffer, 0, n);
		}
		catch (IOException)
		{
		}
	}

	public override void Write(char[] val)
	{
		Write(val, 0, val.Length);
	}

	public override void Write(string val)
	{
		if (val == null)
		{
			return;
		}
		if (driver.Initialized)
		{
			Write(val.ToCharArray());
			return;
		}
		try
		{
			base.Write(val);
		}
		catch (IOException)
		{
		}
	}

	public override void WriteLine(string val)
	{
		Write(val);
		Write(NewLine);
	}
}
