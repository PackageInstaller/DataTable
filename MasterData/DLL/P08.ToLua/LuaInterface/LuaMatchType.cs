using System;
using System.Collections;
using UnityEngine;

namespace LuaInterface;

public class LuaMatchType
{
	private static Type monoType = typeof(Type).GetType();

	public bool CheckNumber(IntPtr L, int pos)
	{
		return LuaDLL.lua_type(L, pos) == LuaTypes.LUA_TNUMBER;
	}

	public bool CheckBool(IntPtr L, int pos)
	{
		return LuaDLL.lua_type(L, pos) == LuaTypes.LUA_TBOOLEAN;
	}

	public bool CheckLong(IntPtr L, int pos)
	{
		return LuaDLL.lua_type(L, pos) switch
		{
			LuaTypes.LUA_TNUMBER => true, 
			LuaTypes.LUA_TUSERDATA => LuaDLL.tolua_getvaluetype(L, pos) == 11, 
			_ => false, 
		};
	}

	public bool CheckULong(IntPtr L, int pos)
	{
		return LuaDLL.lua_type(L, pos) switch
		{
			LuaTypes.LUA_TNUMBER => LuaDLL.lua_tonumber(L, pos) >= 0.0, 
			LuaTypes.LUA_TUSERDATA => LuaDLL.tolua_getvaluetype(L, pos) == 12, 
			_ => false, 
		};
	}

	public bool CheckNullNumber(IntPtr L, int pos)
	{
		LuaTypes luaTypes = LuaDLL.lua_type(L, pos);
		if (luaTypes != LuaTypes.LUA_TNUMBER)
		{
			return luaTypes == LuaTypes.LUA_TNIL;
		}
		return true;
	}

	public bool CheckNullBool(IntPtr L, int pos)
	{
		LuaTypes luaTypes = LuaDLL.lua_type(L, pos);
		if (luaTypes != LuaTypes.LUA_TBOOLEAN)
		{
			return luaTypes == LuaTypes.LUA_TNIL;
		}
		return true;
	}

	public bool CheckNullLong(IntPtr L, int pos)
	{
		return LuaDLL.lua_type(L, pos) switch
		{
			LuaTypes.LUA_TNIL => true, 
			LuaTypes.LUA_TNUMBER => true, 
			LuaTypes.LUA_TUSERDATA => LuaDLL.tolua_getvaluetype(L, pos) == 11, 
			_ => false, 
		};
	}

	public bool CheckNullULong(IntPtr L, int pos)
	{
		return LuaDLL.lua_type(L, pos) switch
		{
			LuaTypes.LUA_TNIL => true, 
			LuaTypes.LUA_TNUMBER => true, 
			LuaTypes.LUA_TUSERDATA => LuaDLL.tolua_getvaluetype(L, pos) == 12, 
			_ => false, 
		};
	}

	public bool CheckString(IntPtr L, int pos)
	{
		return LuaDLL.lua_type(L, pos) switch
		{
			LuaTypes.LUA_TNIL => true, 
			LuaTypes.LUA_TSTRING => true, 
			LuaTypes.LUA_TUSERDATA => CheckClassType(typeof(string), L, pos), 
			_ => false, 
		};
	}

	public bool CheckByteArray(IntPtr L, int pos)
	{
		return LuaDLL.lua_type(L, pos) switch
		{
			LuaTypes.LUA_TNIL => true, 
			LuaTypes.LUA_TSTRING => true, 
			LuaTypes.LUA_TUSERDATA => CheckClassType(typeof(byte[]), L, pos), 
			_ => false, 
		};
	}

	public bool CheckCharArray(IntPtr L, int pos)
	{
		return LuaDLL.lua_type(L, pos) switch
		{
			LuaTypes.LUA_TNIL => true, 
			LuaTypes.LUA_TSTRING => true, 
			LuaTypes.LUA_TUSERDATA => CheckClassType(typeof(char[]), L, pos), 
			_ => false, 
		};
	}

	public bool CheckArray(Type t, IntPtr L, int pos)
	{
		return LuaDLL.lua_type(L, pos) switch
		{
			LuaTypes.LUA_TNIL => true, 
			LuaTypes.LUA_TTABLE => true, 
			LuaTypes.LUA_TUSERDATA => CheckClassType(t, L, pos), 
			_ => false, 
		};
	}

	public bool CheckBoolArray(IntPtr L, int pos)
	{
		return CheckArray(typeof(bool[]), L, pos);
	}

	public bool CheckSByteArray(IntPtr L, int pos)
	{
		return CheckArray(typeof(sbyte[]), L, pos);
	}

	public bool CheckInt16Array(IntPtr L, int pos)
	{
		return CheckArray(typeof(short[]), L, pos);
	}

	public bool CheckUInt16Array(IntPtr L, int pos)
	{
		return CheckArray(typeof(ushort[]), L, pos);
	}

	public bool CheckDecimalArray(IntPtr L, int pos)
	{
		return CheckArray(typeof(decimal[]), L, pos);
	}

	public bool CheckSingleArray(IntPtr L, int pos)
	{
		return CheckArray(typeof(float[]), L, pos);
	}

	public bool CheckDoubleArray(IntPtr L, int pos)
	{
		return CheckArray(typeof(double[]), L, pos);
	}

	public bool CheckInt32Array(IntPtr L, int pos)
	{
		return CheckArray(typeof(int[]), L, pos);
	}

	public bool CheckUInt32Array(IntPtr L, int pos)
	{
		return CheckArray(typeof(uint[]), L, pos);
	}

	public bool CheckInt64Array(IntPtr L, int pos)
	{
		return CheckArray(typeof(long[]), L, pos);
	}

	public bool CheckUInt64Array(IntPtr L, int pos)
	{
		return CheckArray(typeof(ulong[]), L, pos);
	}

	public bool CheckStringArray(IntPtr L, int pos)
	{
		return CheckArray(typeof(string[]), L, pos);
	}

	public bool CheckTypeArray(IntPtr L, int pos)
	{
		return CheckArray(typeof(Type[]), L, pos);
	}

	public bool CheckObjectArray(IntPtr L, int pos)
	{
		return CheckArray(typeof(object[]), L, pos);
	}

	private bool CheckValueType(IntPtr L, int pos, int valueType, Type nt)
	{
		if (LuaDLL.lua_type(L, pos) == LuaTypes.LUA_TTABLE)
		{
			return LuaDLL.tolua_getvaluetype(L, pos) == valueType;
		}
		return false;
	}

	public bool CheckVec3(IntPtr L, int pos)
	{
		if (LuaDLL.lua_type(L, pos) == LuaTypes.LUA_TTABLE)
		{
			return LuaDLL.tolua_getvaluetype(L, pos) == 1;
		}
		return false;
	}

	public bool CheckQuat(IntPtr L, int pos)
	{
		if (LuaDLL.lua_type(L, pos) == LuaTypes.LUA_TTABLE)
		{
			return LuaDLL.tolua_getvaluetype(L, pos) == 2;
		}
		return false;
	}

	public bool CheckVec2(IntPtr L, int pos)
	{
		if (LuaDLL.lua_type(L, pos) == LuaTypes.LUA_TTABLE)
		{
			return LuaDLL.tolua_getvaluetype(L, pos) == 3;
		}
		return false;
	}

	public bool CheckColor(IntPtr L, int pos)
	{
		if (LuaDLL.lua_type(L, pos) == LuaTypes.LUA_TTABLE)
		{
			return LuaDLL.tolua_getvaluetype(L, pos) == 4;
		}
		return false;
	}

	public bool CheckVec4(IntPtr L, int pos)
	{
		if (LuaDLL.lua_type(L, pos) == LuaTypes.LUA_TTABLE)
		{
			return LuaDLL.tolua_getvaluetype(L, pos) == 5;
		}
		return false;
	}

	public bool CheckRay(IntPtr L, int pos)
	{
		if (LuaDLL.lua_type(L, pos) == LuaTypes.LUA_TTABLE)
		{
			return LuaDLL.tolua_getvaluetype(L, pos) == 6;
		}
		return false;
	}

	public bool CheckBounds(IntPtr L, int pos)
	{
		if (LuaDLL.lua_type(L, pos) == LuaTypes.LUA_TTABLE)
		{
			return LuaDLL.tolua_getvaluetype(L, pos) == 7;
		}
		return false;
	}

	public bool CheckTouch(IntPtr L, int pos)
	{
		if (LuaDLL.lua_type(L, pos) == LuaTypes.LUA_TTABLE)
		{
			return LuaDLL.tolua_getvaluetype(L, pos) == 8;
		}
		return false;
	}

	public bool CheckLayerMask(IntPtr L, int pos)
	{
		if (LuaDLL.lua_type(L, pos) == LuaTypes.LUA_TTABLE)
		{
			return LuaDLL.tolua_getvaluetype(L, pos) == 9;
		}
		return false;
	}

	public bool CheckRaycastHit(IntPtr L, int pos)
	{
		if (LuaDLL.lua_type(L, pos) == LuaTypes.LUA_TTABLE)
		{
			return LuaDLL.tolua_getvaluetype(L, pos) == 10;
		}
		return false;
	}

	public bool CheckNullVec3(IntPtr L, int pos)
	{
		return LuaDLL.lua_type(L, pos) switch
		{
			LuaTypes.LUA_TNIL => true, 
			LuaTypes.LUA_TTABLE => LuaDLL.tolua_getvaluetype(L, pos) == 1, 
			_ => false, 
		};
	}

	public bool CheckNullQuat(IntPtr L, int pos)
	{
		return LuaDLL.lua_type(L, pos) switch
		{
			LuaTypes.LUA_TNIL => true, 
			LuaTypes.LUA_TTABLE => LuaDLL.tolua_getvaluetype(L, pos) == 2, 
			_ => false, 
		};
	}

	public bool CheckNullVec2(IntPtr L, int pos)
	{
		return LuaDLL.lua_type(L, pos) switch
		{
			LuaTypes.LUA_TNIL => true, 
			LuaTypes.LUA_TTABLE => LuaDLL.tolua_getvaluetype(L, pos) == 3, 
			_ => false, 
		};
	}

	public bool CheckNullColor(IntPtr L, int pos)
	{
		return LuaDLL.lua_type(L, pos) switch
		{
			LuaTypes.LUA_TNIL => true, 
			LuaTypes.LUA_TTABLE => LuaDLL.tolua_getvaluetype(L, pos) == 4, 
			_ => false, 
		};
	}

	public bool CheckNullVec4(IntPtr L, int pos)
	{
		return LuaDLL.lua_type(L, pos) switch
		{
			LuaTypes.LUA_TNIL => true, 
			LuaTypes.LUA_TTABLE => LuaDLL.tolua_getvaluetype(L, pos) == 5, 
			_ => false, 
		};
	}

	public bool CheckNullRay(IntPtr L, int pos)
	{
		return LuaDLL.lua_type(L, pos) switch
		{
			LuaTypes.LUA_TNIL => true, 
			LuaTypes.LUA_TTABLE => LuaDLL.tolua_getvaluetype(L, pos) == 6, 
			_ => false, 
		};
	}

	public bool CheckNullBounds(IntPtr L, int pos)
	{
		return LuaDLL.lua_type(L, pos) switch
		{
			LuaTypes.LUA_TNIL => true, 
			LuaTypes.LUA_TTABLE => LuaDLL.tolua_getvaluetype(L, pos) == 7, 
			_ => false, 
		};
	}

	public bool CheckNullTouch(IntPtr L, int pos)
	{
		return LuaDLL.lua_type(L, pos) switch
		{
			LuaTypes.LUA_TNIL => true, 
			LuaTypes.LUA_TTABLE => LuaDLL.tolua_getvaluetype(L, pos) == 8, 
			_ => false, 
		};
	}

	public bool CheckNullLayerMask(IntPtr L, int pos)
	{
		return LuaDLL.lua_type(L, pos) switch
		{
			LuaTypes.LUA_TNIL => true, 
			LuaTypes.LUA_TTABLE => LuaDLL.tolua_getvaluetype(L, pos) == 9, 
			_ => false, 
		};
	}

	public bool CheckNullRaycastHit(IntPtr L, int pos)
	{
		return LuaDLL.lua_type(L, pos) switch
		{
			LuaTypes.LUA_TNIL => true, 
			LuaTypes.LUA_TTABLE => LuaDLL.tolua_getvaluetype(L, pos) == 10, 
			_ => false, 
		};
	}

	public bool CheckVec3Array(IntPtr L, int pos)
	{
		return CheckArray(typeof(Vector3[]), L, pos);
	}

	public bool CheckQuatArray(IntPtr L, int pos)
	{
		return CheckArray(typeof(Quaternion[]), L, pos);
	}

	public bool CheckVec2Array(IntPtr L, int pos)
	{
		return CheckArray(typeof(Vector2[]), L, pos);
	}

	public bool CheckVec4Array(IntPtr L, int pos)
	{
		return CheckArray(typeof(Vector4[]), L, pos);
	}

	public bool CheckColorArray(IntPtr L, int pos)
	{
		return CheckArray(typeof(Color[]), L, pos);
	}

	public bool CheckPtr(IntPtr L, int pos)
	{
		LuaTypes luaTypes = LuaDLL.lua_type(L, pos);
		if (luaTypes != LuaTypes.LUA_TLIGHTUSERDATA)
		{
			return luaTypes == LuaTypes.LUA_TNIL;
		}
		return true;
	}

	public bool CheckLuaFunc(IntPtr L, int pos)
	{
		LuaTypes luaTypes = LuaDLL.lua_type(L, pos);
		if (luaTypes != LuaTypes.LUA_TFUNCTION)
		{
			return luaTypes == LuaTypes.LUA_TNIL;
		}
		return true;
	}

	public bool CheckLuaTable(IntPtr L, int pos)
	{
		LuaTypes luaTypes = LuaDLL.lua_type(L, pos);
		if (luaTypes != LuaTypes.LUA_TTABLE)
		{
			return luaTypes == LuaTypes.LUA_TNIL;
		}
		return true;
	}

	public bool CheckLuaThread(IntPtr L, int pos)
	{
		LuaTypes luaTypes = LuaDLL.lua_type(L, pos);
		if (luaTypes != LuaTypes.LUA_TTHREAD)
		{
			return luaTypes == LuaTypes.LUA_TNIL;
		}
		return true;
	}

	public bool CheckLuaBaseRef(IntPtr L, int pos)
	{
		return LuaDLL.lua_type(L, pos) switch
		{
			LuaTypes.LUA_TNIL => true, 
			LuaTypes.LUA_TFUNCTION => true, 
			LuaTypes.LUA_TTABLE => true, 
			LuaTypes.LUA_TTHREAD => true, 
			_ => false, 
		};
	}

	public bool CheckByteBuffer(IntPtr L, int pos)
	{
		LuaTypes luaTypes = LuaDLL.lua_type(L, pos);
		if (luaTypes != LuaTypes.LUA_TSTRING)
		{
			return luaTypes == LuaTypes.LUA_TNIL;
		}
		return true;
	}

	public bool CheckEventObject(IntPtr L, int pos)
	{
		return LuaDLL.lua_type(L, pos) switch
		{
			LuaTypes.LUA_TNIL => true, 
			LuaTypes.LUA_TUSERDATA => CheckClassType(typeof(EventObject), L, pos), 
			_ => false, 
		};
	}

	public bool CheckEnumerator(IntPtr L, int pos)
	{
		switch (LuaDLL.lua_type(L, pos))
		{
		case LuaTypes.LUA_TNIL:
			return true;
		case LuaTypes.LUA_TUSERDATA:
		{
			int num = LuaDLL.tolua_rawnetobj(L, pos);
			if (num != -1)
			{
				object obj = ObjectTranslator.Get(L).GetObject(num);
				if (obj != null)
				{
					return obj is IEnumerator;
				}
				return true;
			}
			return false;
		}
		default:
			return false;
		}
	}

	private bool CheckFinalType(Type type, IntPtr L, int pos)
	{
		return LuaDLL.lua_type(L, pos) switch
		{
			LuaTypes.LUA_TNIL => true, 
			LuaTypes.LUA_TUSERDATA => CheckClassType(type, L, pos), 
			_ => false, 
		};
	}

	public bool CheckGameObject(IntPtr L, int pos)
	{
		return CheckFinalType(typeof(GameObject), L, pos);
	}

	public bool CheckTransform(IntPtr L, int pos)
	{
		switch (LuaDLL.lua_type(L, pos))
		{
		case LuaTypes.LUA_TNIL:
			return true;
		case LuaTypes.LUA_TUSERDATA:
		{
			int num = LuaDLL.tolua_rawnetobj(L, pos);
			if (num != -1)
			{
				object obj = ObjectTranslator.Get(L).GetObject(num);
				if (obj != null)
				{
					return obj is Transform;
				}
				return true;
			}
			return false;
		}
		default:
			return false;
		}
	}

	public bool CheckMonoType(IntPtr L, int pos)
	{
		return LuaDLL.lua_type(L, pos) switch
		{
			LuaTypes.LUA_TNIL => true, 
			LuaTypes.LUA_TUSERDATA => CheckClassType(monoType, L, pos), 
			_ => false, 
		};
	}

	public bool CheckVariant(IntPtr L, int pos)
	{
		return true;
	}

	private bool CheckClassType(Type t, IntPtr L, int pos)
	{
		int num = LuaDLL.tolua_rawnetobj(L, pos);
		if (num != -1)
		{
			object obj = ObjectTranslator.Get(L).GetObject(num);
			if (obj != null)
			{
				return obj.GetType() == t;
			}
			return true;
		}
		return false;
	}
}
