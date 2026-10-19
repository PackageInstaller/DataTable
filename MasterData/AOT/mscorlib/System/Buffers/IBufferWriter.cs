namespace System.Buffers;

public interface IBufferWriter<T>
{
	void Advance(int count);

	Span<T> GetSpan(int sizeHint = 0);
}
