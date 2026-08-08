public class OutSouringLuaClient : LuaClient, ILuaInterface
{
	protected override void StartMain()
	{
		base.luaState.DoFile("OutSouringMain.lua");
		levelLoaded = base.luaState.GetFunction("OnLevelWasLoaded");
		CallMain();
	}
}
