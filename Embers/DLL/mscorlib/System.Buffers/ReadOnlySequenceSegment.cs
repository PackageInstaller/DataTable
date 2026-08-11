namespace System.Buffers;

public abstract class ReadOnlySequenceSegment<T>
{
	public ReadOnlyMemory<T> Memory { get; protected set; }

	public ReadOnlySequenceSegment<T> Next { get; protected set; }

	public long RunningIndex { get; protected set; }
}
