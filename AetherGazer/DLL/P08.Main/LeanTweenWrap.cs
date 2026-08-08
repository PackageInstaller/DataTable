using System;
using LuaInterface;
using UnityEngine;

public class LeanTweenWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(LeanTween), typeof(MonoBehaviour));
		L.RegFunction("init", init);
		L.RegFunction("reset", reset);
		L.RegFunction("Update", Update);
		L.RegFunction("update", update);
		L.RegFunction("removeTween", removeTween);
		L.RegFunction("add", add);
		L.RegFunction("closestRot", closestRot);
		L.RegFunction("cancelAll", cancelAll);
		L.RegFunction("cancel", cancel);
		L.RegFunction("descr", descr);
		L.RegFunction("description", description);
		L.RegFunction("descriptions", descriptions);
		L.RegFunction("pause", pause);
		L.RegFunction("pauseAll", pauseAll);
		L.RegFunction("resumeAll", resumeAll);
		L.RegFunction("resume", resume);
		L.RegFunction("isPaused", isPaused);
		L.RegFunction("isTweening", isTweening);
		L.RegFunction("drawBezierPath", drawBezierPath);
		L.RegFunction("logError", logError);
		L.RegFunction("options", options);
		L.RegFunction("play", play);
		L.RegFunction("sequence", sequence);
		L.RegFunction("alpha", alpha);
		L.RegFunction("textAlpha", textAlpha);
		L.RegFunction("alphaText", alphaText);
		L.RegFunction("alphaCanvas", alphaCanvas);
		L.RegFunction("alphaVertex", alphaVertex);
		L.RegFunction("color", color);
		L.RegFunction("textColor", textColor);
		L.RegFunction("colorText", colorText);
		L.RegFunction("delayedCall", delayedCall);
		L.RegFunction("destroyAfter", destroyAfter);
		L.RegFunction("move", move);
		L.RegFunction("moveSpline", moveSpline);
		L.RegFunction("moveSplineLocal", moveSplineLocal);
		L.RegFunction("moveMargin", moveMargin);
		L.RegFunction("moveX", moveX);
		L.RegFunction("moveY", moveY);
		L.RegFunction("moveZ", moveZ);
		L.RegFunction("moveLocal", moveLocal);
		L.RegFunction("moveLocalX", moveLocalX);
		L.RegFunction("moveLocalY", moveLocalY);
		L.RegFunction("moveLocalZ", moveLocalZ);
		L.RegFunction("rotate", rotate);
		L.RegFunction("rotateLocal", rotateLocal);
		L.RegFunction("rotateX", rotateX);
		L.RegFunction("rotateY", rotateY);
		L.RegFunction("rotateZ", rotateZ);
		L.RegFunction("rotateAround", rotateAround);
		L.RegFunction("rotateAroundLocal", rotateAroundLocal);
		L.RegFunction("scale", scale);
		L.RegFunction("scaleX", scaleX);
		L.RegFunction("scaleY", scaleY);
		L.RegFunction("scaleZ", scaleZ);
		L.RegFunction("value", value);
		L.RegFunction("delayedSound", delayedSound);
		L.RegFunction("size", size);
		L.RegFunction("tweenOnCurve", tweenOnCurve);
		L.RegFunction("tweenOnCurveVector", tweenOnCurveVector);
		L.RegFunction("easeOutQuadOpt", easeOutQuadOpt);
		L.RegFunction("easeInQuadOpt", easeInQuadOpt);
		L.RegFunction("easeInOutQuadOpt", easeInOutQuadOpt);
		L.RegFunction("linear", linear);
		L.RegFunction("clerp", clerp);
		L.RegFunction("spring", spring);
		L.RegFunction("easeInQuad", easeInQuad);
		L.RegFunction("easeOutQuad", easeOutQuad);
		L.RegFunction("easeInOutQuad", easeInOutQuad);
		L.RegFunction("easeInOutQuadOpt2", easeInOutQuadOpt2);
		L.RegFunction("easeInCubic", easeInCubic);
		L.RegFunction("easeOutCubic", easeOutCubic);
		L.RegFunction("easeInOutCubic", easeInOutCubic);
		L.RegFunction("easeInQuart", easeInQuart);
		L.RegFunction("easeOutQuart", easeOutQuart);
		L.RegFunction("easeInOutQuart", easeInOutQuart);
		L.RegFunction("easeInQuint", easeInQuint);
		L.RegFunction("easeOutQuint", easeOutQuint);
		L.RegFunction("easeInOutQuint", easeInOutQuint);
		L.RegFunction("easeInSine", easeInSine);
		L.RegFunction("easeOutSine", easeOutSine);
		L.RegFunction("easeInOutSine", easeInOutSine);
		L.RegFunction("easeInExpo", easeInExpo);
		L.RegFunction("easeOutExpo", easeOutExpo);
		L.RegFunction("easeInOutExpo", easeInOutExpo);
		L.RegFunction("easeInCirc", easeInCirc);
		L.RegFunction("easeOutCirc", easeOutCirc);
		L.RegFunction("easeInOutCirc", easeInOutCirc);
		L.RegFunction("easeInBounce", easeInBounce);
		L.RegFunction("easeOutBounce", easeOutBounce);
		L.RegFunction("easeInOutBounce", easeInOutBounce);
		L.RegFunction("easeInBack", easeInBack);
		L.RegFunction("easeOutBack", easeOutBack);
		L.RegFunction("easeInOutBack", easeInOutBack);
		L.RegFunction("easeInElastic", easeInElastic);
		L.RegFunction("easeOutElastic", easeOutElastic);
		L.RegFunction("easeInOutElastic", easeInOutElastic);
		L.RegFunction("followDamp", followDamp);
		L.RegFunction("followSpring", followSpring);
		L.RegFunction("followBounceOut", followBounceOut);
		L.RegFunction("followLinear", followLinear);
		L.RegFunction("addListener", addListener);
		L.RegFunction("removeListener", removeListener);
		L.RegFunction("dispatchEvent", dispatchEvent);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("throwErrors", get_throwErrors, set_throwErrors);
		L.RegVar("tau", get_tau, set_tau);
		L.RegVar("PI_DIV2", get_PI_DIV2, set_PI_DIV2);
		L.RegVar("dtEstimated", get_dtEstimated, set_dtEstimated);
		L.RegVar("dtManual", get_dtManual, set_dtManual);
		L.RegVar("dtActual", get_dtActual, set_dtActual);
		L.RegVar("punch", get_punch, set_punch);
		L.RegVar("shake", get_shake, set_shake);
		L.RegVar("startSearch", get_startSearch, set_startSearch);
		L.RegVar("d", get_d, set_d);
		L.RegVar("EVENTS_MAX", get_EVENTS_MAX, set_EVENTS_MAX);
		L.RegVar("LISTENERS_MAX", get_LISTENERS_MAX, set_LISTENERS_MAX);
		L.RegVar("maxSearch", get_maxSearch, null);
		L.RegVar("maxSimulataneousTweens", get_maxSimulataneousTweens, null);
		L.RegVar("tweensRunning", get_tweensRunning, null);
		L.RegVar("tweenEmpty", get_tweenEmpty, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int init(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 0:
				LeanTween.init();
				return 0;
			case 1:
				LeanTween.init((int)LuaDLL.luaL_checknumber(L, 1));
				return 0;
			case 2:
			{
				int maxSimultaneousTweens = (int)LuaDLL.luaL_checknumber(L, 1);
				int maxSimultaneousSequences = (int)LuaDLL.luaL_checknumber(L, 2);
				LeanTween.init(maxSimultaneousTweens, maxSimultaneousSequences);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.init");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int reset(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			LeanTween.reset();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Update(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((LeanTween)ToLua.CheckObject<LeanTween>(L, 1)).Update();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int update(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			LeanTween.update();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int removeTween(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				LeanTween.removeTween((int)LuaDLL.luaL_checknumber(L, 1));
				return 0;
			case 2:
			{
				int i = (int)LuaDLL.luaL_checknumber(L, 1);
				int uniqueId = (int)LuaDLL.luaL_checknumber(L, 2);
				LeanTween.removeTween(i, uniqueId);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.removeTween");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int add(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Vector3[] a = ToLua.CheckStructArray<Vector3>(L, 1);
			Vector3 b = ToLua.ToVector3(L, 2);
			Vector3[] array = LeanTween.add(a, b);
			ToLua.Push(L, array);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int closestRot(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			float num = (float)LuaDLL.luaL_checknumber(L, 1);
			float to = (float)LuaDLL.luaL_checknumber(L, 2);
			float num2 = LeanTween.closestRot(num, to);
			LuaDLL.lua_pushnumber(L, num2);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int cancelAll(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 0:
				LeanTween.cancelAll();
				return 0;
			case 1:
				LeanTween.cancelAll(LuaDLL.luaL_checkboolean(L, 1));
				return 0;
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.cancelAll");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int cancel(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<GameObject>(L, 1))
			{
				LeanTween.cancel((GameObject)ToLua.ToObject(L, 1));
				return 0;
			}
			if (num == 1 && TypeChecker.CheckTypes<RectTransform>(L, 1))
			{
				LeanTween.cancel((RectTransform)ToLua.ToObject(L, 1));
				return 0;
			}
			if (num == 1 && TypeChecker.CheckTypes<int>(L, 1))
			{
				LeanTween.cancel((int)LuaDLL.lua_tonumber(L, 1));
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<GameObject, bool>(L, 1))
			{
				GameObject gameObject = (GameObject)ToLua.ToObject(L, 1);
				bool callOnComplete = LuaDLL.lua_toboolean(L, 2);
				LeanTween.cancel(gameObject, callOnComplete);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<GameObject, int>(L, 1))
			{
				GameObject gameObject2 = (GameObject)ToLua.ToObject(L, 1);
				int uniqueId = (int)LuaDLL.lua_tonumber(L, 2);
				LeanTween.cancel(gameObject2, uniqueId);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<LTRect, int>(L, 1))
			{
				LTRect ltRect = (LTRect)ToLua.ToObject(L, 1);
				int uniqueId2 = (int)LuaDLL.lua_tonumber(L, 2);
				LeanTween.cancel(ltRect, uniqueId2);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<int, bool>(L, 1))
			{
				int uniqueId3 = (int)LuaDLL.lua_tonumber(L, 1);
				bool callOnComplete2 = LuaDLL.lua_toboolean(L, 2);
				LeanTween.cancel(uniqueId3, callOnComplete2);
				return 0;
			}
			if (num == 3)
			{
				GameObject gameObject3 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				int uniqueId4 = (int)LuaDLL.luaL_checknumber(L, 2);
				bool callOnComplete3 = LuaDLL.luaL_checkboolean(L, 3);
				LeanTween.cancel(gameObject3, uniqueId4, callOnComplete3);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.cancel");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int descr(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = LeanTween.descr((int)LuaDLL.luaL_checknumber(L, 1));
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int description(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = LeanTween.description((int)LuaDLL.luaL_checknumber(L, 1));
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int descriptions(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 0:
			{
				LTDescr[] array2 = LeanTween.descriptions();
				ToLua.Push(L, array2);
				return 1;
			}
			case 1:
			{
				LTDescr[] array = LeanTween.descriptions((GameObject)ToLua.CheckObject(L, 1, typeof(GameObject)));
				ToLua.Push(L, array);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.descriptions");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int pause(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<int>(L, 1))
			{
				LeanTween.pause((int)LuaDLL.lua_tonumber(L, 1));
				return 0;
			}
			if (num == 1 && TypeChecker.CheckTypes<GameObject>(L, 1))
			{
				LeanTween.pause((GameObject)ToLua.ToObject(L, 1));
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.pause");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int pauseAll(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			LeanTween.pauseAll();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int resumeAll(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			LeanTween.resumeAll();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int resume(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<int>(L, 1))
			{
				LeanTween.resume((int)LuaDLL.lua_tonumber(L, 1));
				return 0;
			}
			if (num == 1 && TypeChecker.CheckTypes<GameObject>(L, 1))
			{
				LeanTween.resume((GameObject)ToLua.ToObject(L, 1));
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.resume");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int isPaused(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 0:
			{
				bool flag2 = LeanTween.isPaused();
				LuaDLL.lua_pushboolean(L, flag2);
				return 1;
			}
			case 1:
				if (TypeChecker.CheckTypes<GameObject>(L, 1))
				{
					bool flag = LeanTween.isPaused((GameObject)ToLua.ToObject(L, 1));
					LuaDLL.lua_pushboolean(L, flag);
					return 1;
				}
				break;
			}
			if (num == 1 && TypeChecker.CheckTypes<RectTransform>(L, 1))
			{
				bool flag3 = LeanTween.isPaused((RectTransform)ToLua.ToObject(L, 1));
				LuaDLL.lua_pushboolean(L, flag3);
				return 1;
			}
			if (num == 1 && TypeChecker.CheckTypes<int>(L, 1))
			{
				bool flag4 = LeanTween.isPaused((int)LuaDLL.lua_tonumber(L, 1));
				LuaDLL.lua_pushboolean(L, flag4);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.isPaused");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int isTweening(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 0:
			{
				bool flag2 = LeanTween.isTweening();
				LuaDLL.lua_pushboolean(L, flag2);
				return 1;
			}
			case 1:
				if (TypeChecker.CheckTypes<GameObject>(L, 1))
				{
					bool flag = LeanTween.isTweening((GameObject)ToLua.ToObject(L, 1));
					LuaDLL.lua_pushboolean(L, flag);
					return 1;
				}
				break;
			}
			if (num == 1 && TypeChecker.CheckTypes<RectTransform>(L, 1))
			{
				bool flag3 = LeanTween.isTweening((RectTransform)ToLua.ToObject(L, 1));
				LuaDLL.lua_pushboolean(L, flag3);
				return 1;
			}
			if (num == 1 && TypeChecker.CheckTypes<int>(L, 1))
			{
				bool flag4 = LeanTween.isTweening((int)LuaDLL.lua_tonumber(L, 1));
				LuaDLL.lua_pushboolean(L, flag4);
				return 1;
			}
			if (num == 1 && TypeChecker.CheckTypes<LTRect>(L, 1))
			{
				bool flag5 = LeanTween.isTweening((LTRect)ToLua.ToObject(L, 1));
				LuaDLL.lua_pushboolean(L, flag5);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.isTweening");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int drawBezierPath(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 4:
			{
				Vector3 a3 = ToLua.ToVector3(L, 1);
				Vector3 b3 = ToLua.ToVector3(L, 2);
				Vector3 c3 = ToLua.ToVector3(L, 3);
				Vector3 d3 = ToLua.ToVector3(L, 4);
				LeanTween.drawBezierPath(a3, b3, c3, d3);
				return 0;
			}
			case 5:
			{
				Vector3 a2 = ToLua.ToVector3(L, 1);
				Vector3 b2 = ToLua.ToVector3(L, 2);
				Vector3 c2 = ToLua.ToVector3(L, 3);
				Vector3 d2 = ToLua.ToVector3(L, 4);
				float arrowSize2 = (float)LuaDLL.luaL_checknumber(L, 5);
				LeanTween.drawBezierPath(a2, b2, c2, d2, arrowSize2);
				return 0;
			}
			case 6:
			{
				Vector3 a = ToLua.ToVector3(L, 1);
				Vector3 b = ToLua.ToVector3(L, 2);
				Vector3 c = ToLua.ToVector3(L, 3);
				Vector3 d = ToLua.ToVector3(L, 4);
				float arrowSize = (float)LuaDLL.luaL_checknumber(L, 5);
				Transform arrowTransform = (Transform)ToLua.CheckObject<Transform>(L, 6);
				LeanTween.drawBezierPath(a, b, c, d, arrowSize, arrowTransform);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.drawBezierPath");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int logError(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			object obj = LeanTween.logError(ToLua.CheckString(L, 1));
			ToLua.Push(L, obj);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int options(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 0:
			{
				LTDescr o2 = LeanTween.options();
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 1:
			{
				LTDescr o = LeanTween.options((LTDescr)ToLua.CheckObject<LTDescr>(L, 1));
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.options");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int play(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RectTransform rectTransform = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			Sprite[] sprites = ToLua.CheckObjectArray<Sprite>(L, 2);
			LTDescr o = LeanTween.play(rectTransform, sprites);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int sequence(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 0:
			{
				LTSeq o2 = LeanTween.sequence();
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 1:
			{
				LTSeq o = LeanTween.sequence(LuaDLL.luaL_checkboolean(L, 1));
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.sequence");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int alpha(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<GameObject, float, float>(L, 1))
			{
				GameObject gameObject = (GameObject)ToLua.ToObject(L, 1);
				float to = (float)LuaDLL.lua_tonumber(L, 2);
				float time = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o = LeanTween.alpha(gameObject, to, time);
				ToLua.PushObject(L, o);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<LTRect, float, float>(L, 1))
			{
				LTRect ltRect = (LTRect)ToLua.ToObject(L, 1);
				float to2 = (float)LuaDLL.lua_tonumber(L, 2);
				float time2 = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o2 = LeanTween.alpha(ltRect, to2, time2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<RectTransform, float, float>(L, 1))
			{
				RectTransform rectTrans = (RectTransform)ToLua.ToObject(L, 1);
				float to3 = (float)LuaDLL.lua_tonumber(L, 2);
				float time3 = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o3 = LeanTween.alpha(rectTrans, to3, time3);
				ToLua.PushObject(L, o3);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.alpha");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int textAlpha(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RectTransform rectTransform = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			float to = (float)LuaDLL.luaL_checknumber(L, 2);
			float time = (float)LuaDLL.luaL_checknumber(L, 3);
			LTDescr o = LeanTween.textAlpha(rectTransform, to, time);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int alphaText(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RectTransform rectTransform = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			float to = (float)LuaDLL.luaL_checknumber(L, 2);
			float time = (float)LuaDLL.luaL_checknumber(L, 3);
			LTDescr o = LeanTween.alphaText(rectTransform, to, time);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int alphaCanvas(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			CanvasGroup canvasGroup = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
			float to = (float)LuaDLL.luaL_checknumber(L, 2);
			float time = (float)LuaDLL.luaL_checknumber(L, 3);
			LTDescr o = LeanTween.alphaCanvas(canvasGroup, to, time);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int alphaVertex(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			GameObject gameObject = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			float to = (float)LuaDLL.luaL_checknumber(L, 2);
			float time = (float)LuaDLL.luaL_checknumber(L, 3);
			LTDescr o = LeanTween.alphaVertex(gameObject, to, time);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int color(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<GameObject, Color, float>(L, 1))
			{
				GameObject gameObject = (GameObject)ToLua.ToObject(L, 1);
				Color to = ToLua.ToColor(L, 2);
				float time = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o = LeanTween.color(gameObject, to, time);
				ToLua.PushObject(L, o);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<RectTransform, Color, float>(L, 1))
			{
				RectTransform rectTrans = (RectTransform)ToLua.ToObject(L, 1);
				Color to2 = ToLua.ToColor(L, 2);
				float time2 = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o2 = LeanTween.color(rectTrans, to2, time2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.color");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int textColor(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RectTransform rectTransform = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			Color to = ToLua.ToColor(L, 2);
			float time = (float)LuaDLL.luaL_checknumber(L, 3);
			LTDescr o = LeanTween.textColor(rectTransform, to, time);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int colorText(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RectTransform rectTransform = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			Color to = ToLua.ToColor(L, 2);
			float time = (float)LuaDLL.luaL_checknumber(L, 3);
			LTDescr o = LeanTween.colorText(rectTransform, to, time);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int delayedCall(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<Action>(L, 2))
			{
				float delayTime = (float)LuaDLL.luaL_checknumber(L, 1);
				Action callback = (Action)ToLua.ToObject(L, 2);
				LTDescr o = LeanTween.delayedCall(delayTime, callback);
				ToLua.PushObject(L, o);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<Action<object>>(L, 2))
			{
				float delayTime2 = (float)LuaDLL.luaL_checknumber(L, 1);
				Action<object> callback2 = (Action<object>)ToLua.ToObject(L, 2);
				LTDescr o2 = LeanTween.delayedCall(delayTime2, callback2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<Action>(L, 3))
			{
				GameObject gameObject = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				float delayTime3 = (float)LuaDLL.luaL_checknumber(L, 2);
				Action callback3 = (Action)ToLua.ToObject(L, 3);
				LTDescr o3 = LeanTween.delayedCall(gameObject, delayTime3, callback3);
				ToLua.PushObject(L, o3);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<Action<object>>(L, 3))
			{
				GameObject gameObject2 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				float delayTime4 = (float)LuaDLL.luaL_checknumber(L, 2);
				Action<object> callback4 = (Action<object>)ToLua.ToObject(L, 3);
				LTDescr o4 = LeanTween.delayedCall(gameObject2, delayTime4, callback4);
				ToLua.PushObject(L, o4);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.delayedCall");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int destroyAfter(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTRect rect = (LTRect)ToLua.CheckObject<LTRect>(L, 1);
			float delayTime = (float)LuaDLL.luaL_checknumber(L, 2);
			LTDescr o = LeanTween.destroyAfter(rect, delayTime);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int move(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<GameObject, Vector3, float>(L, 1))
			{
				GameObject gameObject = (GameObject)ToLua.ToObject(L, 1);
				Vector3 to = ToLua.ToVector3(L, 2);
				float time = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o = LeanTween.move(gameObject, to, time);
				ToLua.PushObject(L, o);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<GameObject, Vector2, float>(L, 1))
			{
				GameObject gameObject2 = (GameObject)ToLua.ToObject(L, 1);
				Vector2 to2 = ToLua.ToVector2(L, 2);
				float time2 = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o2 = LeanTween.move(gameObject2, to2, time2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<GameObject, Vector3[], float>(L, 1))
			{
				GameObject gameObject3 = (GameObject)ToLua.ToObject(L, 1);
				Vector3[] to3 = ToLua.ToStructArray<Vector3>(L, 2);
				float time3 = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o3 = LeanTween.move(gameObject3, to3, time3);
				ToLua.PushObject(L, o3);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<GameObject, LTBezierPath, float>(L, 1))
			{
				GameObject gameObject4 = (GameObject)ToLua.ToObject(L, 1);
				LTBezierPath to4 = (LTBezierPath)ToLua.ToObject(L, 2);
				float time4 = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o4 = LeanTween.move(gameObject4, to4, time4);
				ToLua.PushObject(L, o4);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<GameObject, LTSpline, float>(L, 1))
			{
				GameObject gameObject5 = (GameObject)ToLua.ToObject(L, 1);
				LTSpline to5 = (LTSpline)ToLua.ToObject(L, 2);
				float time5 = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o5 = LeanTween.move(gameObject5, to5, time5);
				ToLua.PushObject(L, o5);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<LTRect, Vector2, float>(L, 1))
			{
				LTRect ltRect = (LTRect)ToLua.ToObject(L, 1);
				Vector2 to6 = ToLua.ToVector2(L, 2);
				float time6 = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o6 = LeanTween.move(ltRect, to6, time6);
				ToLua.PushObject(L, o6);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<GameObject, Transform, float>(L, 1))
			{
				GameObject gameObject6 = (GameObject)ToLua.ToObject(L, 1);
				Transform to7 = (Transform)ToLua.ToObject(L, 2);
				float time7 = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o7 = LeanTween.move(gameObject6, to7, time7);
				ToLua.PushObject(L, o7);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<RectTransform, Vector3, float>(L, 1))
			{
				RectTransform rectTrans = (RectTransform)ToLua.ToObject(L, 1);
				Vector3 to8 = ToLua.ToVector3(L, 2);
				float time8 = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o8 = LeanTween.move(rectTrans, to8, time8);
				ToLua.PushObject(L, o8);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.move");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int moveSpline(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<Vector3[], float>(L, 2))
			{
				GameObject gameObject = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				Vector3[] to = ToLua.ToStructArray<Vector3>(L, 2);
				float time = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o = LeanTween.moveSpline(gameObject, to, time);
				ToLua.PushObject(L, o);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<LTSpline, float>(L, 2))
			{
				GameObject gameObject2 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				LTSpline to2 = (LTSpline)ToLua.ToObject(L, 2);
				float time2 = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o2 = LeanTween.moveSpline(gameObject2, to2, time2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.moveSpline");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int moveSplineLocal(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			GameObject gameObject = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			Vector3[] to = ToLua.CheckStructArray<Vector3>(L, 2);
			float time = (float)LuaDLL.luaL_checknumber(L, 3);
			LTDescr o = LeanTween.moveSplineLocal(gameObject, to, time);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int moveMargin(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			LTRect ltRect = (LTRect)ToLua.CheckObject<LTRect>(L, 1);
			Vector2 to = ToLua.ToVector2(L, 2);
			float time = (float)LuaDLL.luaL_checknumber(L, 3);
			LTDescr o = LeanTween.moveMargin(ltRect, to, time);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int moveX(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<GameObject, float, float>(L, 1))
			{
				GameObject gameObject = (GameObject)ToLua.ToObject(L, 1);
				float to = (float)LuaDLL.lua_tonumber(L, 2);
				float time = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o = LeanTween.moveX(gameObject, to, time);
				ToLua.PushObject(L, o);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<RectTransform, float, float>(L, 1))
			{
				RectTransform rectTrans = (RectTransform)ToLua.ToObject(L, 1);
				float to2 = (float)LuaDLL.lua_tonumber(L, 2);
				float time2 = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o2 = LeanTween.moveX(rectTrans, to2, time2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.moveX");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int moveY(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<GameObject, float, float>(L, 1))
			{
				GameObject gameObject = (GameObject)ToLua.ToObject(L, 1);
				float to = (float)LuaDLL.lua_tonumber(L, 2);
				float time = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o = LeanTween.moveY(gameObject, to, time);
				ToLua.PushObject(L, o);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<RectTransform, float, float>(L, 1))
			{
				RectTransform rectTrans = (RectTransform)ToLua.ToObject(L, 1);
				float to2 = (float)LuaDLL.lua_tonumber(L, 2);
				float time2 = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o2 = LeanTween.moveY(rectTrans, to2, time2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.moveY");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int moveZ(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<GameObject, float, float>(L, 1))
			{
				GameObject gameObject = (GameObject)ToLua.ToObject(L, 1);
				float to = (float)LuaDLL.lua_tonumber(L, 2);
				float time = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o = LeanTween.moveZ(gameObject, to, time);
				ToLua.PushObject(L, o);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<RectTransform, float, float>(L, 1))
			{
				RectTransform rectTrans = (RectTransform)ToLua.ToObject(L, 1);
				float to2 = (float)LuaDLL.lua_tonumber(L, 2);
				float time2 = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o2 = LeanTween.moveZ(rectTrans, to2, time2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.moveZ");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int moveLocal(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<Vector3, float>(L, 2))
			{
				GameObject gameObject = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				Vector3 to = ToLua.ToVector3(L, 2);
				float time = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o = LeanTween.moveLocal(gameObject, to, time);
				ToLua.PushObject(L, o);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<Vector3[], float>(L, 2))
			{
				GameObject gameObject2 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				Vector3[] to2 = ToLua.ToStructArray<Vector3>(L, 2);
				float time2 = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o2 = LeanTween.moveLocal(gameObject2, to2, time2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<LTBezierPath, float>(L, 2))
			{
				GameObject gameObject3 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				LTBezierPath to3 = (LTBezierPath)ToLua.ToObject(L, 2);
				float time3 = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o3 = LeanTween.moveLocal(gameObject3, to3, time3);
				ToLua.PushObject(L, o3);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<LTSpline, float>(L, 2))
			{
				GameObject gameObject4 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				LTSpline to4 = (LTSpline)ToLua.ToObject(L, 2);
				float time4 = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o4 = LeanTween.moveLocal(gameObject4, to4, time4);
				ToLua.PushObject(L, o4);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.moveLocal");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int moveLocalX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			GameObject gameObject = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			float to = (float)LuaDLL.luaL_checknumber(L, 2);
			float time = (float)LuaDLL.luaL_checknumber(L, 3);
			LTDescr o = LeanTween.moveLocalX(gameObject, to, time);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int moveLocalY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			GameObject gameObject = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			float to = (float)LuaDLL.luaL_checknumber(L, 2);
			float time = (float)LuaDLL.luaL_checknumber(L, 3);
			LTDescr o = LeanTween.moveLocalY(gameObject, to, time);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int moveLocalZ(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			GameObject gameObject = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			float to = (float)LuaDLL.luaL_checknumber(L, 2);
			float time = (float)LuaDLL.luaL_checknumber(L, 3);
			LTDescr o = LeanTween.moveLocalZ(gameObject, to, time);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int rotate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<GameObject, Vector3, float>(L, 1))
			{
				GameObject gameObject = (GameObject)ToLua.ToObject(L, 1);
				Vector3 to = ToLua.ToVector3(L, 2);
				float time = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o = LeanTween.rotate(gameObject, to, time);
				ToLua.PushObject(L, o);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<LTRect, float, float>(L, 1))
			{
				LTRect ltRect = (LTRect)ToLua.ToObject(L, 1);
				float to2 = (float)LuaDLL.lua_tonumber(L, 2);
				float time2 = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o2 = LeanTween.rotate(ltRect, to2, time2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<RectTransform, float, float>(L, 1))
			{
				RectTransform rectTrans = (RectTransform)ToLua.ToObject(L, 1);
				float to3 = (float)LuaDLL.lua_tonumber(L, 2);
				float time3 = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o3 = LeanTween.rotate(rectTrans, to3, time3);
				ToLua.PushObject(L, o3);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<RectTransform, Vector3, float>(L, 1))
			{
				RectTransform rectTrans2 = (RectTransform)ToLua.ToObject(L, 1);
				Vector3 to4 = ToLua.ToVector3(L, 2);
				float time4 = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o4 = LeanTween.rotate(rectTrans2, to4, time4);
				ToLua.PushObject(L, o4);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.rotate");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int rotateLocal(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			GameObject gameObject = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			Vector3 to = ToLua.ToVector3(L, 2);
			float time = (float)LuaDLL.luaL_checknumber(L, 3);
			LTDescr o = LeanTween.rotateLocal(gameObject, to, time);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int rotateX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			GameObject gameObject = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			float to = (float)LuaDLL.luaL_checknumber(L, 2);
			float time = (float)LuaDLL.luaL_checknumber(L, 3);
			LTDescr o = LeanTween.rotateX(gameObject, to, time);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int rotateY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			GameObject gameObject = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			float to = (float)LuaDLL.luaL_checknumber(L, 2);
			float time = (float)LuaDLL.luaL_checknumber(L, 3);
			LTDescr o = LeanTween.rotateY(gameObject, to, time);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int rotateZ(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			GameObject gameObject = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			float to = (float)LuaDLL.luaL_checknumber(L, 2);
			float time = (float)LuaDLL.luaL_checknumber(L, 3);
			LTDescr o = LeanTween.rotateZ(gameObject, to, time);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int rotateAround(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 4 && TypeChecker.CheckTypes<GameObject, Vector3, float, float>(L, 1))
			{
				GameObject gameObject = (GameObject)ToLua.ToObject(L, 1);
				Vector3 axis = ToLua.ToVector3(L, 2);
				float num2 = (float)LuaDLL.lua_tonumber(L, 3);
				float time = (float)LuaDLL.lua_tonumber(L, 4);
				LTDescr o = LeanTween.rotateAround(gameObject, axis, num2, time);
				ToLua.PushObject(L, o);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<RectTransform, Vector3, float, float>(L, 1))
			{
				RectTransform rectTrans = (RectTransform)ToLua.ToObject(L, 1);
				Vector3 axis2 = ToLua.ToVector3(L, 2);
				float to = (float)LuaDLL.lua_tonumber(L, 3);
				float time2 = (float)LuaDLL.lua_tonumber(L, 4);
				LTDescr o2 = LeanTween.rotateAround(rectTrans, axis2, to, time2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.rotateAround");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int rotateAroundLocal(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 4 && TypeChecker.CheckTypes<GameObject, Vector3, float, float>(L, 1))
			{
				GameObject gameObject = (GameObject)ToLua.ToObject(L, 1);
				Vector3 axis = ToLua.ToVector3(L, 2);
				float num2 = (float)LuaDLL.lua_tonumber(L, 3);
				float time = (float)LuaDLL.lua_tonumber(L, 4);
				LTDescr o = LeanTween.rotateAroundLocal(gameObject, axis, num2, time);
				ToLua.PushObject(L, o);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<RectTransform, Vector3, float, float>(L, 1))
			{
				RectTransform rectTrans = (RectTransform)ToLua.ToObject(L, 1);
				Vector3 axis2 = ToLua.ToVector3(L, 2);
				float to = (float)LuaDLL.lua_tonumber(L, 3);
				float time2 = (float)LuaDLL.lua_tonumber(L, 4);
				LTDescr o2 = LeanTween.rotateAroundLocal(rectTrans, axis2, to, time2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.rotateAroundLocal");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int scale(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<GameObject, Vector3, float>(L, 1))
			{
				GameObject gameObject = (GameObject)ToLua.ToObject(L, 1);
				Vector3 to = ToLua.ToVector3(L, 2);
				float time = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o = LeanTween.scale(gameObject, to, time);
				ToLua.PushObject(L, o);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<LTRect, Vector2, float>(L, 1))
			{
				LTRect ltRect = (LTRect)ToLua.ToObject(L, 1);
				Vector2 to2 = ToLua.ToVector2(L, 2);
				float time2 = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o2 = LeanTween.scale(ltRect, to2, time2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<RectTransform, Vector3, float>(L, 1))
			{
				RectTransform rectTrans = (RectTransform)ToLua.ToObject(L, 1);
				Vector3 to3 = ToLua.ToVector3(L, 2);
				float time3 = (float)LuaDLL.lua_tonumber(L, 3);
				LTDescr o3 = LeanTween.scale(rectTrans, to3, time3);
				ToLua.PushObject(L, o3);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.scale");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int scaleX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			GameObject gameObject = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			float to = (float)LuaDLL.luaL_checknumber(L, 2);
			float time = (float)LuaDLL.luaL_checknumber(L, 3);
			LTDescr o = LeanTween.scaleX(gameObject, to, time);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int scaleY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			GameObject gameObject = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			float to = (float)LuaDLL.luaL_checknumber(L, 2);
			float time = (float)LuaDLL.luaL_checknumber(L, 3);
			LTDescr o = LeanTween.scaleY(gameObject, to, time);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int scaleZ(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			GameObject gameObject = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			float to = (float)LuaDLL.luaL_checknumber(L, 2);
			float time = (float)LuaDLL.luaL_checknumber(L, 3);
			LTDescr o = LeanTween.scaleZ(gameObject, to, time);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int value(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 3:
			{
				float num3 = (float)LuaDLL.luaL_checknumber(L, 1);
				float to2 = (float)LuaDLL.luaL_checknumber(L, 2);
				float time2 = (float)LuaDLL.luaL_checknumber(L, 3);
				LTDescr o2 = LeanTween.value(num3, to2, time2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 4:
				if (TypeChecker.CheckTypes<float, float, float>(L, 2))
				{
					GameObject gameObject = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
					float num2 = (float)LuaDLL.lua_tonumber(L, 2);
					float to = (float)LuaDLL.lua_tonumber(L, 3);
					float time = (float)LuaDLL.lua_tonumber(L, 4);
					LTDescr o = LeanTween.value(gameObject, num2, to, time);
					ToLua.PushObject(L, o);
					return 1;
				}
				break;
			}
			if (num == 4 && TypeChecker.CheckTypes<Vector2, Vector2, float>(L, 2))
			{
				GameObject gameObject2 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				Vector2 vector = ToLua.ToVector2(L, 2);
				Vector2 to3 = ToLua.ToVector2(L, 3);
				float time3 = (float)LuaDLL.lua_tonumber(L, 4);
				LTDescr o3 = LeanTween.value(gameObject2, vector, to3, time3);
				ToLua.PushObject(L, o3);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<Vector3, Vector3, float>(L, 2))
			{
				GameObject gameObject3 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				Vector3 vector2 = ToLua.ToVector3(L, 2);
				Vector3 to4 = ToLua.ToVector3(L, 3);
				float time4 = (float)LuaDLL.lua_tonumber(L, 4);
				LTDescr o4 = LeanTween.value(gameObject3, vector2, to4, time4);
				ToLua.PushObject(L, o4);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<Color, Color, float>(L, 2))
			{
				GameObject gameObject4 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				Color color = ToLua.ToColor(L, 2);
				Color to5 = ToLua.ToColor(L, 3);
				float time5 = (float)LuaDLL.lua_tonumber(L, 4);
				LTDescr o5 = LeanTween.value(gameObject4, color, to5, time5);
				ToLua.PushObject(L, o5);
				return 1;
			}
			if (num == 5 && TypeChecker.CheckTypes<Action<float>, float, float, float>(L, 2))
			{
				GameObject gameObject5 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				Action<float> callOnUpdate = (Action<float>)ToLua.ToObject(L, 2);
				float num4 = (float)LuaDLL.lua_tonumber(L, 3);
				float to6 = (float)LuaDLL.lua_tonumber(L, 4);
				float time6 = (float)LuaDLL.lua_tonumber(L, 5);
				LTDescr o6 = LeanTween.value(gameObject5, callOnUpdate, num4, to6, time6);
				ToLua.PushObject(L, o6);
				return 1;
			}
			if (num == 5 && TypeChecker.CheckTypes<Action<float, float>, float, float, float>(L, 2))
			{
				GameObject gameObject6 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				Action<float, float> callOnUpdateRatio = (Action<float, float>)ToLua.ToObject(L, 2);
				float num5 = (float)LuaDLL.lua_tonumber(L, 3);
				float to7 = (float)LuaDLL.lua_tonumber(L, 4);
				float time7 = (float)LuaDLL.lua_tonumber(L, 5);
				LTDescr o7 = LeanTween.value(gameObject6, callOnUpdateRatio, num5, to7, time7);
				ToLua.PushObject(L, o7);
				return 1;
			}
			if (num == 5 && TypeChecker.CheckTypes<Action<Color>, Color, Color, float>(L, 2))
			{
				GameObject gameObject7 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				Action<Color> callOnUpdate2 = (Action<Color>)ToLua.ToObject(L, 2);
				Color color2 = ToLua.ToColor(L, 3);
				Color to8 = ToLua.ToColor(L, 4);
				float time8 = (float)LuaDLL.lua_tonumber(L, 5);
				LTDescr o8 = LeanTween.value(gameObject7, callOnUpdate2, color2, to8, time8);
				ToLua.PushObject(L, o8);
				return 1;
			}
			if (num == 5 && TypeChecker.CheckTypes<Action<Color, object>, Color, Color, float>(L, 2))
			{
				GameObject gameObject8 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				Action<Color, object> callOnUpdate3 = (Action<Color, object>)ToLua.ToObject(L, 2);
				Color color3 = ToLua.ToColor(L, 3);
				Color to9 = ToLua.ToColor(L, 4);
				float time9 = (float)LuaDLL.lua_tonumber(L, 5);
				LTDescr o9 = LeanTween.value(gameObject8, callOnUpdate3, color3, to9, time9);
				ToLua.PushObject(L, o9);
				return 1;
			}
			if (num == 5 && TypeChecker.CheckTypes<Action<Vector2>, Vector2, Vector2, float>(L, 2))
			{
				GameObject gameObject9 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				Action<Vector2> callOnUpdate4 = (Action<Vector2>)ToLua.ToObject(L, 2);
				Vector2 vector3 = ToLua.ToVector2(L, 3);
				Vector2 to10 = ToLua.ToVector2(L, 4);
				float time10 = (float)LuaDLL.lua_tonumber(L, 5);
				LTDescr o10 = LeanTween.value(gameObject9, callOnUpdate4, vector3, to10, time10);
				ToLua.PushObject(L, o10);
				return 1;
			}
			if (num == 5 && TypeChecker.CheckTypes<Action<Vector3>, Vector3, Vector3, float>(L, 2))
			{
				GameObject gameObject10 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				Action<Vector3> callOnUpdate5 = (Action<Vector3>)ToLua.ToObject(L, 2);
				Vector3 vector4 = ToLua.ToVector3(L, 3);
				Vector3 to11 = ToLua.ToVector3(L, 4);
				float time11 = (float)LuaDLL.lua_tonumber(L, 5);
				LTDescr o11 = LeanTween.value(gameObject10, callOnUpdate5, vector4, to11, time11);
				ToLua.PushObject(L, o11);
				return 1;
			}
			if (num == 5 && TypeChecker.CheckTypes<Action<float, object>, float, float, float>(L, 2))
			{
				GameObject gameObject11 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				Action<float, object> callOnUpdate6 = (Action<float, object>)ToLua.ToObject(L, 2);
				float num6 = (float)LuaDLL.lua_tonumber(L, 3);
				float to12 = (float)LuaDLL.lua_tonumber(L, 4);
				float time12 = (float)LuaDLL.lua_tonumber(L, 5);
				LTDescr o12 = LeanTween.value(gameObject11, callOnUpdate6, num6, to12, time12);
				ToLua.PushObject(L, o12);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.value");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int delayedSound(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				AudioClip audio2 = (AudioClip)ToLua.CheckObject(L, 1, typeof(AudioClip));
				Vector3 pos2 = ToLua.ToVector3(L, 2);
				float volume2 = (float)LuaDLL.luaL_checknumber(L, 3);
				LTDescr o2 = LeanTween.delayedSound(audio2, pos2, volume2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 4:
			{
				GameObject gameObject = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				AudioClip audio = (AudioClip)ToLua.CheckObject(L, 2, typeof(AudioClip));
				Vector3 pos = ToLua.ToVector3(L, 3);
				float volume = (float)LuaDLL.luaL_checknumber(L, 4);
				LTDescr o = LeanTween.delayedSound(gameObject, audio, pos, volume);
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.delayedSound");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int size(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RectTransform rectTrans = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			Vector2 to = ToLua.ToVector2(L, 2);
			float time = (float)LuaDLL.luaL_checknumber(L, 3);
			LTDescr o = LeanTween.size(rectTrans, to, time);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int tweenOnCurve(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr tweenDescr = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			float ratioPassed = (float)LuaDLL.luaL_checknumber(L, 2);
			float num = LeanTween.tweenOnCurve(tweenDescr, ratioPassed);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int tweenOnCurveVector(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr tweenDescr = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			float ratioPassed = (float)LuaDLL.luaL_checknumber(L, 2);
			Vector3 v = LeanTween.tweenOnCurveVector(tweenDescr, ratioPassed);
			ToLua.Push(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeOutQuadOpt(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float diff = (float)LuaDLL.luaL_checknumber(L, 2);
			float ratioPassed = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.easeOutQuadOpt(start, diff, ratioPassed);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeInQuadOpt(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float diff = (float)LuaDLL.luaL_checknumber(L, 2);
			float ratioPassed = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.easeInQuadOpt(start, diff, ratioPassed);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeInOutQuadOpt(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<float, float, float>(L, 1))
			{
				float start = (float)LuaDLL.lua_tonumber(L, 1);
				float diff = (float)LuaDLL.lua_tonumber(L, 2);
				float ratioPassed = (float)LuaDLL.lua_tonumber(L, 3);
				float num2 = LeanTween.easeInOutQuadOpt(start, diff, ratioPassed);
				LuaDLL.lua_pushnumber(L, num2);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<Vector3, Vector3, float>(L, 1))
			{
				Vector3 start2 = ToLua.ToVector3(L, 1);
				Vector3 diff2 = ToLua.ToVector3(L, 2);
				float ratioPassed2 = (float)LuaDLL.lua_tonumber(L, 3);
				Vector3 v = LeanTween.easeInOutQuadOpt(start2, diff2, ratioPassed2);
				ToLua.Push(L, v);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.easeInOutQuadOpt");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int linear(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float end = (float)LuaDLL.luaL_checknumber(L, 2);
			float val = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.linear(start, end, val);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int clerp(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float end = (float)LuaDLL.luaL_checknumber(L, 2);
			float val = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.clerp(start, end, val);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int spring(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float end = (float)LuaDLL.luaL_checknumber(L, 2);
			float val = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.spring(start, end, val);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeInQuad(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float end = (float)LuaDLL.luaL_checknumber(L, 2);
			float val = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.easeInQuad(start, end, val);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeOutQuad(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float end = (float)LuaDLL.luaL_checknumber(L, 2);
			float val = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.easeOutQuad(start, end, val);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeInOutQuad(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float end = (float)LuaDLL.luaL_checknumber(L, 2);
			float val = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.easeInOutQuad(start, end, val);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeInOutQuadOpt2(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float diffBy = (float)LuaDLL.luaL_checknumber(L, 2);
			float val = (float)LuaDLL.luaL_checknumber(L, 3);
			float val2 = (float)LuaDLL.luaL_checknumber(L, 4);
			float num = LeanTween.easeInOutQuadOpt2(start, diffBy, val, val2);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeInCubic(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float end = (float)LuaDLL.luaL_checknumber(L, 2);
			float val = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.easeInCubic(start, end, val);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeOutCubic(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float end = (float)LuaDLL.luaL_checknumber(L, 2);
			float val = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.easeOutCubic(start, end, val);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeInOutCubic(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float end = (float)LuaDLL.luaL_checknumber(L, 2);
			float val = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.easeInOutCubic(start, end, val);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeInQuart(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float end = (float)LuaDLL.luaL_checknumber(L, 2);
			float val = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.easeInQuart(start, end, val);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeOutQuart(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float end = (float)LuaDLL.luaL_checknumber(L, 2);
			float val = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.easeOutQuart(start, end, val);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeInOutQuart(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float end = (float)LuaDLL.luaL_checknumber(L, 2);
			float val = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.easeInOutQuart(start, end, val);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeInQuint(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float end = (float)LuaDLL.luaL_checknumber(L, 2);
			float val = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.easeInQuint(start, end, val);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeOutQuint(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float end = (float)LuaDLL.luaL_checknumber(L, 2);
			float val = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.easeOutQuint(start, end, val);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeInOutQuint(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float end = (float)LuaDLL.luaL_checknumber(L, 2);
			float val = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.easeInOutQuint(start, end, val);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeInSine(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float end = (float)LuaDLL.luaL_checknumber(L, 2);
			float val = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.easeInSine(start, end, val);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeOutSine(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float end = (float)LuaDLL.luaL_checknumber(L, 2);
			float val = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.easeOutSine(start, end, val);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeInOutSine(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float end = (float)LuaDLL.luaL_checknumber(L, 2);
			float val = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.easeInOutSine(start, end, val);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeInExpo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float end = (float)LuaDLL.luaL_checknumber(L, 2);
			float val = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.easeInExpo(start, end, val);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeOutExpo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float end = (float)LuaDLL.luaL_checknumber(L, 2);
			float val = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.easeOutExpo(start, end, val);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeInOutExpo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float end = (float)LuaDLL.luaL_checknumber(L, 2);
			float val = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.easeInOutExpo(start, end, val);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeInCirc(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float end = (float)LuaDLL.luaL_checknumber(L, 2);
			float val = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.easeInCirc(start, end, val);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeOutCirc(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float end = (float)LuaDLL.luaL_checknumber(L, 2);
			float val = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.easeOutCirc(start, end, val);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeInOutCirc(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float end = (float)LuaDLL.luaL_checknumber(L, 2);
			float val = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.easeInOutCirc(start, end, val);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeInBounce(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float end = (float)LuaDLL.luaL_checknumber(L, 2);
			float val = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.easeInBounce(start, end, val);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeOutBounce(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float end = (float)LuaDLL.luaL_checknumber(L, 2);
			float val = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.easeOutBounce(start, end, val);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeInOutBounce(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float start = (float)LuaDLL.luaL_checknumber(L, 1);
			float end = (float)LuaDLL.luaL_checknumber(L, 2);
			float val = (float)LuaDLL.luaL_checknumber(L, 3);
			float num = LeanTween.easeInOutBounce(start, end, val);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeInBack(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				float start2 = (float)LuaDLL.luaL_checknumber(L, 1);
				float end2 = (float)LuaDLL.luaL_checknumber(L, 2);
				float val2 = (float)LuaDLL.luaL_checknumber(L, 3);
				float num2 = LeanTween.easeInBack(start2, end2, val2);
				LuaDLL.lua_pushnumber(L, num2);
				return 1;
			}
			case 4:
			{
				float start = (float)LuaDLL.luaL_checknumber(L, 1);
				float end = (float)LuaDLL.luaL_checknumber(L, 2);
				float val = (float)LuaDLL.luaL_checknumber(L, 3);
				float overshoot = (float)LuaDLL.luaL_checknumber(L, 4);
				float num = LeanTween.easeInBack(start, end, val, overshoot);
				LuaDLL.lua_pushnumber(L, num);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.easeInBack");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeOutBack(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				float start2 = (float)LuaDLL.luaL_checknumber(L, 1);
				float end2 = (float)LuaDLL.luaL_checknumber(L, 2);
				float val2 = (float)LuaDLL.luaL_checknumber(L, 3);
				float num2 = LeanTween.easeOutBack(start2, end2, val2);
				LuaDLL.lua_pushnumber(L, num2);
				return 1;
			}
			case 4:
			{
				float start = (float)LuaDLL.luaL_checknumber(L, 1);
				float end = (float)LuaDLL.luaL_checknumber(L, 2);
				float val = (float)LuaDLL.luaL_checknumber(L, 3);
				float overshoot = (float)LuaDLL.luaL_checknumber(L, 4);
				float num = LeanTween.easeOutBack(start, end, val, overshoot);
				LuaDLL.lua_pushnumber(L, num);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.easeOutBack");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeInOutBack(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				float start2 = (float)LuaDLL.luaL_checknumber(L, 1);
				float end2 = (float)LuaDLL.luaL_checknumber(L, 2);
				float val2 = (float)LuaDLL.luaL_checknumber(L, 3);
				float num2 = LeanTween.easeInOutBack(start2, end2, val2);
				LuaDLL.lua_pushnumber(L, num2);
				return 1;
			}
			case 4:
			{
				float start = (float)LuaDLL.luaL_checknumber(L, 1);
				float end = (float)LuaDLL.luaL_checknumber(L, 2);
				float val = (float)LuaDLL.luaL_checknumber(L, 3);
				float overshoot = (float)LuaDLL.luaL_checknumber(L, 4);
				float num = LeanTween.easeInOutBack(start, end, val, overshoot);
				LuaDLL.lua_pushnumber(L, num);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.easeInOutBack");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeInElastic(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				float start3 = (float)LuaDLL.luaL_checknumber(L, 1);
				float end3 = (float)LuaDLL.luaL_checknumber(L, 2);
				float val3 = (float)LuaDLL.luaL_checknumber(L, 3);
				float num3 = LeanTween.easeInElastic(start3, end3, val3);
				LuaDLL.lua_pushnumber(L, num3);
				return 1;
			}
			case 4:
			{
				float start2 = (float)LuaDLL.luaL_checknumber(L, 1);
				float end2 = (float)LuaDLL.luaL_checknumber(L, 2);
				float val2 = (float)LuaDLL.luaL_checknumber(L, 3);
				float overshoot2 = (float)LuaDLL.luaL_checknumber(L, 4);
				float num2 = LeanTween.easeInElastic(start2, end2, val2, overshoot2);
				LuaDLL.lua_pushnumber(L, num2);
				return 1;
			}
			case 5:
			{
				float start = (float)LuaDLL.luaL_checknumber(L, 1);
				float end = (float)LuaDLL.luaL_checknumber(L, 2);
				float val = (float)LuaDLL.luaL_checknumber(L, 3);
				float overshoot = (float)LuaDLL.luaL_checknumber(L, 4);
				float period = (float)LuaDLL.luaL_checknumber(L, 5);
				float num = LeanTween.easeInElastic(start, end, val, overshoot, period);
				LuaDLL.lua_pushnumber(L, num);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.easeInElastic");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeOutElastic(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				float start3 = (float)LuaDLL.luaL_checknumber(L, 1);
				float end3 = (float)LuaDLL.luaL_checknumber(L, 2);
				float val3 = (float)LuaDLL.luaL_checknumber(L, 3);
				float num3 = LeanTween.easeOutElastic(start3, end3, val3);
				LuaDLL.lua_pushnumber(L, num3);
				return 1;
			}
			case 4:
			{
				float start2 = (float)LuaDLL.luaL_checknumber(L, 1);
				float end2 = (float)LuaDLL.luaL_checknumber(L, 2);
				float val2 = (float)LuaDLL.luaL_checknumber(L, 3);
				float overshoot2 = (float)LuaDLL.luaL_checknumber(L, 4);
				float num2 = LeanTween.easeOutElastic(start2, end2, val2, overshoot2);
				LuaDLL.lua_pushnumber(L, num2);
				return 1;
			}
			case 5:
			{
				float start = (float)LuaDLL.luaL_checknumber(L, 1);
				float end = (float)LuaDLL.luaL_checknumber(L, 2);
				float val = (float)LuaDLL.luaL_checknumber(L, 3);
				float overshoot = (float)LuaDLL.luaL_checknumber(L, 4);
				float period = (float)LuaDLL.luaL_checknumber(L, 5);
				float num = LeanTween.easeOutElastic(start, end, val, overshoot, period);
				LuaDLL.lua_pushnumber(L, num);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.easeOutElastic");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int easeInOutElastic(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				float start3 = (float)LuaDLL.luaL_checknumber(L, 1);
				float end3 = (float)LuaDLL.luaL_checknumber(L, 2);
				float val3 = (float)LuaDLL.luaL_checknumber(L, 3);
				float num3 = LeanTween.easeInOutElastic(start3, end3, val3);
				LuaDLL.lua_pushnumber(L, num3);
				return 1;
			}
			case 4:
			{
				float start2 = (float)LuaDLL.luaL_checknumber(L, 1);
				float end2 = (float)LuaDLL.luaL_checknumber(L, 2);
				float val2 = (float)LuaDLL.luaL_checknumber(L, 3);
				float overshoot2 = (float)LuaDLL.luaL_checknumber(L, 4);
				float num2 = LeanTween.easeInOutElastic(start2, end2, val2, overshoot2);
				LuaDLL.lua_pushnumber(L, num2);
				return 1;
			}
			case 5:
			{
				float start = (float)LuaDLL.luaL_checknumber(L, 1);
				float end = (float)LuaDLL.luaL_checknumber(L, 2);
				float val = (float)LuaDLL.luaL_checknumber(L, 3);
				float overshoot = (float)LuaDLL.luaL_checknumber(L, 4);
				float period = (float)LuaDLL.luaL_checknumber(L, 5);
				float num = LeanTween.easeInOutElastic(start, end, val, overshoot, period);
				LuaDLL.lua_pushnumber(L, num);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.easeInOutElastic");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int followDamp(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 4:
			{
				Transform trans2 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Transform target2 = (Transform)ToLua.CheckObject<Transform>(L, 2);
				LeanProp prop2 = (LeanProp)ToLua.CheckObject(L, 3, typeof(LeanProp));
				float smoothTime2 = (float)LuaDLL.luaL_checknumber(L, 4);
				LTDescr o2 = LeanTween.followDamp(trans2, target2, prop2, smoothTime2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 5:
			{
				Transform trans = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Transform target = (Transform)ToLua.CheckObject<Transform>(L, 2);
				LeanProp prop = (LeanProp)ToLua.CheckObject(L, 3, typeof(LeanProp));
				float smoothTime = (float)LuaDLL.luaL_checknumber(L, 4);
				float maxSpeed = (float)LuaDLL.luaL_checknumber(L, 5);
				LTDescr o = LeanTween.followDamp(trans, target, prop, smoothTime, maxSpeed);
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.followDamp");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int followSpring(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 4:
			{
				Transform trans4 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Transform target4 = (Transform)ToLua.CheckObject<Transform>(L, 2);
				LeanProp prop4 = (LeanProp)ToLua.CheckObject(L, 3, typeof(LeanProp));
				float smoothTime4 = (float)LuaDLL.luaL_checknumber(L, 4);
				LTDescr o4 = LeanTween.followSpring(trans4, target4, prop4, smoothTime4);
				ToLua.PushObject(L, o4);
				return 1;
			}
			case 5:
			{
				Transform trans3 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Transform target3 = (Transform)ToLua.CheckObject<Transform>(L, 2);
				LeanProp prop3 = (LeanProp)ToLua.CheckObject(L, 3, typeof(LeanProp));
				float smoothTime3 = (float)LuaDLL.luaL_checknumber(L, 4);
				float maxSpeed3 = (float)LuaDLL.luaL_checknumber(L, 5);
				LTDescr o3 = LeanTween.followSpring(trans3, target3, prop3, smoothTime3, maxSpeed3);
				ToLua.PushObject(L, o3);
				return 1;
			}
			case 6:
			{
				Transform trans2 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Transform target2 = (Transform)ToLua.CheckObject<Transform>(L, 2);
				LeanProp prop2 = (LeanProp)ToLua.CheckObject(L, 3, typeof(LeanProp));
				float smoothTime2 = (float)LuaDLL.luaL_checknumber(L, 4);
				float maxSpeed2 = (float)LuaDLL.luaL_checknumber(L, 5);
				float friction2 = (float)LuaDLL.luaL_checknumber(L, 6);
				LTDescr o2 = LeanTween.followSpring(trans2, target2, prop2, smoothTime2, maxSpeed2, friction2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 7:
			{
				Transform trans = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Transform target = (Transform)ToLua.CheckObject<Transform>(L, 2);
				LeanProp prop = (LeanProp)ToLua.CheckObject(L, 3, typeof(LeanProp));
				float smoothTime = (float)LuaDLL.luaL_checknumber(L, 4);
				float maxSpeed = (float)LuaDLL.luaL_checknumber(L, 5);
				float friction = (float)LuaDLL.luaL_checknumber(L, 6);
				float accelRate = (float)LuaDLL.luaL_checknumber(L, 7);
				LTDescr o = LeanTween.followSpring(trans, target, prop, smoothTime, maxSpeed, friction, accelRate);
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.followSpring");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int followBounceOut(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 4:
			{
				Transform trans5 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Transform target5 = (Transform)ToLua.CheckObject<Transform>(L, 2);
				LeanProp prop5 = (LeanProp)ToLua.CheckObject(L, 3, typeof(LeanProp));
				float smoothTime5 = (float)LuaDLL.luaL_checknumber(L, 4);
				LTDescr o5 = LeanTween.followBounceOut(trans5, target5, prop5, smoothTime5);
				ToLua.PushObject(L, o5);
				return 1;
			}
			case 5:
			{
				Transform trans4 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Transform target4 = (Transform)ToLua.CheckObject<Transform>(L, 2);
				LeanProp prop4 = (LeanProp)ToLua.CheckObject(L, 3, typeof(LeanProp));
				float smoothTime4 = (float)LuaDLL.luaL_checknumber(L, 4);
				float maxSpeed4 = (float)LuaDLL.luaL_checknumber(L, 5);
				LTDescr o4 = LeanTween.followBounceOut(trans4, target4, prop4, smoothTime4, maxSpeed4);
				ToLua.PushObject(L, o4);
				return 1;
			}
			case 6:
			{
				Transform trans3 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Transform target3 = (Transform)ToLua.CheckObject<Transform>(L, 2);
				LeanProp prop3 = (LeanProp)ToLua.CheckObject(L, 3, typeof(LeanProp));
				float smoothTime3 = (float)LuaDLL.luaL_checknumber(L, 4);
				float maxSpeed3 = (float)LuaDLL.luaL_checknumber(L, 5);
				float friction3 = (float)LuaDLL.luaL_checknumber(L, 6);
				LTDescr o3 = LeanTween.followBounceOut(trans3, target3, prop3, smoothTime3, maxSpeed3, friction3);
				ToLua.PushObject(L, o3);
				return 1;
			}
			case 7:
			{
				Transform trans2 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Transform target2 = (Transform)ToLua.CheckObject<Transform>(L, 2);
				LeanProp prop2 = (LeanProp)ToLua.CheckObject(L, 3, typeof(LeanProp));
				float smoothTime2 = (float)LuaDLL.luaL_checknumber(L, 4);
				float maxSpeed2 = (float)LuaDLL.luaL_checknumber(L, 5);
				float friction2 = (float)LuaDLL.luaL_checknumber(L, 6);
				float accelRate2 = (float)LuaDLL.luaL_checknumber(L, 7);
				LTDescr o2 = LeanTween.followBounceOut(trans2, target2, prop2, smoothTime2, maxSpeed2, friction2, accelRate2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 8:
			{
				Transform trans = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Transform target = (Transform)ToLua.CheckObject<Transform>(L, 2);
				LeanProp prop = (LeanProp)ToLua.CheckObject(L, 3, typeof(LeanProp));
				float smoothTime = (float)LuaDLL.luaL_checknumber(L, 4);
				float maxSpeed = (float)LuaDLL.luaL_checknumber(L, 5);
				float friction = (float)LuaDLL.luaL_checknumber(L, 6);
				float accelRate = (float)LuaDLL.luaL_checknumber(L, 7);
				float hitDamping = (float)LuaDLL.luaL_checknumber(L, 8);
				LTDescr o = LeanTween.followBounceOut(trans, target, prop, smoothTime, maxSpeed, friction, accelRate, hitDamping);
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.followBounceOut");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int followLinear(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Transform trans = (Transform)ToLua.CheckObject<Transform>(L, 1);
			Transform target = (Transform)ToLua.CheckObject<Transform>(L, 2);
			LeanProp prop = (LeanProp)ToLua.CheckObject(L, 3, typeof(LeanProp));
			float moveSpeed = (float)LuaDLL.luaL_checknumber(L, 4);
			LTDescr o = LeanTween.followLinear(trans, target, prop, moveSpeed);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int addListener(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				int eventId2 = (int)LuaDLL.luaL_checknumber(L, 1);
				Action<LTEvent> callback2 = (Action<LTEvent>)ToLua.CheckDelegate<Action<LTEvent>>(L, 2);
				LeanTween.addListener(eventId2, callback2);
				return 0;
			}
			case 3:
			{
				GameObject caller = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				int eventId = (int)LuaDLL.luaL_checknumber(L, 2);
				Action<LTEvent> callback = (Action<LTEvent>)ToLua.CheckDelegate<Action<LTEvent>>(L, 3);
				LeanTween.addListener(caller, eventId, callback);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.addListener");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int removeListener(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				bool flag3 = LeanTween.removeListener((int)LuaDLL.luaL_checknumber(L, 1));
				LuaDLL.lua_pushboolean(L, flag3);
				return 1;
			}
			case 2:
			{
				int eventId2 = (int)LuaDLL.luaL_checknumber(L, 1);
				Action<LTEvent> callback2 = (Action<LTEvent>)ToLua.CheckDelegate<Action<LTEvent>>(L, 2);
				bool flag2 = LeanTween.removeListener(eventId2, callback2);
				LuaDLL.lua_pushboolean(L, flag2);
				return 1;
			}
			case 3:
			{
				GameObject caller = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				int eventId = (int)LuaDLL.luaL_checknumber(L, 2);
				Action<LTEvent> callback = (Action<LTEvent>)ToLua.CheckDelegate<Action<LTEvent>>(L, 3);
				bool flag = LeanTween.removeListener(caller, eventId, callback);
				LuaDLL.lua_pushboolean(L, flag);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.removeListener");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int dispatchEvent(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				LeanTween.dispatchEvent((int)LuaDLL.luaL_checknumber(L, 1));
				return 0;
			case 2:
			{
				int eventId = (int)LuaDLL.luaL_checknumber(L, 1);
				object data = ToLua.ToVarObject(L, 2);
				LeanTween.dispatchEvent(eventId, data);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LeanTween.dispatchEvent");
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
			bool flag = obj == obj2;
			LuaDLL.lua_pushboolean(L, flag);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_throwErrors(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, LeanTween.throwErrors);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_tau(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, LeanTween.tau);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_PI_DIV2(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, LeanTween.PI_DIV2);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dtEstimated(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, LeanTween.dtEstimated);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dtManual(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, LeanTween.dtManual);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dtActual(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, LeanTween.dtActual);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_punch(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, LeanTween.punch);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_shake(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, LeanTween.shake);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startSearch(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, LeanTween.startSearch);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_d(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, LeanTween.d);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_EVENTS_MAX(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, LeanTween.EVENTS_MAX);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_LISTENERS_MAX(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, LeanTween.LISTENERS_MAX);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxSearch(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, LeanTween.maxSearch);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxSimulataneousTweens(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, LeanTween.maxSimulataneousTweens);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_tweensRunning(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, LeanTween.tweensRunning);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_tweenEmpty(IntPtr L)
	{
		try
		{
			ToLua.PushSealed(L, LeanTween.tweenEmpty);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_throwErrors(IntPtr L)
	{
		try
		{
			LeanTween.throwErrors = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_tau(IntPtr L)
	{
		try
		{
			LeanTween.tau = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_PI_DIV2(IntPtr L)
	{
		try
		{
			LeanTween.PI_DIV2 = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dtEstimated(IntPtr L)
	{
		try
		{
			LeanTween.dtEstimated = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dtManual(IntPtr L)
	{
		try
		{
			LeanTween.dtManual = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dtActual(IntPtr L)
	{
		try
		{
			LeanTween.dtActual = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_punch(IntPtr L)
	{
		try
		{
			LeanTween.punch = (AnimationCurve)ToLua.CheckObject<AnimationCurve>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_shake(IntPtr L)
	{
		try
		{
			LeanTween.shake = (AnimationCurve)ToLua.CheckObject<AnimationCurve>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startSearch(IntPtr L)
	{
		try
		{
			LeanTween.startSearch = (int)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_d(IntPtr L)
	{
		try
		{
			LeanTween.d = (LTDescr)ToLua.CheckObject<LTDescr>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_EVENTS_MAX(IntPtr L)
	{
		try
		{
			LeanTween.EVENTS_MAX = (int)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_LISTENERS_MAX(IntPtr L)
	{
		try
		{
			LeanTween.LISTENERS_MAX = (int)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
