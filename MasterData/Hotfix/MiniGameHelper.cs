public static class MiniGameHelper
{
	public static void SetMiniGameData(string[] data)
	{
		MonoSingleton<GameController>.Instance.dynamicModuleParams = data;
	}

	public static string[] GetMathParkourData()
	{
		string[] result = MonoSingleton<GameController>.Instance.dynamicModuleParams as string[];
		MonoSingleton<GameController>.Instance.dynamicModuleParams = null;
		return result;
	}
}
