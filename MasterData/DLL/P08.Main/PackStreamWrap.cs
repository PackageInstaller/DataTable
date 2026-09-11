using System;
using LuaInterface;

public class PackStreamWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(PackStream), typeof(object));
		L.RegFunction("ToString", ToString);
		L.RegFunction("Reset", Reset);
		L.RegFunction("WriteUint16LittleEndian", WriteUint16LittleEndian);
		L.RegFunction("WriteUint32LittleEndian", WriteUint32LittleEndian);
		L.RegFunction("WriteInt8", WriteInt8);
		L.RegFunction("WriteUint8", WriteUint8);
		L.RegFunction("WriteInt16", WriteInt16);
		L.RegFunction("WriteUint16", WriteUint16);
		L.RegFunction("WriteInt32", WriteInt32);
		L.RegFunction("WriteUint32", WriteUint32);
		L.RegFunction("WriteInt64", WriteInt64);
		L.RegFunction("WriteUint64", WriteUint64);
		L.RegFunction("WriteBool", WriteBool);
		L.RegFunction("WriteFloat", WriteFloat);
		L.RegFunction("WriteDouble", WriteDouble);
		L.RegFunction("WriteString", WriteString);
		L.RegFunction("WriteString2", WriteString2);
		L.RegFunction("WriteString4", WriteString4);
		L.RegFunction("WriteBuffer", WriteBuffer);
		L.RegFunction("WriteBuffer2", WriteBuffer2);
		L.RegFunction("WriteBuffer4", WriteBuffer4);
		L.RegFunction("ToArray", ToArray);
		L.RegFunction("ToArrayRef", ToArrayRef);
		L.RegFunction("ComputeUint32Size", ComputeUint32Size);
		L.RegFunction("computeUint64Size", computeUint64Size);
		L.RegFunction("New", _CreatePackStream);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("Seek", get_Seek, set_Seek);
		L.RegVar("Length", get_Length, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreatePackStream(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 0:
			{
				PackStream o2 = new PackStream();
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 1:
				if (TypeChecker.CheckTypes<int>(L, 1))
				{
					PackStream o = new PackStream((int)LuaDLL.lua_tonumber(L, 1));
					ToLua.PushObject(L, o);
					return 1;
				}
				break;
			}
			if (num == 1 && TypeChecker.CheckTypes<byte[]>(L, 1))
			{
				PackStream o3 = new PackStream(ToLua.CheckByteBuffer(L, 1));
				ToLua.PushObject(L, o3);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: PackStream.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ToString(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string str = ((PackStream)ToLua.CheckObject<PackStream>(L, 1)).ToString();
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Reset(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((PackStream)ToLua.CheckObject<PackStream>(L, 1)).Reset();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WriteUint16LittleEndian(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PackStream obj = (PackStream)ToLua.CheckObject<PackStream>(L, 1);
			short x = (short)LuaDLL.luaL_checknumber(L, 2);
			obj.WriteUint16LittleEndian(x);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WriteUint32LittleEndian(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PackStream obj = (PackStream)ToLua.CheckObject<PackStream>(L, 1);
			uint x = (uint)LuaDLL.luaL_checknumber(L, 2);
			obj.WriteUint32LittleEndian(x);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WriteInt8(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PackStream obj = (PackStream)ToLua.CheckObject<PackStream>(L, 1);
			int x = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.WriteInt8(x);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WriteUint8(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PackStream obj = (PackStream)ToLua.CheckObject<PackStream>(L, 1);
			uint x = (uint)LuaDLL.luaL_checknumber(L, 2);
			obj.WriteUint8(x);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WriteInt16(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PackStream obj = (PackStream)ToLua.CheckObject<PackStream>(L, 1);
			int x = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.WriteInt16(x);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WriteUint16(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PackStream obj = (PackStream)ToLua.CheckObject<PackStream>(L, 1);
			uint x = (uint)LuaDLL.luaL_checknumber(L, 2);
			obj.WriteUint16(x);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WriteInt32(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PackStream obj = (PackStream)ToLua.CheckObject<PackStream>(L, 1);
			int x = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.WriteInt32(x);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WriteUint32(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PackStream obj = (PackStream)ToLua.CheckObject<PackStream>(L, 1);
			uint x = (uint)LuaDLL.luaL_checknumber(L, 2);
			obj.WriteUint32(x);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WriteInt64(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PackStream obj = (PackStream)ToLua.CheckObject<PackStream>(L, 1);
			long x = LuaDLL.tolua_checkint64(L, 2);
			obj.WriteInt64(x);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WriteUint64(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PackStream obj = (PackStream)ToLua.CheckObject<PackStream>(L, 1);
			ulong x = LuaDLL.tolua_checkuint64(L, 2);
			obj.WriteUint64(x);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WriteBool(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PackStream obj = (PackStream)ToLua.CheckObject<PackStream>(L, 1);
			bool x = LuaDLL.luaL_checkboolean(L, 2);
			obj.WriteBool(x);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WriteFloat(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PackStream obj = (PackStream)ToLua.CheckObject<PackStream>(L, 1);
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.WriteFloat(x);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WriteDouble(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PackStream obj = (PackStream)ToLua.CheckObject<PackStream>(L, 1);
			double x = LuaDLL.luaL_checknumber(L, 2);
			obj.WriteDouble(x);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WriteString(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PackStream obj = (PackStream)ToLua.CheckObject<PackStream>(L, 1);
			string x = ToLua.CheckString(L, 2);
			obj.WriteString(x);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WriteString2(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PackStream obj = (PackStream)ToLua.CheckObject<PackStream>(L, 1);
			string x = ToLua.CheckString(L, 2);
			obj.WriteString2(x);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WriteString4(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PackStream obj = (PackStream)ToLua.CheckObject<PackStream>(L, 1);
			string x = ToLua.CheckString(L, 2);
			obj.WriteString4(x);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WriteBuffer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PackStream obj = (PackStream)ToLua.CheckObject<PackStream>(L, 1);
			byte[] bs = ToLua.CheckByteBuffer(L, 2);
			obj.WriteBuffer(bs);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WriteBuffer2(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PackStream obj = (PackStream)ToLua.CheckObject<PackStream>(L, 1);
			byte[] bs = ToLua.CheckByteBuffer(L, 2);
			obj.WriteBuffer2(bs);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WriteBuffer4(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PackStream obj = (PackStream)ToLua.CheckObject<PackStream>(L, 1);
			byte[] bs = ToLua.CheckByteBuffer(L, 2);
			obj.WriteBuffer4(bs);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ToArray(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			byte[] array = ((PackStream)ToLua.CheckObject<PackStream>(L, 1)).ToArray();
			ToLua.Push(L, array);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ToArrayRef(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			PackStream obj = (PackStream)ToLua.CheckObject<PackStream>(L, 1);
			byte[] _bs = null;
			obj.ToArrayRef(out _bs, out var _offset, out var _count);
			ToLua.Push(L, _bs);
			LuaDLL.lua_pushinteger(L, _offset);
			LuaDLL.lua_pushinteger(L, _count);
			return 3;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ComputeUint32Size(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int n = PackStream.ComputeUint32Size((uint)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int computeUint64Size(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int n = PackStream.computeUint64Size(LuaDLL.tolua_checkuint64(L, 1));
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Seek(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int seek = ((PackStream)obj).Seek;
			LuaDLL.lua_pushinteger(L, seek);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Seek on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Length(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int length = ((PackStream)obj).Length;
			LuaDLL.lua_pushinteger(L, length);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Length on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Seek(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PackStream obj2 = (PackStream)obj;
			int seek = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.Seek = seek;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Seek on a nil value");
		}
	}
}
