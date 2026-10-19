namespace System.Buffers;

public abstract class MemoryManager<T>
{
	public virtual Memory<T> Memory => new Memory<T>(this, GetSpan().Length);

	public abstract Span<T> GetSpan();

	public abstract MemoryHandle Pin(int elementIndex = 0);

	protected internal virtual bool TryGetArray(out ArraySegment<T> segment)
	{
		segment = default;
		return false;
	}
}
