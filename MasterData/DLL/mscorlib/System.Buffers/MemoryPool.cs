namespace System.Buffers;

public abstract class MemoryPool<T> : IDisposable
{
	private static readonly MemoryPool<T> s_shared = new ArrayMemoryPool<T>();

	public abstract IMemoryOwner<T> Rent(int minBufferSize = -1);

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	protected abstract void Dispose(bool disposing);
}
