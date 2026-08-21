using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.UI;

public class LTDescrWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(LTDescr), typeof(object));
		L.RegFunction("ToString", ToString);
		L.RegFunction("reset", reset);
		L.RegFunction("setFollow", setFollow);
		L.RegFunction("setMoveX", setMoveX);
		L.RegFunction("setMoveY", setMoveY);
		L.RegFunction("setMoveZ", setMoveZ);
		L.RegFunction("setMoveLocalX", setMoveLocalX);
		L.RegFunction("setMoveLocalY", setMoveLocalY);
		L.RegFunction("setMoveLocalZ", setMoveLocalZ);
		L.RegFunction("setOffset", setOffset);
		L.RegFunction("setMoveCurved", setMoveCurved);
		L.RegFunction("setMoveCurvedLocal", setMoveCurvedLocal);
		L.RegFunction("setMoveSpline", setMoveSpline);
		L.RegFunction("setMoveSplineLocal", setMoveSplineLocal);
		L.RegFunction("setScaleX", setScaleX);
		L.RegFunction("setScaleY", setScaleY);
		L.RegFunction("setScaleZ", setScaleZ);
		L.RegFunction("setRotateX", setRotateX);
		L.RegFunction("setRotateY", setRotateY);
		L.RegFunction("setRotateZ", setRotateZ);
		L.RegFunction("setRotateAround", setRotateAround);
		L.RegFunction("setRotateAroundLocal", setRotateAroundLocal);
		L.RegFunction("setAlpha", setAlpha);
		L.RegFunction("setTextAlpha", setTextAlpha);
		L.RegFunction("setAlphaVertex", setAlphaVertex);
		L.RegFunction("setColor", setColor);
		L.RegFunction("setCallbackColor", setCallbackColor);
		L.RegFunction("setTextColor", setTextColor);
		L.RegFunction("setCanvasAlpha", setCanvasAlpha);
		L.RegFunction("setCanvasGroupAlpha", setCanvasGroupAlpha);
		L.RegFunction("setCanvasColor", setCanvasColor);
		L.RegFunction("setCanvasMoveX", setCanvasMoveX);
		L.RegFunction("setCanvasMoveY", setCanvasMoveY);
		L.RegFunction("setCanvasMoveZ", setCanvasMoveZ);
		L.RegFunction("setCanvasRotateAround", setCanvasRotateAround);
		L.RegFunction("setCanvasRotateAroundLocal", setCanvasRotateAroundLocal);
		L.RegFunction("setCanvasPlaySprite", setCanvasPlaySprite);
		L.RegFunction("setCanvasMove", setCanvasMove);
		L.RegFunction("setCanvasScale", setCanvasScale);
		L.RegFunction("setCanvasSizeDelta", setCanvasSizeDelta);
		L.RegFunction("setCallback", setCallback);
		L.RegFunction("setValue3", setValue3);
		L.RegFunction("setMove", setMove);
		L.RegFunction("setMoveLocal", setMoveLocal);
		L.RegFunction("setMoveToTransform", setMoveToTransform);
		L.RegFunction("setRotate", setRotate);
		L.RegFunction("setRotateLocal", setRotateLocal);
		L.RegFunction("setScale", setScale);
		L.RegFunction("setGUIMove", setGUIMove);
		L.RegFunction("setGUIMoveMargin", setGUIMoveMargin);
		L.RegFunction("setGUIScale", setGUIScale);
		L.RegFunction("setGUIAlpha", setGUIAlpha);
		L.RegFunction("setGUIRotate", setGUIRotate);
		L.RegFunction("setDelayedSound", setDelayedSound);
		L.RegFunction("setTarget", setTarget);
		L.RegFunction("updateNow", updateNow);
		L.RegFunction("updateInternal", updateInternal);
		L.RegFunction("callOnCompletes", callOnCompletes);
		L.RegFunction("setFromColor", setFromColor);
		L.RegFunction("pause", pause);
		L.RegFunction("resume", resume);
		L.RegFunction("setAxis", setAxis);
		L.RegFunction("setDelay", setDelay);
		L.RegFunction("setEase", setEase);
		L.RegFunction("setEaseLinear", setEaseLinear);
		L.RegFunction("setEaseSpring", setEaseSpring);
		L.RegFunction("setEaseInQuad", setEaseInQuad);
		L.RegFunction("setEaseOutQuad", setEaseOutQuad);
		L.RegFunction("setEaseInOutQuad", setEaseInOutQuad);
		L.RegFunction("setEaseInCubic", setEaseInCubic);
		L.RegFunction("setEaseOutCubic", setEaseOutCubic);
		L.RegFunction("setEaseInOutCubic", setEaseInOutCubic);
		L.RegFunction("setEaseInQuart", setEaseInQuart);
		L.RegFunction("setEaseOutQuart", setEaseOutQuart);
		L.RegFunction("setEaseInOutQuart", setEaseInOutQuart);
		L.RegFunction("setEaseInQuint", setEaseInQuint);
		L.RegFunction("setEaseOutQuint", setEaseOutQuint);
		L.RegFunction("setEaseInOutQuint", setEaseInOutQuint);
		L.RegFunction("setEaseInSine", setEaseInSine);
		L.RegFunction("setEaseOutSine", setEaseOutSine);
		L.RegFunction("setEaseInOutSine", setEaseInOutSine);
		L.RegFunction("setEaseInExpo", setEaseInExpo);
		L.RegFunction("setEaseOutExpo", setEaseOutExpo);
		L.RegFunction("setEaseInOutExpo", setEaseInOutExpo);
		L.RegFunction("setEaseInCirc", setEaseInCirc);
		L.RegFunction("setEaseOutCirc", setEaseOutCirc);
		L.RegFunction("setEaseInOutCirc", setEaseInOutCirc);
		L.RegFunction("setEaseInBounce", setEaseInBounce);
		L.RegFunction("setEaseOutBounce", setEaseOutBounce);
		L.RegFunction("setEaseInOutBounce", setEaseInOutBounce);
		L.RegFunction("setEaseInBack", setEaseInBack);
		L.RegFunction("setEaseOutBack", setEaseOutBack);
		L.RegFunction("setEaseInOutBack", setEaseInOutBack);
		L.RegFunction("setEaseInElastic", setEaseInElastic);
		L.RegFunction("setEaseOutElastic", setEaseOutElastic);
		L.RegFunction("setEaseInOutElastic", setEaseInOutElastic);
		L.RegFunction("setEasePunch", setEasePunch);
		L.RegFunction("setEaseShake", setEaseShake);
		L.RegFunction("setOvershoot", setOvershoot);
		L.RegFunction("setPeriod", setPeriod);
		L.RegFunction("setTo", setTo);
		L.RegFunction("setFrom", setFrom);
		L.RegFunction("setDiff", setDiff);
		L.RegFunction("setHasInitialized", setHasInitialized);
		L.RegFunction("setId", setId);
		L.RegFunction("setPassed", setPassed);
		L.RegFunction("setTime", setTime);
		L.RegFunction("setSpeed", setSpeed);
		L.RegFunction("setRepeat", setRepeat);
		L.RegFunction("setLoopType", setLoopType);
		L.RegFunction("setUseEstimatedTime", setUseEstimatedTime);
		L.RegFunction("setIgnoreTimeScale", setIgnoreTimeScale);
		L.RegFunction("setUseFrames", setUseFrames);
		L.RegFunction("setUseManualTime", setUseManualTime);
		L.RegFunction("setLoopCount", setLoopCount);
		L.RegFunction("setLoopOnce", setLoopOnce);
		L.RegFunction("setLoopClamp", setLoopClamp);
		L.RegFunction("setLoopPingPong", setLoopPingPong);
		L.RegFunction("setOnComplete", setOnComplete);
		L.RegFunction("setOnCompleteParam", setOnCompleteParam);
		L.RegFunction("setOnUpdate", setOnUpdate);
		L.RegFunction("setOnUpdateRatio", setOnUpdateRatio);
		L.RegFunction("setOnUpdateObject", setOnUpdateObject);
		L.RegFunction("setOnUpdateVector2", setOnUpdateVector2);
		L.RegFunction("setOnUpdateVector3", setOnUpdateVector3);
		L.RegFunction("setOnUpdateColor", setOnUpdateColor);
		L.RegFunction("setOnUpdateParam", setOnUpdateParam);
		L.RegFunction("setOrientToPath", setOrientToPath);
		L.RegFunction("setOrientToPath2d", setOrientToPath2d);
		L.RegFunction("setRect", setRect);
		L.RegFunction("setPath", setPath);
		L.RegFunction("setPoint", setPoint);
		L.RegFunction("setDestroyOnComplete", setDestroyOnComplete);
		L.RegFunction("setAudio", setAudio);
		L.RegFunction("setOnCompleteOnRepeat", setOnCompleteOnRepeat);
		L.RegFunction("setOnCompleteOnStart", setOnCompleteOnStart);
		L.RegFunction("setSprites", setSprites);
		L.RegFunction("setFrameRate", setFrameRate);
		L.RegFunction("setOnStart", setOnStart);
		L.RegFunction("setDirection", setDirection);
		L.RegFunction("setRecursive", setRecursive);
		L.RegFunction("New", _CreateLTDescr);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("toggle", get_toggle, set_toggle);
		L.RegVar("useEstimatedTime", get_useEstimatedTime, set_useEstimatedTime);
		L.RegVar("useFrames", get_useFrames, set_useFrames);
		L.RegVar("useManualTime", get_useManualTime, set_useManualTime);
		L.RegVar("usesNormalDt", get_usesNormalDt, set_usesNormalDt);
		L.RegVar("hasInitiliazed", get_hasInitiliazed, set_hasInitiliazed);
		L.RegVar("hasExtraOnCompletes", get_hasExtraOnCompletes, set_hasExtraOnCompletes);
		L.RegVar("hasPhysics", get_hasPhysics, set_hasPhysics);
		L.RegVar("onCompleteOnRepeat", get_onCompleteOnRepeat, set_onCompleteOnRepeat);
		L.RegVar("onCompleteOnStart", get_onCompleteOnStart, set_onCompleteOnStart);
		L.RegVar("useRecursion", get_useRecursion, set_useRecursion);
		L.RegVar("ratioPassed", get_ratioPassed, set_ratioPassed);
		L.RegVar("passed", get_passed, set_passed);
		L.RegVar("delay", get_delay, set_delay);
		L.RegVar("time", get_time, set_time);
		L.RegVar("speed", get_speed, set_speed);
		L.RegVar("lastVal", get_lastVal, set_lastVal);
		L.RegVar("loopCount", get_loopCount, set_loopCount);
		L.RegVar("counter", get_counter, set_counter);
		L.RegVar("direction", get_direction, set_direction);
		L.RegVar("directionLast", get_directionLast, set_directionLast);
		L.RegVar("overshoot", get_overshoot, set_overshoot);
		L.RegVar("period", get_period, set_period);
		L.RegVar("scale", get_scale, set_scale);
		L.RegVar("destroyOnComplete", get_destroyOnComplete, set_destroyOnComplete);
		L.RegVar("trans", get_trans, set_trans);
		L.RegVar("type", get_type, set_type);
		L.RegVar("loopType", get_loopType, set_loopType);
		L.RegVar("hasUpdateCallback", get_hasUpdateCallback, set_hasUpdateCallback);
		L.RegVar("easeMethod", get_easeMethod, set_easeMethod);
		L.RegVar("spriteRen", get_spriteRen, set_spriteRen);
		L.RegVar("rectTransform", get_rectTransform, set_rectTransform);
		L.RegVar("uiText", get_uiText, set_uiText);
		L.RegVar("uiImage", get_uiImage, set_uiImage);
		L.RegVar("rawImage", get_rawImage, set_rawImage);
		L.RegVar("sprites", get_sprites, set_sprites);
		L.RegVar("_optional", get__optional, set__optional);
		L.RegVar("val", get_val, set_val);
		L.RegVar("dt", get_dt, set_dt);
		L.RegVar("newVect", get_newVect, set_newVect);
		L.RegVar("from", get_from, set_from);
		L.RegVar("to", get_to, set_to);
		L.RegVar("easeInternal", get_easeInternal, set_easeInternal);
		L.RegVar("initInternal", get_initInternal, set_initInternal);
		L.RegVar("toTrans", get_toTrans, null);
		L.RegVar("uniqueId", get_uniqueId, null);
		L.RegVar("id", get_id, null);
		L.RegVar("optional", get_optional, set_optional);
		L.RegFunction("EaseTypeDelegate", LTDescr_EaseTypeDelegate);
		L.RegFunction("ActionMethodDelegate", LTDescr_ActionMethodDelegate);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateLTDescr(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				LTDescr o = new LTDescr();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: LTDescr.New");
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
			string str = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).ToString();
			LuaDLL.lua_pushstring(L, str);
			return 1;
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
			ToLua.CheckArgsCount(L, 1);
			((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).reset();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setFollow(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setFollow();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setMoveX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setMoveX();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setMoveY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setMoveY();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setMoveZ(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setMoveZ();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setMoveLocalX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setMoveLocalX();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setMoveLocalY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setMoveLocalY();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setMoveLocalZ(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setMoveLocalZ();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setOffset(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			Vector3 offset = ToLua.ToVector3(L, 2);
			LTDescr o = obj.setOffset(offset);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setMoveCurved(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setMoveCurved();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setMoveCurvedLocal(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setMoveCurvedLocal();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setMoveSpline(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setMoveSpline();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setMoveSplineLocal(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setMoveSplineLocal();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setScaleX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setScaleX();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setScaleY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setScaleY();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setScaleZ(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setScaleZ();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setRotateX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setRotateX();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setRotateY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setRotateY();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setRotateZ(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setRotateZ();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setRotateAround(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setRotateAround();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setRotateAroundLocal(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setRotateAroundLocal();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setAlpha(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setAlpha();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setTextAlpha(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setTextAlpha();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setAlphaVertex(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setAlphaVertex();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setColor(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setColor();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setCallbackColor(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setCallbackColor();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setTextColor(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setTextColor();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setCanvasAlpha(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setCanvasAlpha();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setCanvasGroupAlpha(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setCanvasGroupAlpha();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setCanvasColor(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setCanvasColor();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setCanvasMoveX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setCanvasMoveX();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setCanvasMoveY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setCanvasMoveY();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setCanvasMoveZ(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setCanvasMoveZ();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setCanvasRotateAround(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setCanvasRotateAround();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setCanvasRotateAroundLocal(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setCanvasRotateAroundLocal();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setCanvasPlaySprite(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setCanvasPlaySprite();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setCanvasMove(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setCanvasMove();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setCanvasScale(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setCanvasScale();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setCanvasSizeDelta(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setCanvasSizeDelta();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setCallback(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setCallback();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setValue3(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setValue3();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setMove(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setMove();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setMoveLocal(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setMoveLocal();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setMoveToTransform(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setMoveToTransform();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setRotate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setRotate();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setRotateLocal(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setRotateLocal();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setScale(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				LTDescr o2 = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setScale();
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 2:
			{
				LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
				float scale = (float)LuaDLL.luaL_checknumber(L, 2);
				LTDescr o = obj.setScale(scale);
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LTDescr.setScale");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setGUIMove(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setGUIMove();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setGUIMoveMargin(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setGUIMoveMargin();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setGUIScale(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setGUIScale();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setGUIAlpha(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setGUIAlpha();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setGUIRotate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setGUIRotate();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setDelayedSound(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setDelayedSound();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setTarget(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			Transform target = (Transform)ToLua.CheckObject<Transform>(L, 2);
			LTDescr o = obj.setTarget(target);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int updateNow(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).updateNow();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int updateInternal(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).updateInternal();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int callOnCompletes(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).callOnCompletes();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setFromColor(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			Color fromColor = ToLua.ToColor(L, 2);
			LTDescr o = obj.setFromColor(fromColor);
			ToLua.PushObject(L, o);
			return 1;
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
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).pause();
			ToLua.PushObject(L, o);
			return 1;
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
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).resume();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setAxis(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			Vector3 axis = ToLua.ToVector3(L, 2);
			LTDescr o = obj.setAxis(axis);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setDelay(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			float delay = (float)LuaDLL.luaL_checknumber(L, 2);
			LTDescr o = obj.setDelay(delay);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEase(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<LeanTweenType>(L, 2))
			{
				LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
				LeanTweenType ease = (LeanTweenType)ToLua.ToObject(L, 2);
				LTDescr o = obj.setEase(ease);
				ToLua.PushObject(L, o);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<AnimationCurve>(L, 2))
			{
				LTDescr obj2 = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
				AnimationCurve ease2 = (AnimationCurve)ToLua.ToObject(L, 2);
				LTDescr o2 = obj2.setEase(ease2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LTDescr.setEase");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseLinear(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseLinear();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseSpring(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseSpring();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseInQuad(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseInQuad();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseOutQuad(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseOutQuad();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseInOutQuad(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseInOutQuad();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseInCubic(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseInCubic();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseOutCubic(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseOutCubic();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseInOutCubic(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseInOutCubic();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseInQuart(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseInQuart();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseOutQuart(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseOutQuart();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseInOutQuart(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseInOutQuart();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseInQuint(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseInQuint();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseOutQuint(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseOutQuint();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseInOutQuint(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseInOutQuint();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseInSine(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseInSine();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseOutSine(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseOutSine();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseInOutSine(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseInOutSine();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseInExpo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseInExpo();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseOutExpo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseOutExpo();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseInOutExpo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseInOutExpo();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseInCirc(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseInCirc();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseOutCirc(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseOutCirc();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseInOutCirc(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseInOutCirc();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseInBounce(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseInBounce();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseOutBounce(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseOutBounce();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseInOutBounce(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseInOutBounce();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseInBack(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseInBack();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseOutBack(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseOutBack();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseInOutBack(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseInOutBack();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseInElastic(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseInElastic();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseOutElastic(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseOutElastic();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseInOutElastic(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseInOutElastic();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEasePunch(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEasePunch();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setEaseShake(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setEaseShake();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setOvershoot(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			float overshoot = (float)LuaDLL.luaL_checknumber(L, 2);
			LTDescr o = obj.setOvershoot(overshoot);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setPeriod(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			float period = (float)LuaDLL.luaL_checknumber(L, 2);
			LTDescr o = obj.setPeriod(period);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setTo(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<Vector3>(L, 2))
			{
				LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
				Vector3 to = ToLua.ToVector3(L, 2);
				LTDescr o = obj.setTo(to);
				ToLua.PushObject(L, o);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<Transform>(L, 2))
			{
				LTDescr obj2 = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
				Transform to2 = (Transform)ToLua.ToObject(L, 2);
				LTDescr o2 = obj2.setTo(to2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LTDescr.setTo");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setFrom(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<Vector3>(L, 2))
			{
				LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
				Vector3 vector = ToLua.ToVector3(L, 2);
				LTDescr o = obj.setFrom(vector);
				ToLua.PushObject(L, o);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<float>(L, 2))
			{
				LTDescr obj2 = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
				float num2 = (float)LuaDLL.lua_tonumber(L, 2);
				LTDescr o2 = obj2.setFrom(num2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LTDescr.setFrom");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setDiff(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			Vector3 diff = ToLua.ToVector3(L, 2);
			LTDescr o = obj.setDiff(diff);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setHasInitialized(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			bool hasInitialized = LuaDLL.luaL_checkboolean(L, 2);
			LTDescr o = obj.setHasInitialized(hasInitialized);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setId(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			uint id = (uint)LuaDLL.luaL_checknumber(L, 2);
			uint global_counter = (uint)LuaDLL.luaL_checknumber(L, 3);
			LTDescr o = obj.setId(id, global_counter);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setPassed(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			float passed = (float)LuaDLL.luaL_checknumber(L, 2);
			LTDescr o = obj.setPassed(passed);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setTime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			float time = (float)LuaDLL.luaL_checknumber(L, 2);
			LTDescr o = obj.setTime(time);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setSpeed(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			float speed = (float)LuaDLL.luaL_checknumber(L, 2);
			LTDescr o = obj.setSpeed(speed);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setRepeat(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			int repeat = (int)LuaDLL.luaL_checknumber(L, 2);
			LTDescr o = obj.setRepeat(repeat);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setLoopType(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			LeanTweenType loopType = (LeanTweenType)ToLua.CheckObject(L, 2, typeof(LeanTweenType));
			LTDescr o = obj.setLoopType(loopType);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setUseEstimatedTime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			bool useEstimatedTime = LuaDLL.luaL_checkboolean(L, 2);
			LTDescr o = obj.setUseEstimatedTime(useEstimatedTime);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setIgnoreTimeScale(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			bool ignoreTimeScale = LuaDLL.luaL_checkboolean(L, 2);
			LTDescr o = obj.setIgnoreTimeScale(ignoreTimeScale);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setUseFrames(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			bool useFrames = LuaDLL.luaL_checkboolean(L, 2);
			LTDescr o = obj.setUseFrames(useFrames);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setUseManualTime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			bool useManualTime = LuaDLL.luaL_checkboolean(L, 2);
			LTDescr o = obj.setUseManualTime(useManualTime);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setLoopCount(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			int loopCount = (int)LuaDLL.luaL_checknumber(L, 2);
			LTDescr o = obj.setLoopCount(loopCount);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setLoopOnce(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LTDescr o = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setLoopOnce();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setLoopClamp(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				LTDescr o2 = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setLoopClamp();
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 2:
			{
				LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
				int loopClamp = (int)LuaDLL.luaL_checknumber(L, 2);
				LTDescr o = obj.setLoopClamp(loopClamp);
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LTDescr.setLoopClamp");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setLoopPingPong(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				LTDescr o2 = ((LTDescr)ToLua.CheckObject<LTDescr>(L, 1)).setLoopPingPong();
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 2:
			{
				LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
				int loopPingPong = (int)LuaDLL.luaL_checknumber(L, 2);
				LTDescr o = obj.setLoopPingPong(loopPingPong);
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LTDescr.setLoopPingPong");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setOnComplete(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<Action>(L, 2))
			{
				LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
				Action onComplete = (Action)ToLua.ToObject(L, 2);
				LTDescr o = obj.setOnComplete(onComplete);
				ToLua.PushObject(L, o);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<Action<object>>(L, 2))
			{
				LTDescr obj2 = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
				Action<object> onComplete2 = (Action<object>)ToLua.ToObject(L, 2);
				LTDescr o2 = obj2.setOnComplete(onComplete2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			if (num == 3)
			{
				LTDescr obj3 = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
				Action<object> onComplete3 = (Action<object>)ToLua.CheckDelegate<Action<object>>(L, 2);
				object onCompleteParam = ToLua.ToVarObject(L, 3);
				LTDescr o3 = obj3.setOnComplete(onComplete3, onCompleteParam);
				ToLua.PushObject(L, o3);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LTDescr.setOnComplete");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setOnCompleteParam(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			object onCompleteParam = ToLua.ToVarObject(L, 2);
			LTDescr o = obj.setOnCompleteParam(onCompleteParam);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setOnUpdate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<Action<float>>(L, 2))
			{
				LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
				Action<float> onUpdate = (Action<float>)ToLua.ToObject(L, 2);
				LTDescr o = obj.setOnUpdate(onUpdate);
				ToLua.PushObject(L, o);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<Action<Color>>(L, 2))
			{
				LTDescr obj2 = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
				Action<Color> onUpdate2 = (Action<Color>)ToLua.ToObject(L, 2);
				LTDescr o2 = obj2.setOnUpdate(onUpdate2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<Action<Color, object>>(L, 2))
			{
				LTDescr obj3 = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
				Action<Color, object> onUpdate3 = (Action<Color, object>)ToLua.ToObject(L, 2);
				LTDescr o3 = obj3.setOnUpdate(onUpdate3);
				ToLua.PushObject(L, o3);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<Action<float, object>>(L, 2))
			{
				LTDescr obj4 = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
				Action<float, object> onUpdate4 = (Action<float, object>)ToLua.ToObject(L, 2);
				LTDescr o4 = obj4.setOnUpdate(onUpdate4);
				ToLua.PushObject(L, o4);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<Action<Vector3, object>>(L, 2))
			{
				LTDescr obj5 = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
				Action<Vector3, object> onUpdate5 = (Action<Vector3, object>)ToLua.ToObject(L, 2);
				LTDescr o5 = obj5.setOnUpdate(onUpdate5);
				ToLua.PushObject(L, o5);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<Action<Vector2>>(L, 2))
			{
				LTDescr obj6 = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
				Action<Vector2> onUpdate6 = (Action<Vector2>)ToLua.ToObject(L, 2);
				LTDescr o6 = obj6.setOnUpdate(onUpdate6);
				ToLua.PushObject(L, o6);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<Action<Vector3>>(L, 2))
			{
				LTDescr obj7 = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
				Action<Vector3> onUpdate7 = (Action<Vector3>)ToLua.ToObject(L, 2);
				LTDescr o7 = obj7.setOnUpdate(onUpdate7);
				ToLua.PushObject(L, o7);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<Action<float, object>, object>(L, 2))
			{
				LTDescr obj8 = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
				Action<float, object> onUpdate8 = (Action<float, object>)ToLua.ToObject(L, 2);
				object onUpdateParam = ToLua.ToVarObject(L, 3);
				LTDescr o8 = obj8.setOnUpdate(onUpdate8, onUpdateParam);
				ToLua.PushObject(L, o8);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<Action<Vector3, object>, object>(L, 2))
			{
				LTDescr obj9 = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
				Action<Vector3, object> onUpdate9 = (Action<Vector3, object>)ToLua.ToObject(L, 2);
				object onUpdateParam2 = ToLua.ToVarObject(L, 3);
				LTDescr o9 = obj9.setOnUpdate(onUpdate9, onUpdateParam2);
				ToLua.PushObject(L, o9);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<Action<Vector2>, object>(L, 2))
			{
				LTDescr obj10 = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
				Action<Vector2> onUpdate10 = (Action<Vector2>)ToLua.ToObject(L, 2);
				object onUpdateParam3 = ToLua.ToVarObject(L, 3);
				LTDescr o10 = obj10.setOnUpdate(onUpdate10, onUpdateParam3);
				ToLua.PushObject(L, o10);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<Action<Vector3>, object>(L, 2))
			{
				LTDescr obj11 = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
				Action<Vector3> onUpdate11 = (Action<Vector3>)ToLua.ToObject(L, 2);
				object onUpdateParam4 = ToLua.ToVarObject(L, 3);
				LTDescr o11 = obj11.setOnUpdate(onUpdate11, onUpdateParam4);
				ToLua.PushObject(L, o11);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LTDescr.setOnUpdate");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setOnUpdateRatio(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			Action<float, float> onUpdateRatio = (Action<float, float>)ToLua.CheckDelegate<Action<float, float>>(L, 2);
			LTDescr o = obj.setOnUpdateRatio(onUpdateRatio);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setOnUpdateObject(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			Action<float, object> onUpdateObject = (Action<float, object>)ToLua.CheckDelegate<Action<float, object>>(L, 2);
			LTDescr o = obj.setOnUpdateObject(onUpdateObject);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setOnUpdateVector2(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			Action<Vector2> onUpdateVector = (Action<Vector2>)ToLua.CheckDelegate<Action<Vector2>>(L, 2);
			LTDescr o = obj.setOnUpdateVector2(onUpdateVector);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setOnUpdateVector3(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			Action<Vector3> onUpdateVector = (Action<Vector3>)ToLua.CheckDelegate<Action<Vector3>>(L, 2);
			LTDescr o = obj.setOnUpdateVector3(onUpdateVector);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setOnUpdateColor(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<Action<Color>>(L, 2))
			{
				LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
				Action<Color> onUpdateColor = (Action<Color>)ToLua.ToObject(L, 2);
				LTDescr o = obj.setOnUpdateColor(onUpdateColor);
				ToLua.PushObject(L, o);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<Action<Color, object>>(L, 2))
			{
				LTDescr obj2 = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
				Action<Color, object> onUpdateColor2 = (Action<Color, object>)ToLua.ToObject(L, 2);
				LTDescr o2 = obj2.setOnUpdateColor(onUpdateColor2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LTDescr.setOnUpdateColor");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setOnUpdateParam(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			object onUpdateParam = ToLua.ToVarObject(L, 2);
			LTDescr o = obj.setOnUpdateParam(onUpdateParam);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setOrientToPath(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			bool orientToPath = LuaDLL.luaL_checkboolean(L, 2);
			LTDescr o = obj.setOrientToPath(orientToPath);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setOrientToPath2d(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			bool orientToPath2d = LuaDLL.luaL_checkboolean(L, 2);
			LTDescr o = obj.setOrientToPath2d(orientToPath2d);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setRect(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<LTRect>(L, 2))
			{
				LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
				LTRect rect = (LTRect)ToLua.ToObject(L, 2);
				LTDescr o = obj.setRect(rect);
				ToLua.PushObject(L, o);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<Rect>(L, 2))
			{
				LTDescr obj2 = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
				Rect rect2 = StackTraits<Rect>.To(L, 2);
				LTDescr o2 = obj2.setRect(rect2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<RectTransform>(L, 2))
			{
				LTDescr obj3 = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
				RectTransform rect3 = (RectTransform)ToLua.ToObject(L, 2);
				LTDescr o3 = obj3.setRect(rect3);
				ToLua.PushObject(L, o3);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LTDescr.setRect");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setPath(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			LTBezierPath path = (LTBezierPath)ToLua.CheckObject<LTBezierPath>(L, 2);
			LTDescr o = obj.setPath(path);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setPoint(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			Vector3 point = ToLua.ToVector3(L, 2);
			LTDescr o = obj.setPoint(point);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setDestroyOnComplete(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			bool destroyOnComplete = LuaDLL.luaL_checkboolean(L, 2);
			LTDescr o = obj.setDestroyOnComplete(destroyOnComplete);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setAudio(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			object audio = ToLua.ToVarObject(L, 2);
			LTDescr o = obj.setAudio(audio);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setOnCompleteOnRepeat(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			bool onCompleteOnRepeat = LuaDLL.luaL_checkboolean(L, 2);
			LTDescr o = obj.setOnCompleteOnRepeat(onCompleteOnRepeat);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setOnCompleteOnStart(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			bool onCompleteOnStart = LuaDLL.luaL_checkboolean(L, 2);
			LTDescr o = obj.setOnCompleteOnStart(onCompleteOnStart);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setSprites(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			Sprite[] sprites = ToLua.CheckObjectArray<Sprite>(L, 2);
			LTDescr o = obj.setSprites(sprites);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setFrameRate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			float frameRate = (float)LuaDLL.luaL_checknumber(L, 2);
			LTDescr o = obj.setFrameRate(frameRate);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setOnStart(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			Action onStart = (Action)ToLua.CheckDelegate<Action>(L, 2);
			LTDescr o = obj.setOnStart(onStart);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setDirection(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			float direction = (float)LuaDLL.luaL_checknumber(L, 2);
			LTDescr o = obj.setDirection(direction);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int setRecursive(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LTDescr obj = (LTDescr)ToLua.CheckObject<LTDescr>(L, 1);
			bool recursive = LuaDLL.luaL_checkboolean(L, 2);
			LTDescr o = obj.setRecursive(recursive);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_toggle(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool toggle = ((LTDescr)obj).toggle;
			LuaDLL.lua_pushboolean(L, toggle);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index toggle on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useEstimatedTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool useEstimatedTime = ((LTDescr)obj).useEstimatedTime;
			LuaDLL.lua_pushboolean(L, useEstimatedTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useEstimatedTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useFrames(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool useFrames = ((LTDescr)obj).useFrames;
			LuaDLL.lua_pushboolean(L, useFrames);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useFrames on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useManualTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool useManualTime = ((LTDescr)obj).useManualTime;
			LuaDLL.lua_pushboolean(L, useManualTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useManualTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_usesNormalDt(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool usesNormalDt = ((LTDescr)obj).usesNormalDt;
			LuaDLL.lua_pushboolean(L, usesNormalDt);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index usesNormalDt on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hasInitiliazed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool hasInitiliazed = ((LTDescr)obj).hasInitiliazed;
			LuaDLL.lua_pushboolean(L, hasInitiliazed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hasInitiliazed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hasExtraOnCompletes(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool hasExtraOnCompletes = ((LTDescr)obj).hasExtraOnCompletes;
			LuaDLL.lua_pushboolean(L, hasExtraOnCompletes);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hasExtraOnCompletes on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hasPhysics(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool hasPhysics = ((LTDescr)obj).hasPhysics;
			LuaDLL.lua_pushboolean(L, hasPhysics);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hasPhysics on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onCompleteOnRepeat(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool onCompleteOnRepeat = ((LTDescr)obj).onCompleteOnRepeat;
			LuaDLL.lua_pushboolean(L, onCompleteOnRepeat);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onCompleteOnRepeat on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onCompleteOnStart(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool onCompleteOnStart = ((LTDescr)obj).onCompleteOnStart;
			LuaDLL.lua_pushboolean(L, onCompleteOnStart);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onCompleteOnStart on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useRecursion(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool useRecursion = ((LTDescr)obj).useRecursion;
			LuaDLL.lua_pushboolean(L, useRecursion);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useRecursion on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ratioPassed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float ratioPassed = ((LTDescr)obj).ratioPassed;
			LuaDLL.lua_pushnumber(L, ratioPassed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ratioPassed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_passed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float passed = ((LTDescr)obj).passed;
			LuaDLL.lua_pushnumber(L, passed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index passed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_delay(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float delay = ((LTDescr)obj).delay;
			LuaDLL.lua_pushnumber(L, delay);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index delay on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_time(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float time = ((LTDescr)obj).time;
			LuaDLL.lua_pushnumber(L, time);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index time on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_speed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float speed = ((LTDescr)obj).speed;
			LuaDLL.lua_pushnumber(L, speed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index speed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lastVal(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float lastVal = ((LTDescr)obj).lastVal;
			LuaDLL.lua_pushnumber(L, lastVal);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastVal on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_loopCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int loopCount = ((LTDescr)obj).loopCount;
			LuaDLL.lua_pushinteger(L, loopCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index loopCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_counter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			uint counter = ((LTDescr)obj).counter;
			LuaDLL.lua_pushnumber(L, counter);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index counter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_direction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float direction = ((LTDescr)obj).direction;
			LuaDLL.lua_pushnumber(L, direction);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index direction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_directionLast(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float directionLast = ((LTDescr)obj).directionLast;
			LuaDLL.lua_pushnumber(L, directionLast);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index directionLast on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_overshoot(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float overshoot = ((LTDescr)obj).overshoot;
			LuaDLL.lua_pushnumber(L, overshoot);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index overshoot on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_period(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float period = ((LTDescr)obj).period;
			LuaDLL.lua_pushnumber(L, period);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index period on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_scale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float scale = ((LTDescr)obj).scale;
			LuaDLL.lua_pushnumber(L, scale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_destroyOnComplete(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool destroyOnComplete = ((LTDescr)obj).destroyOnComplete;
			LuaDLL.lua_pushboolean(L, destroyOnComplete);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index destroyOnComplete on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_trans(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform trans = ((LTDescr)obj).trans;
			ToLua.Push(L, trans);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index trans on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_type(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TweenAction type = ((LTDescr)obj).type;
			ToLua.Push(L, type);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index type on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_loopType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LeanTweenType loopType = ((LTDescr)obj).loopType;
			ToLua.Push(L, loopType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index loopType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hasUpdateCallback(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool hasUpdateCallback = ((LTDescr)obj).hasUpdateCallback;
			LuaDLL.lua_pushboolean(L, hasUpdateCallback);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hasUpdateCallback on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_easeMethod(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr.EaseTypeDelegate easeMethod = ((LTDescr)obj).easeMethod;
			ToLua.Push(L, easeMethod);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index easeMethod on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_spriteRen(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SpriteRenderer spriteRen = ((LTDescr)obj).spriteRen;
			ToLua.PushSealed(L, spriteRen);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spriteRen on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rectTransform(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform rectTransform = ((LTDescr)obj).rectTransform;
			ToLua.PushSealed(L, rectTransform);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rectTransform on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_uiText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text uiText = ((LTDescr)obj).uiText;
			ToLua.Push(L, uiText);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uiText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_uiImage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Image uiImage = ((LTDescr)obj).uiImage;
			ToLua.Push(L, uiImage);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uiImage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rawImage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RawImage rawImage = ((LTDescr)obj).rawImage;
			ToLua.Push(L, rawImage);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rawImage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sprites(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Sprite[] sprites = ((LTDescr)obj).sprites;
			ToLua.Push(L, sprites);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sprites on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__optional(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescrOptional optional = ((LTDescr)obj)._optional;
			ToLua.PushObject(L, optional);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _optional on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_val(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, LTDescr.val);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dt(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, LTDescr.dt);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_newVect(IntPtr L)
	{
		try
		{
			ToLua.Push(L, LTDescr.newVect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_from(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 v = ((LTDescr)obj).from;
			ToLua.Push(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index from on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_to(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 to = ((LTDescr)obj).to;
			ToLua.Push(L, to);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index to on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_easeInternal(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr.ActionMethodDelegate easeInternal = ((LTDescr)obj).easeInternal;
			ToLua.Push(L, easeInternal);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index easeInternal on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_initInternal(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr.ActionMethodDelegate initInternal = ((LTDescr)obj).initInternal;
			ToLua.Push(L, initInternal);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index initInternal on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_toTrans(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform toTrans = ((LTDescr)obj).toTrans;
			ToLua.Push(L, toTrans);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index toTrans on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_uniqueId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int uniqueId = ((LTDescr)obj).uniqueId;
			LuaDLL.lua_pushinteger(L, uniqueId);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uniqueId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int id = ((LTDescr)obj).id;
			LuaDLL.lua_pushinteger(L, id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_optional(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescrOptional optional = ((LTDescr)obj).optional;
			ToLua.PushObject(L, optional);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index optional on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_toggle(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			bool toggle = LuaDLL.luaL_checkboolean(L, 2);
			obj2.toggle = toggle;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index toggle on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useEstimatedTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			bool useEstimatedTime = LuaDLL.luaL_checkboolean(L, 2);
			obj2.useEstimatedTime = useEstimatedTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useEstimatedTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useFrames(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			bool useFrames = LuaDLL.luaL_checkboolean(L, 2);
			obj2.useFrames = useFrames;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useFrames on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useManualTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			bool useManualTime = LuaDLL.luaL_checkboolean(L, 2);
			obj2.useManualTime = useManualTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useManualTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_usesNormalDt(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			bool usesNormalDt = LuaDLL.luaL_checkboolean(L, 2);
			obj2.usesNormalDt = usesNormalDt;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index usesNormalDt on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_hasInitiliazed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			bool hasInitiliazed = LuaDLL.luaL_checkboolean(L, 2);
			obj2.hasInitiliazed = hasInitiliazed;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hasInitiliazed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_hasExtraOnCompletes(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			bool hasExtraOnCompletes = LuaDLL.luaL_checkboolean(L, 2);
			obj2.hasExtraOnCompletes = hasExtraOnCompletes;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hasExtraOnCompletes on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_hasPhysics(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			bool hasPhysics = LuaDLL.luaL_checkboolean(L, 2);
			obj2.hasPhysics = hasPhysics;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hasPhysics on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onCompleteOnRepeat(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			bool onCompleteOnRepeat = LuaDLL.luaL_checkboolean(L, 2);
			obj2.onCompleteOnRepeat = onCompleteOnRepeat;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onCompleteOnRepeat on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onCompleteOnStart(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			bool onCompleteOnStart = LuaDLL.luaL_checkboolean(L, 2);
			obj2.onCompleteOnStart = onCompleteOnStart;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onCompleteOnStart on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useRecursion(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			bool useRecursion = LuaDLL.luaL_checkboolean(L, 2);
			obj2.useRecursion = useRecursion;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useRecursion on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ratioPassed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			float ratioPassed = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.ratioPassed = ratioPassed;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ratioPassed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_passed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			float passed = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.passed = passed;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index passed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_delay(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			float delay = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.delay = delay;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index delay on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_time(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			float time = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.time = time;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index time on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_speed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			float speed = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.speed = speed;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index speed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lastVal(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			float lastVal = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.lastVal = lastVal;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastVal on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_loopCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			int loopCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.loopCount = loopCount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index loopCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_counter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			uint counter = (uint)LuaDLL.luaL_checknumber(L, 2);
			obj2.counter = counter;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index counter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_direction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			float direction = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.direction = direction;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index direction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_directionLast(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			float directionLast = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.directionLast = directionLast;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index directionLast on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_overshoot(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			float overshoot = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.overshoot = overshoot;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index overshoot on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_period(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			float period = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.period = period;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index period on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_scale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			float scale = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.scale = scale;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_destroyOnComplete(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			bool destroyOnComplete = LuaDLL.luaL_checkboolean(L, 2);
			obj2.destroyOnComplete = destroyOnComplete;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index destroyOnComplete on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_trans(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			Transform trans = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.trans = trans;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index trans on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_type(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			TweenAction type = (TweenAction)ToLua.CheckObject(L, 2, typeof(TweenAction));
			obj2.type = type;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index type on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_loopType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			LeanTweenType loopType = (LeanTweenType)ToLua.CheckObject(L, 2, typeof(LeanTweenType));
			obj2.loopType = loopType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index loopType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_hasUpdateCallback(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			bool hasUpdateCallback = LuaDLL.luaL_checkboolean(L, 2);
			obj2.hasUpdateCallback = hasUpdateCallback;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hasUpdateCallback on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_easeMethod(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			LTDescr.EaseTypeDelegate easeMethod = (LTDescr.EaseTypeDelegate)ToLua.CheckDelegate<LTDescr.EaseTypeDelegate>(L, 2);
			obj2.easeMethod = easeMethod;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index easeMethod on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_spriteRen(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			SpriteRenderer spriteRen = (SpriteRenderer)ToLua.CheckObject(L, 2, typeof(SpriteRenderer));
			obj2.spriteRen = spriteRen;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spriteRen on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rectTransform(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			RectTransform rectTransform = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.rectTransform = rectTransform;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rectTransform on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_uiText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			Text uiText = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.uiText = uiText;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uiText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_uiImage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			Image uiImage = (Image)ToLua.CheckObject<Image>(L, 2);
			obj2.uiImage = uiImage;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uiImage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rawImage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			RawImage rawImage = (RawImage)ToLua.CheckObject<RawImage>(L, 2);
			obj2.rawImage = rawImage;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rawImage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sprites(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			Sprite[] sprites = ToLua.CheckObjectArray<Sprite>(L, 2);
			obj2.sprites = sprites;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sprites on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__optional(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			LTDescrOptional optional = (LTDescrOptional)ToLua.CheckObject<LTDescrOptional>(L, 2);
			obj2._optional = optional;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _optional on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_val(IntPtr L)
	{
		try
		{
			LTDescr.val = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dt(IntPtr L)
	{
		try
		{
			LTDescr.dt = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_newVect(IntPtr L)
	{
		try
		{
			LTDescr.newVect = ToLua.ToVector3(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_from(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			Vector3 vector = ToLua.ToVector3(L, 2);
			obj2.from = vector;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index from on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_to(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			Vector3 to = ToLua.ToVector3(L, 2);
			obj2.to = to;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index to on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_easeInternal(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			LTDescr.ActionMethodDelegate easeInternal = (LTDescr.ActionMethodDelegate)ToLua.CheckDelegate<LTDescr.ActionMethodDelegate>(L, 2);
			obj2.easeInternal = easeInternal;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index easeInternal on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_initInternal(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			LTDescr.ActionMethodDelegate initInternal = (LTDescr.ActionMethodDelegate)ToLua.CheckDelegate<LTDescr.ActionMethodDelegate>(L, 2);
			obj2.initInternal = initInternal;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index initInternal on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_optional(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LTDescr obj2 = (LTDescr)obj;
			LTDescrOptional optional = (LTDescrOptional)ToLua.CheckObject<LTDescrOptional>(L, 2);
			obj2.optional = optional;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index optional on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LTDescr_EaseTypeDelegate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<LTDescr.EaseTypeDelegate>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<LTDescr.EaseTypeDelegate>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LTDescr_ActionMethodDelegate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<LTDescr.ActionMethodDelegate>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<LTDescr.ActionMethodDelegate>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
