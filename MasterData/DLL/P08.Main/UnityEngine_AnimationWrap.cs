using System;
using System.Collections;
using LuaInterface;
using UnityEngine;

public class UnityEngine_AnimationWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Animation), typeof(Behaviour));
		L.RegFunction("Stop", Stop);
		L.RegFunction("Rewind", Rewind);
		L.RegFunction("Sample", Sample);
		L.RegFunction("IsPlaying", IsPlaying);
		L.RegFunction("get_Item", get_Item);
		L.RegFunction("Play", Play);
		L.RegFunction("CrossFade", CrossFade);
		L.RegFunction("Blend", Blend);
		L.RegFunction("CrossFadeQueued", CrossFadeQueued);
		L.RegFunction("PlayQueued", PlayQueued);
		L.RegFunction("AddClip", AddClip);
		L.RegFunction("RemoveClip", RemoveClip);
		L.RegFunction("GetClipCount", GetClipCount);
		L.RegFunction("SyncLayer", SyncLayer);
		L.RegFunction("GetEnumerator", GetEnumerator);
		L.RegFunction("GetClip", GetClip);
		L.RegFunction("ShowHideByScale", ShowHideByScale);
		L.RegFunction("SetHorizontalOrVerticalLayoutGroupSpacing", SetHorizontalOrVerticalLayoutGroupSpacing);
		L.RegFunction("GetHorizontalOrVerticalLayoutGroupSpacing", GetHorizontalOrVerticalLayoutGroupSpacing);
		L.RegFunction("GetLayoutGroupPaddingTop", GetLayoutGroupPaddingTop);
		L.RegFunction("SetShadowsColor", SetShadowsColor);
		L.RegFunction("PlayAnimByName", PlayAnimByName);
		L.RegFunction("GetState", GetState);
		L.RegFunction("SetRaycastTarget", SetRaycastTarget);
		L.RegFunction("SetAlpha", SetAlpha);
		L.RegFunction("SetColor", SetColor);
		L.RegFunction("GetRectSize", GetRectSize);
		L.RegFunction("GetRectHeight", GetRectHeight);
		L.RegFunction("GetRectWidth", GetRectWidth);
		L.RegFunction("SetAnchoredPositionY", SetAnchoredPositionY);
		L.RegFunction("SetAnchoredPositionX", SetAnchoredPositionX);
		L.RegFunction("SetAnchoredPositionEx", SetAnchoredPositionEx);
		L.RegFunction("SetAnchoredPosition", SetAnchoredPosition);
		L.RegFunction("GetAnchoredPositionY", GetAnchoredPositionY);
		L.RegFunction("GetAnchoredPositionX", GetAnchoredPositionX);
		L.RegFunction("GetAnchoredPosition", GetAnchoredPosition);
		L.RegFunction("GetSizeDeltaY", GetSizeDeltaY);
		L.RegFunction("GetSizeDeltaX", GetSizeDeltaX);
		L.RegFunction("GetSizeDeltaEx", GetSizeDeltaEx);
		L.RegFunction("SetSizeDeltaY", SetSizeDeltaY);
		L.RegFunction("SetSizeDeltaX", SetSizeDeltaX);
		L.RegFunction("SetSizeDeltaEx", SetSizeDeltaEx);
		L.RegFunction("SetSizeDelta", SetSizeDelta);
		L.RegFunction("RotateAxisY", RotateAxisY);
		L.RegFunction("GetLocalEulerAngleZ", GetLocalEulerAngleZ);
		L.RegFunction("GetLocalEulerAngleY", GetLocalEulerAngleY);
		L.RegFunction("GetLocalEulerAngleX", GetLocalEulerAngleX);
		L.RegFunction("GetEulerAngleY", GetEulerAngleY);
		L.RegFunction("GetEulerAngle", GetEulerAngle);
		L.RegFunction("GetLocalEulerAngle", GetLocalEulerAngle);
		L.RegFunction("GetLocalEulerAngleOrigin", GetLocalEulerAngleOrigin);
		L.RegFunction("SetLocalEulerAngleY", SetLocalEulerAngleY);
		L.RegFunction("SetLocalEulerAngleZ", SetLocalEulerAngleZ);
		L.RegFunction("SetLocalEulerAngleOrigin", SetLocalEulerAngleOrigin);
		L.RegFunction("SetLocalEulerAngle", SetLocalEulerAngle);
		L.RegFunction("SetLocalRotationOne", SetLocalRotationOne);
		L.RegFunction("GetLocalScaleX", GetLocalScaleX);
		L.RegFunction("GetLocalScaleEx", GetLocalScaleEx);
		L.RegFunction("GetLocalScale", GetLocalScale);
		L.RegFunction("SetLocalScaleZ", SetLocalScaleZ);
		L.RegFunction("SetLocalScaleX", SetLocalScaleX);
		L.RegFunction("SetLocalScaleY", SetLocalScaleY);
		L.RegFunction("SetLocalScaleVal", SetLocalScaleVal);
		L.RegFunction("SetLocalScale", SetLocalScale);
		L.RegFunction("SetLocalScaleEx", SetLocalScaleEx);
		L.RegFunction("SetLocalScaleOne", SetLocalScaleOne);
		L.RegFunction("SetLocalScaleZero", SetLocalScaleZero);
		L.RegFunction("GetPositionEx", GetPositionEx);
		L.RegFunction("GetPositionY", GetPositionY);
		L.RegFunction("GetPositionX", GetPositionX);
		L.RegFunction("GetPosition", GetPosition);
		L.RegFunction("SetPositionFromTarget", SetPositionFromTarget);
		L.RegFunction("SetPositionZ", SetPositionZ);
		L.RegFunction("SetPositionY", SetPositionY);
		L.RegFunction("SetPositionX", SetPositionX);
		L.RegFunction("SetPosition", SetPosition);
		L.RegFunction("SetPositionEx", SetPositionEx);
		L.RegFunction("SetPostionZero", SetPostionZero);
		L.RegFunction("GetLocalPositionY", GetLocalPositionY);
		L.RegFunction("GetLocalPositionX", GetLocalPositionX);
		L.RegFunction("GetLocalPositionEx", GetLocalPositionEx);
		L.RegFunction("GetLocalPosition", GetLocalPosition);
		L.RegFunction("SetLocalPositionFromTarget", SetLocalPositionFromTarget);
		L.RegFunction("SetLocalPositionZ", SetLocalPositionZ);
		L.RegFunction("SetLocalPositionY", SetLocalPositionY);
		L.RegFunction("SetLocalPositionX", SetLocalPositionX);
		L.RegFunction("SetLocalPosition", SetLocalPosition);
		L.RegFunction("SetLocalPositionEx", SetLocalPositionEx);
		L.RegFunction("SetLocalPositionZero", SetLocalPositionZero);
		L.RegFunction("SetParentPure", SetParentPure);
		L.RegFunction("SetParentAndInitTrans", SetParentAndInitTrans);
		L.RegFunction("SetActive", SetActive);
		L.RegFunction("InitTransform", InitTransform);
		L.RegFunction("New", _CreateUnityEngine_Animation);
		L.RegVar("this", _this, null);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("clip", get_clip, set_clip);
		L.RegVar("playAutomatically", get_playAutomatically, set_playAutomatically);
		L.RegVar("wrapMode", get_wrapMode, set_wrapMode);
		L.RegVar("isPlaying", get_isPlaying, null);
		L.RegVar("animatePhysics", get_animatePhysics, set_animatePhysics);
		L.RegVar("cullingType", get_cullingType, set_cullingType);
		L.RegVar("localBounds", get_localBounds, set_localBounds);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_Animation(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				Animation o = new Animation();
				ToLua.PushSealed(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.Animation.New");
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
			Animation obj = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			string name = ToLua.CheckString(L, 2);
			AnimationState o = obj.get_Item(name);
			ToLua.PushSealed(L, o);
			return 1;
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
			LuaDLL.tolua_bindthis(L, _get_this, null);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Stop(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).Stop();
				return 0;
			case 2:
			{
				Animation obj = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
				string name = ToLua.CheckString(L, 2);
				obj.Stop(name);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animation.Stop");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Rewind(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).Rewind();
				return 0;
			case 2:
			{
				Animation obj = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
				string name = ToLua.CheckString(L, 2);
				obj.Rewind(name);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animation.Rewind");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Sample(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).Sample();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsPlaying(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation obj = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			string name = ToLua.CheckString(L, 2);
			bool value = obj.IsPlaying(name);
			LuaDLL.lua_pushboolean(L, value);
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
			Animation obj = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			string name = ToLua.CheckString(L, 2);
			AnimationState o = obj.get_Item(name);
			ToLua.PushSealed(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Play(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 1:
			{
				bool value2 = ((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).Play();
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 2:
				if (TypeChecker.CheckTypes<PlayMode>(L, 2))
				{
					Animation obj = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
					PlayMode mode = (PlayMode)ToLua.ToObject(L, 2);
					bool value = obj.Play(mode);
					LuaDLL.lua_pushboolean(L, value);
					return 1;
				}
				break;
			}
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				Animation obj2 = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
				string animation = ToLua.ToString(L, 2);
				bool value3 = obj2.Play(animation);
				LuaDLL.lua_pushboolean(L, value3);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<PlayMode>(L, 3))
			{
				Animation obj3 = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
				string animation2 = ToLua.CheckString(L, 2);
				PlayMode mode2 = (PlayMode)ToLua.ToObject(L, 3);
				bool value4 = obj3.Play(animation2, mode2);
				LuaDLL.lua_pushboolean(L, value4);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<float>(L, 3))
			{
				Animation animation3 = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
				string name = ToLua.CheckString(L, 2);
				float time = (float)LuaDLL.lua_tonumber(L, 3);
				animation3.Play(name, time);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animation.Play");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CrossFade(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Animation obj3 = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
				string animation3 = ToLua.CheckString(L, 2);
				obj3.CrossFade(animation3);
				return 0;
			}
			case 3:
			{
				Animation obj2 = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
				string animation2 = ToLua.CheckString(L, 2);
				float fadeLength2 = (float)LuaDLL.luaL_checknumber(L, 3);
				obj2.CrossFade(animation2, fadeLength2);
				return 0;
			}
			case 4:
			{
				Animation obj = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
				string animation = ToLua.CheckString(L, 2);
				float fadeLength = (float)LuaDLL.luaL_checknumber(L, 3);
				PlayMode mode = (PlayMode)ToLua.CheckObject(L, 4, typeof(PlayMode));
				obj.CrossFade(animation, fadeLength, mode);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animation.CrossFade");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Blend(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Animation obj3 = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
				string animation3 = ToLua.CheckString(L, 2);
				obj3.Blend(animation3);
				return 0;
			}
			case 3:
			{
				Animation obj2 = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
				string animation2 = ToLua.CheckString(L, 2);
				float targetWeight2 = (float)LuaDLL.luaL_checknumber(L, 3);
				obj2.Blend(animation2, targetWeight2);
				return 0;
			}
			case 4:
			{
				Animation obj = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
				string animation = ToLua.CheckString(L, 2);
				float targetWeight = (float)LuaDLL.luaL_checknumber(L, 3);
				float fadeLength = (float)LuaDLL.luaL_checknumber(L, 4);
				obj.Blend(animation, targetWeight, fadeLength);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animation.Blend");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CrossFadeQueued(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Animation obj4 = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
				string animation4 = ToLua.CheckString(L, 2);
				AnimationState o4 = obj4.CrossFadeQueued(animation4);
				ToLua.PushSealed(L, o4);
				return 1;
			}
			case 3:
			{
				Animation obj3 = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
				string animation3 = ToLua.CheckString(L, 2);
				float fadeLength3 = (float)LuaDLL.luaL_checknumber(L, 3);
				AnimationState o3 = obj3.CrossFadeQueued(animation3, fadeLength3);
				ToLua.PushSealed(L, o3);
				return 1;
			}
			case 4:
			{
				Animation obj2 = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
				string animation2 = ToLua.CheckString(L, 2);
				float fadeLength2 = (float)LuaDLL.luaL_checknumber(L, 3);
				QueueMode queue2 = (QueueMode)ToLua.CheckObject(L, 4, typeof(QueueMode));
				AnimationState o2 = obj2.CrossFadeQueued(animation2, fadeLength2, queue2);
				ToLua.PushSealed(L, o2);
				return 1;
			}
			case 5:
			{
				Animation obj = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
				string animation = ToLua.CheckString(L, 2);
				float fadeLength = (float)LuaDLL.luaL_checknumber(L, 3);
				QueueMode queue = (QueueMode)ToLua.CheckObject(L, 4, typeof(QueueMode));
				PlayMode mode = (PlayMode)ToLua.CheckObject(L, 5, typeof(PlayMode));
				AnimationState o = obj.CrossFadeQueued(animation, fadeLength, queue, mode);
				ToLua.PushSealed(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animation.CrossFadeQueued");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayQueued(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Animation obj3 = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
				string animation3 = ToLua.CheckString(L, 2);
				AnimationState o3 = obj3.PlayQueued(animation3);
				ToLua.PushSealed(L, o3);
				return 1;
			}
			case 3:
			{
				Animation obj2 = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
				string animation2 = ToLua.CheckString(L, 2);
				QueueMode queue2 = (QueueMode)ToLua.CheckObject(L, 3, typeof(QueueMode));
				AnimationState o2 = obj2.PlayQueued(animation2, queue2);
				ToLua.PushSealed(L, o2);
				return 1;
			}
			case 4:
			{
				Animation obj = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
				string animation = ToLua.CheckString(L, 2);
				QueueMode queue = (QueueMode)ToLua.CheckObject(L, 3, typeof(QueueMode));
				PlayMode mode = (PlayMode)ToLua.CheckObject(L, 4, typeof(PlayMode));
				AnimationState o = obj.PlayQueued(animation, queue, mode);
				ToLua.PushSealed(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animation.PlayQueued");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddClip(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				Animation obj3 = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
				AnimationClip clip3 = (AnimationClip)ToLua.CheckObject(L, 2, typeof(AnimationClip));
				string newName3 = ToLua.CheckString(L, 3);
				obj3.AddClip(clip3, newName3);
				return 0;
			}
			case 5:
			{
				Animation obj2 = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
				AnimationClip clip2 = (AnimationClip)ToLua.CheckObject(L, 2, typeof(AnimationClip));
				string newName2 = ToLua.CheckString(L, 3);
				int firstFrame2 = (int)LuaDLL.luaL_checknumber(L, 4);
				int lastFrame2 = (int)LuaDLL.luaL_checknumber(L, 5);
				obj2.AddClip(clip2, newName2, firstFrame2, lastFrame2);
				return 0;
			}
			case 6:
			{
				Animation obj = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
				AnimationClip clip = (AnimationClip)ToLua.CheckObject(L, 2, typeof(AnimationClip));
				string newName = ToLua.CheckString(L, 3);
				int firstFrame = (int)LuaDLL.luaL_checknumber(L, 4);
				int lastFrame = (int)LuaDLL.luaL_checknumber(L, 5);
				bool addLoopFrame = LuaDLL.luaL_checkboolean(L, 6);
				obj.AddClip(clip, newName, firstFrame, lastFrame, addLoopFrame);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animation.AddClip");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveClip(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<AnimationClip>(L, 2))
			{
				Animation obj = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
				AnimationClip clip = (AnimationClip)ToLua.ToObject(L, 2);
				obj.RemoveClip(clip);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				Animation obj2 = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
				string clipName = ToLua.ToString(L, 2);
				obj2.RemoveClip(clipName);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animation.RemoveClip");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetClipCount(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int clipCount = ((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetClipCount();
			LuaDLL.lua_pushinteger(L, clipCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SyncLayer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation obj = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			int layer = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.SyncLayer(layer);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetEnumerator(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			IEnumerator enumerator = ((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetEnumerator();
			ToLua.Push(L, enumerator);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetClip(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation obj = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			string name = ToLua.CheckString(L, 2);
			AnimationClip clip = obj.GetClip(name);
			ToLua.PushSealed(L, clip);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShowHideByScale(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			bool isShow = LuaDLL.luaL_checkboolean(L, 2);
			cmpt.ShowHideByScale(isShow);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetHorizontalOrVerticalLayoutGroupSpacing(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			float spacing = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetHorizontalOrVerticalLayoutGroupSpacing(spacing);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetHorizontalOrVerticalLayoutGroupSpacing(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float horizontalOrVerticalLayoutGroupSpacing = ((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetHorizontalOrVerticalLayoutGroupSpacing();
			LuaDLL.lua_pushnumber(L, horizontalOrVerticalLayoutGroupSpacing);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLayoutGroupPaddingTop(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int layoutGroupPaddingTop = ((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetLayoutGroupPaddingTop();
			LuaDLL.lua_pushinteger(L, layoutGroupPaddingTop);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetShadowsColor(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			Color color = ToLua.ToColor(L, 2);
			cmpt.SetShadowsColor(color);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayAnimByName(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation animation = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			string name = ToLua.CheckString(L, 2);
			animation.PlayAnimByName(name);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation animation = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			string name = ToLua.CheckString(L, 2);
			AnimationState state = animation.GetState(name);
			ToLua.PushSealed(L, state);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetRaycastTarget(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			bool isTarget = LuaDLL.luaL_checkboolean(L, 2);
			cmpt.SetRaycastTarget(isTarget);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAlpha(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			float a = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetAlpha(a);
			return 0;
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
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			Color c = ToLua.ToColor(L, 2);
			cmpt.SetColor(c);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRectSize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetRectSize(out var width, out var height);
			LuaDLL.lua_pushnumber(L, width);
			LuaDLL.lua_pushnumber(L, height);
			return 2;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRectHeight(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetRectHeight(out var height);
			LuaDLL.lua_pushnumber(L, height);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRectWidth(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float rectWidth = ((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetRectWidth();
			LuaDLL.lua_pushnumber(L, rectWidth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAnchoredPositionY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			float y = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetAnchoredPositionY(y);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAnchoredPositionX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetAnchoredPositionX(x);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAnchoredPositionEx(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			float y = (float)LuaDLL.luaL_checknumber(L, 3);
			cmpt.SetAnchoredPositionEx(x, y);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAnchoredPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			Vector2 pos = ToLua.ToVector2(L, 2);
			cmpt.SetAnchoredPosition(pos);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAnchoredPositionY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetAnchoredPositionY(out var y);
			LuaDLL.lua_pushnumber(L, y);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAnchoredPositionX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetAnchoredPositionX(out var x);
			LuaDLL.lua_pushnumber(L, x);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAnchoredPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetAnchoredPosition(out var x, out var y);
			LuaDLL.lua_pushnumber(L, x);
			LuaDLL.lua_pushnumber(L, y);
			return 2;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSizeDeltaY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetSizeDeltaY(out var y);
			LuaDLL.lua_pushnumber(L, y);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSizeDeltaX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetSizeDeltaX(out var x);
			LuaDLL.lua_pushnumber(L, x);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSizeDeltaEx(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetSizeDeltaEx(out var x, out var y);
			LuaDLL.lua_pushnumber(L, x);
			LuaDLL.lua_pushnumber(L, y);
			return 2;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSizeDeltaY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			float y = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetSizeDeltaY(y);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSizeDeltaX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetSizeDeltaX(x);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSizeDeltaEx(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			float y = (float)LuaDLL.luaL_checknumber(L, 3);
			cmpt.SetSizeDeltaEx(x, y);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSizeDelta(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			Vector2 size = ToLua.ToVector2(L, 2);
			cmpt.SetSizeDelta(size);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RotateAxisY(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Animation cmpt2 = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
				float y2 = (float)LuaDLL.luaL_checknumber(L, 2);
				cmpt2.RotateAxisY(y2);
				return 0;
			}
			case 3:
			{
				Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
				float y = (float)LuaDLL.luaL_checknumber(L, 2);
				Space relativeTo = (Space)ToLua.CheckObject(L, 3, typeof(Space));
				cmpt.RotateAxisY(y, relativeTo);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animation.RotateAxisY");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLocalEulerAngleZ(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float localEulerAngleZ = ((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetLocalEulerAngleZ();
			LuaDLL.lua_pushnumber(L, localEulerAngleZ);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLocalEulerAngleY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float localEulerAngleY = ((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetLocalEulerAngleY();
			LuaDLL.lua_pushnumber(L, localEulerAngleY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLocalEulerAngleX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float localEulerAngleX = ((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetLocalEulerAngleX();
			LuaDLL.lua_pushnumber(L, localEulerAngleX);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetEulerAngleY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float eulerAngleY = ((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetEulerAngleY();
			LuaDLL.lua_pushnumber(L, eulerAngleY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetEulerAngle(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector3 eulerAngle = ((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetEulerAngle();
			ToLua.Push(L, eulerAngle);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLocalEulerAngle(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetLocalEulerAngle(out var x, out var y, out var z);
			LuaDLL.lua_pushnumber(L, x);
			LuaDLL.lua_pushnumber(L, y);
			LuaDLL.lua_pushnumber(L, z);
			return 3;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLocalEulerAngleOrigin(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector3 localEulerAngleOrigin = ((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetLocalEulerAngleOrigin();
			ToLua.Push(L, localEulerAngleOrigin);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalEulerAngleY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			float y = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetLocalEulerAngleY(y);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalEulerAngleZ(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			float z = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetLocalEulerAngleZ(z);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalEulerAngleOrigin(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			Vector3 v = ToLua.ToVector3(L, 2);
			cmpt.SetLocalEulerAngleOrigin(v);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalEulerAngle(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			float y = (float)LuaDLL.luaL_checknumber(L, 3);
			float z = (float)LuaDLL.luaL_checknumber(L, 4);
			cmpt.SetLocalEulerAngle(x, y, z);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalRotationOne(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).SetLocalRotationOne();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLocalScaleX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float localScaleX = ((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetLocalScaleX();
			LuaDLL.lua_pushnumber(L, localScaleX);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLocalScaleEx(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetLocalScaleEx(out var x, out var y, out var z);
			LuaDLL.lua_pushnumber(L, x);
			LuaDLL.lua_pushnumber(L, y);
			LuaDLL.lua_pushnumber(L, z);
			return 3;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLocalScale(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector3 localScale = ((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetLocalScale();
			ToLua.Push(L, localScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalScaleZ(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			float z = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetLocalScaleZ(z);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalScaleX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetLocalScaleX(x);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalScaleY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			float y = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetLocalScaleY(y);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalScaleVal(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			float val = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetLocalScaleVal(val);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalScale(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			Vector3 scale = ToLua.ToVector3(L, 2);
			cmpt.SetLocalScale(scale);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalScaleEx(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			float y = (float)LuaDLL.luaL_checknumber(L, 3);
			float z = (float)LuaDLL.luaL_checknumber(L, 4);
			cmpt.SetLocalScaleEx(x, y, z);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalScaleOne(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).SetLocalScaleOne();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalScaleZero(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).SetLocalScaleZero();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPositionEx(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetPositionEx(out var x, out var y, out var z);
			LuaDLL.lua_pushnumber(L, x);
			LuaDLL.lua_pushnumber(L, y);
			LuaDLL.lua_pushnumber(L, z);
			return 3;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPositionY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float positionY = ((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetPositionY();
			LuaDLL.lua_pushnumber(L, positionY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPositionX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float positionX = ((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetPositionX();
			LuaDLL.lua_pushnumber(L, positionX);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector3 position = ((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetPosition();
			ToLua.Push(L, position);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPositionFromTarget(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			Transform target = (Transform)ToLua.CheckObject<Transform>(L, 2);
			cmpt.SetPositionFromTarget(target);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPositionZ(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			float z = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetPositionZ(z);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPositionY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			float y = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetPositionY(y);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPositionX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetPositionX(x);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			Vector3 pos = ToLua.ToVector3(L, 2);
			cmpt.SetPosition(pos);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPositionEx(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			float y = (float)LuaDLL.luaL_checknumber(L, 3);
			float z = (float)LuaDLL.luaL_checknumber(L, 4);
			cmpt.SetPositionEx(x, y, z);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPostionZero(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).SetPostionZero();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLocalPositionY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float localPositionY = ((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetLocalPositionY();
			LuaDLL.lua_pushnumber(L, localPositionY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLocalPositionX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float localPositionX = ((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetLocalPositionX();
			LuaDLL.lua_pushnumber(L, localPositionX);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLocalPositionEx(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetLocalPositionEx(out var x, out var y, out var z);
			LuaDLL.lua_pushnumber(L, x);
			LuaDLL.lua_pushnumber(L, y);
			LuaDLL.lua_pushnumber(L, z);
			return 3;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLocalPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector3 localPosition = ((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).GetLocalPosition();
			ToLua.Push(L, localPosition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalPositionFromTarget(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			Transform target = (Transform)ToLua.CheckObject<Transform>(L, 2);
			cmpt.SetLocalPositionFromTarget(target);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalPositionZ(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			float z = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetLocalPositionZ(z);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalPositionY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			float y = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetLocalPositionY(y);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalPositionX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetLocalPositionX(x);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			Vector3 pos = ToLua.ToVector3(L, 2);
			cmpt.SetLocalPosition(pos);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalPositionEx(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			float y = (float)LuaDLL.luaL_checknumber(L, 3);
			float z = (float)LuaDLL.luaL_checknumber(L, 4);
			cmpt.SetLocalPositionEx(x, y, z);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalPositionZero(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).SetLocalPositionZero();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetParentPure(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			Component parent = (Component)ToLua.CheckObject<Component>(L, 2);
			cmpt.SetParentPure(parent);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetParentAndInitTrans(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			Component parent = (Component)ToLua.CheckObject<Component>(L, 2);
			cmpt.SetParentAndInitTrans(parent);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetActive(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animation cmpt = (Animation)ToLua.CheckObject(L, 1, typeof(Animation));
			bool bActive = LuaDLL.luaL_checkboolean(L, 2);
			cmpt.SetActive(bActive);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitTransform(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Animation)ToLua.CheckObject(L, 1, typeof(Animation))).InitTransform();
			return 0;
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
	private static int get_clip(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationClip clip = ((Animation)obj).clip;
			ToLua.PushSealed(L, clip);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index clip on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_playAutomatically(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool playAutomatically = ((Animation)obj).playAutomatically;
			LuaDLL.lua_pushboolean(L, playAutomatically);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playAutomatically on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wrapMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			WrapMode wrapMode = ((Animation)obj).wrapMode;
			ToLua.Push(L, wrapMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wrapMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isPlaying(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isPlaying = ((Animation)obj).isPlaying;
			LuaDLL.lua_pushboolean(L, isPlaying);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isPlaying on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_animatePhysics(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool animatePhysics = ((Animation)obj).animatePhysics;
			LuaDLL.lua_pushboolean(L, animatePhysics);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index animatePhysics on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cullingType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationCullingType cullingType = ((Animation)obj).cullingType;
			ToLua.Push(L, cullingType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cullingType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_localBounds(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Bounds localBounds = ((Animation)obj).localBounds;
			ToLua.Push(L, localBounds);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index localBounds on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_clip(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animation obj2 = (Animation)obj;
			AnimationClip clip = (AnimationClip)ToLua.CheckObject(L, 2, typeof(AnimationClip));
			obj2.clip = clip;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index clip on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_playAutomatically(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animation obj2 = (Animation)obj;
			bool playAutomatically = LuaDLL.luaL_checkboolean(L, 2);
			obj2.playAutomatically = playAutomatically;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playAutomatically on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wrapMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animation obj2 = (Animation)obj;
			WrapMode wrapMode = (WrapMode)ToLua.CheckObject(L, 2, typeof(WrapMode));
			obj2.wrapMode = wrapMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wrapMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_animatePhysics(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animation obj2 = (Animation)obj;
			bool animatePhysics = LuaDLL.luaL_checkboolean(L, 2);
			obj2.animatePhysics = animatePhysics;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index animatePhysics on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cullingType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animation obj2 = (Animation)obj;
			AnimationCullingType cullingType = (AnimationCullingType)ToLua.CheckObject(L, 2, typeof(AnimationCullingType));
			obj2.cullingType = cullingType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cullingType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_localBounds(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animation obj2 = (Animation)obj;
			Bounds localBounds = ToLua.ToBounds(L, 2);
			obj2.localBounds = localBounds;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index localBounds on a nil value");
		}
	}
}
