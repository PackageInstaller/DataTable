using System;
using System.Collections;
using LuaInterface;
using UnityEngine;

public class System_ArrayWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Array), typeof(object));
		L.RegFunction(".geti", get_Item);
		L.RegFunction(".seti", set_Item);
		L.RegFunction("ToTable", ToTable);
		L.RegFunction("GetLength", GetLength);
		L.RegFunction("GetLongLength", GetLongLength);
		L.RegFunction("GetLowerBound", GetLowerBound);
		L.RegFunction("GetValue", GetValue);
		L.RegFunction("SetValue", SetValue);
		L.RegFunction("GetEnumerator", GetEnumerator);
		L.RegFunction("GetUpperBound", GetUpperBound);
		L.RegFunction("CreateInstance", CreateInstance);
		L.RegFunction("BinarySearch", BinarySearch);
		L.RegFunction("Clear", Clear);
		L.RegFunction("Clone", Clone);
		L.RegFunction("Copy", Copy);
		L.RegFunction("IndexOf", IndexOf);
		L.RegFunction("Initialize", Initialize);
		L.RegFunction("LastIndexOf", LastIndexOf);
		L.RegFunction("Reverse", Reverse);
		L.RegFunction("Sort", Sort);
		L.RegFunction("CopyTo", CopyTo);
		L.RegFunction("ConstrainedCopy", ConstrainedCopy);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("Length", get_Length, null);
		L.RegVar("LongLength", get_LongLength, null);
		L.RegVar("Rank", get_Rank, null);
		L.RegVar("IsSynchronized", get_IsSynchronized, null);
		L.RegVar("SyncRoot", get_SyncRoot, null);
		L.RegVar("IsFixedSize", get_IsFixedSize, null);
		L.RegVar("IsReadOnly", get_IsReadOnly, null);
		L.EndClass();
	}

	private static bool GetPrimitiveValue(IntPtr L, object obj, Type t, int index)
	{
		bool result = true;
		if (t == typeof(float))
		{
			float num = (obj as float[])[index];
			LuaDLL.lua_pushnumber(L, num);
		}
		else if (t == typeof(int))
		{
			int n = (obj as int[])[index];
			LuaDLL.lua_pushinteger(L, n);
		}
		else if (t == typeof(double))
		{
			double number = (obj as double[])[index];
			LuaDLL.lua_pushnumber(L, number);
		}
		else if (t == typeof(bool))
		{
			bool value = (obj as bool[])[index];
			LuaDLL.lua_pushboolean(L, value);
		}
		else if (t == typeof(long))
		{
			long n2 = (obj as long[])[index];
			LuaDLL.tolua_pushint64(L, n2);
		}
		else if (t == typeof(ulong))
		{
			ulong n3 = (obj as ulong[])[index];
			LuaDLL.tolua_pushuint64(L, n3);
		}
		else if (t == typeof(sbyte))
		{
			sbyte b = (obj as sbyte[])[index];
			LuaDLL.lua_pushnumber(L, b);
		}
		else if (t == typeof(byte))
		{
			byte b2 = (obj as byte[])[index];
			LuaDLL.lua_pushnumber(L, (int)b2);
		}
		else if (t == typeof(short))
		{
			short num2 = (obj as short[])[index];
			LuaDLL.lua_pushnumber(L, num2);
		}
		else if (t == typeof(ushort))
		{
			ushort num3 = (obj as ushort[])[index];
			LuaDLL.lua_pushnumber(L, (int)num3);
		}
		else if (t == typeof(char))
		{
			char c = (obj as char[])[index];
			LuaDLL.lua_pushnumber(L, (int)c);
		}
		else if (t == typeof(uint))
		{
			uint num4 = (obj as uint[])[index];
			LuaDLL.lua_pushnumber(L, num4);
		}
		else
		{
			result = false;
		}
		return result;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Item(IntPtr L)
	{
		try
		{
			if (!(ToLua.ToObject(L, 1) is Array array))
			{
				throw new LuaException("trying to index an invalid object reference");
			}
			int num = LuaDLL.lua_tointeger(L, 2);
			if (num >= array.Length)
			{
				throw new LuaException("array index out of bounds: " + num + " " + array.Length);
			}
			Type elementType = array.GetType().GetElementType();
			if (elementType.IsValueType)
			{
				if (elementType.IsPrimitive)
				{
					if (GetPrimitiveValue(L, array, elementType, num))
					{
						return 1;
					}
				}
				else
				{
					if (elementType == typeof(Vector3))
					{
						Vector3 v = (array as Vector3[])[num];
						ToLua.Push(L, v);
						return 1;
					}
					if (elementType == typeof(Quaternion))
					{
						Quaternion q = (array as Quaternion[])[num];
						ToLua.Push(L, q);
						return 1;
					}
					if (elementType == typeof(Vector2))
					{
						Vector2 v2 = (array as Vector2[])[num];
						ToLua.Push(L, v2);
						return 1;
					}
					if (elementType == typeof(Vector4))
					{
						Vector4 v3 = (array as Vector4[])[num];
						ToLua.Push(L, v3);
						return 1;
					}
					if (elementType == typeof(Color))
					{
						Color clr = (array as Color[])[num];
						ToLua.Push(L, clr);
						return 1;
					}
				}
			}
			object value = array.GetValue(num);
			ToLua.Push(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	private static bool SetPrimitiveValue(IntPtr L, object obj, Type t, int index)
	{
		bool result = true;
		if (t == typeof(float))
		{
			float[] obj2 = obj as float[];
			float num = (float)LuaDLL.luaL_checknumber(L, 3);
			obj2[index] = num;
		}
		else if (t == typeof(int))
		{
			int[] obj3 = obj as int[];
			int num2 = LuaDLL.luaL_checkinteger(L, 3);
			obj3[index] = num2;
		}
		else if (t == typeof(double))
		{
			double[] obj4 = obj as double[];
			double num3 = LuaDLL.luaL_checknumber(L, 3);
			obj4[index] = num3;
		}
		else if (t == typeof(bool))
		{
			bool[] obj5 = obj as bool[];
			bool flag = LuaDLL.luaL_checkboolean(L, 3);
			obj5[index] = flag;
		}
		else if (t == typeof(long))
		{
			long[] obj6 = obj as long[];
			long num4 = LuaDLL.tolua_toint64(L, 3);
			obj6[index] = num4;
		}
		else if (t == typeof(ulong))
		{
			ulong[] obj7 = obj as ulong[];
			ulong num5 = LuaDLL.tolua_touint64(L, 3);
			obj7[index] = num5;
		}
		else if (t == typeof(sbyte))
		{
			sbyte[] obj8 = obj as sbyte[];
			sbyte b = (sbyte)LuaDLL.luaL_checknumber(L, 3);
			obj8[index] = b;
		}
		else if (t == typeof(byte))
		{
			byte[] obj9 = obj as byte[];
			byte b2 = (byte)LuaDLL.luaL_checknumber(L, 3);
			obj9[index] = b2;
		}
		else if (t == typeof(short))
		{
			short[] obj10 = obj as short[];
			short num6 = (short)LuaDLL.luaL_checknumber(L, 3);
			obj10[index] = num6;
		}
		else if (t == typeof(ushort))
		{
			ushort[] obj11 = obj as ushort[];
			ushort num7 = (ushort)LuaDLL.luaL_checknumber(L, 3);
			obj11[index] = num7;
		}
		else if (t == typeof(char))
		{
			char[] obj12 = obj as char[];
			char c = (char)LuaDLL.luaL_checknumber(L, 3);
			obj12[index] = c;
		}
		else if (t == typeof(uint))
		{
			uint[] obj13 = obj as uint[];
			uint num8 = (uint)LuaDLL.luaL_checknumber(L, 3);
			obj13[index] = num8;
		}
		else
		{
			result = false;
		}
		return result;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Item(IntPtr L)
	{
		try
		{
			if (!(ToLua.ToObject(L, 1) is Array array))
			{
				throw new LuaException("trying to index an invalid object reference");
			}
			int num = LuaDLL.lua_tointeger(L, 2);
			Type elementType = array.GetType().GetElementType();
			if (elementType.IsValueType)
			{
				if (elementType.IsPrimitive)
				{
					if (SetPrimitiveValue(L, array, elementType, num))
					{
						return 0;
					}
				}
				else
				{
					if (elementType == typeof(Vector3))
					{
						Vector3[] obj = array as Vector3[];
						Vector3 vector = ToLua.ToVector3(L, 3);
						obj[num] = vector;
						return 0;
					}
					if (elementType == typeof(Quaternion))
					{
						Quaternion[] obj2 = array as Quaternion[];
						Quaternion quaternion = ToLua.ToQuaternion(L, 3);
						obj2[num] = quaternion;
						return 0;
					}
					if (elementType == typeof(Vector2))
					{
						Vector2[] obj3 = array as Vector2[];
						Vector2 vector2 = ToLua.ToVector2(L, 3);
						obj3[num] = vector2;
						return 0;
					}
					if (elementType == typeof(Vector4))
					{
						Vector4[] obj4 = array as Vector4[];
						Vector4 vector3 = ToLua.ToVector4(L, 3);
						obj4[num] = vector3;
						return 0;
					}
					if (elementType == typeof(Color))
					{
						Color[] obj5 = array as Color[];
						Color color = ToLua.ToColor(L, 3);
						obj5[num] = color;
						return 0;
					}
				}
			}
			if (!TypeChecker.CheckType(L, elementType, 3))
			{
				return LuaDLL.luaL_typerror(L, 3, LuaMisc.GetTypeName(elementType));
			}
			object temp = ToLua.CheckVarObject(L, 3, elementType);
			temp = TypeChecker.ChangeType(temp, elementType);
			array.SetValue(temp, num);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Length(IntPtr L)
	{
		try
		{
			if (!(ToLua.ToObject(L, 1) is Array array))
			{
				throw new LuaException("trying to index an invalid object reference");
			}
			LuaDLL.lua_pushinteger(L, array.Length);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ToTable(IntPtr L)
	{
		try
		{
			if (!(ToLua.ToObject(L, 1) is Array array))
			{
				throw new LuaException("trying to index an invalid object reference");
			}
			LuaDLL.lua_createtable(L, array.Length, 0);
			Type elementType = array.GetType().GetElementType();
			if (elementType.IsValueType)
			{
				if (elementType.IsPrimitive)
				{
					if (elementType == typeof(float))
					{
						float[] array2 = array as float[];
						for (int i = 0; i < array2.Length; i++)
						{
							float num = array2[i];
							LuaDLL.lua_pushnumber(L, num);
							LuaDLL.lua_rawseti(L, -2, i + 1);
						}
						return 1;
					}
					if (elementType == typeof(int))
					{
						int[] array3 = array as int[];
						for (int j = 0; j < array3.Length; j++)
						{
							int n = array3[j];
							LuaDLL.lua_pushinteger(L, n);
							LuaDLL.lua_rawseti(L, -2, j + 1);
						}
						return 1;
					}
					if (elementType == typeof(double))
					{
						double[] array4 = array as double[];
						for (int k = 0; k < array4.Length; k++)
						{
							double number = array4[k];
							LuaDLL.lua_pushnumber(L, number);
							LuaDLL.lua_rawseti(L, -2, k + 1);
						}
						return 1;
					}
					if (elementType == typeof(bool))
					{
						bool[] array5 = array as bool[];
						for (int l = 0; l < array5.Length; l++)
						{
							bool value = array5[l];
							LuaDLL.lua_pushboolean(L, value);
							LuaDLL.lua_rawseti(L, -2, l + 1);
						}
						return 1;
					}
					if (elementType == typeof(long))
					{
						long[] array6 = array as long[];
						for (int m = 0; m < array6.Length; m++)
						{
							long n2 = array6[m];
							LuaDLL.tolua_pushint64(L, n2);
							LuaDLL.lua_rawseti(L, -2, m + 1);
						}
						return 1;
					}
					if (elementType == typeof(ulong))
					{
						ulong[] array7 = array as ulong[];
						for (int num2 = 0; num2 < array7.Length; num2++)
						{
							ulong n3 = array7[num2];
							LuaDLL.tolua_pushuint64(L, n3);
							LuaDLL.lua_rawseti(L, -2, num2 + 1);
						}
						return 1;
					}
					if (elementType == typeof(byte))
					{
						byte[] array8 = array as byte[];
						for (int num3 = 0; num3 < array8.Length; num3++)
						{
							byte b = array8[num3];
							LuaDLL.lua_pushnumber(L, (int)b);
							LuaDLL.lua_rawseti(L, -2, num3 + 1);
						}
						return 1;
					}
					if (elementType == typeof(sbyte))
					{
						sbyte[] array9 = array as sbyte[];
						for (int num4 = 0; num4 < array9.Length; num4++)
						{
							sbyte b2 = array9[num4];
							LuaDLL.lua_pushnumber(L, b2);
							LuaDLL.lua_rawseti(L, -2, num4 + 1);
						}
						return 1;
					}
					if (elementType == typeof(char))
					{
						char[] array10 = array as char[];
						for (int num5 = 0; num5 < array10.Length; num5++)
						{
							char c = array10[num5];
							LuaDLL.lua_pushnumber(L, (int)c);
							LuaDLL.lua_rawseti(L, -2, num5 + 1);
						}
						return 1;
					}
					if (elementType == typeof(uint))
					{
						uint[] array11 = array as uint[];
						for (int num6 = 0; num6 < array11.Length; num6++)
						{
							uint num7 = array11[num6];
							LuaDLL.lua_pushnumber(L, num7);
							LuaDLL.lua_rawseti(L, -2, num6 + 1);
						}
						return 1;
					}
					if (elementType == typeof(short))
					{
						short[] array12 = array as short[];
						for (int num8 = 0; num8 < array12.Length; num8++)
						{
							short num9 = array12[num8];
							LuaDLL.lua_pushnumber(L, num9);
							LuaDLL.lua_rawseti(L, -2, num8 + 1);
						}
						return 1;
					}
					if (elementType == typeof(ushort))
					{
						ushort[] array13 = array as ushort[];
						for (int num10 = 0; num10 < array13.Length; num10++)
						{
							ushort num11 = array13[num10];
							LuaDLL.lua_pushnumber(L, (int)num11);
							LuaDLL.lua_rawseti(L, -2, num10 + 1);
						}
						return 1;
					}
				}
				else
				{
					if (elementType == typeof(Vector3))
					{
						Vector3[] array14 = array as Vector3[];
						for (int num12 = 0; num12 < array14.Length; num12++)
						{
							Vector3 v = array14[num12];
							ToLua.Push(L, v);
							LuaDLL.lua_rawseti(L, -2, num12 + 1);
						}
						return 1;
					}
					if (elementType == typeof(Quaternion))
					{
						Quaternion[] array15 = array as Quaternion[];
						for (int num13 = 0; num13 < array15.Length; num13++)
						{
							Quaternion q = array15[num13];
							ToLua.Push(L, q);
							LuaDLL.lua_rawseti(L, -2, num13 + 1);
						}
						return 1;
					}
					if (elementType == typeof(Vector2))
					{
						Vector2[] array16 = array as Vector2[];
						for (int num14 = 0; num14 < array16.Length; num14++)
						{
							Vector2 v2 = array16[num14];
							ToLua.Push(L, v2);
							LuaDLL.lua_rawseti(L, -2, num14 + 1);
						}
						return 1;
					}
					if (elementType == typeof(Vector4))
					{
						Vector4[] array17 = array as Vector4[];
						for (int num15 = 0; num15 < array17.Length; num15++)
						{
							Vector4 v3 = array17[num15];
							ToLua.Push(L, v3);
							LuaDLL.lua_rawseti(L, -2, num15 + 1);
						}
						return 1;
					}
					if (elementType == typeof(Color))
					{
						Color[] array18 = array as Color[];
						for (int num16 = 0; num16 < array18.Length; num16++)
						{
							Color clr = array18[num16];
							ToLua.Push(L, clr);
							LuaDLL.lua_rawseti(L, -2, num16 + 1);
						}
						return 1;
					}
				}
			}
			for (int num17 = 0; num17 < array.Length; num17++)
			{
				object value2 = array.GetValue(num17);
				ToLua.Push(L, value2);
				LuaDLL.lua_rawseti(L, -2, num17 + 1);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLength(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Array obj = (Array)ToLua.CheckObject<Array>(L, 1);
			int dimension = (int)LuaDLL.luaL_checknumber(L, 2);
			int length = obj.GetLength(dimension);
			LuaDLL.lua_pushinteger(L, length);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLongLength(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Array obj = (Array)ToLua.CheckObject<Array>(L, 1);
			int dimension = (int)LuaDLL.luaL_checknumber(L, 2);
			long longLength = obj.GetLongLength(dimension);
			LuaDLL.lua_pushnumber(L, longLength);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLowerBound(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Array obj = (Array)ToLua.CheckObject<Array>(L, 1);
			int dimension = (int)LuaDLL.luaL_checknumber(L, 2);
			int lowerBound = obj.GetLowerBound(dimension);
			LuaDLL.lua_pushinteger(L, lowerBound);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetValue(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<long>(L, 2))
			{
				Array obj = (Array)ToLua.CheckObject<Array>(L, 1);
				long index = (long)LuaDLL.lua_tonumber(L, 2);
				object value = obj.GetValue(index);
				ToLua.Push(L, value);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<long, long>(L, 2))
			{
				Array obj2 = (Array)ToLua.CheckObject<Array>(L, 1);
				long index2 = (long)LuaDLL.lua_tonumber(L, 2);
				long index3 = (long)LuaDLL.lua_tonumber(L, 3);
				object value2 = obj2.GetValue(index2, index3);
				ToLua.Push(L, value2);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, int>(L, 2))
			{
				Array obj3 = (Array)ToLua.CheckObject<Array>(L, 1);
				int index4 = (int)LuaDLL.lua_tonumber(L, 2);
				int index5 = (int)LuaDLL.lua_tonumber(L, 3);
				object value3 = obj3.GetValue(index4, index5);
				ToLua.Push(L, value3);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<long, long, long>(L, 2))
			{
				Array obj4 = (Array)ToLua.CheckObject<Array>(L, 1);
				long index6 = (long)LuaDLL.lua_tonumber(L, 2);
				long index7 = (long)LuaDLL.lua_tonumber(L, 3);
				long index8 = (long)LuaDLL.lua_tonumber(L, 4);
				object value4 = obj4.GetValue(index6, index7, index8);
				ToLua.Push(L, value4);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<int, int, int>(L, 2))
			{
				Array obj5 = (Array)ToLua.CheckObject<Array>(L, 1);
				int index9 = (int)LuaDLL.lua_tonumber(L, 2);
				int index10 = (int)LuaDLL.lua_tonumber(L, 3);
				int index11 = (int)LuaDLL.lua_tonumber(L, 4);
				object value5 = obj5.GetValue(index9, index10, index11);
				ToLua.Push(L, value5);
				return 1;
			}
			if (TypeChecker.CheckParamsType<long>(L, 2, num - 1))
			{
				Array obj6 = (Array)ToLua.CheckObject<Array>(L, 1);
				long[] indices = ToLua.ToParamsNumber<long>(L, 2, num - 1);
				object value6 = obj6.GetValue(indices);
				ToLua.Push(L, value6);
				return 1;
			}
			if (TypeChecker.CheckParamsType<int>(L, 2, num - 1))
			{
				Array obj7 = (Array)ToLua.CheckObject<Array>(L, 1);
				int[] indices2 = ToLua.ToParamsNumber<int>(L, 2, num - 1);
				object value7 = obj7.GetValue(indices2);
				ToLua.Push(L, value7);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: System.Array.GetValue");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetValue(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<object, long>(L, 2))
			{
				Array array = (Array)ToLua.CheckObject<Array>(L, 1);
				object value = ToLua.ToVarObject(L, 2, array.GetType().GetElementType());
				long index = (long)LuaDLL.lua_tonumber(L, 3);
				array.SetValue(value, index);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<object, int, int>(L, 2))
			{
				Array array2 = (Array)ToLua.CheckObject<Array>(L, 1);
				object value2 = ToLua.ToVarObject(L, 2, array2.GetType().GetElementType());
				int index2 = (int)LuaDLL.lua_tonumber(L, 3);
				int index3 = (int)LuaDLL.lua_tonumber(L, 4);
				array2.SetValue(value2, index2, index3);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<object, long, long>(L, 2))
			{
				Array array3 = (Array)ToLua.CheckObject<Array>(L, 1);
				object value3 = ToLua.ToVarObject(L, 2, array3.GetType().GetElementType());
				long index4 = (long)LuaDLL.lua_tonumber(L, 3);
				long index5 = (long)LuaDLL.lua_tonumber(L, 4);
				array3.SetValue(value3, index4, index5);
				return 0;
			}
			if (num == 5 && TypeChecker.CheckTypes<object, int, int, int>(L, 2))
			{
				Array array4 = (Array)ToLua.CheckObject<Array>(L, 1);
				object value4 = ToLua.ToVarObject(L, 2, array4.GetType().GetElementType());
				int index6 = (int)LuaDLL.lua_tonumber(L, 3);
				int index7 = (int)LuaDLL.lua_tonumber(L, 4);
				int index8 = (int)LuaDLL.lua_tonumber(L, 5);
				array4.SetValue(value4, index6, index7, index8);
				return 0;
			}
			if (num == 5 && TypeChecker.CheckTypes<object, long, long, long>(L, 2))
			{
				Array array5 = (Array)ToLua.CheckObject<Array>(L, 1);
				object value5 = ToLua.ToVarObject(L, 2, array5.GetType().GetElementType());
				long index9 = (long)LuaDLL.lua_tonumber(L, 3);
				long index10 = (long)LuaDLL.lua_tonumber(L, 4);
				long index11 = (long)LuaDLL.lua_tonumber(L, 5);
				array5.SetValue(value5, index9, index10, index11);
				return 0;
			}
			if (TypeChecker.CheckTypes<object>(L, 2) && TypeChecker.CheckParamsType<long>(L, 3, num - 2))
			{
				Array array6 = (Array)ToLua.CheckObject<Array>(L, 1);
				object value6 = ToLua.ToVarObject(L, 2, array6.GetType().GetElementType());
				long[] indices = ToLua.ToParamsNumber<long>(L, 3, num - 2);
				array6.SetValue(value6, indices);
				return 0;
			}
			if (TypeChecker.CheckTypes<object>(L, 2) && TypeChecker.CheckParamsType<int>(L, 3, num - 2))
			{
				Array array7 = (Array)ToLua.CheckObject<Array>(L, 1);
				object value7 = ToLua.ToVarObject(L, 2, array7.GetType().GetElementType());
				int[] indices2 = ToLua.ToParamsNumber<int>(L, 3, num - 2);
				array7.SetValue(value7, indices2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: System.Array.SetValue");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetEnumerator(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			IEnumerator enumerator = ((Array)ToLua.CheckObject<Array>(L, 1)).GetEnumerator();
			ToLua.Push(L, enumerator);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetUpperBound(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Array obj = (Array)ToLua.CheckObject<Array>(L, 1);
			int dimension = (int)LuaDLL.luaL_checknumber(L, 2);
			int upperBound = obj.GetUpperBound(dimension);
			LuaDLL.lua_pushinteger(L, upperBound);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CreateInstance(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<Type, int>(L, 1))
			{
				Type elementType = (Type)ToLua.ToObject(L, 1);
				int length = (int)LuaDLL.lua_tonumber(L, 2);
				Array array = Array.CreateInstance(elementType, length);
				ToLua.Push(L, array);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<Type, int[], int[]>(L, 1))
			{
				Type elementType2 = (Type)ToLua.ToObject(L, 1);
				int[] lengths = ToLua.CheckNumberArray<int>(L, 2);
				int[] lowerBounds = ToLua.CheckNumberArray<int>(L, 3);
				Array array2 = Array.CreateInstance(elementType2, lengths, lowerBounds);
				ToLua.Push(L, array2);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<Type, int, int>(L, 1))
			{
				Type elementType3 = (Type)ToLua.ToObject(L, 1);
				int length2 = (int)LuaDLL.lua_tonumber(L, 2);
				int length3 = (int)LuaDLL.lua_tonumber(L, 3);
				Array array3 = Array.CreateInstance(elementType3, length2, length3);
				ToLua.Push(L, array3);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<Type, int, int, int>(L, 1))
			{
				Type elementType4 = (Type)ToLua.ToObject(L, 1);
				int length4 = (int)LuaDLL.lua_tonumber(L, 2);
				int length5 = (int)LuaDLL.lua_tonumber(L, 3);
				int length6 = (int)LuaDLL.lua_tonumber(L, 4);
				Array array4 = Array.CreateInstance(elementType4, length4, length5, length6);
				ToLua.Push(L, array4);
				return 1;
			}
			if (TypeChecker.CheckTypes<Type>(L, 1) && TypeChecker.CheckParamsType<long>(L, 2, num - 1))
			{
				Type elementType5 = (Type)ToLua.ToObject(L, 1);
				long[] lengths2 = ToLua.ToParamsNumber<long>(L, 2, num - 1);
				Array array5 = Array.CreateInstance(elementType5, lengths2);
				ToLua.Push(L, array5);
				return 1;
			}
			if (TypeChecker.CheckTypes<Type>(L, 1) && TypeChecker.CheckParamsType<int>(L, 2, num - 1))
			{
				Type elementType6 = (Type)ToLua.ToObject(L, 1);
				int[] lengths3 = ToLua.ToParamsNumber<int>(L, 2, num - 1);
				Array array6 = Array.CreateInstance(elementType6, lengths3);
				ToLua.Push(L, array6);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: System.Array.CreateInstance");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int BinarySearch(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Array array4 = (Array)ToLua.CheckObject<Array>(L, 1);
				object value4 = ToLua.ToVarObject(L, 2, array4.GetType().GetElementType());
				int n4 = Array.BinarySearch(array4, value4);
				LuaDLL.lua_pushinteger(L, n4);
				return 1;
			}
			case 3:
			{
				Array array3 = (Array)ToLua.CheckObject<Array>(L, 1);
				object value3 = ToLua.ToVarObject(L, 2, array3.GetType().GetElementType());
				IComparer comparer2 = (IComparer)ToLua.CheckObject<IComparer>(L, 3);
				int n3 = Array.BinarySearch(array3, value3, comparer2);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			case 4:
			{
				Array array2 = (Array)ToLua.CheckObject<Array>(L, 1);
				int index2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int length2 = (int)LuaDLL.luaL_checknumber(L, 3);
				object value2 = ToLua.ToVarObject(L, 4, array2.GetType().GetElementType());
				int n2 = Array.BinarySearch(array2, index2, length2, value2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 5:
			{
				Array array = (Array)ToLua.CheckObject<Array>(L, 1);
				int index = (int)LuaDLL.luaL_checknumber(L, 2);
				int length = (int)LuaDLL.luaL_checknumber(L, 3);
				object value = ToLua.ToVarObject(L, 4, array.GetType().GetElementType());
				IComparer comparer = (IComparer)ToLua.CheckObject<IComparer>(L, 5);
				int n = Array.BinarySearch(array, index, length, value, comparer);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.Array.BinarySearch");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Clear(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Array array = (Array)ToLua.CheckObject(L, 1, typeof(Array));
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			int length = (int)LuaDLL.luaL_checknumber(L, 3);
			Array.Clear(array, index, length);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Clone(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			object obj = ((Array)ToLua.CheckObject<Array>(L, 1)).Clone();
			ToLua.Push(L, obj);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Copy(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 3:
			{
				Array sourceArray2 = (Array)ToLua.CheckObject<Array>(L, 1);
				Array destinationArray2 = (Array)ToLua.CheckObject<Array>(L, 2);
				long length2 = LuaDLL.tolua_checkint64(L, 3);
				Array.Copy(sourceArray2, destinationArray2, length2);
				return 0;
			}
			case 5:
				if (TypeChecker.CheckTypes<long, Array, long, long>(L, 2))
				{
					Array sourceArray = (Array)ToLua.CheckObject<Array>(L, 1);
					long sourceIndex = LuaDLL.tolua_toint64(L, 2);
					Array destinationArray = (Array)ToLua.ToObject(L, 3);
					long destinationIndex = LuaDLL.tolua_toint64(L, 4);
					long length = LuaDLL.tolua_toint64(L, 5);
					Array.Copy(sourceArray, sourceIndex, destinationArray, destinationIndex, length);
					return 0;
				}
				break;
			}
			if (num == 5 && TypeChecker.CheckTypes<int, Array, int, int>(L, 2))
			{
				Array sourceArray3 = (Array)ToLua.CheckObject<Array>(L, 1);
				int sourceIndex2 = (int)LuaDLL.lua_tonumber(L, 2);
				Array destinationArray3 = (Array)ToLua.ToObject(L, 3);
				int destinationIndex2 = (int)LuaDLL.lua_tonumber(L, 4);
				int length3 = (int)LuaDLL.lua_tonumber(L, 5);
				Array.Copy(sourceArray3, sourceIndex2, destinationArray3, destinationIndex2, length3);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: System.Array.Copy");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IndexOf(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Array array3 = (Array)ToLua.CheckObject<Array>(L, 1);
				object value3 = ToLua.ToVarObject(L, 2, array3.GetType().GetElementType());
				int n3 = Array.IndexOf(array3, value3);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			case 3:
			{
				Array array2 = (Array)ToLua.CheckObject<Array>(L, 1);
				object value2 = ToLua.ToVarObject(L, 2, array2.GetType().GetElementType());
				int startIndex2 = (int)LuaDLL.luaL_checknumber(L, 3);
				int n2 = Array.IndexOf(array2, value2, startIndex2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 4:
			{
				Array array = (Array)ToLua.CheckObject<Array>(L, 1);
				object value = ToLua.ToVarObject(L, 2, array.GetType().GetElementType());
				int startIndex = (int)LuaDLL.luaL_checknumber(L, 3);
				int count = (int)LuaDLL.luaL_checknumber(L, 4);
				int n = Array.IndexOf(array, value, startIndex, count);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.Array.IndexOf");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Initialize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Array)ToLua.CheckObject<Array>(L, 1)).Initialize();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LastIndexOf(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Array array3 = (Array)ToLua.CheckObject<Array>(L, 1);
				object value3 = ToLua.ToVarObject(L, 2, array3.GetType().GetElementType());
				int n3 = Array.LastIndexOf(array3, value3);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			case 3:
			{
				Array array2 = (Array)ToLua.CheckObject<Array>(L, 1);
				object value2 = ToLua.ToVarObject(L, 2, array2.GetType().GetElementType());
				int startIndex2 = (int)LuaDLL.luaL_checknumber(L, 3);
				int n2 = Array.LastIndexOf(array2, value2, startIndex2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 4:
			{
				Array array = (Array)ToLua.CheckObject<Array>(L, 1);
				object value = ToLua.ToVarObject(L, 2, array.GetType().GetElementType());
				int startIndex = (int)LuaDLL.luaL_checknumber(L, 3);
				int count = (int)LuaDLL.luaL_checknumber(L, 4);
				int n = Array.LastIndexOf(array, value, startIndex, count);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.Array.LastIndexOf");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Reverse(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				Array.Reverse((Array)ToLua.CheckObject<Array>(L, 1));
				return 0;
			case 3:
			{
				Array array = (Array)ToLua.CheckObject<Array>(L, 1);
				int index = (int)LuaDLL.luaL_checknumber(L, 2);
				int length = (int)LuaDLL.luaL_checknumber(L, 3);
				Array.Reverse(array, index, length);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.Array.Reverse");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Sort(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 1:
				Array.Sort((Array)ToLua.CheckObject<Array>(L, 1));
				return 0;
			case 2:
				if (TypeChecker.CheckTypes<IComparer>(L, 2))
				{
					Array array = (Array)ToLua.CheckObject<Array>(L, 1);
					IComparer comparer = (IComparer)ToLua.ToObject(L, 2);
					Array.Sort(array, comparer);
					return 0;
				}
				break;
			}
			if (num == 2 && TypeChecker.CheckTypes<Array>(L, 2))
			{
				Array keys = (Array)ToLua.CheckObject<Array>(L, 1);
				Array items = (Array)ToLua.ToObject(L, 2);
				Array.Sort(keys, items);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<Array, IComparer>(L, 2))
			{
				Array keys2 = (Array)ToLua.CheckObject<Array>(L, 1);
				Array items2 = (Array)ToLua.ToObject(L, 2);
				IComparer comparer2 = (IComparer)ToLua.ToObject(L, 3);
				Array.Sort(keys2, items2, comparer2);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, int>(L, 2))
			{
				Array array2 = (Array)ToLua.CheckObject<Array>(L, 1);
				int index = (int)LuaDLL.lua_tonumber(L, 2);
				int length = (int)LuaDLL.lua_tonumber(L, 3);
				Array.Sort(array2, index, length);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<int, int, IComparer>(L, 2))
			{
				Array array3 = (Array)ToLua.CheckObject<Array>(L, 1);
				int index2 = (int)LuaDLL.lua_tonumber(L, 2);
				int length2 = (int)LuaDLL.lua_tonumber(L, 3);
				IComparer comparer3 = (IComparer)ToLua.ToObject(L, 4);
				Array.Sort(array3, index2, length2, comparer3);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<Array, int, int>(L, 2))
			{
				Array keys3 = (Array)ToLua.CheckObject<Array>(L, 1);
				Array items3 = (Array)ToLua.ToObject(L, 2);
				int index3 = (int)LuaDLL.lua_tonumber(L, 3);
				int length3 = (int)LuaDLL.lua_tonumber(L, 4);
				Array.Sort(keys3, items3, index3, length3);
				return 0;
			}
			if (num == 5)
			{
				Array keys4 = (Array)ToLua.CheckObject<Array>(L, 1);
				Array items4 = (Array)ToLua.CheckObject<Array>(L, 2);
				int index4 = (int)LuaDLL.luaL_checknumber(L, 3);
				int length4 = (int)LuaDLL.luaL_checknumber(L, 4);
				IComparer comparer4 = (IComparer)ToLua.CheckObject<IComparer>(L, 5);
				Array.Sort(keys4, items4, index4, length4, comparer4);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: System.Array.Sort");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CopyTo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Array obj = (Array)ToLua.CheckObject<Array>(L, 1);
			Array array = (Array)ToLua.CheckObject<Array>(L, 2);
			long index = (long)LuaDLL.luaL_checknumber(L, 3);
			obj.CopyTo(array, index);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ConstrainedCopy(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			Array sourceArray = (Array)ToLua.CheckObject<Array>(L, 1);
			int sourceIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			Array destinationArray = (Array)ToLua.CheckObject<Array>(L, 3);
			int destinationIndex = (int)LuaDLL.luaL_checknumber(L, 4);
			int length = (int)LuaDLL.luaL_checknumber(L, 5);
			Array.ConstrainedCopy(sourceArray, sourceIndex, destinationArray, destinationIndex, length);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_LongLength(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			long longLength = ((Array)obj).LongLength;
			LuaDLL.lua_pushnumber(L, longLength);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index LongLength on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Rank(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int rank = ((Array)obj).Rank;
			LuaDLL.lua_pushinteger(L, rank);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Rank on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsSynchronized(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isSynchronized = ((Array)obj).IsSynchronized;
			LuaDLL.lua_pushboolean(L, isSynchronized);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsSynchronized on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SyncRoot(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			object syncRoot = ((Array)obj).SyncRoot;
			ToLua.Push(L, syncRoot);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index SyncRoot on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsFixedSize(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isFixedSize = ((Array)obj).IsFixedSize;
			LuaDLL.lua_pushboolean(L, isFixedSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsFixedSize on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsReadOnly(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isReadOnly = ((Array)obj).IsReadOnly;
			LuaDLL.lua_pushboolean(L, isReadOnly);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsReadOnly on a nil value");
		}
	}
}
