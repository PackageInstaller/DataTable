namespace LuaInterface;

public class LuaInjectionStation
{
	public const byte NOT_INJECTION_FLAG = 0;

	public const byte INVALID_INJECTION_FLAG = byte.MaxValue;

	private static int cacheSize;

	private static byte[] injectionFlagCache;

	private static LuaFunction[] injectFunctionCache;

	static LuaInjectionStation()
	{
		injectionFlagCache = new byte[cacheSize];
		injectFunctionCache = new LuaFunction[cacheSize];
	}

	[NoToLua]
	public static byte GetInjectFlag(int index)
	{
		byte b = injectionFlagCache[index];
		switch (b)
		{
		case byte.MaxValue:
			return 0;
		case 0:
			if (LuaState.GetInjectInitState(index))
			{
				injectionFlagCache[index] = byte.MaxValue;
			}
			break;
		}
		return b;
	}

	[NoToLua]
	public static LuaFunction GetInjectionFunction(int index)
	{
		return injectFunctionCache[index];
	}

	public static void CacheInjectFunction(int index, byte injectFlag, LuaFunction func)
	{
		if (index < cacheSize)
		{
			injectFunctionCache[index] = func;
			injectionFlagCache[index] = injectFlag;
		}
	}

	public static void Clear()
	{
		int i = 0;
		for (int num = injectionFlagCache.Length; i < num; i++)
		{
			injectionFlagCache[i] = 0;
			injectFunctionCache[i] = null;
		}
	}
}
