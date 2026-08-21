using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
internal class BitArrayView
{
	public int[] m_array;

	public int m_length;

	public int _version;
}
