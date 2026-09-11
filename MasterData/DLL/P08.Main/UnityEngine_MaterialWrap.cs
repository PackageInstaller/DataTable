using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

public class UnityEngine_MaterialWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Material), typeof(UnityEngine.Object));
		L.RegFunction("HasProperty", HasProperty);
		L.RegFunction("EnableKeyword", EnableKeyword);
		L.RegFunction("DisableKeyword", DisableKeyword);
		L.RegFunction("IsKeywordEnabled", IsKeywordEnabled);
		L.RegFunction("SetShaderPassEnabled", SetShaderPassEnabled);
		L.RegFunction("GetShaderPassEnabled", GetShaderPassEnabled);
		L.RegFunction("GetPassName", GetPassName);
		L.RegFunction("FindPass", FindPass);
		L.RegFunction("SetOverrideTag", SetOverrideTag);
		L.RegFunction("GetTag", GetTag);
		L.RegFunction("Lerp", Lerp);
		L.RegFunction("SetPass", SetPass);
		L.RegFunction("CopyPropertiesFromMaterial", CopyPropertiesFromMaterial);
		L.RegFunction("GetTexturePropertyNames", GetTexturePropertyNames);
		L.RegFunction("GetTexturePropertyNameIDs", GetTexturePropertyNameIDs);
		L.RegFunction("SetFloat", SetFloat);
		L.RegFunction("SetInt", SetInt);
		L.RegFunction("SetColor", SetColor);
		L.RegFunction("SetVector", SetVector);
		L.RegFunction("SetMatrix", SetMatrix);
		L.RegFunction("SetTexture", SetTexture);
		L.RegFunction("SetBuffer", SetBuffer);
		L.RegFunction("SetFloatArray", SetFloatArray);
		L.RegFunction("SetColorArray", SetColorArray);
		L.RegFunction("SetVectorArray", SetVectorArray);
		L.RegFunction("SetMatrixArray", SetMatrixArray);
		L.RegFunction("GetFloat", GetFloat);
		L.RegFunction("GetInt", GetInt);
		L.RegFunction("GetColor", GetColor);
		L.RegFunction("GetVector", GetVector);
		L.RegFunction("GetMatrix", GetMatrix);
		L.RegFunction("GetTexture", GetTexture);
		L.RegFunction("GetFloatArray", GetFloatArray);
		L.RegFunction("GetColorArray", GetColorArray);
		L.RegFunction("GetVectorArray", GetVectorArray);
		L.RegFunction("GetMatrixArray", GetMatrixArray);
		L.RegFunction("SetTextureOffset", SetTextureOffset);
		L.RegFunction("SetTextureScale", SetTextureScale);
		L.RegFunction("GetTextureOffset", GetTextureOffset);
		L.RegFunction("GetTextureScale", GetTextureScale);
		L.RegFunction("New", _CreateUnityEngine_Material);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("shader", get_shader, set_shader);
		L.RegVar("color", get_color, set_color);
		L.RegVar("mainTexture", get_mainTexture, set_mainTexture);
		L.RegVar("mainTextureOffset", get_mainTextureOffset, set_mainTextureOffset);
		L.RegVar("mainTextureScale", get_mainTextureScale, set_mainTextureScale);
		L.RegVar("renderQueue", get_renderQueue, set_renderQueue);
		L.RegVar("globalIlluminationFlags", get_globalIlluminationFlags, set_globalIlluminationFlags);
		L.RegVar("doubleSidedGI", get_doubleSidedGI, set_doubleSidedGI);
		L.RegVar("enableInstancing", get_enableInstancing, set_enableInstancing);
		L.RegVar("passCount", get_passCount, null);
		L.RegVar("shaderKeywords", get_shaderKeywords, set_shaderKeywords);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_Material(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<Material>(L, 1))
			{
				Material obj = new Material((Material)ToLua.ToObject(L, 1));
				ToLua.Push(L, obj);
				return 1;
			}
			if (num == 1 && TypeChecker.CheckTypes<Shader>(L, 1))
			{
				Material obj2 = new Material((Shader)ToLua.ToObject(L, 1));
				ToLua.Push(L, obj2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.Material.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HasProperty(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				string name = ToLua.ToString(L, 2);
				bool value = obj.HasProperty(name);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				Material obj2 = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				bool value2 = obj2.HasProperty(nameID);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.HasProperty");
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
			ToLua.CheckArgsCount(L, 2);
			Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
			string keyword = ToLua.CheckString(L, 2);
			obj.EnableKeyword(keyword);
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
			ToLua.CheckArgsCount(L, 2);
			Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
			string keyword = ToLua.CheckString(L, 2);
			obj.DisableKeyword(keyword);
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
			ToLua.CheckArgsCount(L, 2);
			Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
			string keyword = ToLua.CheckString(L, 2);
			bool value = obj.IsKeywordEnabled(keyword);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetShaderPassEnabled(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
			string passName = ToLua.CheckString(L, 2);
			bool enabled = LuaDLL.luaL_checkboolean(L, 3);
			obj.SetShaderPassEnabled(passName, enabled);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetShaderPassEnabled(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
			string passName = ToLua.CheckString(L, 2);
			bool shaderPassEnabled = obj.GetShaderPassEnabled(passName);
			LuaDLL.lua_pushboolean(L, shaderPassEnabled);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPassName(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
			int pass = (int)LuaDLL.luaL_checknumber(L, 2);
			string passName = obj.GetPassName(pass);
			LuaDLL.lua_pushstring(L, passName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FindPass(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
			string passName = ToLua.CheckString(L, 2);
			int n = obj.FindPass(passName);
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetOverrideTag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
			string tag = ToLua.CheckString(L, 2);
			string val = ToLua.CheckString(L, 3);
			obj.SetOverrideTag(tag, val);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTag(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				Material obj2 = (Material)ToLua.CheckObject<Material>(L, 1);
				string tag3 = ToLua.CheckString(L, 2);
				bool searchFallbacks2 = LuaDLL.luaL_checkboolean(L, 3);
				string tag4 = obj2.GetTag(tag3, searchFallbacks2);
				LuaDLL.lua_pushstring(L, tag4);
				return 1;
			}
			case 4:
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				string tag = ToLua.CheckString(L, 2);
				bool searchFallbacks = LuaDLL.luaL_checkboolean(L, 3);
				string defaultValue = ToLua.CheckString(L, 4);
				string tag2 = obj.GetTag(tag, searchFallbacks, defaultValue);
				LuaDLL.lua_pushstring(L, tag2);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.GetTag");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Lerp(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
			Material start = (Material)ToLua.CheckObject<Material>(L, 2);
			Material end = (Material)ToLua.CheckObject<Material>(L, 3);
			float t = (float)LuaDLL.luaL_checknumber(L, 4);
			obj.Lerp(start, end, t);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPass(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
			int pass = (int)LuaDLL.luaL_checknumber(L, 2);
			bool value = obj.SetPass(pass);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CopyPropertiesFromMaterial(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
			Material mat = (Material)ToLua.CheckObject<Material>(L, 2);
			obj.CopyPropertiesFromMaterial(mat);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTexturePropertyNames(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				string[] texturePropertyNames = ((Material)ToLua.CheckObject<Material>(L, 1)).GetTexturePropertyNames();
				ToLua.Push(L, texturePropertyNames);
				return 1;
			}
			case 2:
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				List<string> outNames = (List<string>)ToLua.CheckObject(L, 2, typeof(List<string>));
				obj.GetTexturePropertyNames(outNames);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.GetTexturePropertyNames");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTexturePropertyNameIDs(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				int[] texturePropertyNameIDs = ((Material)ToLua.CheckObject<Material>(L, 1)).GetTexturePropertyNameIDs();
				ToLua.Push(L, texturePropertyNameIDs);
				return 1;
			}
			case 2:
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				List<int> outNames = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
				obj.GetTexturePropertyNameIDs(outNames);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.GetTexturePropertyNameIDs");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetFloat(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<int, float>(L, 2))
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				float value = (float)LuaDLL.lua_tonumber(L, 3);
				obj.SetFloat(nameID, value);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, float>(L, 2))
			{
				Material obj2 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name = ToLua.ToString(L, 2);
				float value2 = (float)LuaDLL.lua_tonumber(L, 3);
				obj2.SetFloat(name, value2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.SetFloat");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetInt(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<int, int>(L, 2))
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				int value = (int)LuaDLL.lua_tonumber(L, 3);
				obj.SetInt(nameID, value);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, int>(L, 2))
			{
				Material obj2 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name = ToLua.ToString(L, 2);
				int value2 = (int)LuaDLL.lua_tonumber(L, 3);
				obj2.SetInt(name, value2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.SetInt");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetColor(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<int, Color>(L, 2))
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				Color value = ToLua.ToColor(L, 3);
				obj.SetColor(nameID, value);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, Color>(L, 2))
			{
				Material obj2 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name = ToLua.ToString(L, 2);
				Color value2 = ToLua.ToColor(L, 3);
				obj2.SetColor(name, value2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.SetColor");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetVector(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<int, Vector4>(L, 2))
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				Vector4 value = ToLua.ToVector4(L, 3);
				obj.SetVector(nameID, value);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, Vector4>(L, 2))
			{
				Material obj2 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name = ToLua.ToString(L, 2);
				Vector4 value2 = ToLua.ToVector4(L, 3);
				obj2.SetVector(name, value2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.SetVector");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetMatrix(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<int, Matrix4x4>(L, 2))
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				Matrix4x4 value = StackTraits<Matrix4x4>.To(L, 3);
				obj.SetMatrix(nameID, value);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, Matrix4x4>(L, 2))
			{
				Material obj2 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name = ToLua.ToString(L, 2);
				Matrix4x4 value2 = StackTraits<Matrix4x4>.To(L, 3);
				obj2.SetMatrix(name, value2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.SetMatrix");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetTexture(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<int, Texture>(L, 2))
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				Texture value = (Texture)ToLua.ToObject(L, 3);
				obj.SetTexture(nameID, value);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, Texture>(L, 2))
			{
				Material obj2 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name = ToLua.ToString(L, 2);
				Texture value2 = (Texture)ToLua.ToObject(L, 3);
				obj2.SetTexture(name, value2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.SetTexture");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetBuffer(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<int, ComputeBuffer>(L, 2))
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				ComputeBuffer value = (ComputeBuffer)ToLua.ToObject(L, 3);
				obj.SetBuffer(nameID, value);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, ComputeBuffer>(L, 2))
			{
				Material obj2 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name = ToLua.ToString(L, 2);
				ComputeBuffer value2 = (ComputeBuffer)ToLua.ToObject(L, 3);
				obj2.SetBuffer(name, value2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.SetBuffer");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetFloatArray(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<string, float[]>(L, 2))
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				string name = ToLua.ToString(L, 2);
				float[] values = ToLua.ToNumberArray<float>(L, 3);
				obj.SetFloatArray(name, values);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, float[]>(L, 2))
			{
				Material obj2 = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				float[] values2 = ToLua.ToNumberArray<float>(L, 3);
				obj2.SetFloatArray(nameID, values2);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, List<float>>(L, 2))
			{
				Material obj3 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name2 = ToLua.ToString(L, 2);
				List<float> values3 = (List<float>)ToLua.ToObject(L, 3);
				obj3.SetFloatArray(name2, values3);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, List<float>>(L, 2))
			{
				Material obj4 = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID2 = (int)LuaDLL.lua_tonumber(L, 2);
				List<float> values4 = (List<float>)ToLua.ToObject(L, 3);
				obj4.SetFloatArray(nameID2, values4);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.SetFloatArray");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetColorArray(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<string, Color[]>(L, 2))
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				string name = ToLua.ToString(L, 2);
				Color[] values = ToLua.ToStructArray<Color>(L, 3);
				obj.SetColorArray(name, values);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, Color[]>(L, 2))
			{
				Material obj2 = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				Color[] values2 = ToLua.ToStructArray<Color>(L, 3);
				obj2.SetColorArray(nameID, values2);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, List<Color>>(L, 2))
			{
				Material obj3 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name2 = ToLua.ToString(L, 2);
				List<Color> values3 = (List<Color>)ToLua.ToObject(L, 3);
				obj3.SetColorArray(name2, values3);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, List<Color>>(L, 2))
			{
				Material obj4 = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID2 = (int)LuaDLL.lua_tonumber(L, 2);
				List<Color> values4 = (List<Color>)ToLua.ToObject(L, 3);
				obj4.SetColorArray(nameID2, values4);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.SetColorArray");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetVectorArray(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<string, Vector4[]>(L, 2))
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				string name = ToLua.ToString(L, 2);
				Vector4[] values = ToLua.ToStructArray<Vector4>(L, 3);
				obj.SetVectorArray(name, values);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, Vector4[]>(L, 2))
			{
				Material obj2 = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				Vector4[] values2 = ToLua.ToStructArray<Vector4>(L, 3);
				obj2.SetVectorArray(nameID, values2);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, List<Vector4>>(L, 2))
			{
				Material obj3 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name2 = ToLua.ToString(L, 2);
				List<Vector4> values3 = (List<Vector4>)ToLua.ToObject(L, 3);
				obj3.SetVectorArray(name2, values3);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, List<Vector4>>(L, 2))
			{
				Material obj4 = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID2 = (int)LuaDLL.lua_tonumber(L, 2);
				List<Vector4> values4 = (List<Vector4>)ToLua.ToObject(L, 3);
				obj4.SetVectorArray(nameID2, values4);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.SetVectorArray");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetMatrixArray(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<string, Matrix4x4[]>(L, 2))
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				string name = ToLua.ToString(L, 2);
				Matrix4x4[] values = ToLua.ToStructArray<Matrix4x4>(L, 3);
				obj.SetMatrixArray(name, values);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, Matrix4x4[]>(L, 2))
			{
				Material obj2 = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				Matrix4x4[] values2 = ToLua.ToStructArray<Matrix4x4>(L, 3);
				obj2.SetMatrixArray(nameID, values2);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, List<Matrix4x4>>(L, 2))
			{
				Material obj3 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name2 = ToLua.ToString(L, 2);
				List<Matrix4x4> values3 = (List<Matrix4x4>)ToLua.ToObject(L, 3);
				obj3.SetMatrixArray(name2, values3);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, List<Matrix4x4>>(L, 2))
			{
				Material obj4 = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID2 = (int)LuaDLL.lua_tonumber(L, 2);
				List<Matrix4x4> values4 = (List<Matrix4x4>)ToLua.ToObject(L, 3);
				obj4.SetMatrixArray(nameID2, values4);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.SetMatrixArray");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetFloat(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				float num2 = obj.GetFloat(nameID);
				LuaDLL.lua_pushnumber(L, num2);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				Material obj2 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name = ToLua.ToString(L, 2);
				float num3 = obj2.GetFloat(name);
				LuaDLL.lua_pushnumber(L, num3);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.GetFloat");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetInt(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				int n = obj.GetInt(nameID);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				Material obj2 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name = ToLua.ToString(L, 2);
				int n2 = obj2.GetInt(name);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.GetInt");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetColor(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				Color color = obj.GetColor(nameID);
				ToLua.Push(L, color);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				Material obj2 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name = ToLua.ToString(L, 2);
				Color color2 = obj2.GetColor(name);
				ToLua.Push(L, color2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.GetColor");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetVector(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				Vector4 vector = obj.GetVector(nameID);
				ToLua.Push(L, vector);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				Material obj2 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name = ToLua.ToString(L, 2);
				Vector4 vector2 = obj2.GetVector(name);
				ToLua.Push(L, vector2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.GetVector");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetMatrix(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				Matrix4x4 matrix = obj.GetMatrix(nameID);
				ToLua.PushValue(L, matrix);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				Material obj2 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name = ToLua.ToString(L, 2);
				Matrix4x4 matrix2 = obj2.GetMatrix(name);
				ToLua.PushValue(L, matrix2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.GetMatrix");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTexture(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				Texture texture = obj.GetTexture(nameID);
				ToLua.Push(L, texture);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				Material obj2 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name = ToLua.ToString(L, 2);
				Texture texture2 = obj2.GetTexture(name);
				ToLua.Push(L, texture2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.GetTexture");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetFloatArray(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				float[] floatArray = obj.GetFloatArray(nameID);
				ToLua.Push(L, floatArray);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				Material obj2 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name = ToLua.ToString(L, 2);
				float[] floatArray2 = obj2.GetFloatArray(name);
				ToLua.Push(L, floatArray2);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, List<float>>(L, 2))
			{
				Material obj3 = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID2 = (int)LuaDLL.lua_tonumber(L, 2);
				List<float> values = (List<float>)ToLua.ToObject(L, 3);
				obj3.GetFloatArray(nameID2, values);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, List<float>>(L, 2))
			{
				Material obj4 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name2 = ToLua.ToString(L, 2);
				List<float> values2 = (List<float>)ToLua.ToObject(L, 3);
				obj4.GetFloatArray(name2, values2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.GetFloatArray");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetColorArray(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				Color[] colorArray = obj.GetColorArray(nameID);
				ToLua.Push(L, colorArray);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				Material obj2 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name = ToLua.ToString(L, 2);
				Color[] colorArray2 = obj2.GetColorArray(name);
				ToLua.Push(L, colorArray2);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, List<Color>>(L, 2))
			{
				Material obj3 = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID2 = (int)LuaDLL.lua_tonumber(L, 2);
				List<Color> values = (List<Color>)ToLua.ToObject(L, 3);
				obj3.GetColorArray(nameID2, values);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, List<Color>>(L, 2))
			{
				Material obj4 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name2 = ToLua.ToString(L, 2);
				List<Color> values2 = (List<Color>)ToLua.ToObject(L, 3);
				obj4.GetColorArray(name2, values2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.GetColorArray");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetVectorArray(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				Vector4[] vectorArray = obj.GetVectorArray(nameID);
				ToLua.Push(L, vectorArray);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				Material obj2 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name = ToLua.ToString(L, 2);
				Vector4[] vectorArray2 = obj2.GetVectorArray(name);
				ToLua.Push(L, vectorArray2);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, List<Vector4>>(L, 2))
			{
				Material obj3 = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID2 = (int)LuaDLL.lua_tonumber(L, 2);
				List<Vector4> values = (List<Vector4>)ToLua.ToObject(L, 3);
				obj3.GetVectorArray(nameID2, values);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, List<Vector4>>(L, 2))
			{
				Material obj4 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name2 = ToLua.ToString(L, 2);
				List<Vector4> values2 = (List<Vector4>)ToLua.ToObject(L, 3);
				obj4.GetVectorArray(name2, values2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.GetVectorArray");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetMatrixArray(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				Matrix4x4[] matrixArray = obj.GetMatrixArray(nameID);
				ToLua.Push(L, matrixArray);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				Material obj2 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name = ToLua.ToString(L, 2);
				Matrix4x4[] matrixArray2 = obj2.GetMatrixArray(name);
				ToLua.Push(L, matrixArray2);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, List<Matrix4x4>>(L, 2))
			{
				Material obj3 = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID2 = (int)LuaDLL.lua_tonumber(L, 2);
				List<Matrix4x4> values = (List<Matrix4x4>)ToLua.ToObject(L, 3);
				obj3.GetMatrixArray(nameID2, values);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, List<Matrix4x4>>(L, 2))
			{
				Material obj4 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name2 = ToLua.ToString(L, 2);
				List<Matrix4x4> values2 = (List<Matrix4x4>)ToLua.ToObject(L, 3);
				obj4.GetMatrixArray(name2, values2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.GetMatrixArray");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetTextureOffset(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<int, Vector2>(L, 2))
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				Vector2 value = ToLua.ToVector2(L, 3);
				obj.SetTextureOffset(nameID, value);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, Vector2>(L, 2))
			{
				Material obj2 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name = ToLua.ToString(L, 2);
				Vector2 value2 = ToLua.ToVector2(L, 3);
				obj2.SetTextureOffset(name, value2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.SetTextureOffset");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetTextureScale(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<int, Vector2>(L, 2))
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				Vector2 value = ToLua.ToVector2(L, 3);
				obj.SetTextureScale(nameID, value);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, Vector2>(L, 2))
			{
				Material obj2 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name = ToLua.ToString(L, 2);
				Vector2 value2 = ToLua.ToVector2(L, 3);
				obj2.SetTextureScale(name, value2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.SetTextureScale");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTextureOffset(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				Vector2 textureOffset = obj.GetTextureOffset(nameID);
				ToLua.Push(L, textureOffset);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				Material obj2 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name = ToLua.ToString(L, 2);
				Vector2 textureOffset2 = obj2.GetTextureOffset(name);
				ToLua.Push(L, textureOffset2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.GetTextureOffset");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTextureScale(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				Material obj = (Material)ToLua.CheckObject<Material>(L, 1);
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				Vector2 textureScale = obj.GetTextureScale(nameID);
				ToLua.Push(L, textureScale);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				Material obj2 = (Material)ToLua.CheckObject<Material>(L, 1);
				string name = ToLua.ToString(L, 2);
				Vector2 textureScale2 = obj2.GetTextureScale(name);
				ToLua.Push(L, textureScale2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Material.GetTextureScale");
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
	private static int get_shader(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Shader shader = ((Material)obj).shader;
			ToLua.PushSealed(L, shader);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shader on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_color(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Color color = ((Material)obj).color;
			ToLua.Push(L, color);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index color on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mainTexture(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Texture mainTexture = ((Material)obj).mainTexture;
			ToLua.Push(L, mainTexture);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mainTexture on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mainTextureOffset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 mainTextureOffset = ((Material)obj).mainTextureOffset;
			ToLua.Push(L, mainTextureOffset);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mainTextureOffset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mainTextureScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 mainTextureScale = ((Material)obj).mainTextureScale;
			ToLua.Push(L, mainTextureScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mainTextureScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_renderQueue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int renderQueue = ((Material)obj).renderQueue;
			LuaDLL.lua_pushinteger(L, renderQueue);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index renderQueue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_globalIlluminationFlags(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MaterialGlobalIlluminationFlags globalIlluminationFlags = ((Material)obj).globalIlluminationFlags;
			ToLua.Push(L, globalIlluminationFlags);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index globalIlluminationFlags on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_doubleSidedGI(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool doubleSidedGI = ((Material)obj).doubleSidedGI;
			LuaDLL.lua_pushboolean(L, doubleSidedGI);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index doubleSidedGI on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_enableInstancing(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool enableInstancing = ((Material)obj).enableInstancing;
			LuaDLL.lua_pushboolean(L, enableInstancing);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enableInstancing on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_passCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int passCount = ((Material)obj).passCount;
			LuaDLL.lua_pushinteger(L, passCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index passCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_shaderKeywords(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string[] shaderKeywords = ((Material)obj).shaderKeywords;
			ToLua.Push(L, shaderKeywords);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shaderKeywords on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_shader(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Material obj2 = (Material)obj;
			Shader shader = (Shader)ToLua.CheckObject(L, 2, typeof(Shader));
			obj2.shader = shader;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shader on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_color(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Material obj2 = (Material)obj;
			Color color = ToLua.ToColor(L, 2);
			obj2.color = color;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index color on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mainTexture(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Material obj2 = (Material)obj;
			Texture mainTexture = (Texture)ToLua.CheckObject<Texture>(L, 2);
			obj2.mainTexture = mainTexture;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mainTexture on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mainTextureOffset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Material obj2 = (Material)obj;
			Vector2 mainTextureOffset = ToLua.ToVector2(L, 2);
			obj2.mainTextureOffset = mainTextureOffset;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mainTextureOffset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mainTextureScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Material obj2 = (Material)obj;
			Vector2 mainTextureScale = ToLua.ToVector2(L, 2);
			obj2.mainTextureScale = mainTextureScale;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mainTextureScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_renderQueue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Material obj2 = (Material)obj;
			int renderQueue = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.renderQueue = renderQueue;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index renderQueue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_globalIlluminationFlags(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Material obj2 = (Material)obj;
			MaterialGlobalIlluminationFlags globalIlluminationFlags = (MaterialGlobalIlluminationFlags)ToLua.CheckObject(L, 2, typeof(MaterialGlobalIlluminationFlags));
			obj2.globalIlluminationFlags = globalIlluminationFlags;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index globalIlluminationFlags on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_doubleSidedGI(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Material obj2 = (Material)obj;
			bool doubleSidedGI = LuaDLL.luaL_checkboolean(L, 2);
			obj2.doubleSidedGI = doubleSidedGI;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index doubleSidedGI on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_enableInstancing(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Material obj2 = (Material)obj;
			bool enableInstancing = LuaDLL.luaL_checkboolean(L, 2);
			obj2.enableInstancing = enableInstancing;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enableInstancing on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_shaderKeywords(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Material obj2 = (Material)obj;
			string[] shaderKeywords = ToLua.CheckStringArray(L, 2);
			obj2.shaderKeywords = shaderKeywords;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shaderKeywords on a nil value");
		}
	}
}
