using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_RectWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Rect), null);
		L.RegFunction("MinMaxRect", MinMaxRect);
		L.RegFunction("Set", Set);
		L.RegFunction("Contains", Contains);
		L.RegFunction("Overlaps", Overlaps);
		L.RegFunction("NormalizedToPoint", NormalizedToPoint);
		L.RegFunction("PointToNormalized", PointToNormalized);
		L.RegFunction("GetHashCode", GetHashCode);
		L.RegFunction("Equals", Equals);
		L.RegFunction("ToString", ToString);
		L.RegFunction("New", _CreateUnityEngine_Rect);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("zero", get_zero, null);
		L.RegVar("x", get_x, set_x);
		L.RegVar("y", get_y, set_y);
		L.RegVar("position", get_position, set_position);
		L.RegVar("center", get_center, set_center);
		L.RegVar("min", get_min, set_min);
		L.RegVar("max", get_max, set_max);
		L.RegVar("width", get_width, set_width);
		L.RegVar("height", get_height, set_height);
		L.RegVar("size", get_size, set_size);
		L.RegVar("xMin", get_xMin, set_xMin);
		L.RegVar("yMin", get_yMin, set_yMin);
		L.RegVar("xMax", get_xMax, set_xMax);
		L.RegVar("yMax", get_yMax, set_yMax);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_Rect(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				Rect source = StackTraits<Rect>.Check(L, 1);
				Rect v3 = new Rect(source);
				ToLua.PushValue(L, v3);
				return 1;
			}
			case 2:
			{
				Vector2 position = ToLua.ToVector2(L, 1);
				Vector2 size = ToLua.ToVector2(L, 2);
				Rect v2 = new Rect(position, size);
				ToLua.PushValue(L, v2);
				return 1;
			}
			case 4:
			{
				float x = (float)LuaDLL.luaL_checknumber(L, 1);
				float y = (float)LuaDLL.luaL_checknumber(L, 2);
				float width = (float)LuaDLL.luaL_checknumber(L, 3);
				float height = (float)LuaDLL.luaL_checknumber(L, 4);
				Rect v = new Rect(x, y, width, height);
				ToLua.PushValue(L, v);
				return 1;
			}
			case 0:
				ToLua.PushValue(L, default(Rect));
				return 1;
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.Rect.New");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MinMaxRect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			float xmin = (float)LuaDLL.luaL_checknumber(L, 1);
			float ymin = (float)LuaDLL.luaL_checknumber(L, 2);
			float xmax = (float)LuaDLL.luaL_checknumber(L, 3);
			float ymax = (float)LuaDLL.luaL_checknumber(L, 4);
			Rect v = Rect.MinMaxRect(xmin, ymin, xmax, ymax);
			ToLua.PushValue(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Set(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			Rect rect = (Rect)ToLua.CheckObject(L, 1, typeof(Rect));
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			float y = (float)LuaDLL.luaL_checknumber(L, 3);
			float width = (float)LuaDLL.luaL_checknumber(L, 4);
			float height = (float)LuaDLL.luaL_checknumber(L, 5);
			rect.Set(x, y, width, height);
			ToLua.SetBack(L, 1, rect);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Contains(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<Vector3>(L, 2))
			{
				Rect rect = (Rect)ToLua.CheckObject(L, 1, typeof(Rect));
				Vector3 point = ToLua.ToVector3(L, 2);
				bool value = rect.Contains(point);
				LuaDLL.lua_pushboolean(L, value);
				ToLua.SetBack(L, 1, rect);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<Vector2>(L, 2))
			{
				Rect rect2 = (Rect)ToLua.CheckObject(L, 1, typeof(Rect));
				Vector2 point2 = ToLua.ToVector2(L, 2);
				bool value2 = rect2.Contains(point2);
				LuaDLL.lua_pushboolean(L, value2);
				ToLua.SetBack(L, 1, rect2);
				return 1;
			}
			if (num == 3)
			{
				Rect rect3 = (Rect)ToLua.CheckObject(L, 1, typeof(Rect));
				Vector3 point3 = ToLua.ToVector3(L, 2);
				bool allowInverse = LuaDLL.luaL_checkboolean(L, 3);
				bool value3 = rect3.Contains(point3, allowInverse);
				LuaDLL.lua_pushboolean(L, value3);
				ToLua.SetBack(L, 1, rect3);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Rect.Contains");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Overlaps(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Rect rect2 = (Rect)ToLua.CheckObject(L, 1, typeof(Rect));
				Rect other2 = StackTraits<Rect>.Check(L, 2);
				bool value2 = rect2.Overlaps(other2);
				LuaDLL.lua_pushboolean(L, value2);
				ToLua.SetBack(L, 1, rect2);
				return 1;
			}
			case 3:
			{
				Rect rect = (Rect)ToLua.CheckObject(L, 1, typeof(Rect));
				Rect other = StackTraits<Rect>.Check(L, 2);
				bool allowInverse = LuaDLL.luaL_checkboolean(L, 3);
				bool value = rect.Overlaps(other, allowInverse);
				LuaDLL.lua_pushboolean(L, value);
				ToLua.SetBack(L, 1, rect);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Rect.Overlaps");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int NormalizedToPoint(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Rect rectangle = StackTraits<Rect>.Check(L, 1);
			Vector2 normalizedRectCoordinates = ToLua.ToVector2(L, 2);
			Vector2 v = Rect.NormalizedToPoint(rectangle, normalizedRectCoordinates);
			ToLua.Push(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PointToNormalized(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Rect rectangle = StackTraits<Rect>.Check(L, 1);
			Vector2 point = ToLua.ToVector2(L, 2);
			Vector2 v = Rect.PointToNormalized(rectangle, point);
			ToLua.Push(L, v);
			return 1;
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
			Rect rect = StackTraits<Rect>.To(L, 1);
			Rect rect2 = StackTraits<Rect>.To(L, 2);
			bool value = rect == rect2;
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetHashCode(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Rect rect = (Rect)ToLua.CheckObject(L, 1, typeof(Rect));
			int hashCode = rect.GetHashCode();
			LuaDLL.lua_pushinteger(L, hashCode);
			ToLua.SetBack(L, 1, rect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Equals(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<Rect>(L, 2))
			{
				Rect rect = (Rect)ToLua.CheckObject(L, 1, typeof(Rect));
				Rect other = StackTraits<Rect>.To(L, 2);
				bool value = rect.Equals(other);
				LuaDLL.lua_pushboolean(L, value);
				ToLua.SetBack(L, 1, rect);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<object>(L, 2))
			{
				Rect rect2 = (Rect)ToLua.CheckObject(L, 1, typeof(Rect));
				object obj = ToLua.ToVarObject(L, 2);
				bool value2 = rect2.Equals(obj);
				LuaDLL.lua_pushboolean(L, value2);
				ToLua.SetBack(L, 1, rect2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Rect.Equals");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ToString(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				string str2 = ((Rect)ToLua.CheckObject(L, 1, typeof(Rect))/*cast due to constrained. prefix*/).ToString();
				LuaDLL.lua_pushstring(L, str2);
				return 1;
			}
			case 2:
			{
				Rect rect = (Rect)ToLua.CheckObject(L, 1, typeof(Rect));
				string text = ToLua.CheckString(L, 2);
				string str = rect.ToString(text);
				LuaDLL.lua_pushstring(L, str);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Rect.ToString");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_zero(IntPtr L)
	{
		try
		{
			ToLua.PushValue(L, Rect.zero);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_x(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float x = ((Rect)obj).x;
			LuaDLL.lua_pushnumber(L, x);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index x on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_y(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float y = ((Rect)obj).y;
			LuaDLL.lua_pushnumber(L, y);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index y on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_position(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 position = ((Rect)obj).position;
			ToLua.Push(L, position);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index position on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_center(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 center = ((Rect)obj).center;
			ToLua.Push(L, center);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index center on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_min(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 min = ((Rect)obj).min;
			ToLua.Push(L, min);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index min on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_max(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 max = ((Rect)obj).max;
			ToLua.Push(L, max);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index max on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_width(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float width = ((Rect)obj).width;
			LuaDLL.lua_pushnumber(L, width);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index width on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_height(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float height = ((Rect)obj).height;
			LuaDLL.lua_pushnumber(L, height);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index height on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_size(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 size = ((Rect)obj).size;
			ToLua.Push(L, size);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index size on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_xMin(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float xMin = ((Rect)obj).xMin;
			LuaDLL.lua_pushnumber(L, xMin);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index xMin on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_yMin(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float yMin = ((Rect)obj).yMin;
			LuaDLL.lua_pushnumber(L, yMin);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index yMin on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_xMax(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float xMax = ((Rect)obj).xMax;
			LuaDLL.lua_pushnumber(L, xMax);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index xMax on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_yMax(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float yMax = ((Rect)obj).yMax;
			LuaDLL.lua_pushnumber(L, yMax);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index yMax on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_x(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rect rect = (Rect)obj;
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			rect.x = x;
			ToLua.SetBack(L, 1, rect);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index x on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_y(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rect rect = (Rect)obj;
			float y = (float)LuaDLL.luaL_checknumber(L, 2);
			rect.y = y;
			ToLua.SetBack(L, 1, rect);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index y on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_position(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rect rect = (Rect)obj;
			Vector2 position = ToLua.ToVector2(L, 2);
			rect.position = position;
			ToLua.SetBack(L, 1, rect);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index position on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_center(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rect rect = (Rect)obj;
			Vector2 center = ToLua.ToVector2(L, 2);
			rect.center = center;
			ToLua.SetBack(L, 1, rect);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index center on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_min(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rect rect = (Rect)obj;
			Vector2 min = ToLua.ToVector2(L, 2);
			rect.min = min;
			ToLua.SetBack(L, 1, rect);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index min on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_max(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rect rect = (Rect)obj;
			Vector2 max = ToLua.ToVector2(L, 2);
			rect.max = max;
			ToLua.SetBack(L, 1, rect);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index max on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_width(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rect rect = (Rect)obj;
			float width = (float)LuaDLL.luaL_checknumber(L, 2);
			rect.width = width;
			ToLua.SetBack(L, 1, rect);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index width on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_height(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rect rect = (Rect)obj;
			float height = (float)LuaDLL.luaL_checknumber(L, 2);
			rect.height = height;
			ToLua.SetBack(L, 1, rect);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index height on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_size(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rect rect = (Rect)obj;
			Vector2 size = ToLua.ToVector2(L, 2);
			rect.size = size;
			ToLua.SetBack(L, 1, rect);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index size on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_xMin(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rect rect = (Rect)obj;
			float xMin = (float)LuaDLL.luaL_checknumber(L, 2);
			rect.xMin = xMin;
			ToLua.SetBack(L, 1, rect);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index xMin on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_yMin(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rect rect = (Rect)obj;
			float yMin = (float)LuaDLL.luaL_checknumber(L, 2);
			rect.yMin = yMin;
			ToLua.SetBack(L, 1, rect);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index yMin on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_xMax(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rect rect = (Rect)obj;
			float xMax = (float)LuaDLL.luaL_checknumber(L, 2);
			rect.xMax = xMax;
			ToLua.SetBack(L, 1, rect);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index xMax on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_yMax(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rect rect = (Rect)obj;
			float yMax = (float)LuaDLL.luaL_checknumber(L, 2);
			rect.yMax = yMax;
			ToLua.SetBack(L, 1, rect);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index yMax on a nil value");
		}
	}
}
