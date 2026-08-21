using System;
using System.Runtime.InteropServices;

namespace MessagePack;

[StructLayout(LayoutKind.Sequential, Size = 1)]
internal struct MonoProtection
{
	private static readonly object RefEmitLock = new object();

	internal static bool IsRunningOnMono => Type.GetType("Mono.Runtime") != null;

	internal static MonoProtectionDisposal EnterRefEmitLock()
	{
		if (!IsRunningOnMono)
		{
			return default(MonoProtectionDisposal);
		}
		return new MonoProtectionDisposal(RefEmitLock);
	}
}
