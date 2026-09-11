using P08Main.Loading;

namespace T0World;

public static class T0WorldCreator
{
	public static T0CaptureManagerBase CreateCaptureManager()
	{
		return (T0WorldConst.T0characterIDEnum)T0WorldScene.Scene.characterID switch
		{
			T0WorldConst.T0characterIDEnum.SKULD => new T0WorldCaptureManager(), 
			T0WorldConst.T0characterIDEnum.HORUS => new T0WorldCaptureManager_Horus(), 
			_ => new T0WorldCaptureManager(), 
		};
	}

	public static T0WorldDataBaseContext CreateDataBaseContext()
	{
		return (T0WorldConst.T0characterIDEnum)T0WorldScene.Scene.characterID switch
		{
			T0WorldConst.T0characterIDEnum.SKULD => new T0WorldDataBaseContext(), 
			T0WorldConst.T0characterIDEnum.HORUS => new T0WorldDataContext_Horus(), 
			_ => new T0WorldDataBaseContext(), 
		};
	}

	public static LoadingImpl GetLoadingType()
	{
		LoadingImpl result = LoadingImpl.SkuldT0_Loading;
		switch ((T0WorldConst.T0characterIDEnum)T0WorldLuaBridge.loadingCharacterID)
		{
		case T0WorldConst.T0characterIDEnum.SKULD:
			result = LoadingImpl.SkuldT0_Loading;
			break;
		case T0WorldConst.T0characterIDEnum.HORUS:
			result = LoadingImpl.HorusT0_Loading;
			break;
		}
		return result;
	}

	public static BaseT0Gameloading GetLoadingInst()
	{
		BaseT0Gameloading instance = SkuldT0GameLoading.Instance;
		switch ((T0WorldConst.T0characterIDEnum)T0WorldLuaBridge.loadingCharacterID)
		{
		case T0WorldConst.T0characterIDEnum.SKULD:
			instance = SkuldT0GameLoading.Instance;
			break;
		case T0WorldConst.T0characterIDEnum.HORUS:
			instance = HorusT0GameLoading.Instance;
			break;
		}
		return instance;
	}
}
