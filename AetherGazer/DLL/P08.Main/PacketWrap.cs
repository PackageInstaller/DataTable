using System;
using LuaInterface;

public class PacketWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Packet), typeof(object));
		L.RegFunction("getLuaByteBuffer", getLuaByteBuffer);
		L.RegFunction("getLuaStringBuffer", getLuaStringBuffer);
		L.RegFunction("ParserHead", ParserHead);
		L.RegFunction("FillBuff", FillBuff);
		L.RegFunction("New", _CreatePacket);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("Offset", get_Offset, null);
		L.RegVar("Buffer", get_Buffer, null);
		L.RegVar("BodyLength", get_BodyLength, null);
		L.RegVar("Cmd", get_Cmd, null);
		L.RegVar("Index", get_Index, null);
		L.RegVar("ServerIndex", get_ServerIndex, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreatePacket(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 0:
			{
				Packet o2 = new Packet();
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 1:
			{
				Packet o = new Packet((ushort)LuaDLL.luaL_checknumber(L, 1));
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: Packet.New");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int getLuaByteBuffer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaByteBuffer luaByteBuffer = ((Packet)ToLua.CheckObject<Packet>(L, 1)).getLuaByteBuffer();
			ToLua.Push(L, luaByteBuffer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int getLuaStringBuffer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaByteBuffer luaStringBuffer = ((Packet)ToLua.CheckObject<Packet>(L, 1)).getLuaStringBuffer();
			ToLua.Push(L, luaStringBuffer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ParserHead(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Packet obj = (Packet)ToLua.CheckObject<Packet>(L, 1);
			byte[] buffer = ToLua.CheckByteBuffer(L, 2);
			int start = (int)LuaDLL.luaL_checknumber(L, 3);
			int end = (int)LuaDLL.luaL_checknumber(L, 4);
			bool value = obj.ParserHead(buffer, start, end);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FillBuff(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Packet obj = (Packet)ToLua.CheckObject<Packet>(L, 1);
			byte[] buff = ToLua.CheckByteBuffer(L, 2);
			int start = (int)LuaDLL.luaL_checknumber(L, 3);
			int length = (int)LuaDLL.luaL_checknumber(L, 4);
			obj.FillBuff(buff, start, length);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Offset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ushort offset = ((Packet)obj).Offset;
			LuaDLL.lua_pushnumber(L, (int)offset);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Offset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Buffer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			byte[] buffer = ((Packet)obj).Buffer;
			ToLua.Push(L, buffer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Buffer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_BodyLength(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ushort bodyLength = ((Packet)obj).BodyLength;
			LuaDLL.lua_pushnumber(L, (int)bodyLength);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index BodyLength on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Cmd(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			uint cmd = ((Packet)obj).Cmd;
			LuaDLL.lua_pushnumber(L, cmd);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Cmd on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Index(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ushort index = ((Packet)obj).Index;
			LuaDLL.lua_pushnumber(L, (int)index);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Index on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ServerIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ushort serverIndex = ((Packet)obj).ServerIndex;
			LuaDLL.lua_pushnumber(L, (int)serverIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ServerIndex on a nil value");
		}
	}
}
