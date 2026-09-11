using System;
using System.Collections;
using UnityEngine;

namespace LuaInterface;

public class LuaStackOp
{
	public sbyte ToSByte(IntPtr L, int stackPos)
	{
		return Convert.ToSByte(LuaDLL.lua_tonumber(L, stackPos));
	}

	public byte ToByte(IntPtr L, int stackPos)
	{
		return Convert.ToByte(LuaDLL.lua_tonumber(L, stackPos));
	}

	public short ToInt16(IntPtr L, int stackPos)
	{
		return Convert.ToInt16(LuaDLL.lua_tonumber(L, stackPos));
	}

	public ushort ToUInt16(IntPtr L, int stackPos)
	{
		return Convert.ToUInt16(LuaDLL.lua_tonumber(L, stackPos));
	}

	public char ToChar(IntPtr L, int stackPos)
	{
		return Convert.ToChar(LuaDLL.lua_tonumber(L, stackPos));
	}

	public int ToInt32(IntPtr L, int stackPos)
	{
		return Convert.ToInt32(LuaDLL.lua_tonumber(L, stackPos));
	}

	public uint ToUInt32(IntPtr L, int stackPos)
	{
		return Convert.ToUInt32(LuaDLL.lua_tonumber(L, stackPos));
	}

	public decimal ToDecimal(IntPtr L, int stackPos)
	{
		return Convert.ToDecimal(LuaDLL.lua_tonumber(L, stackPos));
	}

	public float ToFloat(IntPtr L, int stackPos)
	{
		return Convert.ToSingle(LuaDLL.lua_tonumber(L, stackPos));
	}

	public LuaByteBuffer ToLuaByteBuffer(IntPtr L, int stackPos)
	{
		return new LuaByteBuffer(ToLua.ToByteBuffer(L, stackPos));
	}

	public IEnumerator ToIter(IntPtr L, int stackPos)
	{
		return (IEnumerator)ToLua.ToObject(L, stackPos);
	}

	public Type ToType(IntPtr L, int stackPos)
	{
		return (Type)ToLua.ToObject(L, stackPos);
	}

	public EventObject ToEventObject(IntPtr L, int stackPos)
	{
		return (EventObject)ToLua.ToObject(L, stackPos);
	}

	public Transform ToTransform(IntPtr L, int stackPos)
	{
		return (Transform)ToLua.ToObject(L, stackPos);
	}

	public GameObject ToGameObject(IntPtr L, int stackPos)
	{
		return (GameObject)ToLua.ToObject(L, stackPos);
	}

	public object ToObject(IntPtr L, int stackPos)
	{
		return ToLua.ToObject(L, stackPos);
	}

	public sbyte CheckSByte(IntPtr L, int stackPos)
	{
		return Convert.ToSByte(LuaDLL.luaL_checknumber(L, stackPos));
	}

	public byte CheckByte(IntPtr L, int stackPos)
	{
		return Convert.ToByte(LuaDLL.luaL_checknumber(L, stackPos));
	}

	public short CheckInt16(IntPtr L, int stackPos)
	{
		return Convert.ToInt16(LuaDLL.luaL_checknumber(L, stackPos));
	}

	public ushort CheckUInt16(IntPtr L, int stackPos)
	{
		return Convert.ToUInt16(LuaDLL.luaL_checknumber(L, stackPos));
	}

	public char CheckChar(IntPtr L, int stackPos)
	{
		return Convert.ToChar(LuaDLL.luaL_checknumber(L, stackPos));
	}

	public int CheckInt32(IntPtr L, int stackPos)
	{
		return Convert.ToInt32(LuaDLL.luaL_checknumber(L, stackPos));
	}

	public uint CheckUInt32(IntPtr L, int stackPos)
	{
		return Convert.ToUInt32(LuaDLL.luaL_checknumber(L, stackPos));
	}

	public decimal CheckDecimal(IntPtr L, int stackPos)
	{
		return Convert.ToDecimal(LuaDLL.luaL_checknumber(L, stackPos));
	}

	public float CheckFloat(IntPtr L, int stackPos)
	{
		return Convert.ToSingle(LuaDLL.luaL_checknumber(L, stackPos));
	}

	public IntPtr CheckIntPtr(IntPtr L, int stackPos)
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

	public UIntPtr CheckUIntPtr(IntPtr L, int stackPos)
	{
		throw new LuaException("NYI");
	}

	public LuaByteBuffer CheckLuaByteBuffer(IntPtr L, int stackPos)
	{
		return new LuaByteBuffer(ToLua.CheckByteBuffer(L, stackPos));
	}

	public EventObject CheckEventObject(IntPtr L, int stackPos)
	{
		return (EventObject)ToLua.CheckObject(L, stackPos, typeof(EventObject));
	}

	public Transform CheckTransform(IntPtr L, int stackPos)
	{
		return (Transform)ToLua.CheckObject(L, stackPos, typeof(Transform));
	}

	public GameObject CheckGameObject(IntPtr L, int stackPos)
	{
		return (GameObject)ToLua.CheckObject(L, stackPos, typeof(GameObject));
	}

	public void Push(IntPtr L, sbyte n)
	{
		LuaDLL.lua_pushnumber(L, n);
	}

	public void Push(IntPtr L, byte n)
	{
		LuaDLL.lua_pushnumber(L, (int)n);
	}

	public void Push(IntPtr L, short n)
	{
		LuaDLL.lua_pushnumber(L, n);
	}

	public void Push(IntPtr L, ushort n)
	{
		LuaDLL.lua_pushnumber(L, (int)n);
	}

	public void Push(IntPtr L, char n)
	{
		LuaDLL.lua_pushnumber(L, (int)n);
	}

	public void Push(IntPtr L, int n)
	{
		LuaDLL.lua_pushnumber(L, n);
	}

	public void Push(IntPtr L, uint n)
	{
		LuaDLL.lua_pushnumber(L, n);
	}

	public void Push(IntPtr L, decimal n)
	{
		LuaDLL.lua_pushnumber(L, (double)n);
	}

	public void Push(IntPtr L, float n)
	{
		LuaDLL.lua_pushnumber(L, n);
	}

	public void Push(IntPtr L, UIntPtr p)
	{
		throw new LuaException("NYI");
	}

	public void Push(IntPtr L, Delegate ev)
	{
		ToLua.Push(L, ev);
	}

	public void Push(IntPtr L, object obj)
	{
		ToLua.Push(L, obj);
	}

	public void Push(IntPtr L, GameObject o)
	{
		if (o == null)
		{
			LuaDLL.lua_pushnil(L);
			return;
		}
		int num = TypeTraits<GameObject>.GetLuaReference(L);
		if (num <= 0)
		{
			num = ToLua.LoadPreType(L, typeof(GameObject));
		}
		ToLua.PushUserData(L, o, num);
	}

	public void Push(IntPtr L, Transform o)
	{
		if (o == null)
		{
			LuaDLL.lua_pushnil(L);
			return;
		}
		Type type = o.GetType();
		int num = -1;
		num = ((!(type == typeof(Transform))) ? LuaStatic.GetMetaReference(L, type) : TypeTraits<Transform>.GetLuaReference(L));
		if (num <= 0)
		{
			num = ToLua.LoadPreType(L, type);
		}
		ToLua.PushUserData(L, o, num);
	}

	public sbyte? ToNullSByte(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return Convert.ToSByte(LuaDLL.lua_tonumber(L, stackPos));
	}

	public byte? ToNullByte(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return Convert.ToByte(LuaDLL.lua_tonumber(L, stackPos));
	}

	public short? ToNullInt16(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return Convert.ToInt16(LuaDLL.lua_tonumber(L, stackPos));
	}

	public ushort? ToNullUInt16(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return Convert.ToUInt16(LuaDLL.lua_tonumber(L, stackPos));
	}

	public char? ToNullChar(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return Convert.ToChar(LuaDLL.lua_tonumber(L, stackPos));
	}

	public int? ToNullInt32(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return Convert.ToInt32(LuaDLL.lua_tonumber(L, stackPos));
	}

	public uint? ToNullUInt32(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return Convert.ToUInt32(LuaDLL.lua_tonumber(L, stackPos));
	}

	public decimal? ToNullDecimal(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return Convert.ToDecimal(LuaDLL.lua_tonumber(L, stackPos));
	}

	public float? ToNullFloat(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return Convert.ToSingle(LuaDLL.lua_tonumber(L, stackPos));
	}

	public double? ToNullNumber(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return LuaDLL.lua_tonumber(L, stackPos);
	}

	public bool? ToNullBool(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return LuaDLL.lua_toboolean(L, stackPos);
	}

	public long? ToNullInt64(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return LuaDLL.tolua_toint64(L, stackPos);
	}

	public ulong? ToNullUInt64(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return LuaDLL.tolua_touint64(L, stackPos);
	}

	public sbyte[] ToSByteArray(IntPtr L, int stackPos)
	{
		return ToLua.ToNumberArray<sbyte>(L, stackPos);
	}

	public short[] ToInt16Array(IntPtr L, int stackPos)
	{
		return ToLua.ToNumberArray<short>(L, stackPos);
	}

	public ushort[] ToUInt16Array(IntPtr L, int stackPos)
	{
		return ToLua.ToNumberArray<ushort>(L, stackPos);
	}

	public decimal[] ToDecimalArray(IntPtr L, int stackPos)
	{
		return ToLua.ToNumberArray<decimal>(L, stackPos);
	}

	public float[] ToFloatArray(IntPtr L, int stackPos)
	{
		return ToLua.ToNumberArray<float>(L, stackPos);
	}

	public double[] ToDoubleArray(IntPtr L, int stackPos)
	{
		return ToLua.ToNumberArray<double>(L, stackPos);
	}

	public int[] ToInt32Array(IntPtr L, int stackPos)
	{
		return ToLua.ToNumberArray<int>(L, stackPos);
	}

	public uint[] ToUInt32Array(IntPtr L, int stackPos)
	{
		return ToLua.ToNumberArray<uint>(L, stackPos);
	}

	public long[] ToInt64Array(IntPtr L, int stackPos)
	{
		return ToLua.ToStructArray<long>(L, stackPos);
	}

	public ulong[] ToUInt64Array(IntPtr L, int stackPos)
	{
		return ToLua.ToStructArray<ulong>(L, stackPos);
	}

	public Vector3? ToNullVec3(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		float x = 0f;
		float y = 0f;
		float z = 0f;
		LuaDLL.tolua_getvec3(L, stackPos, out x, out y, out z);
		return new Vector3(x, y, z);
	}

	public Quaternion? ToNullQuat(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		LuaDLL.tolua_getquat(L, stackPos, out var x, out var y, out var z, out var w);
		return new Quaternion(x, y, z, w);
	}

	public Vector2? ToNullVec2(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		LuaDLL.tolua_getvec2(L, stackPos, out var x, out var y);
		return new Vector2(x, y);
	}

	public Color? ToNullColor(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		LuaDLL.tolua_getclr(L, stackPos, out var r, out var g, out var b, out var a);
		return new Color(r, g, b, a);
	}

	public Vector4? ToNullVec4(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		LuaDLL.tolua_getvec4(L, stackPos, out var x, out var y, out var z, out var w);
		return new Vector4(x, y, z, w);
	}

	public Ray? ToNullRay(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return ToLua.ToRay(L, stackPos);
	}

	public Bounds? ToNullBounds(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return ToLua.ToBounds(L, stackPos);
	}

	public LayerMask? ToNullLayerMask(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return LuaDLL.tolua_getlayermask(L, stackPos);
	}

	public Vector3[] ToVec3Array(IntPtr L, int stackPos)
	{
		return ToLua.ToStructArray<Vector3>(L, stackPos);
	}

	public Quaternion[] ToQuatArray(IntPtr L, int stackPos)
	{
		return ToLua.ToStructArray<Quaternion>(L, stackPos);
	}

	public Vector2[] ToVec2Array(IntPtr L, int stackPos)
	{
		return ToLua.ToStructArray<Vector2>(L, stackPos);
	}

	public Color[] ToColorArray(IntPtr L, int stackPos)
	{
		return ToLua.ToStructArray<Color>(L, stackPos);
	}

	public Vector4[] ToVec4Array(IntPtr L, int stackPos)
	{
		return ToLua.ToStructArray<Vector4>(L, stackPos);
	}

	public Type[] ToTypeArray(IntPtr L, int stackPos)
	{
		return ToLua.ToObjectArray<Type>(L, stackPos);
	}

	public sbyte? CheckNullSByte(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return Convert.ToSByte(LuaDLL.luaL_checknumber(L, stackPos));
	}

	public byte? CheckNullByte(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return Convert.ToByte(LuaDLL.luaL_checknumber(L, stackPos));
	}

	public short? CheckNullInt16(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return Convert.ToInt16(LuaDLL.luaL_checknumber(L, stackPos));
	}

	public ushort? CheckNullUInt16(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return Convert.ToUInt16(LuaDLL.luaL_checknumber(L, stackPos));
	}

	public char? CheckNullChar(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return Convert.ToChar(LuaDLL.luaL_checknumber(L, stackPos));
	}

	public int? CheckNullInt32(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return Convert.ToInt32(LuaDLL.luaL_checknumber(L, stackPos));
	}

	public uint? CheckNullUInt32(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return Convert.ToUInt32(LuaDLL.luaL_checknumber(L, stackPos));
	}

	public decimal? CheckNullDecimal(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return Convert.ToDecimal(LuaDLL.luaL_checknumber(L, stackPos));
	}

	public float? CheckNullFloat(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return Convert.ToSingle(LuaDLL.luaL_checknumber(L, stackPos));
	}

	public double? CheckNullNumber(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return LuaDLL.luaL_checknumber(L, stackPos);
	}

	public bool? CheckNullBool(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return LuaDLL.luaL_checkboolean(L, stackPos);
	}

	public long? CheckNullInt64(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return LuaDLL.tolua_checkint64(L, stackPos);
	}

	public ulong? CheckNullUInt64(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return LuaDLL.tolua_checkuint64(L, stackPos);
	}

	public sbyte[] CheckSByteArray(IntPtr L, int stackPos)
	{
		return ToLua.CheckNumberArray<sbyte>(L, stackPos);
	}

	public short[] CheckInt16Array(IntPtr L, int stackPos)
	{
		return ToLua.CheckNumberArray<short>(L, stackPos);
	}

	public ushort[] CheckUInt16Array(IntPtr L, int stackPos)
	{
		return ToLua.CheckNumberArray<ushort>(L, stackPos);
	}

	public decimal[] CheckDecimalArray(IntPtr L, int stackPos)
	{
		return ToLua.CheckNumberArray<decimal>(L, stackPos);
	}

	public float[] CheckFloatArray(IntPtr L, int stackPos)
	{
		return ToLua.CheckNumberArray<float>(L, stackPos);
	}

	public double[] CheckDoubleArray(IntPtr L, int stackPos)
	{
		return ToLua.CheckNumberArray<double>(L, stackPos);
	}

	public int[] CheckInt32Array(IntPtr L, int stackPos)
	{
		return ToLua.CheckNumberArray<int>(L, stackPos);
	}

	public uint[] CheckUInt32Array(IntPtr L, int stackPos)
	{
		return ToLua.CheckNumberArray<uint>(L, stackPos);
	}

	public long[] CheckInt64Array(IntPtr L, int stackPos)
	{
		return ToLua.CheckStructArray<long>(L, stackPos);
	}

	public ulong[] CheckUInt64Array(IntPtr L, int stackPos)
	{
		return ToLua.CheckStructArray<ulong>(L, stackPos);
	}

	public Vector3? CheckNullVec3(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return ToLua.CheckVector3(L, stackPos);
	}

	public Quaternion? CheckNullQuat(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return ToLua.CheckQuaternion(L, stackPos);
	}

	public Vector2? CheckNullVec2(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return ToLua.CheckVector2(L, stackPos);
	}

	public Color? CheckNullColor(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return ToLua.CheckColor(L, stackPos);
	}

	public Vector4? CheckNullVec4(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return ToLua.CheckVector4(L, stackPos);
	}

	public Ray? CheckNullRay(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return ToLua.CheckRay(L, stackPos);
	}

	public Bounds? CheckNullBounds(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return ToLua.CheckBounds(L, stackPos);
	}

	public LayerMask? CheckNullLayerMask(IntPtr L, int stackPos)
	{
		if (LuaDLL.lua_type(L, stackPos) == LuaTypes.LUA_TNIL)
		{
			return null;
		}
		return ToLua.CheckLayerMask(L, stackPos);
	}

	public Vector3[] CheckVec3Array(IntPtr L, int stackPos)
	{
		return ToLua.CheckStructArray<Vector3>(L, stackPos);
	}

	public Quaternion[] CheckQuatArray(IntPtr L, int stackPos)
	{
		return ToLua.CheckStructArray<Quaternion>(L, stackPos);
	}

	public Vector2[] CheckVec2Array(IntPtr L, int stackPos)
	{
		return ToLua.CheckStructArray<Vector2>(L, stackPos);
	}

	public Color[] CheckColorArray(IntPtr L, int stackPos)
	{
		return ToLua.CheckStructArray<Color>(L, stackPos);
	}

	public Vector4[] CheckVec4Array(IntPtr L, int stackPos)
	{
		return ToLua.CheckStructArray<Vector4>(L, stackPos);
	}

	public Type[] CheckTypeArray(IntPtr L, int stackPos)
	{
		return ToLua.CheckObjectArray<Type>(L, stackPos);
	}

	public void Push(IntPtr L, sbyte? n)
	{
		if (!n.HasValue)
		{
			LuaDLL.lua_pushnil(L);
		}
		else
		{
			LuaDLL.lua_pushnumber(L, n.Value);
		}
	}

	public void Push(IntPtr L, byte? n)
	{
		if (!n.HasValue)
		{
			LuaDLL.lua_pushnil(L);
		}
		else
		{
			LuaDLL.lua_pushnumber(L, (int)n.Value);
		}
	}

	public void Push(IntPtr L, short? n)
	{
		if (!n.HasValue)
		{
			LuaDLL.lua_pushnil(L);
		}
		else
		{
			LuaDLL.lua_pushnumber(L, n.Value);
		}
	}

	public void Push(IntPtr L, ushort? n)
	{
		if (!n.HasValue)
		{
			LuaDLL.lua_pushnil(L);
		}
		else
		{
			LuaDLL.lua_pushnumber(L, (int)n.Value);
		}
	}

	public void Push(IntPtr L, char? n)
	{
		if (!n.HasValue)
		{
			LuaDLL.lua_pushnil(L);
		}
		else
		{
			LuaDLL.lua_pushnumber(L, (int)n.Value);
		}
	}

	public void Push(IntPtr L, int? n)
	{
		if (!n.HasValue)
		{
			LuaDLL.lua_pushnil(L);
		}
		else
		{
			LuaDLL.lua_pushnumber(L, n.Value);
		}
	}

	public void Push(IntPtr L, uint? n)
	{
		if (!n.HasValue)
		{
			LuaDLL.lua_pushnil(L);
		}
		else
		{
			LuaDLL.lua_pushnumber(L, n.Value);
		}
	}

	public void Push(IntPtr L, decimal? n)
	{
		if (!n.HasValue)
		{
			LuaDLL.lua_pushnil(L);
		}
		else
		{
			LuaDLL.lua_pushnumber(L, Convert.ToDouble(n.Value));
		}
	}

	public void Push(IntPtr L, float? n)
	{
		if (!n.HasValue)
		{
			LuaDLL.lua_pushnil(L);
		}
		else
		{
			LuaDLL.lua_pushnumber(L, n.Value);
		}
	}

	public void Push(IntPtr L, double? n)
	{
		if (!n.HasValue)
		{
			LuaDLL.lua_pushnil(L);
		}
		else
		{
			LuaDLL.lua_pushnumber(L, n.Value);
		}
	}

	public void Push(IntPtr L, bool? n)
	{
		if (!n.HasValue)
		{
			LuaDLL.lua_pushnil(L);
		}
		else
		{
			LuaDLL.lua_pushboolean(L, n.Value);
		}
	}

	public void Push(IntPtr L, long? n)
	{
		if (!n.HasValue)
		{
			LuaDLL.lua_pushnil(L);
		}
		else
		{
			LuaDLL.tolua_pushint64(L, n.Value);
		}
	}

	public void Push(IntPtr L, ulong? n)
	{
		if (!n.HasValue)
		{
			LuaDLL.lua_pushnil(L);
		}
		else
		{
			LuaDLL.tolua_pushuint64(L, n.Value);
		}
	}

	public void Push(IntPtr L, Vector3? v3)
	{
		if (!v3.HasValue)
		{
			LuaDLL.lua_pushnil(L);
			return;
		}
		Vector3 value = v3.Value;
		LuaDLL.tolua_pushvec3(L, value.x, value.y, value.z);
	}

	public void Push(IntPtr L, Quaternion? n)
	{
		if (!n.HasValue)
		{
			LuaDLL.lua_pushnil(L);
			return;
		}
		Quaternion value = n.Value;
		LuaDLL.tolua_pushquat(L, value.x, value.y, value.z, value.w);
	}

	public void Push(IntPtr L, Vector2? n)
	{
		if (!n.HasValue)
		{
			LuaDLL.lua_pushnil(L);
			return;
		}
		Vector2 value = n.Value;
		LuaDLL.tolua_pushvec2(L, value.x, value.y);
	}

	public void Push(IntPtr L, Color? n)
	{
		if (!n.HasValue)
		{
			LuaDLL.lua_pushnil(L);
			return;
		}
		Color value = n.Value;
		LuaDLL.tolua_pushclr(L, value.r, value.g, value.b, value.a);
	}

	public void Push(IntPtr L, Vector4? n)
	{
		if (!n.HasValue)
		{
			LuaDLL.lua_pushnil(L);
			return;
		}
		Vector4 value = n.Value;
		LuaDLL.tolua_pushvec4(L, value.x, value.y, value.z, value.w);
	}

	public void Push(IntPtr L, Ray? n)
	{
		if (!n.HasValue)
		{
			LuaDLL.lua_pushnil(L);
		}
		else
		{
			ToLua.Push(L, n.Value);
		}
	}

	public void Push(IntPtr L, Bounds? n)
	{
		if (!n.HasValue)
		{
			LuaDLL.lua_pushnil(L);
		}
		else
		{
			ToLua.Push(L, n.Value);
		}
	}

	public void Push(IntPtr L, LayerMask? n)
	{
		if (!n.HasValue)
		{
			LuaDLL.lua_pushnil(L);
		}
		else
		{
			LuaDLL.tolua_pushlayermask(L, n.Value);
		}
	}

	public void Push(IntPtr L, Touch? n)
	{
		if (!n.HasValue)
		{
			LuaDLL.lua_pushnil(L);
		}
		else
		{
			ToLua.Push(L, n.Value);
		}
	}

	public void Push(IntPtr L, RaycastHit? n)
	{
		if (!n.HasValue)
		{
			LuaDLL.lua_pushnil(L);
		}
		else
		{
			ToLua.Push(L, n.Value);
		}
	}
}
