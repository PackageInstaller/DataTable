using LuaInterface;

public interface ILuaInterface
{
	LuaState luaState { get; set; }

	LuaState InitLuaState();

	void BindLuaState(LuaState luaState);
}
