using System;
using HybridCLR;
using XLua;
using XLua.LuaDLL;

namespace AIScript;

internal static class HotfixLuaWrapReversePInvokeReserve
{
	private const int RESERVE_COUNT = 512;

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	[ReversePInvokeWrapperGeneration(512)]
	private static int __ReservedLuaCSFunctionStub(IntPtr L)
	{
		return 0;
	}
}
