using System.Runtime.InteropServices;
using System.Threading.Tasks;

namespace System.IO;

[Serializable]
[ComVisible(true)]
public class StringReader : TextReader
{
	private string _s;

	private int _pos;

	private int _length;

	public StringReader(string s)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		_s = s;
		_length = s?.Length ?? 0;
	}

	public override void Close()
	{
		Dispose(disposing: true);
	}

	protected override void Dispose(bool disposing)
	{
		_s = null;
		_pos = 0;
		_length = 0;
		base.Dispose(disposing);
	}

	public override int Peek()
	{
		if (_s == null)
		{
			__Error.ReaderClosed();
		}
		if (_pos == _length)
		{
			return -1;
		}
		return _s[_pos];
	}

	public override int Read()
	{
		if (_s == null)
		{
			__Error.ReaderClosed();
		}
		if (_pos == _length)
		{
			return -1;
		}
		return _s[_pos++];
	}

	public override int Read([In][Out] char[] buffer, int index, int count)
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
		if (_s == null)
		{
			__Error.ReaderClosed();
		}
		int num = _length - _pos;
		if (num > 0)
		{
			if (num > count)
			{
				num = count;
			}
			_s.CopyTo(_pos, buffer, index, num);
			_pos += num;
		}
		return num;
	}

	public override string ReadToEnd()
	{
		if (_s == null)
		{
			__Error.ReaderClosed();
		}
		string result = ((_pos != 0) ? _s.Substring(_pos, _length - _pos) : _s);
		_pos = _length;
		return result;
	}

	public override string ReadLine()
	{
		if (_s == null)
		{
			__Error.ReaderClosed();
		}
		int i;
		for (i = _pos; i < _length; i++)
		{
			char c = _s[i];
			if (c == '\r' || c == '\n')
			{
				string result = _s.Substring(_pos, i - _pos);
				_pos = i + 1;
				if (c == '\r' && _pos < _length && _s[_pos] == '\n')
				{
					_pos++;
				}
				return result;
			}
		}
		if (i > _pos)
		{
			string result2 = _s.Substring(_pos, i - _pos);
			_pos = i;
			return result2;
		}
		return null;
	}

	[ComVisible(false)]
	public override Task<string> ReadLineAsync()
	{
		return Task.FromResult(ReadLine());
	}

	[ComVisible(false)]
	public override Task<string> ReadToEndAsync()
	{
		return Task.FromResult(ReadToEnd());
	}

	[ComVisible(false)]
	public override Task<int> ReadBlockAsync(char[] buffer, int index, int count)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer", Environment.GetResourceString("Buffer cannot be null."));
		}
		if (index < 0 || count < 0)
		{
			throw new ArgumentOutOfRangeException((index < 0) ? "index" : "count", Environment.GetResourceString("Non-negative number required."));
		}
		if (buffer.Length - index < count)
		{
			throw new ArgumentException(Environment.GetResourceString("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection."));
		}
		return Task.FromResult(ReadBlock(buffer, index, count));
	}

	[ComVisible(false)]
	public override Task<int> ReadAsync(char[] buffer, int index, int count)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer", Environment.GetResourceString("Buffer cannot be null."));
		}
		if (index < 0 || count < 0)
		{
			throw new ArgumentOutOfRangeException((index < 0) ? "index" : "count", Environment.GetResourceString("Non-negative number required."));
		}
		if (buffer.Length - index < count)
		{
			throw new ArgumentException(Environment.GetResourceString("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection."));
		}
		return Task.FromResult(Read(buffer, index, count));
	}
}
