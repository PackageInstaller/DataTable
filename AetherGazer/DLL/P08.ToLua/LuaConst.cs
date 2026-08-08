using UnityEngine;

public static class LuaConst
{
	public static string luaDir = Application.dataPath + "/Scripts/LuaScripts/";

	public static string toluaDir = luaDir + "library/ToLua/Lua/";

	public static string osDir = "Win";

	public static string luaResDir = $"{Application.persistentDataPath}/{osDir}/Lua";

	public static string zbsDir = "D:/ZeroBraneStudio/lualibs/mobdebug";

	public static bool openLuaSocket = true;

	public static bool openZbsDebugger = false;

	public static bool openLuaDebugger = false;
}
