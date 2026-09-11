using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

public class UnityEngine_SpriteWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Sprite), typeof(UnityEngine.Object));
		L.RegFunction("GetPhysicsShapeCount", GetPhysicsShapeCount);
		L.RegFunction("GetPhysicsShapePointCount", GetPhysicsShapePointCount);
		L.RegFunction("GetPhysicsShape", GetPhysicsShape);
		L.RegFunction("OverridePhysicsShape", OverridePhysicsShape);
		L.RegFunction("OverrideGeometry", OverrideGeometry);
		L.RegFunction("Create", Create);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("bounds", get_bounds, null);
		L.RegVar("rect", get_rect, null);
		L.RegVar("border", get_border, null);
		L.RegVar("texture", get_texture, null);
		L.RegVar("pixelsPerUnit", get_pixelsPerUnit, null);
		L.RegVar("associatedAlphaSplitTexture", get_associatedAlphaSplitTexture, null);
		L.RegVar("pivot", get_pivot, null);
		L.RegVar("packed", get_packed, null);
		L.RegVar("packingMode", get_packingMode, null);
		L.RegVar("packingRotation", get_packingRotation, null);
		L.RegVar("textureRect", get_textureRect, null);
		L.RegVar("textureRectOffset", get_textureRectOffset, null);
		L.RegVar("vertices", get_vertices, null);
		L.RegVar("triangles", get_triangles, null);
		L.RegVar("uv", get_uv, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPhysicsShapeCount(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int physicsShapeCount = ((Sprite)ToLua.CheckObject(L, 1, typeof(Sprite))).GetPhysicsShapeCount();
			LuaDLL.lua_pushinteger(L, physicsShapeCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPhysicsShapePointCount(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Sprite obj = (Sprite)ToLua.CheckObject(L, 1, typeof(Sprite));
			int shapeIdx = (int)LuaDLL.luaL_checknumber(L, 2);
			int physicsShapePointCount = obj.GetPhysicsShapePointCount(shapeIdx);
			LuaDLL.lua_pushinteger(L, physicsShapePointCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPhysicsShape(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Sprite obj = (Sprite)ToLua.CheckObject(L, 1, typeof(Sprite));
			int shapeIdx = (int)LuaDLL.luaL_checknumber(L, 2);
			List<Vector2> physicsShape = (List<Vector2>)ToLua.CheckObject(L, 3, typeof(List<Vector2>));
			int physicsShape2 = obj.GetPhysicsShape(shapeIdx, physicsShape);
			LuaDLL.lua_pushinteger(L, physicsShape2);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OverridePhysicsShape(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Sprite obj = (Sprite)ToLua.CheckObject(L, 1, typeof(Sprite));
			IList<Vector2[]> physicsShapes = (IList<Vector2[]>)ToLua.CheckObject<IList<Vector2[]>>(L, 2);
			obj.OverridePhysicsShape(physicsShapes);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OverrideGeometry(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Sprite obj = (Sprite)ToLua.CheckObject(L, 1, typeof(Sprite));
			Vector2[] vertices = ToLua.CheckStructArray<Vector2>(L, 2);
			ushort[] triangles = ToLua.CheckNumberArray<ushort>(L, 3);
			obj.OverrideGeometry(vertices, triangles);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Create(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				Texture2D texture6 = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				Rect rect6 = StackTraits<Rect>.Check(L, 2);
				Vector2 pivot6 = ToLua.ToVector2(L, 3);
				Sprite o6 = Sprite.Create(texture6, rect6, pivot6);
				ToLua.PushSealed(L, o6);
				return 1;
			}
			case 4:
			{
				Texture2D texture5 = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				Rect rect5 = StackTraits<Rect>.Check(L, 2);
				Vector2 pivot5 = ToLua.ToVector2(L, 3);
				float pixelsPerUnit5 = (float)LuaDLL.luaL_checknumber(L, 4);
				Sprite o5 = Sprite.Create(texture5, rect5, pivot5, pixelsPerUnit5);
				ToLua.PushSealed(L, o5);
				return 1;
			}
			case 5:
			{
				Texture2D texture4 = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				Rect rect4 = StackTraits<Rect>.Check(L, 2);
				Vector2 pivot4 = ToLua.ToVector2(L, 3);
				float pixelsPerUnit4 = (float)LuaDLL.luaL_checknumber(L, 4);
				uint extrude4 = (uint)LuaDLL.luaL_checknumber(L, 5);
				Sprite o4 = Sprite.Create(texture4, rect4, pivot4, pixelsPerUnit4, extrude4);
				ToLua.PushSealed(L, o4);
				return 1;
			}
			case 6:
			{
				Texture2D texture3 = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				Rect rect3 = StackTraits<Rect>.Check(L, 2);
				Vector2 pivot3 = ToLua.ToVector2(L, 3);
				float pixelsPerUnit3 = (float)LuaDLL.luaL_checknumber(L, 4);
				uint extrude3 = (uint)LuaDLL.luaL_checknumber(L, 5);
				SpriteMeshType meshType3 = (SpriteMeshType)ToLua.CheckObject(L, 6, typeof(SpriteMeshType));
				Sprite o3 = Sprite.Create(texture3, rect3, pivot3, pixelsPerUnit3, extrude3, meshType3);
				ToLua.PushSealed(L, o3);
				return 1;
			}
			case 7:
			{
				Texture2D texture2 = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				Rect rect2 = StackTraits<Rect>.Check(L, 2);
				Vector2 pivot2 = ToLua.ToVector2(L, 3);
				float pixelsPerUnit2 = (float)LuaDLL.luaL_checknumber(L, 4);
				uint extrude2 = (uint)LuaDLL.luaL_checknumber(L, 5);
				SpriteMeshType meshType2 = (SpriteMeshType)ToLua.CheckObject(L, 6, typeof(SpriteMeshType));
				Vector4 border2 = ToLua.ToVector4(L, 7);
				Sprite o2 = Sprite.Create(texture2, rect2, pivot2, pixelsPerUnit2, extrude2, meshType2, border2);
				ToLua.PushSealed(L, o2);
				return 1;
			}
			case 8:
			{
				Texture2D texture = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				Rect rect = StackTraits<Rect>.Check(L, 2);
				Vector2 pivot = ToLua.ToVector2(L, 3);
				float pixelsPerUnit = (float)LuaDLL.luaL_checknumber(L, 4);
				uint extrude = (uint)LuaDLL.luaL_checknumber(L, 5);
				SpriteMeshType meshType = (SpriteMeshType)ToLua.CheckObject(L, 6, typeof(SpriteMeshType));
				Vector4 border = ToLua.ToVector4(L, 7);
				bool generateFallbackPhysicsShape = LuaDLL.luaL_checkboolean(L, 8);
				Sprite o = Sprite.Create(texture, rect, pivot, pixelsPerUnit, extrude, meshType, border, generateFallbackPhysicsShape);
				ToLua.PushSealed(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Sprite.Create");
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
	private static int get_bounds(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Bounds bounds = ((Sprite)obj).bounds;
			ToLua.Push(L, bounds);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bounds on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rect rect = ((Sprite)obj).rect;
			ToLua.PushValue(L, rect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_border(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector4 border = ((Sprite)obj).border;
			ToLua.Push(L, border);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index border on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_texture(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Texture2D texture = ((Sprite)obj).texture;
			ToLua.PushSealed(L, texture);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index texture on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pixelsPerUnit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float pixelsPerUnit = ((Sprite)obj).pixelsPerUnit;
			LuaDLL.lua_pushnumber(L, pixelsPerUnit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pixelsPerUnit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_associatedAlphaSplitTexture(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Texture2D associatedAlphaSplitTexture = ((Sprite)obj).associatedAlphaSplitTexture;
			ToLua.PushSealed(L, associatedAlphaSplitTexture);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index associatedAlphaSplitTexture on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pivot(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 pivot = ((Sprite)obj).pivot;
			ToLua.Push(L, pivot);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pivot on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_packed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool packed = ((Sprite)obj).packed;
			LuaDLL.lua_pushboolean(L, packed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index packed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_packingMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SpritePackingMode packingMode = ((Sprite)obj).packingMode;
			ToLua.Push(L, packingMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index packingMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_packingRotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SpritePackingRotation packingRotation = ((Sprite)obj).packingRotation;
			ToLua.Push(L, packingRotation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index packingRotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_textureRect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rect textureRect = ((Sprite)obj).textureRect;
			ToLua.PushValue(L, textureRect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index textureRect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_textureRectOffset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 textureRectOffset = ((Sprite)obj).textureRectOffset;
			ToLua.Push(L, textureRectOffset);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index textureRectOffset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_vertices(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2[] vertices = ((Sprite)obj).vertices;
			ToLua.Push(L, vertices);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index vertices on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_triangles(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ushort[] triangles = ((Sprite)obj).triangles;
			ToLua.Push(L, triangles);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index triangles on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_uv(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2[] uv = ((Sprite)obj).uv;
			ToLua.Push(L, uv);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uv on a nil value");
		}
	}
}
