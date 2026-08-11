using System;

namespace Ase.Serializing;

public sealed class PooledReader : Reader, IDisposable
{
	internal PooledReader(byte[] bytes)
		: base(bytes)
	{
	}

	internal PooledReader(ArraySegment<byte> segment)
		: base(segment)
	{
	}

	public void Dispose()
	{
		ReaderPool.Recycle(this);
	}
}
