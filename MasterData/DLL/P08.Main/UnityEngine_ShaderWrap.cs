using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

public class UnityEngine_ShaderWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Shader), typeof(UnityEngine.Object));
		L.RegFunction("Find", Find);
		L.RegFunction("EnableKeyword", EnableKeyword);
		L.RegFunction("DisableKeyword", DisableKeyword);
		L.RegFunction("IsKeywordEnabled", IsKeywordEnabled);
		L.RegFunction("WarmupAllShaders", WarmupAllShaders);
		L.RegFunction("PropertyToID", PropertyToID);
		L.RegFunction("SetGlobalFloat", SetGlobalFloat);
		L.RegFunction("SetGlobalInt", SetGlobalInt);
		L.RegFunction("SetGlobalVector", SetGlobalVector);
		L.RegFunction("SetGlobalColor", SetGlobalColor);
		L.RegFunction("SetGlobalMatrix", SetGlobalMatrix);
		L.RegFunction("SetGlobalTexture", SetGlobalTexture);
		L.RegFunction("SetGlobalBuffer", SetGlobalBuffer);
		L.RegFunction("SetGlobalFloatArray", SetGlobalFloatArray);
		L.RegFunction("SetGlobalVectorArray", SetGlobalVectorArray);
		L.RegFunction("SetGlobalMatrixArray", SetGlobalMatrixArray);
		L.RegFunction("GetGlobalFloat", GetGlobalFloat);
		L.RegFunction("GetGlobalInt", GetGlobalInt);
		L.RegFunction("GetGlobalVector", GetGlobalVector);
		L.RegFunction("GetGlobalColor", GetGlobalColor);
		L.RegFunction("GetGlobalMatrix", GetGlobalMatrix);
		L.RegFunction("GetGlobalTexture", GetGlobalTexture);
		L.RegFunction("GetGlobalFloatArray", GetGlobalFloatArray);
		L.RegFunction("GetGlobalVectorArray", GetGlobalVectorArray);
		L.RegFunction("GetGlobalMatrixArray", GetGlobalMatrixArray);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("maximumLOD", get_maximumLOD, set_maximumLOD);
		L.RegVar("globalMaximumLOD", get_globalMaximumLOD, set_globalMaximumLOD);
		L.RegVar("isSupported", get_isSupported, null);
		L.RegVar("globalRenderPipeline", get_globalRenderPipeline, set_globalRenderPipeline);
		L.RegVar("renderQueue", get_renderQueue, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Find(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Shader o = Shader.Find(ToLua.CheckString(L, 1));
			ToLua.PushSealed(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnableKeyword(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Shader.EnableKeyword(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DisableKeyword(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Shader.DisableKeyword(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsKeywordEnabled(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = Shader.IsKeywordEnabled(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WarmupAllShaders(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			Shader.WarmupAllShaders();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PropertyToID(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int n = Shader.PropertyToID(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGlobalFloat(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<int, float>(L, 1))
			{
				int nameID = (int)LuaDLL.lua_tonumber(L, 1);
				float value = (float)LuaDLL.lua_tonumber(L, 2);
				Shader.SetGlobalFloat(nameID, value);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<string, float>(L, 1))
			{
				string name = ToLua.ToString(L, 1);
				float value2 = (float)LuaDLL.lua_tonumber(L, 2);
				Shader.SetGlobalFloat(name, value2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Shader.SetGlobalFloat");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGlobalInt(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<int, int>(L, 1))
			{
				int nameID = (int)LuaDLL.lua_tonumber(L, 1);
				int value = (int)LuaDLL.lua_tonumber(L, 2);
				Shader.SetGlobalInt(nameID, value);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<string, int>(L, 1))
			{
				string name = ToLua.ToString(L, 1);
				int value2 = (int)LuaDLL.lua_tonumber(L, 2);
				Shader.SetGlobalInt(name, value2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Shader.SetGlobalInt");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGlobalVector(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<int, Vector4>(L, 1))
			{
				int nameID = (int)LuaDLL.lua_tonumber(L, 1);
				Vector4 value = ToLua.ToVector4(L, 2);
				Shader.SetGlobalVector(nameID, value);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<string, Vector4>(L, 1))
			{
				string name = ToLua.ToString(L, 1);
				Vector4 value2 = ToLua.ToVector4(L, 2);
				Shader.SetGlobalVector(name, value2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Shader.SetGlobalVector");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGlobalColor(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<int, Color>(L, 1))
			{
				int nameID = (int)LuaDLL.lua_tonumber(L, 1);
				Color value = ToLua.ToColor(L, 2);
				Shader.SetGlobalColor(nameID, value);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<string, Color>(L, 1))
			{
				string name = ToLua.ToString(L, 1);
				Color value2 = ToLua.ToColor(L, 2);
				Shader.SetGlobalColor(name, value2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Shader.SetGlobalColor");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGlobalMatrix(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<int, Matrix4x4>(L, 1))
			{
				int nameID = (int)LuaDLL.lua_tonumber(L, 1);
				Matrix4x4 value = StackTraits<Matrix4x4>.To(L, 2);
				Shader.SetGlobalMatrix(nameID, value);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<string, Matrix4x4>(L, 1))
			{
				string name = ToLua.ToString(L, 1);
				Matrix4x4 value2 = StackTraits<Matrix4x4>.To(L, 2);
				Shader.SetGlobalMatrix(name, value2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Shader.SetGlobalMatrix");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGlobalTexture(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<int, Texture>(L, 1))
			{
				int nameID = (int)LuaDLL.lua_tonumber(L, 1);
				Texture value = (Texture)ToLua.ToObject(L, 2);
				Shader.SetGlobalTexture(nameID, value);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<string, Texture>(L, 1))
			{
				string name = ToLua.ToString(L, 1);
				Texture value2 = (Texture)ToLua.ToObject(L, 2);
				Shader.SetGlobalTexture(name, value2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Shader.SetGlobalTexture");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGlobalBuffer(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<int, ComputeBuffer>(L, 1))
			{
				int nameID = (int)LuaDLL.lua_tonumber(L, 1);
				ComputeBuffer value = (ComputeBuffer)ToLua.ToObject(L, 2);
				Shader.SetGlobalBuffer(nameID, value);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<string, ComputeBuffer>(L, 1))
			{
				string name = ToLua.ToString(L, 1);
				ComputeBuffer value2 = (ComputeBuffer)ToLua.ToObject(L, 2);
				Shader.SetGlobalBuffer(name, value2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Shader.SetGlobalBuffer");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGlobalFloatArray(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<string, float[]>(L, 1))
			{
				string name = ToLua.ToString(L, 1);
				float[] values = ToLua.ToNumberArray<float>(L, 2);
				Shader.SetGlobalFloatArray(name, values);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<int, float[]>(L, 1))
			{
				int nameID = (int)LuaDLL.lua_tonumber(L, 1);
				float[] values2 = ToLua.ToNumberArray<float>(L, 2);
				Shader.SetGlobalFloatArray(nameID, values2);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<string, List<float>>(L, 1))
			{
				string name2 = ToLua.ToString(L, 1);
				List<float> values3 = (List<float>)ToLua.ToObject(L, 2);
				Shader.SetGlobalFloatArray(name2, values3);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<int, List<float>>(L, 1))
			{
				int nameID2 = (int)LuaDLL.lua_tonumber(L, 1);
				List<float> values4 = (List<float>)ToLua.ToObject(L, 2);
				Shader.SetGlobalFloatArray(nameID2, values4);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Shader.SetGlobalFloatArray");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGlobalVectorArray(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<string, Vector4[]>(L, 1))
			{
				string name = ToLua.ToString(L, 1);
				Vector4[] values = ToLua.ToStructArray<Vector4>(L, 2);
				Shader.SetGlobalVectorArray(name, values);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<int, Vector4[]>(L, 1))
			{
				int nameID = (int)LuaDLL.lua_tonumber(L, 1);
				Vector4[] values2 = ToLua.ToStructArray<Vector4>(L, 2);
				Shader.SetGlobalVectorArray(nameID, values2);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<string, List<Vector4>>(L, 1))
			{
				string name2 = ToLua.ToString(L, 1);
				List<Vector4> values3 = (List<Vector4>)ToLua.ToObject(L, 2);
				Shader.SetGlobalVectorArray(name2, values3);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<int, List<Vector4>>(L, 1))
			{
				int nameID2 = (int)LuaDLL.lua_tonumber(L, 1);
				List<Vector4> values4 = (List<Vector4>)ToLua.ToObject(L, 2);
				Shader.SetGlobalVectorArray(nameID2, values4);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Shader.SetGlobalVectorArray");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGlobalMatrixArray(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<string, Matrix4x4[]>(L, 1))
			{
				string name = ToLua.ToString(L, 1);
				Matrix4x4[] values = ToLua.ToStructArray<Matrix4x4>(L, 2);
				Shader.SetGlobalMatrixArray(name, values);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<int, Matrix4x4[]>(L, 1))
			{
				int nameID = (int)LuaDLL.lua_tonumber(L, 1);
				Matrix4x4[] values2 = ToLua.ToStructArray<Matrix4x4>(L, 2);
				Shader.SetGlobalMatrixArray(nameID, values2);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<string, List<Matrix4x4>>(L, 1))
			{
				string name2 = ToLua.ToString(L, 1);
				List<Matrix4x4> values3 = (List<Matrix4x4>)ToLua.ToObject(L, 2);
				Shader.SetGlobalMatrixArray(name2, values3);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<int, List<Matrix4x4>>(L, 1))
			{
				int nameID2 = (int)LuaDLL.lua_tonumber(L, 1);
				List<Matrix4x4> values4 = (List<Matrix4x4>)ToLua.ToObject(L, 2);
				Shader.SetGlobalMatrixArray(nameID2, values4);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Shader.SetGlobalMatrixArray");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetGlobalFloat(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<int>(L, 1))
			{
				float globalFloat = Shader.GetGlobalFloat((int)LuaDLL.lua_tonumber(L, 1));
				LuaDLL.lua_pushnumber(L, globalFloat);
				return 1;
			}
			if (num == 1 && TypeChecker.CheckTypes<string>(L, 1))
			{
				float globalFloat2 = Shader.GetGlobalFloat(ToLua.ToString(L, 1));
				LuaDLL.lua_pushnumber(L, globalFloat2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Shader.GetGlobalFloat");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetGlobalInt(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<int>(L, 1))
			{
				int globalInt = Shader.GetGlobalInt((int)LuaDLL.lua_tonumber(L, 1));
				LuaDLL.lua_pushinteger(L, globalInt);
				return 1;
			}
			if (num == 1 && TypeChecker.CheckTypes<string>(L, 1))
			{
				int globalInt2 = Shader.GetGlobalInt(ToLua.ToString(L, 1));
				LuaDLL.lua_pushinteger(L, globalInt2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Shader.GetGlobalInt");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetGlobalVector(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<int>(L, 1))
			{
				Vector4 globalVector = Shader.GetGlobalVector((int)LuaDLL.lua_tonumber(L, 1));
				ToLua.Push(L, globalVector);
				return 1;
			}
			if (num == 1 && TypeChecker.CheckTypes<string>(L, 1))
			{
				Vector4 globalVector2 = Shader.GetGlobalVector(ToLua.ToString(L, 1));
				ToLua.Push(L, globalVector2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Shader.GetGlobalVector");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetGlobalColor(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<int>(L, 1))
			{
				Color globalColor = Shader.GetGlobalColor((int)LuaDLL.lua_tonumber(L, 1));
				ToLua.Push(L, globalColor);
				return 1;
			}
			if (num == 1 && TypeChecker.CheckTypes<string>(L, 1))
			{
				Color globalColor2 = Shader.GetGlobalColor(ToLua.ToString(L, 1));
				ToLua.Push(L, globalColor2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Shader.GetGlobalColor");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetGlobalMatrix(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<int>(L, 1))
			{
				Matrix4x4 globalMatrix = Shader.GetGlobalMatrix((int)LuaDLL.lua_tonumber(L, 1));
				ToLua.PushValue(L, globalMatrix);
				return 1;
			}
			if (num == 1 && TypeChecker.CheckTypes<string>(L, 1))
			{
				Matrix4x4 globalMatrix2 = Shader.GetGlobalMatrix(ToLua.ToString(L, 1));
				ToLua.PushValue(L, globalMatrix2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Shader.GetGlobalMatrix");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetGlobalTexture(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<int>(L, 1))
			{
				Texture globalTexture = Shader.GetGlobalTexture((int)LuaDLL.lua_tonumber(L, 1));
				ToLua.Push(L, globalTexture);
				return 1;
			}
			if (num == 1 && TypeChecker.CheckTypes<string>(L, 1))
			{
				Texture globalTexture2 = Shader.GetGlobalTexture(ToLua.ToString(L, 1));
				ToLua.Push(L, globalTexture2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Shader.GetGlobalTexture");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetGlobalFloatArray(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<int>(L, 1))
			{
				float[] globalFloatArray = Shader.GetGlobalFloatArray((int)LuaDLL.lua_tonumber(L, 1));
				ToLua.Push(L, globalFloatArray);
				return 1;
			}
			if (num == 1 && TypeChecker.CheckTypes<string>(L, 1))
			{
				float[] globalFloatArray2 = Shader.GetGlobalFloatArray(ToLua.ToString(L, 1));
				ToLua.Push(L, globalFloatArray2);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int, List<float>>(L, 1))
			{
				int nameID = (int)LuaDLL.lua_tonumber(L, 1);
				List<float> values = (List<float>)ToLua.ToObject(L, 2);
				Shader.GetGlobalFloatArray(nameID, values);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<string, List<float>>(L, 1))
			{
				string name = ToLua.ToString(L, 1);
				List<float> values2 = (List<float>)ToLua.ToObject(L, 2);
				Shader.GetGlobalFloatArray(name, values2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Shader.GetGlobalFloatArray");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetGlobalVectorArray(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<int>(L, 1))
			{
				Vector4[] globalVectorArray = Shader.GetGlobalVectorArray((int)LuaDLL.lua_tonumber(L, 1));
				ToLua.Push(L, globalVectorArray);
				return 1;
			}
			if (num == 1 && TypeChecker.CheckTypes<string>(L, 1))
			{
				Vector4[] globalVectorArray2 = Shader.GetGlobalVectorArray(ToLua.ToString(L, 1));
				ToLua.Push(L, globalVectorArray2);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int, List<Vector4>>(L, 1))
			{
				int nameID = (int)LuaDLL.lua_tonumber(L, 1);
				List<Vector4> values = (List<Vector4>)ToLua.ToObject(L, 2);
				Shader.GetGlobalVectorArray(nameID, values);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<string, List<Vector4>>(L, 1))
			{
				string name = ToLua.ToString(L, 1);
				List<Vector4> values2 = (List<Vector4>)ToLua.ToObject(L, 2);
				Shader.GetGlobalVectorArray(name, values2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Shader.GetGlobalVectorArray");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetGlobalMatrixArray(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<int>(L, 1))
			{
				Matrix4x4[] globalMatrixArray = Shader.GetGlobalMatrixArray((int)LuaDLL.lua_tonumber(L, 1));
				ToLua.Push(L, globalMatrixArray);
				return 1;
			}
			if (num == 1 && TypeChecker.CheckTypes<string>(L, 1))
			{
				Matrix4x4[] globalMatrixArray2 = Shader.GetGlobalMatrixArray(ToLua.ToString(L, 1));
				ToLua.Push(L, globalMatrixArray2);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int, List<Matrix4x4>>(L, 1))
			{
				int nameID = (int)LuaDLL.lua_tonumber(L, 1);
				List<Matrix4x4> values = (List<Matrix4x4>)ToLua.ToObject(L, 2);
				Shader.GetGlobalMatrixArray(nameID, values);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<string, List<Matrix4x4>>(L, 1))
			{
				string name = ToLua.ToString(L, 1);
				List<Matrix4x4> values2 = (List<Matrix4x4>)ToLua.ToObject(L, 2);
				Shader.GetGlobalMatrixArray(name, values2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Shader.GetGlobalMatrixArray");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int op_Equality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.Object obj = (UnityEngine.Object)ToLua.ToObject(L, 1);
			UnityEngine.Object obj2 = (UnityEngine.Object)ToLua.ToObject(L, 2);
			bool value = obj == obj2;
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maximumLOD(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int maximumLOD = ((Shader)obj).maximumLOD;
			LuaDLL.lua_pushinteger(L, maximumLOD);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maximumLOD on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_globalMaximumLOD(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, Shader.globalMaximumLOD);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isSupported(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isSupported = ((Shader)obj).isSupported;
			LuaDLL.lua_pushboolean(L, isSupported);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isSupported on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_globalRenderPipeline(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, Shader.globalRenderPipeline);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_renderQueue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int renderQueue = ((Shader)obj).renderQueue;
			LuaDLL.lua_pushinteger(L, renderQueue);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index renderQueue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maximumLOD(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Shader obj2 = (Shader)obj;
			int maximumLOD = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.maximumLOD = maximumLOD;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maximumLOD on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_globalMaximumLOD(IntPtr L)
	{
		try
		{
			Shader.globalMaximumLOD = (int)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_globalRenderPipeline(IntPtr L)
	{
		try
		{
			Shader.globalRenderPipeline = ToLua.CheckString(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
