namespace System.Buffers;

public abstract class ReadOnlySequenceSegment<T>
{
	public ReadOnlyMemory<T> Memory { get; }

	public ReadOnlySequenceSegment<T> Next { get; }

	public long RunningIndex { get; }
}
