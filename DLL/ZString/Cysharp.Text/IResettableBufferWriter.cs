using System.Buffers;

namespace Cysharp.Text;

public interface IResettableBufferWriter<T> : IBufferWriter<T>
{
	void Reset();
}
