using LuaInterface;
using UnityEngine;

public class UnityEngine_CoroutineWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Coroutine), null);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}
}
