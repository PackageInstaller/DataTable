using System.Globalization;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace System.IO;

[Serializable]
[ComVisible(true)]
public class StringWriter : TextWriter
{
	private static volatile UnicodeEncoding m_encoding;

	private StringBuilder _sb;

	private bool _isOpen;

	public override Encoding Encoding
	{
		get
		{
			if (m_encoding == null)
			{
				m_encoding = new UnicodeEncoding(bigEndian: false, byteOrderMark: false);
			}
			return m_encoding;
		}
	}

	public StringWriter()
		: this(new StringBuilder(), CultureInfo.CurrentCulture)
	{
	}

	public StringWriter(IFormatProvider formatProvider)
		: this(new StringBuilder(), formatProvider)
	{
	}

	public StringWriter(StringBuilder sb)
		: this(sb, CultureInfo.CurrentCulture)
	{
	}

	public StringWriter(StringBuilder sb, IFormatProvider formatProvider)
		: base(formatProvider)
	{
		if (sb == null)
		{
			throw new ArgumentNullException("sb", Environment.GetResourceString("Buffer cannot be null."));
		}
		_sb = sb;
		_isOpen = true;
	}

	public override void Close()
	{
		Dispose(disposing: true);
	}

	protected override void Dispose(bool disposing)
	{
		_isOpen = false;
		base.Dispose(disposing);
	}

	public virtual StringBuilder GetStringBuilder()
	{
		return _sb;
	}

	public override void Write(char value)
	{
		if (!_isOpen)
		{
			__Error.WriterClosed();
		}
		_sb.Append(value);
	}

	public override void Write(char[] buffer, int index, int count)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer", Environment.GetResourceString("Buffer cannot be null."));
		}
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index", Environment.GetResourceString("Non-negative number required."));
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", Environment.GetResourceString("Non-negative number required."));
		}
		if (buffer.Length - index < count)
		{
			throw new ArgumentException(Environment.GetResourceString("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection."));
		}
		if (!_isOpen)
		{
			__Error.WriterClosed();
		}
		_sb.Append(buffer, index, count);
	}

	public override void Write(string value)
	{
		if (!_isOpen)
		{
			__Error.WriterClosed();
		}
		if (value != null)
		{
			_sb.Append(value);
		}
	}

	[ComVisible(false)]
	public override Task WriteAsync(char value)
	{
		Write(value);
		return Task.CompletedTask;
	}

	[ComVisible(false)]
	public override Task WriteAsync(string value)
	{
		Write(value);
		return Task.CompletedTask;
	}

	[ComVisible(false)]
	public override Task WriteAsync(char[] buffer, int index, int count)
	{
		Write(buffer, index, count);
		return Task.CompletedTask;
	}

	[ComVisible(false)]
	public override Task WriteLineAsync(char value)
	{
		WriteLine(value);
		return Task.CompletedTask;
	}

	[ComVisible(false)]
	public override Task WriteLineAsync(string value)
	{
		WriteLine(value);
		return Task.CompletedTask;
	}

	[ComVisible(false)]
	public override Task WriteLineAsync(char[] buffer, int index, int count)
	{
		WriteLine(buffer, index, count);
		return Task.CompletedTask;
	}

	[ComVisible(false)]
	public override Task FlushAsync()
	{
		return Task.CompletedTask;
	}

	public override string ToString()
	{
		return _sb.ToString();
	}
}
