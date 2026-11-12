using System;

namespace XLua.CSObjectWrap;

public class AdventureModuleLevelLoadParamsBootConfigLoadTypeWrap
{
	public static void __Register(IntPtr L)
	{
		ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
		Utils.BeginObjectRegister(typeof(AdventureModuleLevelLoadParams.BootConfigLoadType), L, translator, 0, 0, 0, 0);
		Utils.EndObjectRegister(typeof(AdventureModuleLevelLoadParams.BootConfigLoadType), L, translator, null, null, null, null, null);
		Utils.BeginClassRegister(typeof(AdventureModuleLevelLoadParams.BootConfigLoadType), L, null, 34, 0, 0);
		Utils.RegisterEnumType(L, typeof(AdventureModuleLevelLoadParams.BootConfigLoadType));
		Utils.EndClassRegister(typeof(AdventureModuleLevelLoadParams.BootConfigLoadType), L, translator);
	}
}
