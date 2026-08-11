using System.Buffers;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace System.IO;

[Serializable]
public abstract class TextReader : MarshalByRefObject, IDisposable
{
	[Serializable]
	private sealed class NullTextReader : TextReader
	{
		public override int Read(char[] buffer, int index, int count)
		{
			return 0;
		}

		public override string ReadLine()
		{
			return null;
		}
	}

	[Serializable]
	internal sealed class SyncTextReader : TextReader
	{
		internal readonly TextReader _in;

		internal SyncTextReader(TextReader t)
		{
			_in = t;
		}

		[MethodImpl((MethodImplOptions)32)]
		public override void Close()
		{
			_in.Close();
		}

		[MethodImpl((MethodImplOptions)32)]
		protected override void Dispose(bool disposing)
		{
			if (disposing)
			{
				((IDisposable)_in).Dispose();
			}
		}

		[MethodImpl((MethodImplOptions)32)]
		public override int Peek()
		{
			return _in.Peek();
		}

		[MethodImpl((MethodImplOptions)32)]
		public override int Read()
		{
			return _in.Read();
		}

		[MethodImpl((MethodImplOptions)32)]
		public override int Read(char[] buffer, int index, int count)
		{
			return _in.Read(buffer, index, count);
		}

		[MethodImpl((MethodImplOptions)32)]
		public override int ReadBlock(char[] buffer, int index, int count)
		{
			return _in.ReadBlock(buffer, index, count);
		}

		[MethodImpl((MethodImplOptions)32)]
		public override string ReadLine()
		{
			return _in.ReadLine();
		}

		[MethodImpl((MethodImplOptions)32)]
		public override string ReadToEnd()
		{
			return _in.ReadToEnd();
		}

		[MethodImpl((MethodImplOptions)32)]
		public override Task<string> ReadLineAsync()
		{
			return Task.FromResult(ReadLine());
		}

		[MethodImpl((MethodImplOptions)32)]
		public override Task<string> ReadToEndAsync()
		{
			return Task.FromResult(ReadToEnd());
		}

		[MethodImpl((MethodImplOptions)32)]
		public override Task<int> ReadBlockAsync(char[] buffer, int index, int count)
		{
			if (buffer == null)
			{
				throw new ArgumentNullException("buffer", "Buffer cannot be null.");
			}
			if (index < 0 || count < 0)
			{
				throw new ArgumentOutOfRangeException((index < 0) ? "index" : "count", "Non-negative number required.");
			}
			if (buffer.Length - index < count)
			{
				throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
			}
			return Task.FromResult(ReadBlock(buffer, index, count));
		}

		[MethodImpl((MethodImplOptions)32)]
		public override Task<int> ReadAsync(char[] buffer, int index, int count)
		{
			if (buffer == null)
			{
				throw new ArgumentNullException("buffer", "Buffer cannot be null.");
			}
			if (index < 0 || count < 0)
			{
				throw new ArgumentOutOfRangeException((index < 0) ? "index" : "count", "Non-negative number required.");
			}
			if (buffer.Length - index < count)
			{
				throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
			}
			return Task.FromResult(Read(buffer, index, count));
		}
	}

	public static readonly TextReader Null = new NullTextReader();

	public virtual void Close()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	protected virtual void Dispose(bool disposing)
	{
	}

	public virtual int Peek()
	{
		return -1;
	}

	public virtual int Read()
	{
		return -1;
	}

	public virtual int Read(char[] buffer, int index, int count)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer", "Buffer cannot be null.");
		}
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index", "Non-negative number required.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Non-negative number required.");
		}
		if (buffer.Length - index < count)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		int i;
		for (i = 0; i < count; i++)
		{
			int num = Read();
			if (num == -1)
			{
				break;
			}
			buffer[index + i] = (char)num;
		}
		return i;
	}

	public virtual int Read(Span<char> buffer)
	{
		char[] array = ArrayPool<char>.Shared.Rent(buffer.Length);
		try
		{
			int num = Read(array, 0, buffer.Length);
			if ((uint)num > buffer.Length)
			{
				throw new IOException("The read operation returned an invalid length.");
			}
			new Span<char>(array, 0, num).CopyTo(buffer);
			return num;
		}
		finally
		{
			ArrayPool<char>.Shared.Return(array);
		}
	}

	public virtual string ReadToEnd()
	{
		char[] array = new char[4096];
		StringBuilder stringBuilder = new StringBuilder(4096);
		int charCount;
		while ((charCount = Read(array, 0, array.Length)) != 0)
		{
			stringBuilder.Append(array, 0, charCount);
		}
		return stringBuilder.ToString();
	}

	public virtual int ReadBlock(char[] buffer, int index, int count)
	{
		int num = 0;
		int num2;
		do
		{
			num += (num2 = Read(buffer, index + num, count - num));
		}
		while (num2 > 0 && num < count);
		return num;
	}

	public virtual int ReadBlock(Span<char> buffer)
	{
		char[] array = ArrayPool<char>.Shared.Rent(buffer.Length);
		try
		{
			int num = ReadBlock(array, 0, buffer.Length);
			if ((uint)num > buffer.Length)
			{
				throw new IOException("The read operation returned an invalid length.");
			}
			new Span<char>(array, 0, num).CopyTo(buffer);
			return num;
		}
		finally
		{
			ArrayPool<char>.Shared.Return(array);
		}
	}

	public virtual string ReadLine()
	{
		StringBuilder stringBuilder = new StringBuilder();
		while (true)
		{
			int num = Read();
			switch (num)
			{
			case 10:
			case 13:
				if (num == 13 && Peek() == 10)
				{
					Read();
				}
				return stringBuilder.ToString();
			case -1:
				if (stringBuilder.Length > 0)
				{
					return stringBuilder.ToString();
				}
				return null;
			}
			stringBuilder.Append((char)num);
		}
	}

	public virtual Task<string> ReadLineAsync()
	{
		return Task<string>.Factory.StartNew((object state) => ((TextReader)state).ReadLine(), this, CancellationToken.None, TaskCreationOptions.DenyChildAttach, TaskScheduler.Default);
	}

	public virtual async Task<string> ReadToEndAsync()
	{
		StringBuilder sb = new StringBuilder(4096);
		char[] chars = ArrayPool<char>.Shared.Rent(4096);
		try
		{
			int charCount;
			while ((charCount = await ReadAsyncInternal(chars, default(CancellationToken)).ConfigureAwait(continueOnCapturedContext: false)) != 0)
			{
				sb.Append(chars, 0, charCount);
			}
		}
		finally
		{
			ArrayPool<char>.Shared.Return(chars);
		}
		return sb.ToString();
	}

	public virtual Task<int> ReadAsync(char[] buffer, int index, int count)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer", "Buffer cannot be null.");
		}
		if (index < 0 || count < 0)
		{
			throw new ArgumentOutOfRangeException((index < 0) ? "index" : "count", "Non-negative number required.");
		}
		if (buffer.Length - index < count)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		return ReadAsyncInternal(new Memory<char>(buffer, index, count), default(CancellationToken)).AsTask();
	}

	public virtual ValueTask<int> ReadAsync(Memory<char> buffer, CancellationToken cancellationToken = default(CancellationToken))
	{
		ArraySegment<char> segment;
		return new ValueTask<int>(MemoryMarshal.TryGetArray((ReadOnlyMemory<char>)buffer, out segment) ? ReadAsync(segment.Array, segment.Offset, segment.Count) : Task<int>.Factory.StartNew(delegate(object state)
		{
			Tuple<TextReader, Memory<char>> tuple = (Tuple<TextReader, Memory<char>>)state;
			return tuple.Item1.Read(tuple.Item2.Span);
		}, Tuple.Create(this, buffer), cancellationToken, TaskCreationOptions.DenyChildAttach, TaskScheduler.Default));
	}

	internal virtual ValueTask<int> ReadAsyncInternal(Memory<char> buffer, CancellationToken cancellationToken)
	{
		Tuple<TextReader, Memory<char>> state = new Tuple<TextReader, Memory<char>>(this, buffer);
		return new ValueTask<int>(Task<int>.Factory.StartNew(delegate(object obj)
		{
			Tuple<TextReader, Memory<char>> tuple = (Tuple<TextReader, Memory<char>>)obj;
			return tuple.Item1.Read(tuple.Item2.Span);
		}, state, cancellationToken, TaskCreationOptions.DenyChildAttach, TaskScheduler.Default));
	}

	public virtual Task<int> ReadBlockAsync(char[] buffer, int index, int count)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer", "Buffer cannot be null.");
		}
		if (index < 0 || count < 0)
		{
			throw new ArgumentOutOfRangeException((index < 0) ? "index" : "count", "Non-negative number required.");
		}
		if (buffer.Length - index < count)
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
		return ReadBlockAsyncInternal(new Memory<char>(buffer, index, count), default(CancellationToken)).AsTask();
	}

	public virtual ValueTask<int> ReadBlockAsync(Memory<char> buffer, CancellationToken cancellationToken = default(CancellationToken))
	{
		ArraySegment<char> segment;
		return new ValueTask<int>(MemoryMarshal.TryGetArray((ReadOnlyMemory<char>)buffer, out segment) ? ReadBlockAsync(segment.Array, segment.Offset, segment.Count) : Task<int>.Factory.StartNew(delegate(object state)
		{
			Tuple<TextReader, Memory<char>> tuple = (Tuple<TextReader, Memory<char>>)state;
			return tuple.Item1.ReadBlock(tuple.Item2.Span);
		}, Tuple.Create(this, buffer), cancellationToken, TaskCreationOptions.DenyChildAttach, TaskScheduler.Default));
	}

	internal async ValueTask<int> ReadBlockAsyncInternal(Memory<char> buffer, CancellationToken cancellationToken)
	{
		int n = 0;
		int num;
		do
		{
			num = await ReadAsyncInternal(buffer.Slice(n), cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
			n += num;
		}
		while (num > 0 && n < buffer.Length);
		return n;
	}

	public static TextReader Synchronized(TextReader reader)
	{
		if (reader == null)
		{
			throw new ArgumentNullException("reader");
		}
		if (!(reader is SyncTextReader))
		{
			return new SyncTextReader(reader);
		}
		return reader;
	}
}
