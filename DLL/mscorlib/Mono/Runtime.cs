using System.Runtime.CompilerServices;

namespace Mono;

public static class Runtime
{
	private static object dump = new object();

	[MethodImpl((MethodImplOptions)4096)]
	public static extern string GetDisplayName();
}
