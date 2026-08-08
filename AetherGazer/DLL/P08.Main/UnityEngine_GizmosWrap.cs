using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_GizmosWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Gizmos), typeof(object));
		L.RegFunction("DrawLine", DrawLine);
		L.RegFunction("DrawWireSphere", DrawWireSphere);
		L.RegFunction("DrawSphere", DrawSphere);
		L.RegFunction("DrawWireCube", DrawWireCube);
		L.RegFunction("DrawCube", DrawCube);
		L.RegFunction("DrawMesh", DrawMesh);
		L.RegFunction("DrawWireMesh", DrawWireMesh);
		L.RegFunction("DrawIcon", DrawIcon);
		L.RegFunction("DrawGUITexture", DrawGUITexture);
		L.RegFunction("DrawFrustum", DrawFrustum);
		L.RegFunction("DrawRay", DrawRay);
		L.RegFunction("New", _CreateUnityEngine_Gizmos);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("color", get_color, set_color);
		L.RegVar("matrix", get_matrix, set_matrix);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_Gizmos(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				Gizmos o = new Gizmos();
				ToLua.PushSealed(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.Gizmos.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DrawLine(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Vector3 vector = ToLua.ToVector3(L, 1);
			Vector3 to = ToLua.ToVector3(L, 2);
			Gizmos.DrawLine(vector, to);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DrawWireSphere(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Vector3 center = ToLua.ToVector3(L, 1);
			float radius = (float)LuaDLL.luaL_checknumber(L, 2);
			Gizmos.DrawWireSphere(center, radius);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DrawSphere(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Vector3 center = ToLua.ToVector3(L, 1);
			float radius = (float)LuaDLL.luaL_checknumber(L, 2);
			Gizmos.DrawSphere(center, radius);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DrawWireCube(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Vector3 center = ToLua.ToVector3(L, 1);
			Vector3 size = ToLua.ToVector3(L, 2);
			Gizmos.DrawWireCube(center, size);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DrawCube(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Vector3 center = ToLua.ToVector3(L, 1);
			Vector3 size = ToLua.ToVector3(L, 2);
			Gizmos.DrawCube(center, size);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DrawMesh(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 1:
				Gizmos.DrawMesh((Mesh)ToLua.CheckObject(L, 1, typeof(Mesh)));
				return 0;
			case 2:
				if (TypeChecker.CheckTypes<int>(L, 2))
				{
					Mesh mesh = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
					int submeshIndex = (int)LuaDLL.lua_tonumber(L, 2);
					Gizmos.DrawMesh(mesh, submeshIndex);
					return 0;
				}
				break;
			}
			if (num == 2 && TypeChecker.CheckTypes<Vector3>(L, 2))
			{
				Mesh mesh2 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				Vector3 position = ToLua.ToVector3(L, 2);
				Gizmos.DrawMesh(mesh2, position);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, Vector3>(L, 2))
			{
				Mesh mesh3 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				int submeshIndex2 = (int)LuaDLL.lua_tonumber(L, 2);
				Vector3 position2 = ToLua.ToVector3(L, 3);
				Gizmos.DrawMesh(mesh3, submeshIndex2, position2);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<Vector3, Quaternion>(L, 2))
			{
				Mesh mesh4 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				Vector3 position3 = ToLua.ToVector3(L, 2);
				Quaternion rotation = ToLua.ToQuaternion(L, 3);
				Gizmos.DrawMesh(mesh4, position3, rotation);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<int, Vector3, Quaternion>(L, 2))
			{
				Mesh mesh5 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				int submeshIndex3 = (int)LuaDLL.lua_tonumber(L, 2);
				Vector3 position4 = ToLua.ToVector3(L, 3);
				Quaternion rotation2 = ToLua.ToQuaternion(L, 4);
				Gizmos.DrawMesh(mesh5, submeshIndex3, position4, rotation2);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<Vector3, Quaternion, Vector3>(L, 2))
			{
				Mesh mesh6 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				Vector3 position5 = ToLua.ToVector3(L, 2);
				Quaternion rotation3 = ToLua.ToQuaternion(L, 3);
				Vector3 scale = ToLua.ToVector3(L, 4);
				Gizmos.DrawMesh(mesh6, position5, rotation3, scale);
				return 0;
			}
			if (num == 5)
			{
				Mesh mesh7 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				int submeshIndex4 = (int)LuaDLL.luaL_checknumber(L, 2);
				Vector3 position6 = ToLua.ToVector3(L, 3);
				Quaternion rotation4 = ToLua.ToQuaternion(L, 4);
				Vector3 scale2 = ToLua.ToVector3(L, 5);
				Gizmos.DrawMesh(mesh7, submeshIndex4, position6, rotation4, scale2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Gizmos.DrawMesh");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DrawWireMesh(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 1:
				Gizmos.DrawWireMesh((Mesh)ToLua.CheckObject(L, 1, typeof(Mesh)));
				return 0;
			case 2:
				if (TypeChecker.CheckTypes<int>(L, 2))
				{
					Mesh mesh = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
					int submeshIndex = (int)LuaDLL.lua_tonumber(L, 2);
					Gizmos.DrawWireMesh(mesh, submeshIndex);
					return 0;
				}
				break;
			}
			if (num == 2 && TypeChecker.CheckTypes<Vector3>(L, 2))
			{
				Mesh mesh2 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				Vector3 position = ToLua.ToVector3(L, 2);
				Gizmos.DrawWireMesh(mesh2, position);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, Vector3>(L, 2))
			{
				Mesh mesh3 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				int submeshIndex2 = (int)LuaDLL.lua_tonumber(L, 2);
				Vector3 position2 = ToLua.ToVector3(L, 3);
				Gizmos.DrawWireMesh(mesh3, submeshIndex2, position2);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<Vector3, Quaternion>(L, 2))
			{
				Mesh mesh4 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				Vector3 position3 = ToLua.ToVector3(L, 2);
				Quaternion rotation = ToLua.ToQuaternion(L, 3);
				Gizmos.DrawWireMesh(mesh4, position3, rotation);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<int, Vector3, Quaternion>(L, 2))
			{
				Mesh mesh5 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				int submeshIndex3 = (int)LuaDLL.lua_tonumber(L, 2);
				Vector3 position4 = ToLua.ToVector3(L, 3);
				Quaternion rotation2 = ToLua.ToQuaternion(L, 4);
				Gizmos.DrawWireMesh(mesh5, submeshIndex3, position4, rotation2);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<Vector3, Quaternion, Vector3>(L, 2))
			{
				Mesh mesh6 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				Vector3 position5 = ToLua.ToVector3(L, 2);
				Quaternion rotation3 = ToLua.ToQuaternion(L, 3);
				Vector3 scale = ToLua.ToVector3(L, 4);
				Gizmos.DrawWireMesh(mesh6, position5, rotation3, scale);
				return 0;
			}
			if (num == 5)
			{
				Mesh mesh7 = (Mesh)ToLua.CheckObject(L, 1, typeof(Mesh));
				int submeshIndex4 = (int)LuaDLL.luaL_checknumber(L, 2);
				Vector3 position6 = ToLua.ToVector3(L, 3);
				Quaternion rotation4 = ToLua.ToQuaternion(L, 4);
				Vector3 scale2 = ToLua.ToVector3(L, 5);
				Gizmos.DrawWireMesh(mesh7, submeshIndex4, position6, rotation4, scale2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Gizmos.DrawWireMesh");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DrawIcon(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Vector3 center2 = ToLua.ToVector3(L, 1);
				string name2 = ToLua.CheckString(L, 2);
				Gizmos.DrawIcon(center2, name2);
				return 0;
			}
			case 3:
			{
				Vector3 center = ToLua.ToVector3(L, 1);
				string name = ToLua.CheckString(L, 2);
				bool allowScaling = LuaDLL.luaL_checkboolean(L, 3);
				Gizmos.DrawIcon(center, name, allowScaling);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Gizmos.DrawIcon");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DrawGUITexture(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Rect screenRect4 = StackTraits<Rect>.Check(L, 1);
				Texture texture4 = (Texture)ToLua.CheckObject<Texture>(L, 2);
				Gizmos.DrawGUITexture(screenRect4, texture4);
				return 0;
			}
			case 3:
			{
				Rect screenRect3 = StackTraits<Rect>.Check(L, 1);
				Texture texture3 = (Texture)ToLua.CheckObject<Texture>(L, 2);
				Material mat2 = (Material)ToLua.CheckObject<Material>(L, 3);
				Gizmos.DrawGUITexture(screenRect3, texture3, mat2);
				return 0;
			}
			case 6:
			{
				Rect screenRect2 = StackTraits<Rect>.Check(L, 1);
				Texture texture2 = (Texture)ToLua.CheckObject<Texture>(L, 2);
				int leftBorder2 = (int)LuaDLL.luaL_checknumber(L, 3);
				int rightBorder2 = (int)LuaDLL.luaL_checknumber(L, 4);
				int topBorder2 = (int)LuaDLL.luaL_checknumber(L, 5);
				int bottomBorder2 = (int)LuaDLL.luaL_checknumber(L, 6);
				Gizmos.DrawGUITexture(screenRect2, texture2, leftBorder2, rightBorder2, topBorder2, bottomBorder2);
				return 0;
			}
			case 7:
			{
				Rect screenRect = StackTraits<Rect>.Check(L, 1);
				Texture texture = (Texture)ToLua.CheckObject<Texture>(L, 2);
				int leftBorder = (int)LuaDLL.luaL_checknumber(L, 3);
				int rightBorder = (int)LuaDLL.luaL_checknumber(L, 4);
				int topBorder = (int)LuaDLL.luaL_checknumber(L, 5);
				int bottomBorder = (int)LuaDLL.luaL_checknumber(L, 6);
				Material mat = (Material)ToLua.CheckObject<Material>(L, 7);
				Gizmos.DrawGUITexture(screenRect, texture, leftBorder, rightBorder, topBorder, bottomBorder, mat);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Gizmos.DrawGUITexture");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DrawFrustum(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			Vector3 center = ToLua.ToVector3(L, 1);
			float fov = (float)LuaDLL.luaL_checknumber(L, 2);
			float maxRange = (float)LuaDLL.luaL_checknumber(L, 3);
			float minRange = (float)LuaDLL.luaL_checknumber(L, 4);
			float aspect = (float)LuaDLL.luaL_checknumber(L, 5);
			Gizmos.DrawFrustum(center, fov, maxRange, minRange, aspect);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DrawRay(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				Gizmos.DrawRay(ToLua.ToRay(L, 1));
				return 0;
			case 2:
			{
				Vector3 vector = ToLua.ToVector3(L, 1);
				Vector3 direction = ToLua.ToVector3(L, 2);
				Gizmos.DrawRay(vector, direction);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Gizmos.DrawRay");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_color(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Gizmos.color);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_matrix(IntPtr L)
	{
		try
		{
			ToLua.PushValue(L, Gizmos.matrix);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_color(IntPtr L)
	{
		try
		{
			Gizmos.color = ToLua.ToColor(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_matrix(IntPtr L)
	{
		try
		{
			Gizmos.matrix = StackTraits<Matrix4x4>.Check(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
