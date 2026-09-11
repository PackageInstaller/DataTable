using System.Runtime.CompilerServices;

namespace System.Security.Cryptography;

public static class CryptographicOperations
{
	[MethodImpl((MethodImplOptions)72)]
	public static void ZeroMemory(Span<byte> buffer)
	{
		buffer.Clear();
	}
}
