using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;
using UnityEngine.Rendering;

public class UnityEngine_MeshWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Mesh), typeof(UnityEngine.Object));
		L.RegFunction("GetNativeVertexBufferPtr", GetNativeVertexBufferPtr);
		L.RegFunction("GetNativeIndexBufferPtr", GetNativeIndexBufferPtr);
		L.RegFunction("ClearBlendShapes", ClearBlendShapes);
		L.RegFunction("GetBlendShapeName", GetBlendShapeName);
		L.RegFunction("GetBlendShapeIndex", GetBlendShapeIndex);
		L.RegFunction("GetBlendShapeFrameCount", GetBlendShapeFrameCount);
		L.RegFunction("GetBlendShapeFrameWeight", GetBlendShapeFrameWeight);
		L.RegFunction("GetBlendShapeFrameVertices", GetBlendShapeFrameVertices);
		L.RegFunction("AddBlendShapeFrame", AddBlendShapeFrame);
		L.RegFunction("GetUVDistributionMetric", GetUVDistributionMetric);
		L.RegFunction("GetVertices", GetVertices);
		L.RegFunction("SetVertices", SetVertices);
		L.RegFunction("GetNormals", GetNormals);
		L.RegFunction("SetNormals", SetNormals);
		L.RegFunction("GetTangents", GetTangents);
		L.RegFunction("SetTangents", SetTangents);
		L.RegFunction("GetColors", GetColors);
		L.RegFunction("SetColors", SetColors);
		L.RegFunction("SetUVs", SetUVs);
		L.RegFunction("GetUVs", GetUVs);
		L.RegFunction("GetTriangles", GetTriangles);
		L.RegFunction("GetIndices", GetIndices);
		L.RegFunction("GetIndexStart", GetIndexStart);
		L.RegFunction("GetIndexCount", GetIndexCount);
		L.RegFunction("GetBaseVertex", GetBaseVertex);
		L.RegFunction("SetTriangles", SetTriangles);
		L.RegFunction("SetIndices", SetIndices);
		L.RegFunction("GetBindposes", GetBindposes);
		L.RegFunction("GetBoneWeights", GetBoneWeights);
		L.RegFunction("Clear", Clear);
		L.RegFunction("RecalculateBounds", RecalculateBounds);
		L.RegFunction("RecalculateNormals", RecalculateNormals);
		L.RegFunction("RecalculateTangents", RecalculateTangents);
		L.RegFunction("MarkDynamic", MarkDynamic);
		L.RegFunction("UploadMeshData", UploadMeshData);
		L.RegFunction("GetTopology", GetTopology);
		L.RegFunction("CombineMeshes", CombineMeshes);
		L.RegFunction("New", _CreateUnityEngine_Mesh);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("indexFormat", get_indexFormat, set_indexFormat);
		L.RegVar("vertexBufferCount", get_vertexBufferCount, null);
		L.RegVar("blendShapeCount", get_blendShapeCount, null);
		L.RegVar("boneWeights", get_boneWeights, set_boneWeights);
		L.RegVar("bindposes", get_bindposes, set_bindposes);
		L.RegVar("isReadable", get_isReadable, null);
		L.RegVar("vertexCount", get_vertexCount, null);
		L.RegVar("subMeshCount", get_subMeshCount, set_subMeshCount);
		L.RegVar("bounds", get_bounds, set_bounds);
		L.RegVar("vertices", get_vertices, set_vertices);
		L.RegVar("normals", get_normals, set_normals);
		L.RegVar("tangents", get_tangents, set_tangents);
		L.RegVar("uv", get_uv, set_uv);
		L.RegVar("uv2", get_uv2, set_uv2);
		L.RegVar("uv3", get_uv3, set_uv3);
		L.RegVar("uv4", get_uv4, set_uv4);
		L.RegVar("uv5", get_uv5, set_uv5);
		L.RegVar("uv6", get_uv6, set_uv6);
		L.RegVar("uv7", get_uv7, set_uv7);
		L.RegVar("uv8", get_uv8, set_uv8);
		L.RegVar("colors", get_colors, set_colors);
		L.RegVar("colors32", get_colors32, set_colors32);
		L.RegVar("triangles", get_triangles, set_triangles);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_Mesh(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				Mesh o = new Mesh();
				ToLua.PushSealed(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.Mesh.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetNativeVertexBufferPtr(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			IntPtr nativeVertexBufferPtr = obj.GetNativeVertexBufferPtr(index);
			LuaDLL.lua_pushlightuserdata(L, nativeVertexBufferPtr);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetNativeIndexBufferPtr(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			IntPtr nativeIndexBufferPtr = ((Mesh)ToLua.CheckObject(L, 1, typeof(Mesh))).GetNativeIndexBufferPtr();
			LuaDLL.lua_pushlightuserdata(L, nativeIndexBufferPtr);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearBlendShapes(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Mesh)ToLua.CheckObject(L, 1, typeof(Mesh))).ClearBlendShapes();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetBlendShapeName(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
			int shapeIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			string blendShapeName = obj.GetBlendShapeName(shapeIndex);
			LuaDLL.lua_pushstring(L, blendShapeName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetBlendShapeIndex(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
			string blendShapeName = ToLua.CheckString(L, 2);
			int blendShapeIndex = obj.GetBlendShapeIndex(blendShapeName);
			LuaDLL.lua_pushinteger(L, blendShapeIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetBlendShapeFrameCount(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
			int shapeIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			int blendShapeFrameCount = obj.GetBlendShapeFrameCount(shapeIndex);
			LuaDLL.lua_pushinteger(L, blendShapeFrameCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetBlendShapeFrameWeight(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
			int shapeIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			int frameIndex = (int)LuaDLL.luaL_checknumber(L, 3);
			float blendShapeFrameWeight = obj.GetBlendShapeFrameWeight(shapeIndex, frameIndex);
			LuaDLL.lua_pushnumber(L, blendShapeFrameWeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetBlendShapeFrameVertices(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 6);
			Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
			int shapeIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			int frameIndex = (int)LuaDLL.luaL_checknumber(L, 3);
			Vector3[] deltaVertices = ToLua.CheckStructArray<Vector3>(L, 4);
			Vector3[] deltaNormals = ToLua.CheckStructArray<Vector3>(L, 5);
			Vector3[] deltaTangents = ToLua.CheckStructArray<Vector3>(L, 6);
			obj.GetBlendShapeFrameVertices(shapeIndex, frameIndex, deltaVertices, deltaNormals, deltaTangents);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddBlendShapeFrame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 6);
			Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
			string shapeName = ToLua.CheckString(L, 2);
			float frameWeight = (float)LuaDLL.luaL_checknumber(L, 3);
			Vector3[] deltaVertices = ToLua.CheckStructArray<Vector3>(L, 4);
			Vector3[] deltaNormals = ToLua.CheckStructArray<Vector3>(L, 5);
			Vector3[] deltaTangents = ToLua.CheckStructArray<Vector3>(L, 6);
			obj.AddBlendShapeFrame(shapeName, frameWeight, deltaVertices, deltaNormals, deltaTangents);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetUVDistributionMetric(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
			int uvSetIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			float uVDistributionMetric = obj.GetUVDistributionMetric(uvSetIndex);
			LuaDLL.lua_pushnumber(L, uVDistributionMetric);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetVertices(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
			List<Vector3> vertices = (List<Vector3>)ToLua.CheckObject(L, 2, typeof(List<Vector3>));
			obj.GetVertices(vertices);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetVertices(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
			List<Vector3> vertices = (List<Vector3>)ToLua.CheckObject(L, 2, typeof(List<Vector3>));
			obj.SetVertices(vertices);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetNormals(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
			List<Vector3> normals = (List<Vector3>)ToLua.CheckObject(L, 2, typeof(List<Vector3>));
			obj.GetNormals(normals);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetNormals(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
			List<Vector3> normals = (List<Vector3>)ToLua.CheckObject(L, 2, typeof(List<Vector3>));
			obj.SetNormals(normals);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTangents(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
			List<Vector4> tangents = (List<Vector4>)ToLua.CheckObject(L, 2, typeof(List<Vector4>));
			obj.GetTangents(tangents);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetTangents(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
			List<Vector4> tangents = (List<Vector4>)ToLua.CheckObject(L, 2, typeof(List<Vector4>));
			obj.SetTangents(tangents);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetColors(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<List<Color>>(L, 2))
			{
				Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				List<Color> colors = (List<Color>)ToLua.ToObject(L, 2);
				obj.GetColors(colors);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<List<Color32>>(L, 2))
			{
				Mesh obj2 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				List<Color32> colors2 = (List<Color32>)ToLua.ToObject(L, 2);
				obj2.GetColors(colors2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Mesh.GetColors");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetColors(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<List<Color>>(L, 2))
			{
				Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				List<Color> colors = (List<Color>)ToLua.ToObject(L, 2);
				obj.SetColors(colors);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<List<Color32>>(L, 2))
			{
				Mesh obj2 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				List<Color32> colors2 = (List<Color32>)ToLua.ToObject(L, 2);
				obj2.SetColors(colors2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Mesh.SetColors");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetUVs(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<List<Vector2>>(L, 3))
			{
				Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				int channel = (int)LuaDLL.luaL_checknumber(L, 2);
				List<Vector2> uvs = (List<Vector2>)ToLua.ToObject(L, 3);
				obj.SetUVs(channel, uvs);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<List<Vector3>>(L, 3))
			{
				Mesh obj2 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				int channel2 = (int)LuaDLL.luaL_checknumber(L, 2);
				List<Vector3> uvs2 = (List<Vector3>)ToLua.ToObject(L, 3);
				obj2.SetUVs(channel2, uvs2);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<List<Vector4>>(L, 3))
			{
				Mesh obj3 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				int channel3 = (int)LuaDLL.luaL_checknumber(L, 2);
				List<Vector4> uvs3 = (List<Vector4>)ToLua.ToObject(L, 3);
				obj3.SetUVs(channel3, uvs3);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Mesh.SetUVs");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetUVs(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<List<Vector2>>(L, 3))
			{
				Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				int channel = (int)LuaDLL.luaL_checknumber(L, 2);
				List<Vector2> uvs = (List<Vector2>)ToLua.ToObject(L, 3);
				obj.GetUVs(channel, uvs);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<List<Vector3>>(L, 3))
			{
				Mesh obj2 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				int channel2 = (int)LuaDLL.luaL_checknumber(L, 2);
				List<Vector3> uvs2 = (List<Vector3>)ToLua.ToObject(L, 3);
				obj2.GetUVs(channel2, uvs2);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<List<Vector4>>(L, 3))
			{
				Mesh obj3 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				int channel3 = (int)LuaDLL.luaL_checknumber(L, 2);
				List<Vector4> uvs3 = (List<Vector4>)ToLua.ToObject(L, 3);
				obj3.GetUVs(channel3, uvs3);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Mesh.GetUVs");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTriangles(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 2:
			{
				Mesh obj2 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				int submesh2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int[] triangles2 = obj2.GetTriangles(submesh2);
				ToLua.Push(L, triangles2);
				return 1;
			}
			case 3:
				if (TypeChecker.CheckTypes<int, bool>(L, 2))
				{
					Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
					int submesh = (int)LuaDLL.lua_tonumber(L, 2);
					bool applyBaseVertex = LuaDLL.lua_toboolean(L, 3);
					int[] triangles = obj.GetTriangles(submesh, applyBaseVertex);
					ToLua.Push(L, triangles);
					return 1;
				}
				break;
			}
			if (num == 3 && TypeChecker.CheckTypes<List<int>, int>(L, 2))
			{
				Mesh obj3 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				List<int> triangles3 = (List<int>)ToLua.ToObject(L, 2);
				int submesh3 = (int)LuaDLL.lua_tonumber(L, 3);
				obj3.GetTriangles(triangles3, submesh3);
				return 0;
			}
			if (num == 4)
			{
				Mesh obj4 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				List<int> triangles4 = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
				int submesh4 = (int)LuaDLL.luaL_checknumber(L, 3);
				bool applyBaseVertex2 = LuaDLL.luaL_checkboolean(L, 4);
				obj4.GetTriangles(triangles4, submesh4, applyBaseVertex2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Mesh.GetTriangles");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetIndices(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 2:
			{
				Mesh obj2 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				int submesh2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int[] indices2 = obj2.GetIndices(submesh2);
				ToLua.Push(L, indices2);
				return 1;
			}
			case 3:
				if (TypeChecker.CheckTypes<int, bool>(L, 2))
				{
					Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
					int submesh = (int)LuaDLL.lua_tonumber(L, 2);
					bool applyBaseVertex = LuaDLL.lua_toboolean(L, 3);
					int[] indices = obj.GetIndices(submesh, applyBaseVertex);
					ToLua.Push(L, indices);
					return 1;
				}
				break;
			}
			if (num == 3 && TypeChecker.CheckTypes<List<int>, int>(L, 2))
			{
				Mesh obj3 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				List<int> indices3 = (List<int>)ToLua.ToObject(L, 2);
				int submesh3 = (int)LuaDLL.lua_tonumber(L, 3);
				obj3.GetIndices(indices3, submesh3);
				return 0;
			}
			if (num == 4)
			{
				Mesh obj4 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				List<int> indices4 = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
				int submesh4 = (int)LuaDLL.luaL_checknumber(L, 3);
				bool applyBaseVertex2 = LuaDLL.luaL_checkboolean(L, 4);
				obj4.GetIndices(indices4, submesh4, applyBaseVertex2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Mesh.GetIndices");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetIndexStart(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
			int submesh = (int)LuaDLL.luaL_checknumber(L, 2);
			uint indexStart = obj.GetIndexStart(submesh);
			LuaDLL.lua_pushnumber(L, indexStart);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetIndexCount(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
			int submesh = (int)LuaDLL.luaL_checknumber(L, 2);
			uint indexCount = obj.GetIndexCount(submesh);
			LuaDLL.lua_pushnumber(L, indexCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetBaseVertex(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
			int submesh = (int)LuaDLL.luaL_checknumber(L, 2);
			uint baseVertex = obj.GetBaseVertex(submesh);
			LuaDLL.lua_pushnumber(L, baseVertex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetTriangles(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<int[], int>(L, 2))
			{
				Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				int[] triangles = ToLua.ToNumberArray<int>(L, 2);
				int submesh = (int)LuaDLL.lua_tonumber(L, 3);
				obj.SetTriangles(triangles, submesh);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<List<int>, int>(L, 2))
			{
				Mesh obj2 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				List<int> triangles2 = (List<int>)ToLua.ToObject(L, 2);
				int submesh2 = (int)LuaDLL.lua_tonumber(L, 3);
				obj2.SetTriangles(triangles2, submesh2);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<int[], int, bool>(L, 2))
			{
				Mesh obj3 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				int[] triangles3 = ToLua.ToNumberArray<int>(L, 2);
				int submesh3 = (int)LuaDLL.lua_tonumber(L, 3);
				bool calculateBounds = LuaDLL.lua_toboolean(L, 4);
				obj3.SetTriangles(triangles3, submesh3, calculateBounds);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<List<int>, int, bool>(L, 2))
			{
				Mesh obj4 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				List<int> triangles4 = (List<int>)ToLua.ToObject(L, 2);
				int submesh4 = (int)LuaDLL.lua_tonumber(L, 3);
				bool calculateBounds2 = LuaDLL.lua_toboolean(L, 4);
				obj4.SetTriangles(triangles4, submesh4, calculateBounds2);
				return 0;
			}
			if (num == 5 && TypeChecker.CheckTypes<int[], int, bool, int>(L, 2))
			{
				Mesh obj5 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				int[] triangles5 = ToLua.ToNumberArray<int>(L, 2);
				int submesh5 = (int)LuaDLL.lua_tonumber(L, 3);
				bool calculateBounds3 = LuaDLL.lua_toboolean(L, 4);
				int baseVertex = (int)LuaDLL.lua_tonumber(L, 5);
				obj5.SetTriangles(triangles5, submesh5, calculateBounds3, baseVertex);
				return 0;
			}
			if (num == 5 && TypeChecker.CheckTypes<List<int>, int, bool, int>(L, 2))
			{
				Mesh obj6 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				List<int> triangles6 = (List<int>)ToLua.ToObject(L, 2);
				int submesh6 = (int)LuaDLL.lua_tonumber(L, 3);
				bool calculateBounds4 = LuaDLL.lua_toboolean(L, 4);
				int baseVertex2 = (int)LuaDLL.lua_tonumber(L, 5);
				obj6.SetTriangles(triangles6, submesh6, calculateBounds4, baseVertex2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Mesh.SetTriangles");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetIndices(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 4:
			{
				Mesh obj3 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				int[] indices3 = ToLua.CheckNumberArray<int>(L, 2);
				MeshTopology topology3 = (MeshTopology)ToLua.CheckObject(L, 3, typeof(MeshTopology));
				int submesh3 = (int)LuaDLL.luaL_checknumber(L, 4);
				obj3.SetIndices(indices3, topology3, submesh3);
				return 0;
			}
			case 5:
			{
				Mesh obj2 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				int[] indices2 = ToLua.CheckNumberArray<int>(L, 2);
				MeshTopology topology2 = (MeshTopology)ToLua.CheckObject(L, 3, typeof(MeshTopology));
				int submesh2 = (int)LuaDLL.luaL_checknumber(L, 4);
				bool calculateBounds2 = LuaDLL.luaL_checkboolean(L, 5);
				obj2.SetIndices(indices2, topology2, submesh2, calculateBounds2);
				return 0;
			}
			case 6:
			{
				Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				int[] indices = ToLua.CheckNumberArray<int>(L, 2);
				MeshTopology topology = (MeshTopology)ToLua.CheckObject(L, 3, typeof(MeshTopology));
				int submesh = (int)LuaDLL.luaL_checknumber(L, 4);
				bool calculateBounds = LuaDLL.luaL_checkboolean(L, 5);
				int baseVertex = (int)LuaDLL.luaL_checknumber(L, 6);
				obj.SetIndices(indices, topology, submesh, calculateBounds, baseVertex);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Mesh.SetIndices");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetBindposes(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
			List<Matrix4x4> bindposes = (List<Matrix4x4>)ToLua.CheckObject(L, 2, typeof(List<Matrix4x4>));
			obj.GetBindposes(bindposes);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetBoneWeights(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
			List<BoneWeight> boneWeights = (List<BoneWeight>)ToLua.CheckObject(L, 2, typeof(List<BoneWeight>));
			obj.GetBoneWeights(boneWeights);
			return 0;
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
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((Mesh)ToLua.CheckObject(L, 1, typeof(Mesh))).Clear();
				return 0;
			case 2:
			{
				Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				bool keepVertexLayout = LuaDLL.luaL_checkboolean(L, 2);
				obj.Clear(keepVertexLayout);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Mesh.Clear");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RecalculateBounds(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Mesh)ToLua.CheckObject(L, 1, typeof(Mesh))).RecalculateBounds();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RecalculateNormals(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Mesh)ToLua.CheckObject(L, 1, typeof(Mesh))).RecalculateNormals();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RecalculateTangents(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Mesh)ToLua.CheckObject(L, 1, typeof(Mesh))).RecalculateTangents();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MarkDynamic(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Mesh)ToLua.CheckObject(L, 1, typeof(Mesh))).MarkDynamic();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UploadMeshData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
			bool markNoLongerReadable = LuaDLL.luaL_checkboolean(L, 2);
			obj.UploadMeshData(markNoLongerReadable);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTopology(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
			int submesh = (int)LuaDLL.luaL_checknumber(L, 2);
			MeshTopology topology = obj.GetTopology(submesh);
			ToLua.Push(L, topology);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CombineMeshes(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Mesh obj4 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				CombineInstance[] combine4 = ToLua.CheckStructArray<CombineInstance>(L, 2);
				obj4.CombineMeshes(combine4);
				return 0;
			}
			case 3:
			{
				Mesh obj3 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				CombineInstance[] combine3 = ToLua.CheckStructArray<CombineInstance>(L, 2);
				bool mergeSubMeshes3 = LuaDLL.luaL_checkboolean(L, 3);
				obj3.CombineMeshes(combine3, mergeSubMeshes3);
				return 0;
			}
			case 4:
			{
				Mesh obj2 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				CombineInstance[] combine2 = ToLua.CheckStructArray<CombineInstance>(L, 2);
				bool mergeSubMeshes2 = LuaDLL.luaL_checkboolean(L, 3);
				bool useMatrices2 = LuaDLL.luaL_checkboolean(L, 4);
				obj2.CombineMeshes(combine2, mergeSubMeshes2, useMatrices2);
				return 0;
			}
			case 5:
			{
				Mesh obj = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				CombineInstance[] combine = ToLua.CheckStructArray<CombineInstance>(L, 2);
				bool mergeSubMeshes = LuaDLL.luaL_checkboolean(L, 3);
				bool useMatrices = LuaDLL.luaL_checkboolean(L, 4);
				bool hasLightmapData = LuaDLL.luaL_checkboolean(L, 5);
				obj.CombineMeshes(combine, mergeSubMeshes, useMatrices, hasLightmapData);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Mesh.CombineMeshes");
			}
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
	private static int get_indexFormat(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			IndexFormat indexFormat = ((Mesh)obj).indexFormat;
			ToLua.Push(L, indexFormat);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index indexFormat on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_vertexBufferCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int vertexBufferCount = ((Mesh)obj).vertexBufferCount;
			LuaDLL.lua_pushinteger(L, vertexBufferCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index vertexBufferCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_blendShapeCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int blendShapeCount = ((Mesh)obj).blendShapeCount;
			LuaDLL.lua_pushinteger(L, blendShapeCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blendShapeCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_boneWeights(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BoneWeight[] boneWeights = ((Mesh)obj).boneWeights;
			ToLua.Push(L, boneWeights);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index boneWeights on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bindposes(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Matrix4x4[] bindposes = ((Mesh)obj).bindposes;
			ToLua.Push(L, bindposes);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bindposes on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isReadable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isReadable = ((Mesh)obj).isReadable;
			LuaDLL.lua_pushboolean(L, isReadable);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isReadable on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_vertexCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int vertexCount = ((Mesh)obj).vertexCount;
			LuaDLL.lua_pushinteger(L, vertexCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index vertexCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_subMeshCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int subMeshCount = ((Mesh)obj).subMeshCount;
			LuaDLL.lua_pushinteger(L, subMeshCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index subMeshCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bounds(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Bounds bounds = ((Mesh)obj).bounds;
			ToLua.Push(L, bounds);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bounds on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_vertices(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3[] vertices = ((Mesh)obj).vertices;
			ToLua.Push(L, vertices);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index vertices on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_normals(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3[] normals = ((Mesh)obj).normals;
			ToLua.Push(L, normals);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index normals on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_tangents(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector4[] tangents = ((Mesh)obj).tangents;
			ToLua.Push(L, tangents);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tangents on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_uv(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2[] uv = ((Mesh)obj).uv;
			ToLua.Push(L, uv);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uv on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_uv2(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2[] uv = ((Mesh)obj).uv2;
			ToLua.Push(L, uv);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uv2 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_uv3(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2[] uv = ((Mesh)obj).uv3;
			ToLua.Push(L, uv);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uv3 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_uv4(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2[] uv = ((Mesh)obj).uv4;
			ToLua.Push(L, uv);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uv4 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_uv5(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2[] uv = ((Mesh)obj).uv5;
			ToLua.Push(L, uv);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uv5 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_uv6(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2[] uv = ((Mesh)obj).uv6;
			ToLua.Push(L, uv);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uv6 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_uv7(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2[] uv = ((Mesh)obj).uv7;
			ToLua.Push(L, uv);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uv7 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_uv8(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2[] uv = ((Mesh)obj).uv8;
			ToLua.Push(L, uv);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uv8 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_colors(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Color[] colors = ((Mesh)obj).colors;
			ToLua.Push(L, colors);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index colors on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_colors32(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Color32[] colors = ((Mesh)obj).colors32;
			ToLua.Push(L, colors);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index colors32 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_triangles(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] triangles = ((Mesh)obj).triangles;
			ToLua.Push(L, triangles);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index triangles on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_indexFormat(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Mesh obj2 = (Mesh)obj;
			IndexFormat indexFormat = (IndexFormat)ToLua.CheckObject(L, 2, typeof(IndexFormat));
			obj2.indexFormat = indexFormat;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index indexFormat on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_boneWeights(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Mesh obj2 = (Mesh)obj;
			BoneWeight[] boneWeights = ToLua.CheckStructArray<BoneWeight>(L, 2);
			obj2.boneWeights = boneWeights;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index boneWeights on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bindposes(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Mesh obj2 = (Mesh)obj;
			Matrix4x4[] bindposes = ToLua.CheckStructArray<Matrix4x4>(L, 2);
			obj2.bindposes = bindposes;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bindposes on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_subMeshCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Mesh obj2 = (Mesh)obj;
			int subMeshCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.subMeshCount = subMeshCount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index subMeshCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bounds(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Mesh obj2 = (Mesh)obj;
			Bounds bounds = ToLua.ToBounds(L, 2);
			obj2.bounds = bounds;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bounds on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_vertices(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Mesh obj2 = (Mesh)obj;
			Vector3[] vertices = ToLua.CheckStructArray<Vector3>(L, 2);
			obj2.vertices = vertices;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index vertices on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_normals(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Mesh obj2 = (Mesh)obj;
			Vector3[] normals = ToLua.CheckStructArray<Vector3>(L, 2);
			obj2.normals = normals;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index normals on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_tangents(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Mesh obj2 = (Mesh)obj;
			Vector4[] tangents = ToLua.CheckStructArray<Vector4>(L, 2);
			obj2.tangents = tangents;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tangents on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_uv(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Mesh obj2 = (Mesh)obj;
			Vector2[] uv = ToLua.CheckStructArray<Vector2>(L, 2);
			obj2.uv = uv;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uv on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_uv2(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Mesh obj2 = (Mesh)obj;
			Vector2[] uv = ToLua.CheckStructArray<Vector2>(L, 2);
			obj2.uv2 = uv;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uv2 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_uv3(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Mesh obj2 = (Mesh)obj;
			Vector2[] uv = ToLua.CheckStructArray<Vector2>(L, 2);
			obj2.uv3 = uv;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uv3 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_uv4(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Mesh obj2 = (Mesh)obj;
			Vector2[] uv = ToLua.CheckStructArray<Vector2>(L, 2);
			obj2.uv4 = uv;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uv4 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_uv5(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Mesh obj2 = (Mesh)obj;
			Vector2[] uv = ToLua.CheckStructArray<Vector2>(L, 2);
			obj2.uv5 = uv;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uv5 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_uv6(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Mesh obj2 = (Mesh)obj;
			Vector2[] uv = ToLua.CheckStructArray<Vector2>(L, 2);
			obj2.uv6 = uv;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uv6 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_uv7(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Mesh obj2 = (Mesh)obj;
			Vector2[] uv = ToLua.CheckStructArray<Vector2>(L, 2);
			obj2.uv7 = uv;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uv7 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_uv8(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Mesh obj2 = (Mesh)obj;
			Vector2[] uv = ToLua.CheckStructArray<Vector2>(L, 2);
			obj2.uv8 = uv;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uv8 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_colors(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Mesh obj2 = (Mesh)obj;
			Color[] colors = ToLua.CheckStructArray<Color>(L, 2);
			obj2.colors = colors;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index colors on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_colors32(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Mesh obj2 = (Mesh)obj;
			Color32[] colors = ToLua.CheckStructArray<Color32>(L, 2);
			obj2.colors32 = colors;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index colors32 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_triangles(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Mesh obj2 = (Mesh)obj;
			int[] triangles = ToLua.CheckNumberArray<int>(L, 2);
			obj2.triangles = triangles;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index triangles on a nil value");
		}
	}
}
