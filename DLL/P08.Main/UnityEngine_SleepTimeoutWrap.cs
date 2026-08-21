using LuaInterface;

public class UnityEngine_SleepTimeoutWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("SleepTimeout");
		L.RegConstant("NeverSleep", -1.0);
		L.RegConstant("SystemSetting", -2.0);
		L.EndStaticLibs();
	}
}
