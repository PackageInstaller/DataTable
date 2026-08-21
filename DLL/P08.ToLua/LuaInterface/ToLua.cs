using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Text;
using UnityEngine;

namespace LuaInterface;

public static class ToLua
{
	public delegate object LuaTableToVar(IntPtr L, int pos);

	public delegate void LuaPushVarObject(IntPtr L, object o);

	private static Type monoType;

	public static LuaTableToVar[] ToVarMap;

	public static Dictionary<Type, LuaPushVarObject> VarPushMap;

	static ToLua()
	{
		monoType = typeof(Type).GetType();
		ToVarMap = new LuaTableToVar[64];
		VarPushMap = new Dictionary<Type, LuaPushVarObject>();
		ToVarMap[1] = ToObjectVec3;
		ToVarMap[2] = ToObjectQuat;
		ToVarMap[3] = ToObjectVec2;
		ToVarMap[4] = ToObjectColor;
		ToVarMap[5] = ToObjectVec4;
		ToVarMap[6] = ToObjectRay;
		ToVarMap[9] = ToObjectLayerMask;
		ToVarMap[7] = ToObjectBounds;
	}

	public static void OpenLibs(IntPtr L)
	{
		AddLuaLoader(L);
		LuaDLL.tolua_atpanic(L, Panic);
		LuaDLL.tolua_pushcfunction(L, Print);
		LuaDLL.lua_setglobal(L, "print");
		LuaDLL.tolua_pushcfunction(L, DoFile);
		LuaDLL.lua_setglobal(L, "dofile");
		LuaDLL.tolua_pushcfunction(L, LoadFile);
		LuaDLL.lua_setglobal(L, "loadfile");
		LuaDLL.lua_getglobal(L, "tolua");
		LuaDLL.lua_pushstring(L, "isnull");
		LuaDLL.lua_pushcfunction(L, IsNull);
		LuaDLL.lua_rawset(L, -3);
		LuaDLL.lua_pushstring(L, "typeof");
		LuaDLL.lua_pushcfunction(L, GetClassType);
		LuaDLL.lua_rawset(L, -3);
		LuaDLL.lua_pushstring(L, "tolstring");
		LuaDLL.tolua_pushcfunction(L, BufferToString);
		LuaDLL.lua_rawset(L, -3);
		LuaDLL.lua_pushstring(L, "toarray");
		LuaDLL.tolua_pushcfunction(L, TableToArray);
		LuaDLL.lua_rawset(L, -3);
		int metaReference = LuaStatic.GetMetaReference(L, typeof(NullObject));
		LuaDLL.lua_pushstring(L, "null");
		LuaDLL.tolua_pushnewudata(L, metaReference, 1);
		LuaDLL.lua_rawset(L, -3);
		LuaDLL.lua_pop(L, 1);
		LuaDLL.tolua_pushudata(L, 1);
		LuaDLL.lua_setfield(L, LuaIndexes.LUA_GLOBALSINDEX, "null");
	}

	private static void AddLuaLoader(IntPtr L)
	{
		LuaDLL.lua_getglobal(L, "package");
		LuaDLL.lua_getfield(L, -1, "loaders");
		LuaDLL.tolua_pushcfunction(L, Loader);
		for (int num = LuaDLL.lua_objlen(L, -2) + 1; num > 2; num--)
		{
			LuaDLL.lua_rawgeti(L, -2, num - 1);
			LuaDLL.lua_rawseti(L, -3, num);
		}
		LuaDLL.lua_rawseti(L, -2, 2);
		LuaDLL.lua_pop(L, 2);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Panic(IntPtr L)
	{
		throw new LuaException($"PANIC: unprotected error in call to Lua API ({LuaDLL.lua_tostring(L, -1)})");
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Print(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			using (CString.Block())
			{
				CString cString = CString.Alloc(256);
				for (int i = 1; i <= num; i++)
				{
					if (i > 1)
					{
						cString.Append("    ");
					}
					if (LuaDLL.lua_isstring(L, i) == 1)
					{
						cString.Append(LuaDLL.lua_tostring(L, i));
						continue;
					}
					if (LuaDLL.lua_isnil(L, i))
					{
						cString.Append("nil");
						continue;
					}
					if (LuaDLL.lua_isboolean(L, i))
					{
						cString.Append(LuaDLL.lua_toboolean(L, i) ? "true" : "false");
						continue;
					}
					IntPtr intPtr = LuaDLL.lua_topointer(L, i);
					if (intPtr == IntPtr.Zero)
					{
						cString.Append("nil");
					}
					else
					{
						cString.Append(LuaDLL.luaL_typename(L, i)).Append(":0x").Append(intPtr.ToString("X"));
					}
				}
				Debugger.Log(cString.ToString());
			}
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Loader(IntPtr L)
	{
		try
		{
			string text = LuaDLL.lua_tostring(L, 1);
			text = text.Replace(".", "/");
			byte[] array = LuaFileUtils.Instance.ReadFile(text);
			if (array == null)
			{
				string str = LuaFileUtils.Instance.FindFileError(text);
				LuaDLL.lua_pushstring(L, str);
				return 1;
			}
			if (LuaConst.openLuaDebugger)
			{
				text = LuaFileUtils.Instance.FindFile(text);
			}
			if (LuaDLL.luaL_loadbuffer(L, array, array.Length, "@" + text) != 0)
			{
				throw new LuaException(LuaDLL.lua_tostring(L, -1), LuaException.GetLastError());
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	public static int DoFile(IntPtr L)
	{
		try
		{
			string text = LuaDLL.lua_tostring(L, 1);
			int num = LuaDLL.lua_gettop(L);
			byte[] array = LuaFileUtils.Instance.ReadFile(text);
			if (array == null)
			{
				throw new LuaException($"cannot open {text}: No such file or directory" + LuaFileUtils.Instance.FindFileError(text));
			}
			if (LuaDLL.luaL_loadbuffer(L, array, array.Length, text) == 0)
			{
				if (LuaDLL.lua_pcall(L, 0, LuaDLL.LUA_MULTRET, 0) != 0)
				{
					throw new LuaException(LuaDLL.lua_tostring(L, -1), LuaException.GetLastError());
				}
				return LuaDLL.lua_gettop(L) - num;
			}
			throw new LuaException(LuaDLL.lua_tostring(L, -1), LuaException.GetLastError());
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	public static int LoadFile(IntPtr L)
	{
		try
		{
			string text = LuaDLL.lua_tostring(L, 1);
			byte[] array = LuaFileUtils.Instance.ReadFile(text);
			if (array == null)
			{
				throw new LuaException($"cannot open {text}: No such file or directory" + LuaFileUtils.Instance.FindFileError(text));
			}
			if (LuaDLL.luaL_loadbuffer(L, array, array.Length, text) == 0)
			{
				return 1;
			}
			LuaDLL.lua_pushnil(L);
			LuaDLL.lua_insert(L, -2);
			return 2;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsNull(IntPtr L)
	{
		if (LuaDLL.lua_type(L, 1) == LuaTypes.LUA_TNIL)
		{
			LuaDLL.lua_pushboolean(L, value: true);
		}
		else
		{
			object obj = ToObject(L, -1);
			if (obj == null || obj.Equals(null))
			{
				LuaDLL.lua_pushboolean(L, value: true);
			}
			else
			{
				LuaDLL.lua_pushboolean(L, value: false);
			}
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int BufferToString(IntPtr L)
	{
		try
		{
			object obj = CheckObject(L, 1);
			if (obj is byte[])
			{
				byte[] array = (byte[])obj;
				LuaDLL.lua_pushlstring(L, array, array.Length);
			}
			else if (obj is char[])
			{
				byte[] bytes = Encoding.UTF8.GetBytes((char[])obj);
				LuaDLL.lua_pushlstring(L, bytes, bytes.Length);
			}
			else if (obj is string)
			{
				LuaDLL.lua_pushstring(L, (string)obj);
			}
			else
			{
				LuaDLL.luaL_typerror(L, 1, "byte[] or char[]");
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetClassType(IntPtr L)
	{
		int num = LuaDLL.tolua_getmetatableref(L, 1);
		if (num > 0)
		{
			Type classType = LuaStatic.GetClassType(L, num);
			Push(L, classType);
		}
		else
		{
			int num2 = LuaDLL.tolua_getvaluetype(L, -1);
			if (num2 != 0)
			{
				Type t = TypeChecker.LuaValueTypeMap[num2];
				Push(L, t);
			}
			else
			{
				Debugger.LogError("type not register to lua");
				LuaDLL.lua_pushnil(L);
			}
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TableToArray(IntPtr L)
	{
		try
		{
			object[] array = CheckObjectArray(L, 1);
			Array array2 = Array.CreateInstance(CheckMonoType(L, 2), array.Length);
			for (int i = 0; i < array.Length; i++)
			{
				array2.SetValue(array[i], i);
			}
			Push(L, array2);
			return 1;
		}
		catch (LuaException e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	public static int op_ToString(IntPtr L)
	{
		object obj = ToObject(L, 1);
		if (obj != null)
		{
			LuaDLL.lua_pushstring(L, obj.ToString());
		}
		else
		{
			LuaDLL.lua_pushnil(L);
		}
		return 1;
	}

	public static string ToString(IntPtr L, int stackPos)
	{
		return LuaDLL.lua_type(L, stackPos) switch
		{
			LuaTypes.LUA_TSTRING => LuaDLL.lua_tostring(L, stackPos), 
			LuaTypes.LUA_TUSERDATA => (string)ToObject(L, stackPos), 
			_ => null, 
		};
	}

	public static object ToObject(IntPtr L, int stackPos)
	{
		int num = LuaDLL.tolua_rawnetobj(L, stackPos);
		if (num != -1)
		{
			return ObjectTranslator.Get(L).GetObject(num);
		}
		return null;
	}

	public static LuaFunction ToLuaFunction(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		stackPos = LuaDLL.abs_index(L, stackPos);
		LuaDLL.lua_pushvalue(L, stackPos);
		int reference = LuaDLL.toluaL_ref(L);
		return LuaStatic.GetFunction(L, reference);
	}

	public static LuaTable ToLuaTable(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		stackPos = LuaDLL.abs_index(L, stackPos);
		LuaDLL.lua_pushvalue(L, stackPos);
		int reference = LuaDLL.toluaL_ref(L);
		return LuaStatic.GetTable(L, reference);
	}

	public static LuaThread ToLuaThread(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		stackPos = LuaDLL.abs_index(L, stackPos);
		LuaDLL.lua_pushvalue(L, stackPos);
		int reference = LuaDLL.toluaL_ref(L);
		return LuaStatic.GetLuaThread(L, reference);
	}

	public static Vector3 ToVector3(IntPtr L, int stackPos)
	{
		float x = 0f;
		float y = 0f;
		float z = 0f;
		LuaDLL.tolua_getvec3(L, stackPos, out x, out y, out z);
		return new Vector3(x, y, z);
	}

	public static Vector4 ToVector4(IntPtr L, int stackPos)
	{
		LuaDLL.tolua_getvec4(L, stackPos, out var x, out var y, out var z, out var w);
		return new Vector4(x, y, z, w);
	}

	public static Vector2 ToVector2(IntPtr L, int stackPos)
	{
		LuaDLL.tolua_getvec2(L, stackPos, out var x, out var y);
		return new Vector2(x, y);
	}

	public static Quaternion ToQuaternion(IntPtr L, int stackPos)
	{
		LuaDLL.tolua_getquat(L, stackPos, out var x, out var y, out var z, out var w);
		return new Quaternion(x, y, z, w);
	}

	public static Color ToColor(IntPtr L, int stackPos)
	{
		LuaDLL.tolua_getclr(L, stackPos, out var r, out var g, out var b, out var a);
		return new Color(r, g, b, a);
	}

	public static Ray ToRay(IntPtr L, int stackPos)
	{
		int num = LuaDLL.lua_gettop(L);
		LuaStatic.GetUnpackRayRef(L);
		stackPos = LuaDLL.abs_index(L, stackPos);
		LuaDLL.lua_pushvalue(L, stackPos);
		if (LuaDLL.lua_pcall(L, 1, 6, 0) == 0)
		{
			float x = (float)LuaDLL.lua_tonumber(L, num + 1);
			float y = (float)LuaDLL.lua_tonumber(L, num + 2);
			float z = (float)LuaDLL.lua_tonumber(L, num + 3);
			float x2 = (float)LuaDLL.lua_tonumber(L, num + 4);
			float y2 = (float)LuaDLL.lua_tonumber(L, num + 5);
			float z2 = (float)LuaDLL.lua_tonumber(L, num + 6);
			LuaDLL.lua_settop(L, num);
			return new Ray(new Vector3(x, y, z), new Vector3(x2, y2, z2));
		}
		string msg = LuaDLL.lua_tostring(L, -1);
		LuaDLL.lua_settop(L, num);
		throw new LuaException(msg);
	}

	public static Bounds ToBounds(IntPtr L, int stackPos)
	{
		int num = LuaDLL.lua_gettop(L);
		LuaStatic.GetUnpackBounds(L);
		stackPos = LuaDLL.abs_index(L, stackPos);
		LuaDLL.lua_pushvalue(L, stackPos);
		if (LuaDLL.lua_pcall(L, 1, 2, 0) == 0)
		{
			Vector3 center = ToVector3(L, num + 1);
			Vector3 size = ToVector3(L, num + 2);
			LuaDLL.lua_settop(L, num);
			return new Bounds(center, size);
		}
		string msg = LuaDLL.lua_tostring(L, -1);
		LuaDLL.lua_settop(L, num);
		throw new LuaException(msg);
	}

	public static LayerMask ToLayerMask(IntPtr L, int stackPos)
	{
		return LuaDLL.tolua_getlayermask(L, stackPos);
	}

	public static object ToVarObject(IntPtr L, int stackPos)
	{
		return LuaDLL.lua_type(L, stackPos) switch
		{
			LuaTypes.LUA_TNUMBER => LuaDLL.lua_tonumber(L, stackPos), 
			LuaTypes.LUA_TSTRING => LuaDLL.lua_tostring(L, stackPos), 
			LuaTypes.LUA_TUSERDATA => LuaDLL.tolua_getvaluetype(L, stackPos) switch
			{
				11 => LuaDLL.tolua_toint64(L, stackPos), 
				12 => LuaDLL.tolua_touint64(L, stackPos), 
				_ => ToObject(L, stackPos), 
			}, 
			LuaTypes.LUA_TBOOLEAN => LuaDLL.lua_toboolean(L, stackPos), 
			LuaTypes.LUA_TFUNCTION => ToLuaFunction(L, stackPos), 
			LuaTypes.LUA_TTABLE => ToVarTable(L, stackPos), 
			LuaTypes.LUA_TNIL => null, 
			LuaTypes.LUA_TLIGHTUSERDATA => LuaDLL.lua_touserdata(L, stackPos), 
			LuaTypes.LUA_TTHREAD => ToLuaThread(L, stackPos), 
			_ => null, 
		};
	}

	public static object ToVarObject(IntPtr L, int stackPos, Type t)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNUMBER)
		{
			return Convert.ChangeType(LuaDLL.lua_tonumber(L, stackPos), t);
		}
		return ToVarObject(L, stackPos);
	}

	public static object ToVarTable(IntPtr L, int stackPos)
	{
		stackPos = LuaDLL.abs_index(L, stackPos);
		int num = LuaDLL.tolua_getvaluetype(L, stackPos);
		LuaTableToVar luaTableToVar = ToVarMap[num];
		if (luaTableToVar != null)
		{
			return luaTableToVar(L, stackPos);
		}
		LuaDLL.lua_pushvalue(L, stackPos);
		int reference = LuaDLL.toluaL_ref(L);
		return LuaStatic.GetTable(L, reference);
	}

	public static T? ToNullable<T>(IntPtr L, int stackPos) where T : struct
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return StackTraits<T>.To(L, stackPos);
	}

	private static object ToObjectVec3(IntPtr L, int stackPos)
	{
		return ToVector3(L, stackPos);
	}

	private static object ToObjectQuat(IntPtr L, int stackPos)
	{
		return ToQuaternion(L, stackPos);
	}

	private static object ToObjectColor(IntPtr L, int stackPos)
	{
		return ToColor(L, stackPos);
	}

	private static object ToObjectVec4(IntPtr L, int stackPos)
	{
		return ToVector4(L, stackPos);
	}

	private static object ToObjectVec2(IntPtr L, int stackPos)
	{
		return ToVector2(L, stackPos);
	}

	private static object ToObjectRay(IntPtr L, int stackPos)
	{
		return ToRay(L, stackPos);
	}

	private static object ToObjectLayerMask(IntPtr L, int stackPos)
	{
		return ToLayerMask(L, stackPos);
	}

	private static object ToObjectBounds(IntPtr L, int stackPos)
	{
		return ToBounds(L, stackPos);
	}

	public static LuaFunction CheckLuaFunction(IntPtr L, int stackPos)
	{
		switch (LuaDLL.lua_type(L, stackPos))
		{
		case LuaTypes.LUA_TNIL:
			return null;
		case LuaTypes.LUA_TFUNCTION:
		{
			stackPos = LuaDLL.abs_index(L, stackPos);
			LuaDLL.lua_pushvalue(L, stackPos);
			int reference = LuaDLL.toluaL_ref(L);
			return LuaStatic.GetFunction(L, reference);
		}
		default:
			LuaDLL.luaL_typerror(L, stackPos, "function");
			return null;
		}
	}

	public static LuaTable CheckLuaTable(IntPtr L, int stackPos)
	{
		switch (LuaDLL.lua_type(L, stackPos))
		{
		case LuaTypes.LUA_TNIL:
			return null;
		case LuaTypes.LUA_TTABLE:
		{
			stackPos = LuaDLL.abs_index(L, stackPos);
			LuaDLL.lua_pushvalue(L, stackPos);
			int reference = LuaDLL.toluaL_ref(L);
			return LuaStatic.GetTable(L, reference);
		}
		default:
			LuaDLL.luaL_typerror(L, stackPos, "table");
			return null;
		}
	}

	public static LuaThread CheckLuaThread(IntPtr L, int stackPos)
	{
		switch (LuaDLL.lua_type(L, stackPos))
		{
		case LuaTypes.LUA_TNIL:
			return null;
		case LuaTypes.LUA_TTHREAD:
		{
			stackPos = LuaDLL.abs_index(L, stackPos);
			LuaDLL.lua_pushvalue(L, stackPos);
			int reference = LuaDLL.toluaL_ref(L);
			return LuaStatic.GetLuaThread(L, reference);
		}
		default:
			LuaDLL.luaL_typerror(L, stackPos, "thread");
			return null;
		}
	}

	public static LuaBaseRef CheckLuaBaseRef(IntPtr L, int stackPos)
	{
		switch (LuaDLL.lua_type(L, stackPos))
		{
		case LuaTypes.LUA_TNIL:
			return null;
		case LuaTypes.LUA_TFUNCTION:
		{
			stackPos = LuaDLL.abs_index(L, stackPos);
			LuaDLL.lua_pushvalue(L, stackPos);
			int reference3 = LuaDLL.toluaL_ref(L);
			return LuaStatic.GetFunction(L, reference3);
		}
		case LuaTypes.LUA_TTABLE:
		{
			stackPos = LuaDLL.abs_index(L, stackPos);
			LuaDLL.lua_pushvalue(L, stackPos);
			int reference2 = LuaDLL.toluaL_ref(L);
			return LuaStatic.GetTable(L, reference2);
		}
		case LuaTypes.LUA_TTHREAD:
		{
			stackPos = LuaDLL.abs_index(L, stackPos);
			LuaDLL.lua_pushvalue(L, stackPos);
			int reference = LuaDLL.toluaL_ref(L);
			return LuaStatic.GetLuaThread(L, reference);
		}
		default:
			LuaDLL.luaL_typerror(L, stackPos, "function or table or thread");
			return null;
		}
	}

	public static string CheckString(IntPtr L, int stackPos)
	{
		switch (LuaDLL.lua_type(L, stackPos))
		{
		case LuaTypes.LUA_TNIL:
			return null;
		case LuaTypes.LUA_TNUMBER:
			return LuaDLL.lua_tostring(L, stackPos);
		case LuaTypes.LUA_TSTRING:
			return LuaDLL.lua_tostring(L, stackPos);
		case LuaTypes.LUA_TUSERDATA:
		{
			int num = LuaDLL.tolua_rawnetobj(L, stackPos);
			if (num == -1)
			{
				break;
			}
			object obj = ObjectTranslator.Get(L).GetObject(num);
			if (obj != null)
			{
				if (obj is string)
				{
					return (string)obj;
				}
				LuaDLL.luaL_argerror(L, stackPos, $"string expected, got {obj.GetType().FullName}");
			}
			return null;
		}
		}
		LuaDLL.luaL_typerror(L, stackPos, "string");
		return null;
	}

	public static IntPtr CheckIntPtr(IntPtr L, int stackPos)
	{
		switch (LuaDLL.lua_type(L, stackPos))
		{
		case LuaTypes.LUA_TNIL:
			return IntPtr.Zero;
		case LuaTypes.LUA_TLIGHTUSERDATA:
			return LuaDLL.lua_touserdata(L, stackPos);
		default:
			LuaDLL.luaL_typerror(L, stackPos, "IntPtr");
			return IntPtr.Zero;
		}
	}

	public static Type CheckMonoType(IntPtr L, int stackPos)
	{
		int num = LuaDLL.tolua_rawnetobj(L, stackPos);
		if (num != -1)
		{
			object obj = ObjectTranslator.Get(L).GetObject(num);
			if (obj != null)
			{
				if (obj is Type)
				{
					return (Type)obj;
				}
				LuaDLL.luaL_argerror(L, stackPos, $"Type expected, got {obj.GetType().FullName}");
			}
			return null;
		}
		if (LuaDLL.lua_isnil(L, stackPos))
		{
			return null;
		}
		LuaDLL.luaL_typerror(L, stackPos, "Type");
		return null;
	}

	public static IEnumerator CheckIter(IntPtr L, int stackPos)
	{
		int num = LuaDLL.tolua_rawnetobj(L, stackPos);
		if (num != -1)
		{
			object obj = ObjectTranslator.Get(L).GetObject(num);
			if (obj != null)
			{
				if (obj is IEnumerator)
				{
					return (IEnumerator)obj;
				}
				LuaDLL.luaL_argerror(L, stackPos, $"Type expected, got {obj.GetType().FullName}");
			}
			return null;
		}
		if (LuaDLL.lua_isnil(L, stackPos))
		{
			return null;
		}
		LuaDLL.luaL_typerror(L, stackPos, "Type");
		return null;
	}

	public static object CheckObject(IntPtr L, int stackPos)
	{
		int num = LuaDLL.tolua_rawnetobj(L, stackPos);
		if (num != -1)
		{
			return ObjectTranslator.Get(L).GetObject(num);
		}
		if (LuaDLL.lua_isnil(L, stackPos))
		{
			return null;
		}
		LuaDLL.luaL_typerror(L, stackPos, "object");
		return null;
	}

	public static object CheckObject(IntPtr L, int stackPos, Type type)
	{
		int num = LuaDLL.tolua_rawnetobj(L, stackPos);
		if (num != -1)
		{
			object obj = ObjectTranslator.Get(L).GetObject(num);
			if (obj != null)
			{
				Type type2 = obj.GetType();
				if (type == type2 || type.IsAssignableFrom(type2))
				{
					return obj;
				}
				LuaDLL.luaL_argerror(L, stackPos, $"{LuaMisc.GetTypeName(type)} expected, got {LuaMisc.GetTypeName(type2)}");
			}
			return null;
		}
		if (LuaDLL.lua_isnil(L, stackPos))
		{
			return null;
		}
		LuaDLL.luaL_typerror(L, stackPos, LuaMisc.GetTypeName(type));
		return null;
	}

	public static object CheckObject<T>(IntPtr L, int stackPos) where T : class
	{
		int num = LuaDLL.tolua_rawnetobj(L, stackPos);
		if (num != -1)
		{
			object obj = ObjectTranslator.Get(L).GetObject(num);
			if (obj != null)
			{
				if (obj is T)
				{
					return obj;
				}
				Type type = obj.GetType();
				LuaDLL.luaL_argerror(L, stackPos, $"{TypeTraits<T>.GetTypeName()} expected, got {type.FullName}");
			}
			return null;
		}
		if (LuaDLL.lua_isnil(L, stackPos))
		{
			return null;
		}
		LuaDLL.luaL_typerror(L, stackPos, TypeTraits<T>.GetTypeName());
		return null;
	}

	public static Vector3 CheckVector3(IntPtr L, int stackPos)
	{
		int num = LuaDLL.tolua_getvaluetype(L, stackPos);
		if (num != 1)
		{
			LuaDLL.luaL_typerror(L, stackPos, "Vector3", LuaValueTypeName.Get(num));
			return Vector3.zero;
		}
		LuaDLL.tolua_getvec3(L, stackPos, out var x, out var y, out var z);
		return new Vector3(x, y, z);
	}

	public static Quaternion CheckQuaternion(IntPtr L, int stackPos)
	{
		int num = LuaDLL.tolua_getvaluetype(L, stackPos);
		if (num != 2)
		{
			LuaDLL.luaL_typerror(L, stackPos, "Quaternion", LuaValueTypeName.Get(num));
			return Quaternion.identity;
		}
		LuaDLL.tolua_getquat(L, stackPos, out var x, out var y, out var z, out var w);
		return new Quaternion(x, y, z, w);
	}

	public static Vector2 CheckVector2(IntPtr L, int stackPos)
	{
		int num = LuaDLL.tolua_getvaluetype(L, stackPos);
		if (num != 3)
		{
			LuaDLL.luaL_typerror(L, stackPos, "Vector2", LuaValueTypeName.Get(num));
			return Vector2.zero;
		}
		LuaDLL.tolua_getvec2(L, stackPos, out var x, out var y);
		return new Vector2(x, y);
	}

	public static Vector4 CheckVector4(IntPtr L, int stackPos)
	{
		int num = LuaDLL.tolua_getvaluetype(L, stackPos);
		if (num != 5)
		{
			LuaDLL.luaL_typerror(L, stackPos, "Vector4", LuaValueTypeName.Get(num));
			return Vector4.zero;
		}
		LuaDLL.tolua_getvec4(L, stackPos, out var x, out var y, out var z, out var w);
		return new Vector4(x, y, z, w);
	}

	public static Color CheckColor(IntPtr L, int stackPos)
	{
		int num = LuaDLL.tolua_getvaluetype(L, stackPos);
		if (num != 4)
		{
			LuaDLL.luaL_typerror(L, stackPos, "Color", LuaValueTypeName.Get(num));
			return Color.black;
		}
		LuaDLL.tolua_getclr(L, stackPos, out var r, out var g, out var b, out var a);
		return new Color(r, g, b, a);
	}

	public static Ray CheckRay(IntPtr L, int stackPos)
	{
		int num = LuaDLL.tolua_getvaluetype(L, stackPos);
		if (num != 6)
		{
			LuaDLL.luaL_typerror(L, stackPos, "Ray", LuaValueTypeName.Get(num));
			return default(Ray);
		}
		return ToRay(L, stackPos);
	}

	public static Bounds CheckBounds(IntPtr L, int stackPos)
	{
		int num = LuaDLL.tolua_getvaluetype(L, stackPos);
		if (num != 7)
		{
			LuaDLL.luaL_typerror(L, stackPos, "Bounds", LuaValueTypeName.Get(num));
			return default(Bounds);
		}
		return ToBounds(L, stackPos);
	}

	public static LayerMask CheckLayerMask(IntPtr L, int stackPos)
	{
		int num = LuaDLL.tolua_getvaluetype(L, stackPos);
		if (num != 9)
		{
			LuaDLL.luaL_typerror(L, stackPos, "LayerMask", LuaValueTypeName.Get(num));
			return 0;
		}
		return LuaDLL.tolua_getlayermask(L, stackPos);
	}

	public static T CheckValue<T>(IntPtr L, int stackPos) where T : struct
	{
		return StackTraits<T>.Check(L, stackPos);
	}

	public static T? CheckNullable<T>(IntPtr L, int stackPos) where T : struct
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return StackTraits<T>.Check(L, stackPos);
	}

	public static object CheckVarObject(IntPtr L, int stackPos, Type t)
	{
		bool flag = TypeChecker.IsValueType(t);
		LuaTypes luaTypes = LuaDLL.lua_type(L, stackPos);
		if (!flag && luaTypes == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		if (flag)
		{
			if (TypeChecker.IsNullable(t))
			{
				if (luaTypes == LuaTypes.LUA_TNIL)
				{
					return null;
				}
				t = t.GetGenericArguments()[0];
			}
			if (t == typeof(bool))
			{
				return LuaDLL.luaL_checkboolean(L, stackPos);
			}
			if (t == typeof(long))
			{
				return LuaDLL.tolua_checkint64(L, stackPos);
			}
			if (t == typeof(ulong))
			{
				return LuaDLL.tolua_checkuint64(L, stackPos);
			}
			if (t.IsPrimitive)
			{
				return Convert.ChangeType(LuaDLL.luaL_checknumber(L, stackPos), t);
			}
			if (t == typeof(LuaByteBuffer))
			{
				int strLen = 0;
				return new LuaByteBuffer(LuaDLL.tolua_tolstring(L, stackPos, out strLen), strLen);
			}
			if (t == typeof(Vector3))
			{
				return CheckVector3(L, stackPos);
			}
			if (t == typeof(Quaternion))
			{
				return CheckQuaternion(L, stackPos);
			}
			if (t == typeof(Vector2))
			{
				return CheckVector2(L, stackPos);
			}
			if (t == typeof(Vector4))
			{
				return CheckVector4(L, stackPos);
			}
			if (t == typeof(Color))
			{
				return CheckColor(L, stackPos);
			}
			if (t == typeof(Ray))
			{
				return CheckRay(L, stackPos);
			}
			if (t == typeof(Bounds))
			{
				return CheckBounds(L, stackPos);
			}
			if (t == typeof(LayerMask))
			{
				return CheckLayerMask(L, stackPos);
			}
			if (luaTypes == LuaTypes.LUA_TTABLE)
			{
				object obj = ToVarTable(L, stackPos);
				if (obj.GetType() != t)
				{
					LuaDLL.luaL_typerror(L, stackPos, LuaMisc.GetTypeName(t));
				}
				return obj;
			}
			return CheckObject(L, stackPos, t);
		}
		if (t.IsEnum)
		{
			return CheckObject(L, stackPos, t);
		}
		if (t == typeof(string))
		{
			return CheckString(L, stackPos);
		}
		return CheckObject(L, stackPos, t);
	}

	public static UnityEngine.Object CheckUnityObject(IntPtr L, int stackPos, Type type)
	{
		int num = LuaDLL.tolua_rawnetobj(L, stackPos);
		object obj = null;
		if (num != -1)
		{
			obj = ObjectTranslator.Get(L).GetObject(num);
			if (obj != null)
			{
				UnityEngine.Object obj2 = (UnityEngine.Object)obj;
				if (obj2 == null)
				{
					LuaDLL.luaL_argerror(L, stackPos, $"{type.FullName} expected, got nil");
					return null;
				}
				Type type2 = obj2.GetType();
				if (type == type2 || type2.IsSubclassOf(type))
				{
					return obj2;
				}
				LuaDLL.luaL_argerror(L, stackPos, $"{type.FullName} expected, got {type2.FullName}");
			}
			return null;
		}
		if (LuaDLL.lua_isnil(L, stackPos))
		{
			return null;
		}
		LuaDLL.luaL_typerror(L, stackPos, type.FullName);
		return null;
	}

	public static TrackedReference CheckTrackedReference(IntPtr L, int stackPos, Type type)
	{
		int num = LuaDLL.tolua_rawnetobj(L, stackPos);
		object obj = null;
		if (num != -1)
		{
			obj = ObjectTranslator.Get(L).GetObject(num);
			if (obj != null)
			{
				TrackedReference trackedReference = (TrackedReference)obj;
				if (trackedReference == null)
				{
					LuaDLL.luaL_argerror(L, stackPos, $"{type.FullName} expected, got nil");
					return null;
				}
				Type type2 = trackedReference.GetType();
				if (type == type2 || type2.IsSubclassOf(type))
				{
					return trackedReference;
				}
				LuaDLL.luaL_argerror(L, stackPos, $"{type.FullName} expected, got {type2.FullName}");
			}
			return null;
		}
		if (LuaDLL.lua_isnil(L, stackPos))
		{
			return null;
		}
		LuaDLL.luaL_typerror(L, stackPos, type.FullName);
		return null;
	}

	public static object[] CheckObjectArray(IntPtr L, int stackPos)
	{
		switch (LuaDLL.lua_type(L, stackPos))
		{
		case LuaTypes.LUA_TNIL:
			return null;
		case LuaTypes.LUA_TTABLE:
		{
			int num = LuaDLL.lua_objlen(L, stackPos);
			object[] array = new object[num];
			int stackPos2 = LuaDLL.lua_gettop(L) + 1;
			for (int i = 1; i <= num; i++)
			{
				LuaDLL.lua_rawgeti(L, stackPos, i);
				array[i - 1] = ToVarObject(L, stackPos2);
				LuaDLL.lua_pop(L, 1);
			}
			return array;
		}
		case LuaTypes.LUA_TUSERDATA:
			return (object[])CheckObject(L, stackPos, typeof(object[]));
		default:
			LuaDLL.luaL_typerror(L, stackPos, "object[] or table");
			return null;
		}
	}

	public static T[] CheckObjectArray<T>(IntPtr L, int stackPos) where T : class
	{
		switch (LuaDLL.lua_type(L, stackPos))
		{
		case LuaTypes.LUA_TNIL:
			return null;
		case LuaTypes.LUA_TTABLE:
		{
			int num = LuaDLL.lua_objlen(L, stackPos);
			T[] array = new T[num];
			int arg = LuaDLL.lua_gettop(L) + 1;
			for (int i = 1; i <= num; i++)
			{
				LuaDLL.lua_rawgeti(L, stackPos, i);
				if (!TypeTraits<T>.Check(L, arg))
				{
					LuaDLL.lua_pop(L, 1);
					LuaDLL.luaL_typerror(L, stackPos, typeof(T[]).FullName);
					return array;
				}
				array[i - 1] = StackTraits<T>.To(L, arg);
				LuaDLL.lua_pop(L, 1);
			}
			return array;
		}
		case LuaTypes.LUA_TUSERDATA:
			return (T[])CheckObject(L, stackPos, typeof(T[]));
		default:
			LuaDLL.luaL_typerror(L, stackPos, TypeTraits<T[]>.GetTypeName());
			return null;
		}
	}

	public static T[] CheckStructArray<T>(IntPtr L, int stackPos) where T : struct
	{
		switch (LuaDLL.lua_type(L, stackPos))
		{
		case LuaTypes.LUA_TTABLE:
		{
			int num = LuaDLL.lua_objlen(L, stackPos);
			T[] array = new T[num];
			int arg = LuaDLL.lua_gettop(L) + 1;
			for (int i = 1; i <= num; i++)
			{
				LuaDLL.lua_rawgeti(L, stackPos, i);
				if (!TypeTraits<T>.Check(L, arg))
				{
					LuaDLL.lua_pop(L, 1);
					LuaDLL.luaL_typerror(L, stackPos, typeof(T[]).FullName);
					return array;
				}
				array[i - 1] = StackTraits<T>.To(L, arg);
				LuaDLL.lua_pop(L, 1);
			}
			return array;
		}
		case LuaTypes.LUA_TUSERDATA:
			return (T[])CheckObject(L, stackPos, typeof(T[]));
		default:
			LuaDLL.luaL_typerror(L, stackPos, TypeTraits<T[]>.GetTypeName());
			return null;
		}
	}

	public static char[] CheckCharBuffer(IntPtr L, int stackPos)
	{
		switch (LuaDLL.lua_type(L, stackPos))
		{
		case LuaTypes.LUA_TNIL:
			return null;
		case LuaTypes.LUA_TSTRING:
			return LuaDLL.lua_tostring(L, stackPos).ToCharArray();
		case LuaTypes.LUA_TUSERDATA:
			return (char[])CheckObject(L, stackPos, typeof(char[]));
		default:
			LuaDLL.luaL_typerror(L, stackPos, "string or char[]");
			return null;
		}
	}

	public static byte[] CheckByteBuffer(IntPtr L, int stackPos)
	{
		switch (LuaDLL.lua_type(L, stackPos))
		{
		case LuaTypes.LUA_TNIL:
			return null;
		case LuaTypes.LUA_TSTRING:
		{
			IntPtr source = LuaDLL.lua_tolstring(L, stackPos, out var strLen);
			byte[] array = new byte[strLen];
			Marshal.Copy(source, array, 0, strLen);
			return array;
		}
		case LuaTypes.LUA_TUSERDATA:
			return (byte[])CheckObject(L, stackPos, typeof(byte[]));
		default:
			LuaDLL.luaL_typerror(L, stackPos, "string or byte[]");
			return null;
		}
	}

	public static T[] CheckNumberArray<T>(IntPtr L, int stackPos) where T : struct
	{
		switch (LuaDLL.lua_type(L, stackPos))
		{
		case LuaTypes.LUA_TNIL:
			return null;
		case LuaTypes.LUA_TTABLE:
		{
			int num = LuaDLL.lua_objlen(L, stackPos);
			T[] array = new T[num];
			int arg = LuaDLL.lua_gettop(L) + 1;
			for (int i = 1; i <= num; i++)
			{
				LuaDLL.lua_rawgeti(L, stackPos, i);
				if (!TypeTraits<T>.Check(L, arg))
				{
					LuaDLL.lua_pop(L, 1);
					LuaDLL.luaL_typerror(L, stackPos, TypeTraits<T[]>.GetTypeName());
					return array;
				}
				array[i - 1] = StackTraits<T>.To(L, arg);
				LuaDLL.lua_pop(L, 1);
			}
			return array;
		}
		case LuaTypes.LUA_TUSERDATA:
			return (T[])CheckObject(L, stackPos, typeof(T[]));
		default:
			LuaDLL.luaL_typerror(L, stackPos, TypeTraits<T[]>.GetTypeName());
			return null;
		}
	}

	public static bool[] CheckBoolArray(IntPtr L, int stackPos)
	{
		switch (LuaDLL.lua_type(L, stackPos))
		{
		case LuaTypes.LUA_TNIL:
			return null;
		case LuaTypes.LUA_TTABLE:
		{
			int num = LuaDLL.lua_objlen(L, stackPos);
			bool[] array = new bool[num];
			int num2 = LuaDLL.lua_gettop(L) + 1;
			for (int i = 1; i <= num; i++)
			{
				LuaDLL.lua_rawgeti(L, stackPos, i);
				if (LuaDLL.lua_type(L, num2) != LuaTypes.LUA_TBOOLEAN)
				{
					LuaDLL.lua_pop(L, 1);
					LuaDLL.luaL_typerror(L, stackPos, "bool[]");
					return array;
				}
				array[i - 1] = LuaDLL.lua_toboolean(L, num2);
				LuaDLL.lua_pop(L, 1);
			}
			return array;
		}
		case LuaTypes.LUA_TUSERDATA:
			return (bool[])CheckObject(L, stackPos, typeof(bool[]));
		default:
			LuaDLL.luaL_typerror(L, stackPos, "bool[]");
			return null;
		}
	}

	public static string[] CheckStringArray(IntPtr L, int stackPos)
	{
		switch (LuaDLL.lua_type(L, stackPos))
		{
		case LuaTypes.LUA_TNIL:
			return null;
		case LuaTypes.LUA_TTABLE:
		{
			int num = LuaDLL.lua_objlen(L, stackPos);
			string[] array = new string[num];
			int arg = LuaDLL.lua_gettop(L) + 1;
			for (int i = 1; i <= num; i++)
			{
				LuaDLL.lua_rawgeti(L, stackPos, i);
				if (!TypeTraits<string>.Check(L, arg))
				{
					LuaDLL.lua_pop(L, 1);
					LuaDLL.luaL_typerror(L, stackPos, "string[]");
					return array;
				}
				array[i - 1] = StackTraits<string>.To(L, arg);
				LuaDLL.lua_pop(L, 1);
			}
			return array;
		}
		case LuaTypes.LUA_TUSERDATA:
			return (string[])CheckObject(L, stackPos, typeof(string[]));
		default:
			LuaDLL.luaL_typerror(L, stackPos, "string[]");
			return null;
		}
	}

	public static object CheckGenericObject(IntPtr L, int stackPos, Type type, out Type ArgType)
	{
		object obj = ToObject(L, 1);
		Type type2 = obj.GetType();
		ArgType = null;
		if (type2.IsGenericType && type2.GetGenericTypeDefinition() == type)
		{
			Type[] genericArguments = type2.GetGenericArguments();
			ArgType = genericArguments[0];
			return obj;
		}
		LuaDLL.luaL_argerror(L, stackPos, LuaMisc.GetTypeName(type));
		return null;
	}

	public static object CheckGenericObject(IntPtr L, int stackPos, Type type, out Type t1, out Type t2)
	{
		object obj = ToObject(L, 1);
		Type type2 = obj.GetType();
		t1 = null;
		t2 = null;
		if (type2.IsGenericType && type2.GetGenericTypeDefinition() == type)
		{
			Type[] genericArguments = type2.GetGenericArguments();
			t1 = genericArguments[0];
			t2 = genericArguments[1];
			return obj;
		}
		LuaDLL.luaL_argerror(L, stackPos, LuaMisc.GetTypeName(type));
		return null;
	}

	public static object CheckGenericObject(IntPtr L, int stackPos, Type type)
	{
		object obj = ToObject(L, 1);
		Type type2 = obj.GetType();
		if (type2.IsGenericType && type2.GetGenericTypeDefinition() == type)
		{
			return obj;
		}
		LuaDLL.luaL_argerror(L, stackPos, LuaMisc.GetTypeName(type));
		return null;
	}

	public static object[] ToParamsObject(IntPtr L, int stackPos, int count)
	{
		if (count <= 0)
		{
			return null;
		}
		object[] array = new object[count];
		int num = 0;
		while (num < count)
		{
			array[num++] = ToVarObject(L, stackPos++);
		}
		return array;
	}

	public static T[] ToParamsObject<T>(IntPtr L, int stackPos, int count)
	{
		if (count <= 0)
		{
			return null;
		}
		T[] array = new T[count];
		int num = 0;
		while (num < count)
		{
			array[num++] = StackTraits<T>.To(L, stackPos++);
		}
		return array;
	}

	public static string[] ToParamsString(IntPtr L, int stackPos, int count)
	{
		if (count <= 0)
		{
			return null;
		}
		string[] array = new string[count];
		int num = 0;
		while (num < count)
		{
			array[num++] = ToString(L, stackPos++);
		}
		return array;
	}

	public static T[] ToParamsNumber<T>(IntPtr L, int stackPos, int count) where T : struct
	{
		if (count <= 0)
		{
			return null;
		}
		T[] array = new T[count];
		int num = 0;
		while (num < count)
		{
			array[num++] = StackTraits<T>.To(L, stackPos++);
		}
		return array;
	}

	public static char[] ToParamsChar(IntPtr L, int stackPos, int count)
	{
		if (count <= 0)
		{
			return null;
		}
		char[] array = new char[count];
		int num = 0;
		while (num < count)
		{
			array[num++] = (char)LuaDLL.lua_tointeger(L, stackPos++);
		}
		return array;
	}

	public static bool[] CheckParamsBool(IntPtr L, int stackPos, int count)
	{
		if (count <= 0)
		{
			return null;
		}
		bool[] array = new bool[count];
		int num = 0;
		while (num < count)
		{
			array[num++] = LuaDLL.luaL_checkboolean(L, stackPos++);
		}
		return array;
	}

	public static T[] CheckParamsNumber<T>(IntPtr L, int stackPos, int count) where T : struct
	{
		if (count <= 0)
		{
			return null;
		}
		T[] array = new T[count];
		int num = 0;
		while (num < count)
		{
			array[num++] = StackTraits<T>.Check(L, stackPos++);
		}
		return array;
	}

	public static char[] CheckParamsChar(IntPtr L, int stackPos, int count)
	{
		if (count <= 0)
		{
			return null;
		}
		char[] array = new char[count];
		int num = 0;
		while (num < count)
		{
			array[num++] = (char)LuaDLL.luaL_checkinteger(L, stackPos++);
		}
		return array;
	}

	public static string[] CheckParamsString(IntPtr L, int stackPos, int count)
	{
		if (count <= 0)
		{
			return null;
		}
		string[] array = new string[count];
		int num = 0;
		while (num < count)
		{
			array[num++] = CheckString(L, stackPos++);
		}
		return array;
	}

	public static T[] CheckParamsObject<T>(IntPtr L, int stackPos, int count)
	{
		if (count <= 0)
		{
			return null;
		}
		T[] array = new T[count];
		int num = 0;
		while (num < count)
		{
			array[num++] = StackTraits<T>.Check(L, stackPos++);
		}
		return array;
	}

	public static char[] ToCharBuffer(IntPtr L, int stackPos)
	{
		return LuaDLL.lua_type(L, stackPos) switch
		{
			LuaTypes.LUA_TNIL => null, 
			LuaTypes.LUA_TSTRING => LuaDLL.lua_tostring(L, stackPos).ToCharArray(), 
			LuaTypes.LUA_TUSERDATA => (char[])ToObject(L, stackPos), 
			_ => null, 
		};
	}

	public static byte[] ToByteBuffer(IntPtr L, int stackPos)
	{
		switch (LuaDLL.lua_type(L, stackPos))
		{
		case LuaTypes.LUA_TNIL:
			return null;
		case LuaTypes.LUA_TSTRING:
		{
			IntPtr source = LuaDLL.lua_tolstring(L, stackPos, out var strLen);
			byte[] array = new byte[strLen];
			Marshal.Copy(source, array, 0, strLen);
			return array;
		}
		case LuaTypes.LUA_TUSERDATA:
			return (byte[])ToObject(L, stackPos);
		default:
			return null;
		}
	}

	public static T[] ToNumberArray<T>(IntPtr L, int stackPos) where T : struct
	{
		switch (LuaDLL.lua_type(L, stackPos))
		{
		case LuaTypes.LUA_TNIL:
			return null;
		case LuaTypes.LUA_TTABLE:
		{
			int num = LuaDLL.lua_objlen(L, stackPos);
			T[] array = new T[num];
			int arg = LuaDLL.lua_gettop(L) + 1;
			for (int i = 1; i <= num; i++)
			{
				LuaDLL.lua_rawgeti(L, stackPos, i);
				if (!TypeTraits<T>.Check(L, arg))
				{
					LuaDLL.lua_pop(L, 1);
					LuaDLL.luaL_typerror(L, stackPos, TypeTraits<T[]>.GetTypeName());
					return array;
				}
				array[i - 1] = StackTraits<T>.To(L, arg);
				LuaDLL.lua_pop(L, 1);
			}
			return array;
		}
		case LuaTypes.LUA_TUSERDATA:
			return (T[])ToObject(L, stackPos);
		default:
			return null;
		}
	}

	public static bool[] ToBoolArray(IntPtr L, int stackPos)
	{
		switch (LuaDLL.lua_type(L, stackPos))
		{
		case LuaTypes.LUA_TNIL:
			return null;
		case LuaTypes.LUA_TTABLE:
		{
			int num = LuaDLL.lua_objlen(L, stackPos);
			bool[] array = new bool[num];
			int num2 = LuaDLL.lua_gettop(L) + 1;
			for (int i = 1; i <= num; i++)
			{
				LuaDLL.lua_rawgeti(L, stackPos, i);
				if (LuaDLL.lua_type(L, num2) != LuaTypes.LUA_TBOOLEAN)
				{
					LuaDLL.lua_pop(L, 1);
					LuaDLL.luaL_typerror(L, stackPos, "bool[]");
					return array;
				}
				array[i - 1] = LuaDLL.lua_toboolean(L, num2);
				LuaDLL.lua_pop(L, 1);
			}
			return array;
		}
		case LuaTypes.LUA_TUSERDATA:
			return (bool[])ToObject(L, stackPos);
		default:
			return null;
		}
	}

	public static string[] ToStringArray(IntPtr L, int stackPos)
	{
		switch (LuaDLL.lua_type(L, stackPos))
		{
		case LuaTypes.LUA_TNIL:
			return null;
		case LuaTypes.LUA_TTABLE:
		{
			int num = LuaDLL.lua_objlen(L, stackPos);
			string[] array = new string[num];
			int arg = LuaDLL.lua_gettop(L) + 1;
			for (int i = 1; i <= num; i++)
			{
				LuaDLL.lua_rawgeti(L, stackPos, i);
				if (!TypeTraits<string>.Check(L, arg))
				{
					LuaDLL.lua_pop(L, 1);
					LuaDLL.luaL_typerror(L, stackPos, "string[]");
					return array;
				}
				array[i - 1] = StackTraits<string>.To(L, arg);
				LuaDLL.lua_pop(L, 1);
			}
			return array;
		}
		case LuaTypes.LUA_TUSERDATA:
			return (string[])ToObject(L, stackPos);
		default:
			return null;
		}
	}

	public static object[] ToObjectArray(IntPtr L, int stackPos)
	{
		switch (LuaDLL.lua_type(L, stackPos))
		{
		case LuaTypes.LUA_TNIL:
			return null;
		case LuaTypes.LUA_TTABLE:
		{
			int num = LuaDLL.lua_objlen(L, stackPos);
			object[] array = new object[num];
			int stackPos2 = LuaDLL.lua_gettop(L) + 1;
			for (int i = 1; i <= num; i++)
			{
				LuaDLL.lua_rawgeti(L, stackPos, i);
				array[i - 1] = ToVarObject(L, stackPos2);
				LuaDLL.lua_pop(L, 1);
			}
			return array;
		}
		case LuaTypes.LUA_TUSERDATA:
			return (object[])ToObject(L, stackPos);
		default:
			return null;
		}
	}

	public static T[] ToObjectArray<T>(IntPtr L, int stackPos) where T : class
	{
		switch (LuaDLL.lua_type(L, stackPos))
		{
		case LuaTypes.LUA_TNIL:
			return null;
		case LuaTypes.LUA_TTABLE:
		{
			int num = LuaDLL.lua_objlen(L, stackPos);
			T[] array = new T[num];
			int arg = LuaDLL.lua_gettop(L) + 1;
			for (int i = 1; i <= num; i++)
			{
				LuaDLL.lua_rawgeti(L, stackPos, i);
				if (!TypeTraits<T>.Check(L, arg))
				{
					LuaDLL.lua_pop(L, 1);
					LuaDLL.luaL_typerror(L, stackPos, typeof(T[]).FullName);
					return array;
				}
				array[i - 1] = StackTraits<T>.To(L, arg);
				LuaDLL.lua_pop(L, 1);
			}
			return array;
		}
		case LuaTypes.LUA_TUSERDATA:
			return (T[])ToObject(L, stackPos);
		default:
			return null;
		}
	}

	public static T[] ToStructArray<T>(IntPtr L, int stackPos) where T : struct
	{
		switch (LuaDLL.lua_type(L, stackPos))
		{
		case LuaTypes.LUA_TNIL:
			return null;
		case LuaTypes.LUA_TTABLE:
		{
			int num = LuaDLL.lua_objlen(L, stackPos);
			T[] array = new T[num];
			int arg = LuaDLL.lua_gettop(L) + 1;
			for (int i = 1; i <= num; i++)
			{
				LuaDLL.lua_rawgeti(L, stackPos, i);
				if (!TypeTraits<T>.Check(L, arg))
				{
					LuaDLL.lua_pop(L, 1);
					LuaDLL.luaL_typerror(L, stackPos, typeof(T[]).FullName);
					return array;
				}
				array[i - 1] = StackTraits<T>.To(L, arg);
				LuaDLL.lua_pop(L, 1);
			}
			return array;
		}
		case LuaTypes.LUA_TUSERDATA:
			return (T[])ToObject(L, stackPos);
		default:
			return null;
		}
	}

	public static void Push(IntPtr L, Vector3 v3)
	{
		LuaDLL.tolua_pushvec3(L, v3.x, v3.y, v3.z);
	}

	public static void Push(IntPtr L, Vector2 v2)
	{
		LuaDLL.tolua_pushvec2(L, v2.x, v2.y);
	}

	public static void Push(IntPtr L, Vector4 v4)
	{
		LuaDLL.tolua_pushvec4(L, v4.x, v4.y, v4.z, v4.w);
	}

	public static void Push(IntPtr L, Quaternion q)
	{
		LuaDLL.tolua_pushquat(L, q.x, q.y, q.z, q.w);
	}

	public static void Push(IntPtr L, Color clr)
	{
		LuaDLL.tolua_pushclr(L, clr.r, clr.g, clr.b, clr.a);
	}

	public static void Push(IntPtr L, Ray ray)
	{
		LuaStatic.GetPackRay(L);
		Push(L, ray.direction);
		Push(L, ray.origin);
		if (LuaDLL.lua_pcall(L, 2, 1, 0) != 0)
		{
			throw new LuaException(LuaDLL.lua_tostring(L, -1));
		}
	}

	public static void Push(IntPtr L, Bounds bound)
	{
		LuaStatic.GetPackBounds(L);
		Push(L, bound.center);
		Push(L, bound.size);
		if (LuaDLL.lua_pcall(L, 2, 1, 0) != 0)
		{
			throw new LuaException(LuaDLL.lua_tostring(L, -1));
		}
	}

	public static void Push(IntPtr L, RaycastHit hit)
	{
		LuaStatic.GetPackRaycastHit(L);
		Push(L, hit.collider);
		LuaDLL.lua_pushnumber(L, hit.distance);
		Push(L, hit.normal);
		Push(L, hit.point);
		Push(L, hit.rigidbody);
		Push(L, hit.transform);
		if (LuaDLL.lua_pcall(L, 6, 1, 0) != 0)
		{
			throw new LuaException(LuaDLL.lua_tostring(L, -1));
		}
	}

	public static void Push(IntPtr L, RaycastHit hit, int flag)
	{
		LuaStatic.GetPackRaycastHit(L);
		if ((flag & 1) != 0)
		{
			Push(L, hit.collider);
		}
		else
		{
			LuaDLL.lua_pushnil(L);
		}
		LuaDLL.lua_pushnumber(L, hit.distance);
		if ((flag & 2) != 0)
		{
			Push(L, hit.normal);
		}
		else
		{
			LuaDLL.lua_pushnil(L);
		}
		if ((flag & 4) != 0)
		{
			Push(L, hit.point);
		}
		else
		{
			LuaDLL.lua_pushnil(L);
		}
		if ((flag & 8) != 0)
		{
			Push(L, hit.rigidbody);
		}
		else
		{
			LuaDLL.lua_pushnil(L);
		}
		if ((flag & 0x10) != 0)
		{
			Push(L, hit.transform);
		}
		else
		{
			LuaDLL.lua_pushnil(L);
		}
		if (LuaDLL.lua_pcall(L, 6, 1, 0) != 0)
		{
			throw new LuaException(LuaDLL.lua_tostring(L, -1));
		}
	}

	public static void Push(IntPtr L, Touch t)
	{
		Push(L, t, 7);
	}

	public static void Push(IntPtr L, Touch t, int flag)
	{
		LuaStatic.GetPackTouch(L);
		LuaDLL.lua_pushinteger(L, t.fingerId);
		if ((flag & 2) != 0)
		{
			Push(L, t.position);
		}
		else
		{
			LuaDLL.lua_pushnil(L);
		}
		if ((flag & 4) != 0)
		{
			Push(L, t.rawPosition);
		}
		else
		{
			LuaDLL.lua_pushnil(L);
		}
		if ((flag & 1) != 0)
		{
			Push(L, t.deltaPosition);
		}
		else
		{
			LuaDLL.lua_pushnil(L);
		}
		LuaDLL.lua_pushnumber(L, t.deltaTime);
		LuaDLL.lua_pushinteger(L, t.tapCount);
		LuaDLL.lua_pushinteger(L, (int)t.phase);
		if (LuaDLL.lua_pcall(L, 7, -1, 0) != 0)
		{
			throw new LuaException(LuaDLL.lua_tostring(L, -1));
		}
	}

	public static void PushLayerMask(IntPtr L, LayerMask l)
	{
		LuaDLL.tolua_pushlayermask(L, l.value);
	}

	public static void Push(IntPtr L, LuaByteBuffer bb)
	{
		LuaDLL.lua_pushlstring(L, bb.buffer, bb.Length);
	}

	public static void PushByteBuffer(IntPtr L, byte[] buffer)
	{
		LuaDLL.tolua_pushlstring(L, buffer, buffer.Length);
	}

	public static void Push(IntPtr L, Array array)
	{
		if (array == null)
		{
			LuaDLL.lua_pushnil(L);
			return;
		}
		int arrayMetatable = LuaStatic.GetArrayMetatable(L);
		PushUserData(L, array, arrayMetatable);
	}

	public static void Push(IntPtr L, LuaBaseRef lbr)
	{
		if (lbr == null)
		{
			LuaDLL.lua_pushnil(L);
		}
		else
		{
			LuaDLL.lua_getref(L, lbr.GetReference());
		}
	}

	public static void Push(IntPtr L, Type t)
	{
		if (t == null)
		{
			LuaDLL.lua_pushnil(L);
			return;
		}
		int typeMetatable = LuaStatic.GetTypeMetatable(L);
		PushUserData(L, t, typeMetatable);
	}

	public static void Push(IntPtr L, Delegate ev)
	{
		if ((object)ev == null)
		{
			LuaDLL.lua_pushnil(L);
			return;
		}
		int delegateMetatable = LuaStatic.GetDelegateMetatable(L);
		PushUserData(L, ev, delegateMetatable);
	}

	public static void Push(IntPtr L, EventObject ev)
	{
		if (ev == null)
		{
			LuaDLL.lua_pushnil(L);
			return;
		}
		int eventMetatable = LuaStatic.GetEventMetatable(L);
		PushUserData(L, ev, eventMetatable);
	}

	public static void Push(IntPtr L, IEnumerator iter)
	{
		if (iter == null)
		{
			LuaDLL.lua_pushnil(L);
			return;
		}
		int metaReference = LuaStatic.GetMetaReference(L, iter.GetType());
		if (metaReference > 0)
		{
			PushUserData(L, iter, metaReference);
			return;
		}
		int iterMetatable = LuaStatic.GetIterMetatable(L);
		PushUserData(L, iter, iterMetatable);
	}

	public static void Push(IntPtr L, Enum e)
	{
		object obj = null;
		int enumObject = LuaStatic.GetEnumObject(L, e, out obj);
		PushUserData(L, obj, enumObject);
	}

	public static void PushOut<T>(IntPtr L, LuaOut<T> lo)
	{
		int index = ObjectTranslator.Get(L).AddObject(lo);
		LuaDLL.tolua_pushnewudata(L, LuaIndexes.LUA_REGISTRYINDEX, index);
	}

	public static void PushStruct(IntPtr L, object o)
	{
		if (o == null || o.Equals(null))
		{
			LuaDLL.lua_pushnil(L);
			return;
		}
		if (o is Enum)
		{
			Push(L, (Enum)o);
			return;
		}
		Type type = o.GetType();
		int num = LuaStatic.GetMetaReference(L, type);
		if (num <= 0)
		{
			num = LoadPreType(L, type);
		}
		int index = ObjectTranslator.Get(L).AddObject(o);
		LuaDLL.tolua_pushnewudata(L, num, index);
	}

	public static void PushValue<T>(IntPtr L, T v) where T : struct
	{
		StackTraits<T>.Push(L, v);
	}

	public static void PusNullable<T>(IntPtr L, T? v) where T : struct
	{
		if (!v.HasValue)
		{
			LuaDLL.lua_pushnil(L);
		}
		else
		{
			StackTraits<T>.Push(L, v.Value);
		}
	}

	public static void PushUserData(IntPtr L, object o, int reference)
	{
		ObjectTranslator objectTranslator = ObjectTranslator.Get(L);
		if (objectTranslator.Getudata(o, out var index))
		{
			if (LuaDLL.tolua_pushudata(L, index))
			{
				return;
			}
			objectTranslator.Destroyudata(index);
		}
		index = objectTranslator.AddObject(o);
		LuaDLL.tolua_pushnewudata(L, reference, index);
	}

	private static int LuaPCall(IntPtr L, LuaCSFunction func)
	{
		int top = LuaDLL.lua_gettop(L);
		LuaDLL.tolua_pushcfunction(L, func);
		if (LuaDLL.lua_pcall(L, 0, -1, 0) != 0)
		{
			string msg = LuaDLL.lua_tostring(L, -1);
			LuaDLL.lua_settop(L, top);
			throw new LuaException(msg, LuaException.GetLastError());
		}
		int result = LuaDLL.tolua_getclassref(L, -1);
		LuaDLL.lua_settop(L, top);
		return result;
	}

	public static int LoadPreType(IntPtr L, Type type)
	{
		LuaCSFunction preModule = LuaStatic.GetPreModule(L, type);
		int num = -1;
		if (preModule != null)
		{
			return LuaPCall(L, preModule);
		}
		return LuaStatic.GetMissMetaReference(L, type);
	}

	private static void PushUserObject(IntPtr L, object o)
	{
		Type type = o.GetType();
		int num = LuaStatic.GetMetaReference(L, type);
		if (num <= 0)
		{
			num = LoadPreType(L, type);
		}
		PushUserData(L, o, num);
	}

	public static void Push(IntPtr L, UnityEngine.Object obj)
	{
		if (obj == null)
		{
			LuaDLL.lua_pushnil(L);
		}
		else
		{
			PushUserObject(L, obj);
		}
	}

	public static void Push(IntPtr L, TrackedReference obj)
	{
		if (obj == null)
		{
			LuaDLL.lua_pushnil(L);
		}
		else
		{
			PushUserObject(L, obj);
		}
	}

	public static void PushSealed<T>(IntPtr L, T o)
	{
		if (o == null || o.Equals(null))
		{
			LuaDLL.lua_pushnil(L);
			return;
		}
		int num = TypeTraits<T>.GetLuaReference(L);
		if (num <= 0)
		{
			num = LoadPreType(L, o.GetType());
		}
		PushUserData(L, o, num);
	}

	public static void PushObject(IntPtr L, object o)
	{
		if (o == null || o.Equals(null))
		{
			LuaDLL.lua_pushnil(L);
		}
		else if (o is Enum)
		{
			Push(L, (Enum)o);
		}
		else
		{
			PushUserObject(L, o);
		}
	}

	public static void Push(IntPtr L, nil obj)
	{
		LuaDLL.lua_pushnil(L);
	}

	public static void Push(IntPtr L, object obj)
	{
		if (obj == null || obj.Equals(null))
		{
			LuaDLL.lua_pushnil(L);
			return;
		}
		Type type = obj.GetType();
		if (type.IsValueType)
		{
			if (TypeChecker.IsNullable(type))
			{
				type = type.GetGenericArguments()[0];
			}
			if (type == typeof(bool))
			{
				bool value = (bool)obj;
				LuaDLL.lua_pushboolean(L, value);
				return;
			}
			if (obj is Enum)
			{
				Push(L, (Enum)obj);
				return;
			}
			if (type == typeof(long))
			{
				LuaDLL.tolua_pushint64(L, (long)obj);
				return;
			}
			if (type == typeof(ulong))
			{
				LuaDLL.tolua_pushuint64(L, (ulong)obj);
				return;
			}
			if (type.IsPrimitive)
			{
				double number = LuaMisc.ToDouble(obj);
				LuaDLL.lua_pushnumber(L, number);
				return;
			}
			if (type == typeof(LuaByteBuffer))
			{
				LuaByteBuffer luaByteBuffer = (LuaByteBuffer)obj;
				LuaDLL.lua_pushlstring(L, luaByteBuffer.buffer, luaByteBuffer.buffer.Length);
				return;
			}
			if (type == typeof(Vector3))
			{
				Push(L, (Vector3)obj);
				return;
			}
			if (type == typeof(Quaternion))
			{
				Push(L, (Quaternion)obj);
				return;
			}
			if (type == typeof(Vector2))
			{
				Push(L, (Vector2)obj);
				return;
			}
			if (type == typeof(Vector4))
			{
				Push(L, (Vector4)obj);
				return;
			}
			if (type == typeof(Color))
			{
				Push(L, (Color)obj);
				return;
			}
			if (type == typeof(RaycastHit))
			{
				Push(L, (RaycastHit)obj);
				return;
			}
			if (type == typeof(Touch))
			{
				Push(L, (Touch)obj);
				return;
			}
			if (type == typeof(Ray))
			{
				Push(L, (Ray)obj);
				return;
			}
			if (type == typeof(Bounds))
			{
				Push(L, (Bounds)obj);
				return;
			}
			if (type == typeof(LayerMask))
			{
				PushLayerMask(L, (LayerMask)obj);
				return;
			}
			LuaPushVarObject value2 = null;
			if (VarPushMap.TryGetValue(type, out value2))
			{
				value2(L, obj);
			}
			else
			{
				PushStruct(L, obj);
			}
		}
		else if (type.IsArray)
		{
			Push(L, (Array)obj);
		}
		else if (type == typeof(string))
		{
			LuaDLL.lua_pushstring(L, (string)obj);
		}
		else if (obj is LuaBaseRef)
		{
			Push(L, (LuaBaseRef)obj);
		}
		else if (obj is UnityEngine.Object)
		{
			Push(L, (UnityEngine.Object)obj);
		}
		else if (obj is TrackedReference)
		{
			Push(L, (TrackedReference)obj);
		}
		else if (obj is Delegate)
		{
			Push(L, (Delegate)obj);
		}
		else if (obj is IEnumerator)
		{
			Push(L, (IEnumerator)obj);
		}
		else if (type == typeof(EventObject))
		{
			Push(L, (EventObject)obj);
		}
		else if (type == monoType)
		{
			Push(L, (Type)obj);
		}
		else
		{
			PushObject(L, obj);
		}
	}

	public static void SetBack(IntPtr L, int stackPos, object o)
	{
		int num = LuaDLL.tolua_rawnetobj(L, stackPos);
		ObjectTranslator objectTranslator = ObjectTranslator.Get(L);
		if (num != -1)
		{
			objectTranslator.SetBack(num, o);
		}
	}

	public static int Destroy(IntPtr L)
	{
		int udata = LuaDLL.tolua_rawnetobj(L, 1);
		ObjectTranslator.Get(L).Destroy(udata);
		return 0;
	}

	public static void CheckArgsCount(IntPtr L, string method, int count)
	{
		int num = LuaDLL.lua_gettop(L);
		if (num != count)
		{
			throw new LuaException($"no overload for method '{method}' takes '{num}' arguments");
		}
	}

	public static void CheckArgsCount(IntPtr L, int count)
	{
		int num = LuaDLL.lua_gettop(L);
		if (num != count)
		{
			throw new LuaException($"no overload for method takes '{num}' arguments");
		}
	}

	public static Delegate CheckDelegate(Type t, IntPtr L, int stackPos)
	{
		switch (LuaDLL.lua_type(L, stackPos))
		{
		case LuaTypes.LUA_TNIL:
			return null;
		case LuaTypes.LUA_TFUNCTION:
		{
			LuaFunction func = ToLuaFunction(L, stackPos);
			return DelegateFactory.CreateDelegate(t, func);
		}
		case LuaTypes.LUA_TUSERDATA:
			return (Delegate)CheckObject(L, stackPos, t);
		default:
			LuaDLL.luaL_typerror(L, stackPos, LuaMisc.GetTypeName(t));
			return null;
		}
	}

	public static Delegate CheckDelegate<T>(IntPtr L, int stackPos)
	{
		switch (LuaDLL.lua_type(L, stackPos))
		{
		case LuaTypes.LUA_TNIL:
			return null;
		case LuaTypes.LUA_TFUNCTION:
			return DelegateTraits<T>.Create(ToLuaFunction(L, stackPos));
		case LuaTypes.LUA_TUSERDATA:
			return (Delegate)CheckObject(L, stackPos, typeof(T));
		default:
			LuaDLL.luaL_typerror(L, stackPos, TypeTraits<T>.GetTypeName());
			return null;
		}
	}
}
