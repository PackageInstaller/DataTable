using System;
using System.Globalization;
using System.IO;
using System.Text;
using System.Threading.Tasks;

namespace Cysharp.Text;

public sealed class ZStringWriter : TextWriter
{
	private Utf16ValueStringBuilder sb;

	private bool isOpen;

	private UnicodeEncoding? encoding;

	public override Encoding Encoding
	{
		get
		{
			UnicodeEncoding? obj = encoding ?? new UnicodeEncoding(bigEndian: false, byteOrderMark: false);
			UnicodeEncoding result = obj;
			encoding = obj;
			return result;
		}
	}

	public ZStringWriter()
		: this(CultureInfo.CurrentCulture)
	{
	}

	public ZStringWriter(IFormatProvider formatProvider)
		: base(formatProvider)
	{
		sb = ZString.CreateStringBuilder();
		isOpen = true;
	}

	public override void Close()
	{
		Dispose(disposing: true);
	}

	protected override void Dispose(bool disposing)
	{
		sb.Dispose();
		isOpen = false;
		base.Dispose(disposing);
	}

	public override void Write(char value)
	{
		AssertNotDisposed();
		sb.Append(value);
	}

	public override void Write(char[] buffer, int index, int count)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer");
		}
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count");
		}
		if (buffer.Length - index < count)
		{
			throw new ArgumentException();
		}
		AssertNotDisposed();
		sb.Append(buffer, index, count);
	}

	public override void Write(string value)
	{
		AssertNotDisposed();
		if (value != null)
		{
			sb.Append(value);
		}
	}

	public override Task WriteAsync(char value)
	{
		Write(value);
		return Task.CompletedTask;
	}

	public override Task WriteAsync(string value)
	{
		Write(value);
		return Task.CompletedTask;
	}

	public override Task WriteAsync(char[] buffer, int index, int count)
	{
		Write(buffer, index, count);
		return Task.CompletedTask;
	}

	public override Task WriteLineAsync(char value)
	{
		WriteLine(value);
		return Task.CompletedTask;
	}

	public override Task WriteLineAsync(string value)
	{
		WriteLine(value);
		return Task.CompletedTask;
	}

	public override Task WriteLineAsync(char[] buffer, int index, int count)
	{
		WriteLine(buffer, index, count);
		return Task.CompletedTask;
	}

	public override void Write(bool value)
	{
		AssertNotDisposed();
		sb.Append(value);
	}

	public override void Write(decimal value)
	{
		AssertNotDisposed();
		sb.Append(value);
	}

	public override Task FlushAsync()
	{
		return Task.CompletedTask;
	}

	public override string ToString()
	{
		return sb.ToString();
	}

	private void AssertNotDisposed()
	{
		if (!isOpen)
		{
			throw new ObjectDisposedException("sb");
		}
	}
}
