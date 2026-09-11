using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;
using UnityEngine.Rendering;

public class UnityEngine_MaterialPropertyBlockWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(MaterialPropertyBlock), typeof(object));
		L.RegFunction("Clear", Clear);
		L.RegFunction("SetInt", SetInt);
		L.RegFunction("SetFloat", SetFloat);
		L.RegFunction("SetInteger", SetInteger);
		L.RegFunction("SetVector", SetVector);
		L.RegFunction("SetColor", SetColor);
		L.RegFunction("SetMatrix", SetMatrix);
		L.RegFunction("SetBuffer", SetBuffer);
		L.RegFunction("SetTexture", SetTexture);
		L.RegFunction("SetConstantBuffer", SetConstantBuffer);
		L.RegFunction("SetFloatArray", SetFloatArray);
		L.RegFunction("SetVectorArray", SetVectorArray);
		L.RegFunction("SetMatrixArray", SetMatrixArray);
		L.RegFunction("HasProperty", HasProperty);
		L.RegFunction("HasInt", HasInt);
		L.RegFunction("HasFloat", HasFloat);
		L.RegFunction("HasInteger", HasInteger);
		L.RegFunction("HasTexture", HasTexture);
		L.RegFunction("HasMatrix", HasMatrix);
		L.RegFunction("HasVector", HasVector);
		L.RegFunction("HasColor", HasColor);
		L.RegFunction("HasBuffer", HasBuffer);
		L.RegFunction("HasConstantBuffer", HasConstantBuffer);
		L.RegFunction("GetFloat", GetFloat);
		L.RegFunction("GetInt", GetInt);
		L.RegFunction("GetInteger", GetInteger);
		L.RegFunction("GetVector", GetVector);
		L.RegFunction("GetColor", GetColor);
		L.RegFunction("GetMatrix", GetMatrix);
		L.RegFunction("GetTexture", GetTexture);
		L.RegFunction("GetFloatArray", GetFloatArray);
		L.RegFunction("GetVectorArray", GetVectorArray);
		L.RegFunction("GetMatrixArray", GetMatrixArray);
		L.RegFunction("CopySHCoefficientArraysFrom", CopySHCoefficientArraysFrom);
		L.RegFunction("CopyProbeOcclusionArrayFrom", CopyProbeOcclusionArrayFrom);
		L.RegFunction("New", _CreateUnityEngine_MaterialPropertyBlock);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("isEmpty", get_isEmpty, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_MaterialPropertyBlock(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				MaterialPropertyBlock o = new MaterialPropertyBlock();
				ToLua.PushSealed(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.MaterialPropertyBlock.New");
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
			ToLua.CheckArgsCount(L, 1);
			((MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock))).Clear();
			return 0;
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
			if (num == 3 && TypeChecker.CheckTypes<string, int>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				int value = (int)LuaDLL.lua_tonumber(L, 3);
				obj.SetInt(name, value);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, int>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				int value2 = (int)LuaDLL.lua_tonumber(L, 3);
				obj2.SetInt(nameID, value2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.SetInt");
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
			if (num == 3 && TypeChecker.CheckTypes<string, float>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				float value = (float)LuaDLL.lua_tonumber(L, 3);
				obj.SetFloat(name, value);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, float>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				float value2 = (float)LuaDLL.lua_tonumber(L, 3);
				obj2.SetFloat(nameID, value2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.SetFloat");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetInteger(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<string, int>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				int value = (int)LuaDLL.lua_tonumber(L, 3);
				obj.SetInteger(name, value);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, int>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				int value2 = (int)LuaDLL.lua_tonumber(L, 3);
				obj2.SetInteger(nameID, value2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.SetInteger");
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
			if (num == 3 && TypeChecker.CheckTypes<string, Vector4>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				Vector4 value = ToLua.ToVector4(L, 3);
				obj.SetVector(name, value);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, Vector4>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				Vector4 value2 = ToLua.ToVector4(L, 3);
				obj2.SetVector(nameID, value2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.SetVector");
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
			if (num == 3 && TypeChecker.CheckTypes<string, Color>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				Color value = ToLua.ToColor(L, 3);
				obj.SetColor(name, value);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, Color>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				Color value2 = ToLua.ToColor(L, 3);
				obj2.SetColor(nameID, value2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.SetColor");
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
			if (num == 3 && TypeChecker.CheckTypes<string, Matrix4x4>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				Matrix4x4 value = StackTraits<Matrix4x4>.To(L, 3);
				obj.SetMatrix(name, value);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, Matrix4x4>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				Matrix4x4 value2 = StackTraits<Matrix4x4>.To(L, 3);
				obj2.SetMatrix(nameID, value2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.SetMatrix");
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
			if (num == 3 && TypeChecker.CheckTypes<string, ComputeBuffer>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				ComputeBuffer value = (ComputeBuffer)ToLua.ToObject(L, 3);
				obj.SetBuffer(name, value);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, ComputeBuffer>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				ComputeBuffer value2 = (ComputeBuffer)ToLua.ToObject(L, 3);
				obj2.SetBuffer(nameID, value2);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, GraphicsBuffer>(L, 2))
			{
				MaterialPropertyBlock obj3 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name2 = ToLua.ToString(L, 2);
				GraphicsBuffer value3 = (GraphicsBuffer)ToLua.ToObject(L, 3);
				obj3.SetBuffer(name2, value3);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, GraphicsBuffer>(L, 2))
			{
				MaterialPropertyBlock obj4 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID2 = (int)LuaDLL.lua_tonumber(L, 2);
				GraphicsBuffer value4 = (GraphicsBuffer)ToLua.ToObject(L, 3);
				obj4.SetBuffer(nameID2, value4);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.SetBuffer");
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
			if (num == 3 && TypeChecker.CheckTypes<string, Texture>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				Texture value = (Texture)ToLua.ToObject(L, 3);
				obj.SetTexture(name, value);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, Texture>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				Texture value2 = (Texture)ToLua.ToObject(L, 3);
				obj2.SetTexture(nameID, value2);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<string, RenderTexture, RenderTextureSubElement>(L, 2))
			{
				MaterialPropertyBlock obj3 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name2 = ToLua.ToString(L, 2);
				RenderTexture value3 = (RenderTexture)ToLua.ToObject(L, 3);
				RenderTextureSubElement element = (RenderTextureSubElement)ToLua.ToObject(L, 4);
				obj3.SetTexture(name2, value3, element);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<int, RenderTexture, RenderTextureSubElement>(L, 2))
			{
				MaterialPropertyBlock obj4 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID2 = (int)LuaDLL.lua_tonumber(L, 2);
				RenderTexture value4 = (RenderTexture)ToLua.ToObject(L, 3);
				RenderTextureSubElement element2 = (RenderTextureSubElement)ToLua.ToObject(L, 4);
				obj4.SetTexture(nameID2, value4, element2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.SetTexture");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetConstantBuffer(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 5 && TypeChecker.CheckTypes<string, ComputeBuffer, int, int>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				ComputeBuffer value = (ComputeBuffer)ToLua.ToObject(L, 3);
				int offset = (int)LuaDLL.lua_tonumber(L, 4);
				int size = (int)LuaDLL.lua_tonumber(L, 5);
				obj.SetConstantBuffer(name, value, offset, size);
				return 0;
			}
			if (num == 5 && TypeChecker.CheckTypes<int, ComputeBuffer, int, int>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				ComputeBuffer value2 = (ComputeBuffer)ToLua.ToObject(L, 3);
				int offset2 = (int)LuaDLL.lua_tonumber(L, 4);
				int size2 = (int)LuaDLL.lua_tonumber(L, 5);
				obj2.SetConstantBuffer(nameID, value2, offset2, size2);
				return 0;
			}
			if (num == 5 && TypeChecker.CheckTypes<string, GraphicsBuffer, int, int>(L, 2))
			{
				MaterialPropertyBlock obj3 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name2 = ToLua.ToString(L, 2);
				GraphicsBuffer value3 = (GraphicsBuffer)ToLua.ToObject(L, 3);
				int offset3 = (int)LuaDLL.lua_tonumber(L, 4);
				int size3 = (int)LuaDLL.lua_tonumber(L, 5);
				obj3.SetConstantBuffer(name2, value3, offset3, size3);
				return 0;
			}
			if (num == 5 && TypeChecker.CheckTypes<int, GraphicsBuffer, int, int>(L, 2))
			{
				MaterialPropertyBlock obj4 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID2 = (int)LuaDLL.lua_tonumber(L, 2);
				GraphicsBuffer value4 = (GraphicsBuffer)ToLua.ToObject(L, 3);
				int offset4 = (int)LuaDLL.lua_tonumber(L, 4);
				int size4 = (int)LuaDLL.lua_tonumber(L, 5);
				obj4.SetConstantBuffer(nameID2, value4, offset4, size4);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.SetConstantBuffer");
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
			if (num == 3 && TypeChecker.CheckTypes<string, List<float>>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				List<float> values = (List<float>)ToLua.ToObject(L, 3);
				obj.SetFloatArray(name, values);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, List<float>>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				List<float> values2 = (List<float>)ToLua.ToObject(L, 3);
				obj2.SetFloatArray(nameID, values2);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, float[]>(L, 2))
			{
				MaterialPropertyBlock obj3 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name2 = ToLua.ToString(L, 2);
				float[] values3 = ToLua.ToNumberArray<float>(L, 3);
				obj3.SetFloatArray(name2, values3);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, float[]>(L, 2))
			{
				MaterialPropertyBlock obj4 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID2 = (int)LuaDLL.lua_tonumber(L, 2);
				float[] values4 = ToLua.ToNumberArray<float>(L, 3);
				obj4.SetFloatArray(nameID2, values4);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.SetFloatArray");
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
			if (num == 3 && TypeChecker.CheckTypes<string, List<Vector4>>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				List<Vector4> values = (List<Vector4>)ToLua.ToObject(L, 3);
				obj.SetVectorArray(name, values);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, List<Vector4>>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				List<Vector4> values2 = (List<Vector4>)ToLua.ToObject(L, 3);
				obj2.SetVectorArray(nameID, values2);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, Vector4[]>(L, 2))
			{
				MaterialPropertyBlock obj3 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name2 = ToLua.ToString(L, 2);
				Vector4[] values3 = ToLua.ToStructArray<Vector4>(L, 3);
				obj3.SetVectorArray(name2, values3);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, Vector4[]>(L, 2))
			{
				MaterialPropertyBlock obj4 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID2 = (int)LuaDLL.lua_tonumber(L, 2);
				Vector4[] values4 = ToLua.ToStructArray<Vector4>(L, 3);
				obj4.SetVectorArray(nameID2, values4);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.SetVectorArray");
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
			if (num == 3 && TypeChecker.CheckTypes<string, List<Matrix4x4>>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				List<Matrix4x4> values = (List<Matrix4x4>)ToLua.ToObject(L, 3);
				obj.SetMatrixArray(name, values);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, List<Matrix4x4>>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				List<Matrix4x4> values2 = (List<Matrix4x4>)ToLua.ToObject(L, 3);
				obj2.SetMatrixArray(nameID, values2);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, Matrix4x4[]>(L, 2))
			{
				MaterialPropertyBlock obj3 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name2 = ToLua.ToString(L, 2);
				Matrix4x4[] values3 = ToLua.ToStructArray<Matrix4x4>(L, 3);
				obj3.SetMatrixArray(name2, values3);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, Matrix4x4[]>(L, 2))
			{
				MaterialPropertyBlock obj4 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID2 = (int)LuaDLL.lua_tonumber(L, 2);
				Matrix4x4[] values4 = ToLua.ToStructArray<Matrix4x4>(L, 3);
				obj4.SetMatrixArray(nameID2, values4);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.SetMatrixArray");
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
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				bool value = obj.HasProperty(name);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				bool value2 = obj2.HasProperty(nameID);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.HasProperty");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HasInt(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				bool value = obj.HasInt(name);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				bool value2 = obj2.HasInt(nameID);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.HasInt");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HasFloat(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				bool value = obj.HasFloat(name);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				bool value2 = obj2.HasFloat(nameID);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.HasFloat");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HasInteger(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				bool value = obj.HasInteger(name);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				bool value2 = obj2.HasInteger(nameID);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.HasInteger");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HasTexture(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				bool value = obj.HasTexture(name);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				bool value2 = obj2.HasTexture(nameID);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.HasTexture");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HasMatrix(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				bool value = obj.HasMatrix(name);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				bool value2 = obj2.HasMatrix(nameID);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.HasMatrix");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HasVector(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				bool value = obj.HasVector(name);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				bool value2 = obj2.HasVector(nameID);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.HasVector");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HasColor(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				bool value = obj.HasColor(name);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				bool value2 = obj2.HasColor(nameID);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.HasColor");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HasBuffer(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				bool value = obj.HasBuffer(name);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				bool value2 = obj2.HasBuffer(nameID);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.HasBuffer");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HasConstantBuffer(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				bool value = obj.HasConstantBuffer(name);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				bool value2 = obj2.HasConstantBuffer(nameID);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.HasConstantBuffer");
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
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				float num2 = obj.GetFloat(name);
				LuaDLL.lua_pushnumber(L, num2);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				float num3 = obj2.GetFloat(nameID);
				LuaDLL.lua_pushnumber(L, num3);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.GetFloat");
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
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				int n = obj.GetInt(name);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				int n2 = obj2.GetInt(nameID);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.GetInt");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetInteger(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				int integer = obj.GetInteger(name);
				LuaDLL.lua_pushinteger(L, integer);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				int integer2 = obj2.GetInteger(nameID);
				LuaDLL.lua_pushinteger(L, integer2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.GetInteger");
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
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				Vector4 vector = obj.GetVector(name);
				ToLua.Push(L, vector);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				Vector4 vector2 = obj2.GetVector(nameID);
				ToLua.Push(L, vector2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.GetVector");
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
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				Color color = obj.GetColor(name);
				ToLua.Push(L, color);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				Color color2 = obj2.GetColor(nameID);
				ToLua.Push(L, color2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.GetColor");
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
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				Matrix4x4 matrix = obj.GetMatrix(name);
				ToLua.PushValue(L, matrix);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				Matrix4x4 matrix2 = obj2.GetMatrix(nameID);
				ToLua.PushValue(L, matrix2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.GetMatrix");
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
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				Texture texture = obj.GetTexture(name);
				ToLua.Push(L, texture);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				Texture texture2 = obj2.GetTexture(nameID);
				ToLua.Push(L, texture2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.GetTexture");
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
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				float[] floatArray = obj.GetFloatArray(name);
				ToLua.Push(L, floatArray);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				float[] floatArray2 = obj2.GetFloatArray(nameID);
				ToLua.Push(L, floatArray2);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, List<float>>(L, 2))
			{
				MaterialPropertyBlock obj3 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name2 = ToLua.ToString(L, 2);
				List<float> values = (List<float>)ToLua.ToObject(L, 3);
				obj3.GetFloatArray(name2, values);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, List<float>>(L, 2))
			{
				MaterialPropertyBlock obj4 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID2 = (int)LuaDLL.lua_tonumber(L, 2);
				List<float> values2 = (List<float>)ToLua.ToObject(L, 3);
				obj4.GetFloatArray(nameID2, values2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.GetFloatArray");
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
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				Vector4[] vectorArray = obj.GetVectorArray(name);
				ToLua.Push(L, vectorArray);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				Vector4[] vectorArray2 = obj2.GetVectorArray(nameID);
				ToLua.Push(L, vectorArray2);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, List<Vector4>>(L, 2))
			{
				MaterialPropertyBlock obj3 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name2 = ToLua.ToString(L, 2);
				List<Vector4> values = (List<Vector4>)ToLua.ToObject(L, 3);
				obj3.GetVectorArray(name2, values);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, List<Vector4>>(L, 2))
			{
				MaterialPropertyBlock obj4 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID2 = (int)LuaDLL.lua_tonumber(L, 2);
				List<Vector4> values2 = (List<Vector4>)ToLua.ToObject(L, 3);
				obj4.GetVectorArray(nameID2, values2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.GetVectorArray");
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
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name = ToLua.ToString(L, 2);
				Matrix4x4[] matrixArray = obj.GetMatrixArray(name);
				ToLua.Push(L, matrixArray);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID = (int)LuaDLL.lua_tonumber(L, 2);
				Matrix4x4[] matrixArray2 = obj2.GetMatrixArray(nameID);
				ToLua.Push(L, matrixArray2);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, List<Matrix4x4>>(L, 2))
			{
				MaterialPropertyBlock obj3 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				string name2 = ToLua.ToString(L, 2);
				List<Matrix4x4> values = (List<Matrix4x4>)ToLua.ToObject(L, 3);
				obj3.GetMatrixArray(name2, values);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, List<Matrix4x4>>(L, 2))
			{
				MaterialPropertyBlock obj4 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				int nameID2 = (int)LuaDLL.lua_tonumber(L, 2);
				List<Matrix4x4> values2 = (List<Matrix4x4>)ToLua.ToObject(L, 3);
				obj4.GetMatrixArray(nameID2, values2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.GetMatrixArray");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CopySHCoefficientArraysFrom(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<List<SphericalHarmonicsL2>>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				List<SphericalHarmonicsL2> lightProbes = (List<SphericalHarmonicsL2>)ToLua.ToObject(L, 2);
				obj.CopySHCoefficientArraysFrom(lightProbes);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<SphericalHarmonicsL2[]>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				SphericalHarmonicsL2[] lightProbes2 = ToLua.ToStructArray<SphericalHarmonicsL2>(L, 2);
				obj2.CopySHCoefficientArraysFrom(lightProbes2);
				return 0;
			}
			if (num == 5 && TypeChecker.CheckTypes<List<SphericalHarmonicsL2>, int, int, int>(L, 2))
			{
				MaterialPropertyBlock obj3 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				List<SphericalHarmonicsL2> lightProbes3 = (List<SphericalHarmonicsL2>)ToLua.ToObject(L, 2);
				int sourceStart = (int)LuaDLL.lua_tonumber(L, 3);
				int destStart = (int)LuaDLL.lua_tonumber(L, 4);
				int count = (int)LuaDLL.lua_tonumber(L, 5);
				obj3.CopySHCoefficientArraysFrom(lightProbes3, sourceStart, destStart, count);
				return 0;
			}
			if (num == 5 && TypeChecker.CheckTypes<SphericalHarmonicsL2[], int, int, int>(L, 2))
			{
				MaterialPropertyBlock obj4 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				SphericalHarmonicsL2[] lightProbes4 = ToLua.ToStructArray<SphericalHarmonicsL2>(L, 2);
				int sourceStart2 = (int)LuaDLL.lua_tonumber(L, 3);
				int destStart2 = (int)LuaDLL.lua_tonumber(L, 4);
				int count2 = (int)LuaDLL.lua_tonumber(L, 5);
				obj4.CopySHCoefficientArraysFrom(lightProbes4, sourceStart2, destStart2, count2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.CopySHCoefficientArraysFrom");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CopyProbeOcclusionArrayFrom(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<List<Vector4>>(L, 2))
			{
				MaterialPropertyBlock obj = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				List<Vector4> occlusionProbes = (List<Vector4>)ToLua.ToObject(L, 2);
				obj.CopyProbeOcclusionArrayFrom(occlusionProbes);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<Vector4[]>(L, 2))
			{
				MaterialPropertyBlock obj2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				Vector4[] occlusionProbes2 = ToLua.ToStructArray<Vector4>(L, 2);
				obj2.CopyProbeOcclusionArrayFrom(occlusionProbes2);
				return 0;
			}
			if (num == 5 && TypeChecker.CheckTypes<List<Vector4>, int, int, int>(L, 2))
			{
				MaterialPropertyBlock obj3 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				List<Vector4> occlusionProbes3 = (List<Vector4>)ToLua.ToObject(L, 2);
				int sourceStart = (int)LuaDLL.lua_tonumber(L, 3);
				int destStart = (int)LuaDLL.lua_tonumber(L, 4);
				int count = (int)LuaDLL.lua_tonumber(L, 5);
				obj3.CopyProbeOcclusionArrayFrom(occlusionProbes3, sourceStart, destStart, count);
				return 0;
			}
			if (num == 5 && TypeChecker.CheckTypes<Vector4[], int, int, int>(L, 2))
			{
				MaterialPropertyBlock obj4 = (MaterialPropertyBlock)ToLua.CheckObject(L, 1, typeof(MaterialPropertyBlock));
				Vector4[] occlusionProbes4 = ToLua.ToStructArray<Vector4>(L, 2);
				int sourceStart2 = (int)LuaDLL.lua_tonumber(L, 3);
				int destStart2 = (int)LuaDLL.lua_tonumber(L, 4);
				int count2 = (int)LuaDLL.lua_tonumber(L, 5);
				obj4.CopyProbeOcclusionArrayFrom(occlusionProbes4, sourceStart2, destStart2, count2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.MaterialPropertyBlock.CopyProbeOcclusionArrayFrom");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isEmpty(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isEmpty = ((MaterialPropertyBlock)obj).isEmpty;
			LuaDLL.lua_pushboolean(L, isEmpty);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isEmpty on a nil value");
		}
	}
}
