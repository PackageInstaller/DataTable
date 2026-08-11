using System;

namespace Ase.Serializing;

public sealed class PooledWriter : Writer, IDisposable
{
	public void Dispose()
	{
		WriterPool.Recycle(this);
	}

	public void DisposeLength()
	{
		WriterPool.RecycleLength(this);
	}
}
