using System.Runtime.CompilerServices;

namespace System.Buffers;

internal sealed class ArrayMemoryPool<T> : MemoryPool<T>
{
	private sealed class ArrayMemoryPoolBuffer : IMemoryOwner<T>, IDisposable
	{
		private T[] _array;

		public Memory<T> Memory
		{
			get
			{
				T[] array = _array;
				if (array == null)
				{
					ThrowHelper.ThrowObjectDisposedException_ArrayMemoryPoolBuffer();
				}
				return new Memory<T>(array);
			}
		}

		public ArrayMemoryPoolBuffer(int size)
		{
			_array = ArrayPool<T>.Shared.Rent(size);
		}

		public void Dispose()
		{
			T[] array = _array;
			if (array != null)
			{
				_array = null;
				ArrayPool<T>.Shared.Return(array);
			}
		}
	}

	public sealed override IMemoryOwner<T> Rent(int minimumBufferSize = -1)
	{
		if (minimumBufferSize == -1)
		{
			minimumBufferSize = 1 + 4095 / Unsafe.SizeOf<T>();
		}
		else if ((uint)minimumBufferSize > 2147483647u)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.minimumBufferSize);
		}
		return new ArrayMemoryPoolBuffer(minimumBufferSize);
	}

	protected sealed override void Dispose(bool disposing)
	{
	}
}
