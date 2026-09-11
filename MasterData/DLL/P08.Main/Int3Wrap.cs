using System;
using LuaInterface;
using UnityEngine;

public class Int3Wrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Int3), null);
		L.RegFunction(".geti", get_Item);
		L.RegFunction("get_Item", get_Item);
		L.RegFunction(".seti", set_Item);
		L.RegFunction("set_Item", set_Item);
		L.RegFunction("Angle", Angle);
		L.RegFunction("AngleInt", AngleInt);
		L.RegFunction("Dot", Dot);
		L.RegFunction("DotLong", DotLong);
		L.RegFunction("Normal2D", Normal2D);
		L.RegFunction("ClampMagnitude", ClampMagnitude);
		L.RegFunction("Cross", Cross);
		L.RegFunction("Det", Det);
		L.RegFunction("MoveTowards", MoveTowards);
		L.RegFunction("NormalizeTo", NormalizeTo);
		L.RegFunction("Normalize", Normalize);
		L.RegFunction("RotateY", RotateY);
		L.RegFunction("RotateYWithLength", RotateYWithLength);
		L.RegFunction("IsEqualXZ", IsEqualXZ);
		L.RegFunction("XZSqrMagnitude", XZSqrMagnitude);
		L.RegFunction("Lerp", Lerp);
		L.RegFunction("ToString", ToString);
		L.RegFunction("Equals", Equals);
		L.RegFunction("GetHashCode", GetHashCode);
		L.RegFunction("DotXZLong", DotXZLong);
		L.RegFunction("ProjectionToY", ProjectionToY);
		L.RegFunction("New", _CreateInt3);
		L.RegVar("this", _this, null);
		L.RegFunction("__add", op_Addition);
		L.RegFunction("__sub", op_Subtraction);
		L.RegFunction("__mul", op_Multiply);
		L.RegFunction("__div", op_Division);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__unm", op_UnaryNegation);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("x", get_x, set_x);
		L.RegVar("y", get_y, set_y);
		L.RegVar("z", get_z, set_z);
		L.RegConstant("Precision", 1000.0);
		L.RegConstant("FloatPrecision", 1000.0);
		L.RegConstant("PrecisionFactor", 0.00100000004749745);
		L.RegVar("zero", get_zero, null);
		L.RegVar("one", get_one, null);
		L.RegVar("half", get_half, null);
		L.RegVar("forward", get_forward, null);
		L.RegVar("up", get_up, null);
		L.RegVar("right", get_right, null);
		L.RegVar("magnitude", get_magnitude, null);
		L.RegVar("LongMagnitude", get_LongMagnitude, null);
		L.RegVar("IntMagnitude", get_IntMagnitude, null);
		L.RegVar("costMagnitude", get_costMagnitude, null);
		L.RegVar("sqrMagnitude", get_sqrMagnitude, null);
		L.RegVar("sqrMagnitudeLong", get_sqrMagnitudeLong, null);
		L.RegVar("sqrMagnitudeLong2D", get_sqrMagnitudeLong2D, null);
		L.RegVar("magnitude2D", get_magnitude2D, null);
		L.RegVar("abs", get_abs, null);
		L.RegVar("vec3", get_vec3, null);
		L.RegVar("xz", get_xz, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateInt3(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				Vector3 position = ToLua.ToVector3(L, 1);
				Int3 v2 = new Int3(position);
				ToLua.PushValue(L, v2);
				return 1;
			}
			case 3:
			{
				int x = (int)LuaDLL.luaL_checknumber(L, 1);
				int y = (int)LuaDLL.luaL_checknumber(L, 2);
				int z = (int)LuaDLL.luaL_checknumber(L, 3);
				Int3 v = new Int3(x, y, z);
				ToLua.PushValue(L, v);
				return 1;
			}
			case 0:
				ToLua.PushValue(L, default(Int3));
				return 1;
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: Int3.New");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _get_this(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Int3 @int = (Int3)ToLua.CheckObject(L, 1, typeof(Int3));
			int i = (int)LuaDLL.luaL_checknumber(L, 2);
			int n = @int[i];
			LuaDLL.lua_pushinteger(L, n);
			ToLua.SetBack(L, 1, @int);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _set_this(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Int3 @int = (Int3)ToLua.CheckObject(L, 1, typeof(Int3));
			int i = (int)LuaDLL.luaL_checknumber(L, 2);
			int value = (int)LuaDLL.luaL_checknumber(L, 3);
			@int[i] = value;
			ToLua.SetBack(L, 1, @int);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _this(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushvalue(L, 1);
			LuaDLL.tolua_bindthis(L, _get_this, _set_this);
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
			Int3 @int = StackTraits<Int3>.To(L, 1);
			Int3 int2 = StackTraits<Int3>.To(L, 2);
			bool value = @int == int2;
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int op_Subtraction(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Int3 @int = StackTraits<Int3>.Check(L, 1);
			Int3 int2 = StackTraits<Int3>.Check(L, 2);
			Int3 v = @int - int2;
			ToLua.PushValue(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int op_UnaryNegation(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Int3 v = -StackTraits<Int3>.Check(L, 1);
			ToLua.PushValue(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int op_Addition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Int3 @int = StackTraits<Int3>.Check(L, 1);
			Int3 int2 = StackTraits<Int3>.Check(L, 2);
			Int3 v = @int + int2;
			ToLua.PushValue(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int op_Multiply(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Int3 @int = StackTraits<Int3>.Check(L, 1);
			double num = LuaDLL.luaL_checknumber(L, 2);
			Int3 v = @int * num;
			ToLua.PushValue(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int op_Division(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Int3 @int = StackTraits<Int3>.Check(L, 1);
			float num = (float)LuaDLL.luaL_checknumber(L, 2);
			Int3 v = @int / num;
			ToLua.PushValue(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Item(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Int3 @int = (Int3)ToLua.CheckObject(L, 1, typeof(Int3));
			int i = (int)LuaDLL.luaL_checknumber(L, 2);
			int n = @int[i];
			LuaDLL.lua_pushinteger(L, n);
			ToLua.SetBack(L, 1, @int);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Item(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Int3 @int = (Int3)ToLua.CheckObject(L, 1, typeof(Int3));
			int i = (int)LuaDLL.luaL_checknumber(L, 2);
			int value = (int)LuaDLL.luaL_checknumber(L, 3);
			@int[i] = value;
			ToLua.SetBack(L, 1, @int);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Angle(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Int3 lhs = StackTraits<Int3>.Check(L, 1);
			Int3 rhs = StackTraits<Int3>.Check(L, 2);
			float num = Int3.Angle(lhs, rhs);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AngleInt(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Int3 lhs = StackTraits<Int3>.Check(L, 1);
			Int3 rhs = StackTraits<Int3>.Check(L, 2);
			VFactor v = Int3.AngleInt(lhs, rhs);
			ToLua.PushValue(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Dot(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Int3 lhs = StackTraits<Int3>.Check(L, 1);
			Int3 rhs = StackTraits<Int3>.Check(L, 2);
			int n = Int3.Dot(lhs, rhs);
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DotLong(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Int3 lhs = StackTraits<Int3>.Check(L, 1);
			Int3 rhs = StackTraits<Int3>.Check(L, 2);
			long n = Int3.DotLong(lhs, rhs);
			LuaDLL.tolua_pushint64(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Normal2D(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Int3 @int = (Int3)ToLua.CheckObject(L, 1, typeof(Int3));
			Int3 v = @int.Normal2D();
			ToLua.PushValue(L, v);
			ToLua.SetBack(L, 1, @int);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClampMagnitude(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Int3 v = StackTraits<Int3>.Check(L, 1);
			int maxLength = (int)LuaDLL.luaL_checknumber(L, 2);
			Int3 v2 = Int3.ClampMagnitude(v, maxLength);
			ToLua.PushValue(L, v2);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Cross(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<Int3, Int3>(L, 1))
			{
				Int3 lhs = StackTraits<Int3>.To(L, 1);
				Int3 rhs = StackTraits<Int3>.To(L, 2);
				Int3 v = Int3.Cross(ref lhs, ref rhs);
				ToLua.PushValue(L, v);
				ToLua.PushValue(L, lhs);
				ToLua.PushValue(L, rhs);
				return 3;
			}
			if (num == 2 && TypeChecker.CheckTypes<Int3, Int3>(L, 1))
			{
				Int3 lhs2 = StackTraits<Int3>.To(L, 1);
				Int3 rhs2 = StackTraits<Int3>.To(L, 2);
				Int3 v2 = Int3.Cross(lhs2, rhs2);
				ToLua.PushValue(L, v2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: Int3.Cross");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Det(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Int3 lhs = StackTraits<Int3>.Check(L, 1);
			Int3 rhs = StackTraits<Int3>.Check(L, 2);
			long n = Int3.Det(lhs, rhs);
			LuaDLL.tolua_pushint64(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MoveTowards(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Int3 @int = StackTraits<Int3>.Check(L, 1);
			Int3 to = StackTraits<Int3>.Check(L, 2);
			int dt = (int)LuaDLL.luaL_checknumber(L, 3);
			Int3 v = Int3.MoveTowards(@int, to, dt);
			ToLua.PushValue(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int NormalizeTo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Int3 @int = (Int3)ToLua.CheckObject(L, 1, typeof(Int3));
			int newMagn = (int)LuaDLL.luaL_checknumber(L, 2);
			Int3 v = @int.NormalizeTo(newMagn);
			ToLua.PushValue(L, v);
			ToLua.SetBack(L, 1, @int);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Normalize(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				Int3 @int = (Int3)ToLua.CheckObject(L, 1, typeof(Int3));
				long n = @int.Normalize();
				LuaDLL.tolua_pushint64(L, n);
				ToLua.SetBack(L, 1, @int);
				return 1;
			}
			case 2:
			{
				Int3 v = Int3.Normalize(StackTraits<Int3>.Check(L, 1), out var magnitude);
				ToLua.PushValue(L, v);
				LuaDLL.tolua_pushint64(L, magnitude);
				return 2;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Int3.Normalize");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RotateY(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				Int3 @int = (Int3)ToLua.CheckObject(L, 1, typeof(Int3));
				int degree = (int)LuaDLL.lua_tonumber(L, 2);
				Int3 v = @int.RotateY(degree);
				ToLua.PushValue(L, v);
				ToLua.SetBack(L, 1, @int);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<VFactor>(L, 2))
			{
				Int3 int2 = (Int3)ToLua.CheckObject(L, 1, typeof(Int3));
				VFactor radians = StackTraits<VFactor>.To(L, 2);
				Int3 v2 = int2.RotateY(ref radians);
				ToLua.PushValue(L, v2);
				ToLua.PushValue(L, radians);
				ToLua.SetBack(L, 1, int2);
				return 2;
			}
			if (num == 3)
			{
				Int3 int3 = (Int3)ToLua.CheckObject(L, 1, typeof(Int3));
				int degree2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int distance = (int)LuaDLL.luaL_checknumber(L, 3);
				Int3 v3 = int3.RotateY(degree2, distance);
				ToLua.PushValue(L, v3);
				ToLua.SetBack(L, 1, int3);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: Int3.RotateY");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RotateYWithLength(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Int3 @int = (Int3)ToLua.CheckObject(L, 1, typeof(Int3));
			int degree = (int)LuaDLL.luaL_checknumber(L, 2);
			Int3 v = @int.RotateYWithLength(degree);
			ToLua.PushValue(L, v);
			ToLua.SetBack(L, 1, @int);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsEqualXZ(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Int3 @int = (Int3)ToLua.CheckObject(L, 1, typeof(Int3));
			Int3 rhs = StackTraits<Int3>.Check(L, 2);
			bool value = @int.IsEqualXZ(ref rhs);
			LuaDLL.lua_pushboolean(L, value);
			ToLua.PushValue(L, rhs);
			ToLua.SetBack(L, 1, @int);
			return 2;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int XZSqrMagnitude(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Int3 @int = (Int3)ToLua.CheckObject(L, 1, typeof(Int3));
			Int3 rhs = StackTraits<Int3>.Check(L, 2);
			long n = @int.XZSqrMagnitude(rhs);
			LuaDLL.tolua_pushint64(L, n);
			ToLua.SetBack(L, 1, @int);
			return 1;
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
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<float>(L, 3))
			{
				Int3 a = StackTraits<Int3>.Check(L, 1);
				Int3 b = StackTraits<Int3>.Check(L, 2);
				float f = (float)LuaDLL.lua_tonumber(L, 3);
				Int3 v = Int3.Lerp(a, b, f);
				ToLua.PushValue(L, v);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<VFactor>(L, 3))
			{
				Int3 a2 = StackTraits<Int3>.Check(L, 1);
				Int3 b2 = StackTraits<Int3>.Check(L, 2);
				VFactor f2 = StackTraits<VFactor>.To(L, 3);
				Int3 v2 = Int3.Lerp(a2, b2, f2);
				ToLua.PushValue(L, v2);
				return 1;
			}
			if (num == 4)
			{
				Int3 a3 = StackTraits<Int3>.Check(L, 1);
				Int3 b3 = StackTraits<Int3>.Check(L, 2);
				int factorNom = (int)LuaDLL.luaL_checknumber(L, 3);
				int factorDen = (int)LuaDLL.luaL_checknumber(L, 4);
				Int3 v3 = Int3.Lerp(a3, b3, factorNom, factorDen);
				ToLua.PushValue(L, v3);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: Int3.Lerp");
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
			ToLua.CheckArgsCount(L, 1);
			string str = ((Int3)ToLua.CheckObject(L, 1, typeof(Int3))/*cast due to constrained. prefix*/).ToString();
			LuaDLL.lua_pushstring(L, str);
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
			if (num == 2 && TypeChecker.CheckTypes<Int3>(L, 2))
			{
				Int3 @int = (Int3)ToLua.CheckObject(L, 1, typeof(Int3));
				Int3 other = StackTraits<Int3>.To(L, 2);
				bool value = @int.Equals(other);
				LuaDLL.lua_pushboolean(L, value);
				ToLua.SetBack(L, 1, @int);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<object>(L, 2))
			{
				Int3 int2 = (Int3)ToLua.CheckObject(L, 1, typeof(Int3));
				object obj = ToLua.ToVarObject(L, 2);
				bool value2 = int2.Equals(obj);
				LuaDLL.lua_pushboolean(L, value2);
				ToLua.SetBack(L, 1, int2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: Int3.Equals");
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
			Int3 @int = (Int3)ToLua.CheckObject(L, 1, typeof(Int3));
			int hashCode = @int.GetHashCode();
			LuaDLL.lua_pushinteger(L, hashCode);
			ToLua.SetBack(L, 1, @int);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DotXZLong(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<Int3, Int3>(L, 1))
			{
				Int3 lhs = StackTraits<Int3>.To(L, 1);
				Int3 rhs = StackTraits<Int3>.To(L, 2);
				long n = Int3.DotXZLong(ref lhs, ref rhs);
				LuaDLL.tolua_pushint64(L, n);
				ToLua.PushValue(L, lhs);
				ToLua.PushValue(L, rhs);
				return 3;
			}
			if (num == 2 && TypeChecker.CheckTypes<Int3, Int3>(L, 1))
			{
				Int3 lhs2 = StackTraits<Int3>.To(L, 1);
				Int3 rhs2 = StackTraits<Int3>.To(L, 2);
				long n2 = Int3.DotXZLong(lhs2, rhs2);
				LuaDLL.tolua_pushint64(L, n2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: Int3.DotXZLong");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ProjectionToY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Int3 v = Int3.ProjectionToY(StackTraits<Int3>.Check(L, 1));
			ToLua.PushValue(L, v);
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
			int x = ((Int3)obj).x;
			LuaDLL.lua_pushinteger(L, x);
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
			int y = ((Int3)obj).y;
			LuaDLL.lua_pushinteger(L, y);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index y on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_z(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int z = ((Int3)obj).z;
			LuaDLL.lua_pushinteger(L, z);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index z on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_zero(IntPtr L)
	{
		try
		{
			ToLua.PushValue(L, Int3.zero);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_one(IntPtr L)
	{
		try
		{
			ToLua.PushValue(L, Int3.one);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_half(IntPtr L)
	{
		try
		{
			ToLua.PushValue(L, Int3.half);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_forward(IntPtr L)
	{
		try
		{
			ToLua.PushValue(L, Int3.forward);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_up(IntPtr L)
	{
		try
		{
			ToLua.PushValue(L, Int3.up);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_right(IntPtr L)
	{
		try
		{
			ToLua.PushValue(L, Int3.right);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_magnitude(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float magnitude = ((Int3)obj).magnitude;
			LuaDLL.lua_pushnumber(L, magnitude);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index magnitude on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_LongMagnitude(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			long longMagnitude = ((Int3)obj).LongMagnitude;
			LuaDLL.tolua_pushint64(L, longMagnitude);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index LongMagnitude on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IntMagnitude(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Int intMagnitude = ((Int3)obj).IntMagnitude;
			ToLua.PushValue(L, intMagnitude);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IntMagnitude on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_costMagnitude(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int costMagnitude = ((Int3)obj).costMagnitude;
			LuaDLL.lua_pushinteger(L, costMagnitude);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index costMagnitude on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sqrMagnitude(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float sqrMagnitude = ((Int3)obj).sqrMagnitude;
			LuaDLL.lua_pushnumber(L, sqrMagnitude);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sqrMagnitude on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sqrMagnitudeLong(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			long sqrMagnitudeLong = ((Int3)obj).sqrMagnitudeLong;
			LuaDLL.tolua_pushint64(L, sqrMagnitudeLong);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sqrMagnitudeLong on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sqrMagnitudeLong2D(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			long sqrMagnitudeLong2D = ((Int3)obj).sqrMagnitudeLong2D;
			LuaDLL.tolua_pushint64(L, sqrMagnitudeLong2D);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sqrMagnitudeLong2D on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_magnitude2D(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int magnitude2D = ((Int3)obj).magnitude2D;
			LuaDLL.lua_pushinteger(L, magnitude2D);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index magnitude2D on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_abs(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Int3 abs = ((Int3)obj).abs;
			ToLua.PushValue(L, abs);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index abs on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_vec3(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 vec = ((Int3)obj).vec3;
			ToLua.Push(L, vec);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index vec3 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_xz(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Int2 xz = ((Int3)obj).xz;
			ToLua.PushValue(L, xz);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index xz on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_x(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Int3 @int = (Int3)obj;
			int x = (int)LuaDLL.luaL_checknumber(L, 2);
			@int.x = x;
			ToLua.SetBack(L, 1, @int);
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
			Int3 @int = (Int3)obj;
			int y = (int)LuaDLL.luaL_checknumber(L, 2);
			@int.y = y;
			ToLua.SetBack(L, 1, @int);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index y on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_z(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Int3 @int = (Int3)obj;
			int z = (int)LuaDLL.luaL_checknumber(L, 2);
			@int.z = z;
			ToLua.SetBack(L, 1, @int);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index z on a nil value");
		}
	}
}
