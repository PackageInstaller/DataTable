using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;
using UnityEngine.Playables;

public class UnityEngine_AnimatorWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Animator), typeof(Behaviour));
		L.RegFunction("GetFloat", GetFloat);
		L.RegFunction("SetFloat", SetFloat);
		L.RegFunction("GetBool", GetBool);
		L.RegFunction("SetBool", SetBool);
		L.RegFunction("GetInteger", GetInteger);
		L.RegFunction("SetInteger", SetInteger);
		L.RegFunction("SetTrigger", SetTrigger);
		L.RegFunction("ResetTrigger", ResetTrigger);
		L.RegFunction("IsParameterControlledByCurve", IsParameterControlledByCurve);
		L.RegFunction("GetIKPosition", GetIKPosition);
		L.RegFunction("SetIKPosition", SetIKPosition);
		L.RegFunction("GetIKRotation", GetIKRotation);
		L.RegFunction("SetIKRotation", SetIKRotation);
		L.RegFunction("GetIKPositionWeight", GetIKPositionWeight);
		L.RegFunction("SetIKPositionWeight", SetIKPositionWeight);
		L.RegFunction("GetIKRotationWeight", GetIKRotationWeight);
		L.RegFunction("SetIKRotationWeight", SetIKRotationWeight);
		L.RegFunction("GetIKHintPosition", GetIKHintPosition);
		L.RegFunction("SetIKHintPosition", SetIKHintPosition);
		L.RegFunction("GetIKHintPositionWeight", GetIKHintPositionWeight);
		L.RegFunction("SetIKHintPositionWeight", SetIKHintPositionWeight);
		L.RegFunction("SetLookAtPosition", SetLookAtPosition);
		L.RegFunction("SetLookAtWeight", SetLookAtWeight);
		L.RegFunction("SetBoneLocalRotation", SetBoneLocalRotation);
		L.RegFunction("GetBehaviours", GetBehaviours);
		L.RegFunction("GetLayerName", GetLayerName);
		L.RegFunction("GetLayerIndex", GetLayerIndex);
		L.RegFunction("GetLayerWeight", GetLayerWeight);
		L.RegFunction("SetLayerWeight", SetLayerWeight);
		L.RegFunction("GetCurrentAnimatorStateInfo", GetCurrentAnimatorStateInfo);
		L.RegFunction("GetNextAnimatorStateInfo", GetNextAnimatorStateInfo);
		L.RegFunction("GetAnimatorTransitionInfo", GetAnimatorTransitionInfo);
		L.RegFunction("GetCurrentAnimatorClipInfoCount", GetCurrentAnimatorClipInfoCount);
		L.RegFunction("GetNextAnimatorClipInfoCount", GetNextAnimatorClipInfoCount);
		L.RegFunction("GetCurrentAnimatorClipInfo", GetCurrentAnimatorClipInfo);
		L.RegFunction("GetNextAnimatorClipInfo", GetNextAnimatorClipInfo);
		L.RegFunction("IsInTransition", IsInTransition);
		L.RegFunction("GetParameter", GetParameter);
		L.RegFunction("MatchTarget", MatchTarget);
		L.RegFunction("InterruptMatchTarget", InterruptMatchTarget);
		L.RegFunction("CrossFadeInFixedTime", CrossFadeInFixedTime);
		L.RegFunction("WriteDefaultValues", WriteDefaultValues);
		L.RegFunction("CrossFade", CrossFade);
		L.RegFunction("PlayInFixedTime", PlayInFixedTime);
		L.RegFunction("Play", Play);
		L.RegFunction("SetTarget", SetTarget);
		L.RegFunction("GetBoneTransform", GetBoneTransform);
		L.RegFunction("StartPlayback", StartPlayback);
		L.RegFunction("StopPlayback", StopPlayback);
		L.RegFunction("StartRecording", StartRecording);
		L.RegFunction("StopRecording", StopRecording);
		L.RegFunction("HasState", HasState);
		L.RegFunction("StringToHash", StringToHash);
		L.RegFunction("Update", Update);
		L.RegFunction("Rebind", Rebind);
		L.RegFunction("ApplyBuiltinRootMotion", ApplyBuiltinRootMotion);
		L.RegFunction("ShowHideByScale", ShowHideByScale);
		L.RegFunction("SetHorizontalOrVerticalLayoutGroupSpacing", SetHorizontalOrVerticalLayoutGroupSpacing);
		L.RegFunction("GetHorizontalOrVerticalLayoutGroupSpacing", GetHorizontalOrVerticalLayoutGroupSpacing);
		L.RegFunction("GetLayoutGroupPaddingTop", GetLayoutGroupPaddingTop);
		L.RegFunction("SetShadowsColor", SetShadowsColor);
		L.RegFunction("GetClipLength", GetClipLength);
		L.RegFunction("OnCheckPlayingState", OnCheckPlayingState);
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
		L.RegFunction("New", _CreateUnityEngine_Animator);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("isOptimizable", get_isOptimizable, null);
		L.RegVar("isHuman", get_isHuman, null);
		L.RegVar("hasRootMotion", get_hasRootMotion, null);
		L.RegVar("humanScale", get_humanScale, null);
		L.RegVar("isInitialized", get_isInitialized, null);
		L.RegVar("deltaPosition", get_deltaPosition, null);
		L.RegVar("deltaRotation", get_deltaRotation, null);
		L.RegVar("velocity", get_velocity, null);
		L.RegVar("angularVelocity", get_angularVelocity, null);
		L.RegVar("rootPosition", get_rootPosition, set_rootPosition);
		L.RegVar("rootRotation", get_rootRotation, set_rootRotation);
		L.RegVar("applyRootMotion", get_applyRootMotion, set_applyRootMotion);
		L.RegVar("updateMode", get_updateMode, set_updateMode);
		L.RegVar("hasTransformHierarchy", get_hasTransformHierarchy, null);
		L.RegVar("gravityWeight", get_gravityWeight, null);
		L.RegVar("bodyPosition", get_bodyPosition, set_bodyPosition);
		L.RegVar("bodyRotation", get_bodyRotation, set_bodyRotation);
		L.RegVar("stabilizeFeet", get_stabilizeFeet, set_stabilizeFeet);
		L.RegVar("layerCount", get_layerCount, null);
		L.RegVar("parameters", get_parameters, null);
		L.RegVar("parameterCount", get_parameterCount, null);
		L.RegVar("feetPivotActive", get_feetPivotActive, set_feetPivotActive);
		L.RegVar("pivotWeight", get_pivotWeight, null);
		L.RegVar("pivotPosition", get_pivotPosition, null);
		L.RegVar("isMatchingTarget", get_isMatchingTarget, null);
		L.RegVar("speed", get_speed, set_speed);
		L.RegVar("targetPosition", get_targetPosition, null);
		L.RegVar("targetRotation", get_targetRotation, null);
		L.RegVar("cullingMode", get_cullingMode, set_cullingMode);
		L.RegVar("playbackTime", get_playbackTime, set_playbackTime);
		L.RegVar("recorderStartTime", get_recorderStartTime, set_recorderStartTime);
		L.RegVar("recorderStopTime", get_recorderStopTime, set_recorderStopTime);
		L.RegVar("recorderMode", get_recorderMode, null);
		L.RegVar("runtimeAnimatorController", get_runtimeAnimatorController, set_runtimeAnimatorController);
		L.RegVar("hasBoundPlayables", get_hasBoundPlayables, null);
		L.RegVar("avatar", get_avatar, set_avatar);
		L.RegVar("playableGraph", get_playableGraph, null);
		L.RegVar("layersAffectMassCenter", get_layersAffectMassCenter, set_layersAffectMassCenter);
		L.RegVar("leftFeetBottomHeight", get_leftFeetBottomHeight, null);
		L.RegVar("rightFeetBottomHeight", get_rightFeetBottomHeight, null);
		L.RegVar("logWarnings", get_logWarnings, set_logWarnings);
		L.RegVar("fireEvents", get_fireEvents, set_fireEvents);
		L.RegVar("keepAnimatorControllerStateOnDisable", get_keepAnimatorControllerStateOnDisable, set_keepAnimatorControllerStateOnDisable);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_Animator(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				Animator obj = new Animator();
				ToLua.Push(L, obj);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.Animator.New");
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
				Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
				string name = ToLua.ToString(L, 2);
				float num2 = obj.GetFloat(name);
				LuaDLL.lua_pushnumber(L, num2);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				Animator obj2 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				int id = (int)LuaDLL.lua_tonumber(L, 2);
				float num3 = obj2.GetFloat(id);
				LuaDLL.lua_pushnumber(L, num3);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animator.GetFloat");
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
				Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
				string name = ToLua.ToString(L, 2);
				float value = (float)LuaDLL.lua_tonumber(L, 3);
				obj.SetFloat(name, value);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, float>(L, 2))
			{
				Animator obj2 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				int id = (int)LuaDLL.lua_tonumber(L, 2);
				float value2 = (float)LuaDLL.lua_tonumber(L, 3);
				obj2.SetFloat(id, value2);
				return 0;
			}
			if (num == 5 && TypeChecker.CheckTypes<string, float, float, float>(L, 2))
			{
				Animator obj3 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				string name2 = ToLua.ToString(L, 2);
				float value3 = (float)LuaDLL.lua_tonumber(L, 3);
				float dampTime = (float)LuaDLL.lua_tonumber(L, 4);
				float deltaTime = (float)LuaDLL.lua_tonumber(L, 5);
				obj3.SetFloat(name2, value3, dampTime, deltaTime);
				return 0;
			}
			if (num == 5 && TypeChecker.CheckTypes<int, float, float, float>(L, 2))
			{
				Animator obj4 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				int id2 = (int)LuaDLL.lua_tonumber(L, 2);
				float value4 = (float)LuaDLL.lua_tonumber(L, 3);
				float dampTime2 = (float)LuaDLL.lua_tonumber(L, 4);
				float deltaTime2 = (float)LuaDLL.lua_tonumber(L, 5);
				obj4.SetFloat(id2, value4, dampTime2, deltaTime2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animator.SetFloat");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetBool(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
				string name = ToLua.ToString(L, 2);
				bool value = obj.GetBool(name);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				Animator obj2 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				int id = (int)LuaDLL.lua_tonumber(L, 2);
				bool value2 = obj2.GetBool(id);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animator.GetBool");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetBool(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<string, bool>(L, 2))
			{
				Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
				string name = ToLua.ToString(L, 2);
				bool value = LuaDLL.lua_toboolean(L, 3);
				obj.SetBool(name, value);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, bool>(L, 2))
			{
				Animator obj2 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				int id = (int)LuaDLL.lua_tonumber(L, 2);
				bool value2 = LuaDLL.lua_toboolean(L, 3);
				obj2.SetBool(id, value2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animator.SetBool");
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
				Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
				string name = ToLua.ToString(L, 2);
				int integer = obj.GetInteger(name);
				LuaDLL.lua_pushinteger(L, integer);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				Animator obj2 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				int id = (int)LuaDLL.lua_tonumber(L, 2);
				int integer2 = obj2.GetInteger(id);
				LuaDLL.lua_pushinteger(L, integer2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animator.GetInteger");
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
				Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
				string name = ToLua.ToString(L, 2);
				int value = (int)LuaDLL.lua_tonumber(L, 3);
				obj.SetInteger(name, value);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, int>(L, 2))
			{
				Animator obj2 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				int id = (int)LuaDLL.lua_tonumber(L, 2);
				int value2 = (int)LuaDLL.lua_tonumber(L, 3);
				obj2.SetInteger(id, value2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animator.SetInteger");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetTrigger(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
				string trigger = ToLua.ToString(L, 2);
				obj.SetTrigger(trigger);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				Animator obj2 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				int trigger2 = (int)LuaDLL.lua_tonumber(L, 2);
				obj2.SetTrigger(trigger2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animator.SetTrigger");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetTrigger(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
				string name = ToLua.ToString(L, 2);
				obj.ResetTrigger(name);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				Animator obj2 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				int id = (int)LuaDLL.lua_tonumber(L, 2);
				obj2.ResetTrigger(id);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animator.ResetTrigger");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsParameterControlledByCurve(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
				string name = ToLua.ToString(L, 2);
				bool value = obj.IsParameterControlledByCurve(name);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				Animator obj2 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				int id = (int)LuaDLL.lua_tonumber(L, 2);
				bool value2 = obj2.IsParameterControlledByCurve(id);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animator.IsParameterControlledByCurve");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetIKPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			AvatarIKGoal goal = (AvatarIKGoal)ToLua.CheckObject(L, 2, typeof(AvatarIKGoal));
			Vector3 iKPosition = obj.GetIKPosition(goal);
			ToLua.Push(L, iKPosition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetIKPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			AvatarIKGoal goal = (AvatarIKGoal)ToLua.CheckObject(L, 2, typeof(AvatarIKGoal));
			Vector3 goalPosition = ToLua.ToVector3(L, 3);
			obj.SetIKPosition(goal, goalPosition);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetIKRotation(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			AvatarIKGoal goal = (AvatarIKGoal)ToLua.CheckObject(L, 2, typeof(AvatarIKGoal));
			Quaternion iKRotation = obj.GetIKRotation(goal);
			ToLua.Push(L, iKRotation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetIKRotation(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			AvatarIKGoal goal = (AvatarIKGoal)ToLua.CheckObject(L, 2, typeof(AvatarIKGoal));
			Quaternion goalRotation = ToLua.ToQuaternion(L, 3);
			obj.SetIKRotation(goal, goalRotation);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetIKPositionWeight(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			AvatarIKGoal goal = (AvatarIKGoal)ToLua.CheckObject(L, 2, typeof(AvatarIKGoal));
			float iKPositionWeight = obj.GetIKPositionWeight(goal);
			LuaDLL.lua_pushnumber(L, iKPositionWeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetIKPositionWeight(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			AvatarIKGoal goal = (AvatarIKGoal)ToLua.CheckObject(L, 2, typeof(AvatarIKGoal));
			float value = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.SetIKPositionWeight(goal, value);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetIKRotationWeight(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			AvatarIKGoal goal = (AvatarIKGoal)ToLua.CheckObject(L, 2, typeof(AvatarIKGoal));
			float iKRotationWeight = obj.GetIKRotationWeight(goal);
			LuaDLL.lua_pushnumber(L, iKRotationWeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetIKRotationWeight(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			AvatarIKGoal goal = (AvatarIKGoal)ToLua.CheckObject(L, 2, typeof(AvatarIKGoal));
			float value = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.SetIKRotationWeight(goal, value);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetIKHintPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			AvatarIKHint hint = (AvatarIKHint)ToLua.CheckObject(L, 2, typeof(AvatarIKHint));
			Vector3 iKHintPosition = obj.GetIKHintPosition(hint);
			ToLua.Push(L, iKHintPosition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetIKHintPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			AvatarIKHint hint = (AvatarIKHint)ToLua.CheckObject(L, 2, typeof(AvatarIKHint));
			Vector3 hintPosition = ToLua.ToVector3(L, 3);
			obj.SetIKHintPosition(hint, hintPosition);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetIKHintPositionWeight(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			AvatarIKHint hint = (AvatarIKHint)ToLua.CheckObject(L, 2, typeof(AvatarIKHint));
			float iKHintPositionWeight = obj.GetIKHintPositionWeight(hint);
			LuaDLL.lua_pushnumber(L, iKHintPositionWeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetIKHintPositionWeight(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			AvatarIKHint hint = (AvatarIKHint)ToLua.CheckObject(L, 2, typeof(AvatarIKHint));
			float value = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.SetIKHintPositionWeight(hint, value);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLookAtPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			Vector3 lookAtPosition = ToLua.ToVector3(L, 2);
			obj.SetLookAtPosition(lookAtPosition);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLookAtWeight(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Animator obj5 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				float lookAtWeight = (float)LuaDLL.luaL_checknumber(L, 2);
				obj5.SetLookAtWeight(lookAtWeight);
				return 0;
			}
			case 3:
			{
				Animator obj4 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				float weight4 = (float)LuaDLL.luaL_checknumber(L, 2);
				float bodyWeight4 = (float)LuaDLL.luaL_checknumber(L, 3);
				obj4.SetLookAtWeight(weight4, bodyWeight4);
				return 0;
			}
			case 4:
			{
				Animator obj3 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				float weight3 = (float)LuaDLL.luaL_checknumber(L, 2);
				float bodyWeight3 = (float)LuaDLL.luaL_checknumber(L, 3);
				float headWeight3 = (float)LuaDLL.luaL_checknumber(L, 4);
				obj3.SetLookAtWeight(weight3, bodyWeight3, headWeight3);
				return 0;
			}
			case 5:
			{
				Animator obj2 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				float weight2 = (float)LuaDLL.luaL_checknumber(L, 2);
				float bodyWeight2 = (float)LuaDLL.luaL_checknumber(L, 3);
				float headWeight2 = (float)LuaDLL.luaL_checknumber(L, 4);
				float eyesWeight2 = (float)LuaDLL.luaL_checknumber(L, 5);
				obj2.SetLookAtWeight(weight2, bodyWeight2, headWeight2, eyesWeight2);
				return 0;
			}
			case 6:
			{
				Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
				float weight = (float)LuaDLL.luaL_checknumber(L, 2);
				float bodyWeight = (float)LuaDLL.luaL_checknumber(L, 3);
				float headWeight = (float)LuaDLL.luaL_checknumber(L, 4);
				float eyesWeight = (float)LuaDLL.luaL_checknumber(L, 5);
				float clampWeight = (float)LuaDLL.luaL_checknumber(L, 6);
				obj.SetLookAtWeight(weight, bodyWeight, headWeight, eyesWeight, clampWeight);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animator.SetLookAtWeight");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetBoneLocalRotation(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			HumanBodyBones humanBoneId = (HumanBodyBones)ToLua.CheckObject(L, 2, typeof(HumanBodyBones));
			Quaternion rotation = ToLua.ToQuaternion(L, 3);
			obj.SetBoneLocalRotation(humanBoneId, rotation);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetBehaviours(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			int fullPathHash = (int)LuaDLL.luaL_checknumber(L, 2);
			int layerIndex = (int)LuaDLL.luaL_checknumber(L, 3);
			StateMachineBehaviour[] behaviours = obj.GetBehaviours(fullPathHash, layerIndex);
			ToLua.Push(L, behaviours);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLayerName(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			int layerIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			string layerName = obj.GetLayerName(layerIndex);
			LuaDLL.lua_pushstring(L, layerName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLayerIndex(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			string layerName = ToLua.CheckString(L, 2);
			int layerIndex = obj.GetLayerIndex(layerName);
			LuaDLL.lua_pushinteger(L, layerIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLayerWeight(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			int layerIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			float layerWeight = obj.GetLayerWeight(layerIndex);
			LuaDLL.lua_pushnumber(L, layerWeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLayerWeight(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			int layerIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			float weight = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.SetLayerWeight(layerIndex, weight);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCurrentAnimatorStateInfo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			int layerIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			AnimatorStateInfo currentAnimatorStateInfo = obj.GetCurrentAnimatorStateInfo(layerIndex);
			ToLua.PushValue(L, currentAnimatorStateInfo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetNextAnimatorStateInfo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			int layerIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			AnimatorStateInfo nextAnimatorStateInfo = obj.GetNextAnimatorStateInfo(layerIndex);
			ToLua.PushValue(L, nextAnimatorStateInfo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAnimatorTransitionInfo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			int layerIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			AnimatorTransitionInfo animatorTransitionInfo = obj.GetAnimatorTransitionInfo(layerIndex);
			ToLua.PushValue(L, animatorTransitionInfo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCurrentAnimatorClipInfoCount(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			int layerIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			int currentAnimatorClipInfoCount = obj.GetCurrentAnimatorClipInfoCount(layerIndex);
			LuaDLL.lua_pushinteger(L, currentAnimatorClipInfoCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetNextAnimatorClipInfoCount(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			int layerIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			int nextAnimatorClipInfoCount = obj.GetNextAnimatorClipInfoCount(layerIndex);
			LuaDLL.lua_pushinteger(L, nextAnimatorClipInfoCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCurrentAnimatorClipInfo(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Animator obj2 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				int layerIndex2 = (int)LuaDLL.luaL_checknumber(L, 2);
				AnimatorClipInfo[] currentAnimatorClipInfo = obj2.GetCurrentAnimatorClipInfo(layerIndex2);
				ToLua.Push(L, currentAnimatorClipInfo);
				return 1;
			}
			case 3:
			{
				Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
				int layerIndex = (int)LuaDLL.luaL_checknumber(L, 2);
				List<AnimatorClipInfo> clips = (List<AnimatorClipInfo>)ToLua.CheckObject(L, 3, typeof(List<AnimatorClipInfo>));
				obj.GetCurrentAnimatorClipInfo(layerIndex, clips);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animator.GetCurrentAnimatorClipInfo");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetNextAnimatorClipInfo(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Animator obj2 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				int layerIndex2 = (int)LuaDLL.luaL_checknumber(L, 2);
				AnimatorClipInfo[] nextAnimatorClipInfo = obj2.GetNextAnimatorClipInfo(layerIndex2);
				ToLua.Push(L, nextAnimatorClipInfo);
				return 1;
			}
			case 3:
			{
				Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
				int layerIndex = (int)LuaDLL.luaL_checknumber(L, 2);
				List<AnimatorClipInfo> clips = (List<AnimatorClipInfo>)ToLua.CheckObject(L, 3, typeof(List<AnimatorClipInfo>));
				obj.GetNextAnimatorClipInfo(layerIndex, clips);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animator.GetNextAnimatorClipInfo");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsInTransition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			int layerIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			bool value = obj.IsInTransition(layerIndex);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetParameter(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			AnimatorControllerParameter parameter = obj.GetParameter(index);
			ToLua.PushObject(L, parameter);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MatchTarget(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 6:
			{
				Animator obj3 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				Vector3 matchPosition3 = ToLua.ToVector3(L, 2);
				Quaternion matchRotation3 = ToLua.ToQuaternion(L, 3);
				AvatarTarget targetBodyPart3 = (AvatarTarget)ToLua.CheckObject(L, 4, typeof(AvatarTarget));
				MatchTargetWeightMask weightMask3 = StackTraits<MatchTargetWeightMask>.Check(L, 5);
				float startNormalizedTime3 = (float)LuaDLL.luaL_checknumber(L, 6);
				obj3.MatchTarget(matchPosition3, matchRotation3, targetBodyPart3, weightMask3, startNormalizedTime3);
				return 0;
			}
			case 7:
			{
				Animator obj2 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				Vector3 matchPosition2 = ToLua.ToVector3(L, 2);
				Quaternion matchRotation2 = ToLua.ToQuaternion(L, 3);
				AvatarTarget targetBodyPart2 = (AvatarTarget)ToLua.CheckObject(L, 4, typeof(AvatarTarget));
				MatchTargetWeightMask weightMask2 = StackTraits<MatchTargetWeightMask>.Check(L, 5);
				float startNormalizedTime2 = (float)LuaDLL.luaL_checknumber(L, 6);
				float targetNormalizedTime2 = (float)LuaDLL.luaL_checknumber(L, 7);
				obj2.MatchTarget(matchPosition2, matchRotation2, targetBodyPart2, weightMask2, startNormalizedTime2, targetNormalizedTime2);
				return 0;
			}
			case 8:
			{
				Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
				Vector3 matchPosition = ToLua.ToVector3(L, 2);
				Quaternion matchRotation = ToLua.ToQuaternion(L, 3);
				AvatarTarget targetBodyPart = (AvatarTarget)ToLua.CheckObject(L, 4, typeof(AvatarTarget));
				MatchTargetWeightMask weightMask = StackTraits<MatchTargetWeightMask>.Check(L, 5);
				float startNormalizedTime = (float)LuaDLL.luaL_checknumber(L, 6);
				float targetNormalizedTime = (float)LuaDLL.luaL_checknumber(L, 7);
				bool completeMatch = LuaDLL.luaL_checkboolean(L, 8);
				obj.MatchTarget(matchPosition, matchRotation, targetBodyPart, weightMask, startNormalizedTime, targetNormalizedTime, completeMatch);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animator.MatchTarget");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InterruptMatchTarget(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((Animator)ToLua.CheckObject<Animator>(L, 1)).InterruptMatchTarget();
				return 0;
			case 2:
			{
				Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
				bool completeMatch = LuaDLL.luaL_checkboolean(L, 2);
				obj.InterruptMatchTarget(completeMatch);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animator.InterruptMatchTarget");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CrossFadeInFixedTime(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<string, float>(L, 2))
			{
				Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
				string stateName = ToLua.ToString(L, 2);
				float fixedTransitionDuration = (float)LuaDLL.lua_tonumber(L, 3);
				obj.CrossFadeInFixedTime(stateName, fixedTransitionDuration);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, float>(L, 2))
			{
				Animator obj2 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				int stateHashName = (int)LuaDLL.lua_tonumber(L, 2);
				float fixedTransitionDuration2 = (float)LuaDLL.lua_tonumber(L, 3);
				obj2.CrossFadeInFixedTime(stateHashName, fixedTransitionDuration2);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<string, float, int>(L, 2))
			{
				Animator obj3 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				string stateName2 = ToLua.ToString(L, 2);
				float fixedTransitionDuration3 = (float)LuaDLL.lua_tonumber(L, 3);
				int layer = (int)LuaDLL.lua_tonumber(L, 4);
				obj3.CrossFadeInFixedTime(stateName2, fixedTransitionDuration3, layer);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<int, float, int>(L, 2))
			{
				Animator obj4 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				int stateHashName2 = (int)LuaDLL.lua_tonumber(L, 2);
				float fixedTransitionDuration4 = (float)LuaDLL.lua_tonumber(L, 3);
				int layer2 = (int)LuaDLL.lua_tonumber(L, 4);
				obj4.CrossFadeInFixedTime(stateHashName2, fixedTransitionDuration4, layer2);
				return 0;
			}
			if (num == 5 && TypeChecker.CheckTypes<string, float, int, float>(L, 2))
			{
				Animator obj5 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				string stateName3 = ToLua.ToString(L, 2);
				float fixedTransitionDuration5 = (float)LuaDLL.lua_tonumber(L, 3);
				int layer3 = (int)LuaDLL.lua_tonumber(L, 4);
				float fixedTimeOffset = (float)LuaDLL.lua_tonumber(L, 5);
				obj5.CrossFadeInFixedTime(stateName3, fixedTransitionDuration5, layer3, fixedTimeOffset);
				return 0;
			}
			if (num == 5 && TypeChecker.CheckTypes<int, float, int, float>(L, 2))
			{
				Animator obj6 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				int stateHashName3 = (int)LuaDLL.lua_tonumber(L, 2);
				float fixedTransitionDuration6 = (float)LuaDLL.lua_tonumber(L, 3);
				int layer4 = (int)LuaDLL.lua_tonumber(L, 4);
				float fixedTimeOffset2 = (float)LuaDLL.lua_tonumber(L, 5);
				obj6.CrossFadeInFixedTime(stateHashName3, fixedTransitionDuration6, layer4, fixedTimeOffset2);
				return 0;
			}
			if (num == 6 && TypeChecker.CheckTypes<string, float, int, float, float>(L, 2))
			{
				Animator obj7 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				string stateName4 = ToLua.ToString(L, 2);
				float fixedTransitionDuration7 = (float)LuaDLL.lua_tonumber(L, 3);
				int layer5 = (int)LuaDLL.lua_tonumber(L, 4);
				float fixedTimeOffset3 = (float)LuaDLL.lua_tonumber(L, 5);
				float normalizedTransitionTime = (float)LuaDLL.lua_tonumber(L, 6);
				obj7.CrossFadeInFixedTime(stateName4, fixedTransitionDuration7, layer5, fixedTimeOffset3, normalizedTransitionTime);
				return 0;
			}
			if (num == 6 && TypeChecker.CheckTypes<int, float, int, float, float>(L, 2))
			{
				Animator obj8 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				int stateHashName4 = (int)LuaDLL.lua_tonumber(L, 2);
				float fixedTransitionDuration8 = (float)LuaDLL.lua_tonumber(L, 3);
				int layer6 = (int)LuaDLL.lua_tonumber(L, 4);
				float fixedTimeOffset4 = (float)LuaDLL.lua_tonumber(L, 5);
				float normalizedTransitionTime2 = (float)LuaDLL.lua_tonumber(L, 6);
				obj8.CrossFadeInFixedTime(stateHashName4, fixedTransitionDuration8, layer6, fixedTimeOffset4, normalizedTransitionTime2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animator.CrossFadeInFixedTime");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WriteDefaultValues(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Animator)ToLua.CheckObject<Animator>(L, 1)).WriteDefaultValues();
			return 0;
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
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<string, float>(L, 2))
			{
				Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
				string stateName = ToLua.ToString(L, 2);
				float normalizedTransitionDuration = (float)LuaDLL.lua_tonumber(L, 3);
				obj.CrossFade(stateName, normalizedTransitionDuration);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, float>(L, 2))
			{
				Animator obj2 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				int stateHashName = (int)LuaDLL.lua_tonumber(L, 2);
				float normalizedTransitionDuration2 = (float)LuaDLL.lua_tonumber(L, 3);
				obj2.CrossFade(stateHashName, normalizedTransitionDuration2);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<string, float, int>(L, 2))
			{
				Animator obj3 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				string stateName2 = ToLua.ToString(L, 2);
				float normalizedTransitionDuration3 = (float)LuaDLL.lua_tonumber(L, 3);
				int layer = (int)LuaDLL.lua_tonumber(L, 4);
				obj3.CrossFade(stateName2, normalizedTransitionDuration3, layer);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<int, float, int>(L, 2))
			{
				Animator obj4 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				int stateHashName2 = (int)LuaDLL.lua_tonumber(L, 2);
				float normalizedTransitionDuration4 = (float)LuaDLL.lua_tonumber(L, 3);
				int layer2 = (int)LuaDLL.lua_tonumber(L, 4);
				obj4.CrossFade(stateHashName2, normalizedTransitionDuration4, layer2);
				return 0;
			}
			if (num == 5 && TypeChecker.CheckTypes<string, float, int, float>(L, 2))
			{
				Animator obj5 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				string stateName3 = ToLua.ToString(L, 2);
				float normalizedTransitionDuration5 = (float)LuaDLL.lua_tonumber(L, 3);
				int layer3 = (int)LuaDLL.lua_tonumber(L, 4);
				float normalizedTimeOffset = (float)LuaDLL.lua_tonumber(L, 5);
				obj5.CrossFade(stateName3, normalizedTransitionDuration5, layer3, normalizedTimeOffset);
				return 0;
			}
			if (num == 5 && TypeChecker.CheckTypes<int, float, int, float>(L, 2))
			{
				Animator obj6 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				int stateHashName3 = (int)LuaDLL.lua_tonumber(L, 2);
				float normalizedTransitionDuration6 = (float)LuaDLL.lua_tonumber(L, 3);
				int layer4 = (int)LuaDLL.lua_tonumber(L, 4);
				float normalizedTimeOffset2 = (float)LuaDLL.lua_tonumber(L, 5);
				obj6.CrossFade(stateHashName3, normalizedTransitionDuration6, layer4, normalizedTimeOffset2);
				return 0;
			}
			if (num == 6 && TypeChecker.CheckTypes<string, float, int, float, float>(L, 2))
			{
				Animator obj7 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				string stateName4 = ToLua.ToString(L, 2);
				float normalizedTransitionDuration7 = (float)LuaDLL.lua_tonumber(L, 3);
				int layer5 = (int)LuaDLL.lua_tonumber(L, 4);
				float normalizedTimeOffset3 = (float)LuaDLL.lua_tonumber(L, 5);
				float normalizedTransitionTime = (float)LuaDLL.lua_tonumber(L, 6);
				obj7.CrossFade(stateName4, normalizedTransitionDuration7, layer5, normalizedTimeOffset3, normalizedTransitionTime);
				return 0;
			}
			if (num == 6 && TypeChecker.CheckTypes<int, float, int, float, float>(L, 2))
			{
				Animator obj8 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				int stateHashName4 = (int)LuaDLL.lua_tonumber(L, 2);
				float normalizedTransitionDuration8 = (float)LuaDLL.lua_tonumber(L, 3);
				int layer6 = (int)LuaDLL.lua_tonumber(L, 4);
				float normalizedTimeOffset4 = (float)LuaDLL.lua_tonumber(L, 5);
				float normalizedTransitionTime2 = (float)LuaDLL.lua_tonumber(L, 6);
				obj8.CrossFade(stateHashName4, normalizedTransitionDuration8, layer6, normalizedTimeOffset4, normalizedTransitionTime2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animator.CrossFade");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayInFixedTime(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
				string stateName = ToLua.ToString(L, 2);
				obj.PlayInFixedTime(stateName);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				Animator obj2 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				int stateNameHash = (int)LuaDLL.lua_tonumber(L, 2);
				obj2.PlayInFixedTime(stateNameHash);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, int>(L, 2))
			{
				Animator obj3 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				string stateName2 = ToLua.ToString(L, 2);
				int layer = (int)LuaDLL.lua_tonumber(L, 3);
				obj3.PlayInFixedTime(stateName2, layer);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, int>(L, 2))
			{
				Animator obj4 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				int stateNameHash2 = (int)LuaDLL.lua_tonumber(L, 2);
				int layer2 = (int)LuaDLL.lua_tonumber(L, 3);
				obj4.PlayInFixedTime(stateNameHash2, layer2);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<string, int, float>(L, 2))
			{
				Animator obj5 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				string stateName3 = ToLua.ToString(L, 2);
				int layer3 = (int)LuaDLL.lua_tonumber(L, 3);
				float fixedTime = (float)LuaDLL.lua_tonumber(L, 4);
				obj5.PlayInFixedTime(stateName3, layer3, fixedTime);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<int, int, float>(L, 2))
			{
				Animator obj6 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				int stateNameHash3 = (int)LuaDLL.lua_tonumber(L, 2);
				int layer4 = (int)LuaDLL.lua_tonumber(L, 3);
				float fixedTime2 = (float)LuaDLL.lua_tonumber(L, 4);
				obj6.PlayInFixedTime(stateNameHash3, layer4, fixedTime2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animator.PlayInFixedTime");
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
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
				string stateName = ToLua.ToString(L, 2);
				obj.Play(stateName);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				Animator obj2 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				int stateNameHash = (int)LuaDLL.lua_tonumber(L, 2);
				obj2.Play(stateNameHash);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, int>(L, 2))
			{
				Animator obj3 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				string stateName2 = ToLua.ToString(L, 2);
				int layer = (int)LuaDLL.lua_tonumber(L, 3);
				obj3.Play(stateName2, layer);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, int>(L, 2))
			{
				Animator obj4 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				int stateNameHash2 = (int)LuaDLL.lua_tonumber(L, 2);
				int layer2 = (int)LuaDLL.lua_tonumber(L, 3);
				obj4.Play(stateNameHash2, layer2);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<string, int, float>(L, 2))
			{
				Animator obj5 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				string stateName3 = ToLua.ToString(L, 2);
				int layer3 = (int)LuaDLL.lua_tonumber(L, 3);
				float normalizedTime = (float)LuaDLL.lua_tonumber(L, 4);
				obj5.Play(stateName3, layer3, normalizedTime);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<int, int, float>(L, 2))
			{
				Animator obj6 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				int stateNameHash3 = (int)LuaDLL.lua_tonumber(L, 2);
				int layer4 = (int)LuaDLL.lua_tonumber(L, 3);
				float normalizedTime2 = (float)LuaDLL.lua_tonumber(L, 4);
				obj6.Play(stateNameHash3, layer4, normalizedTime2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animator.Play");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetTarget(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			AvatarTarget targetIndex = (AvatarTarget)ToLua.CheckObject(L, 2, typeof(AvatarTarget));
			float targetNormalizedTime = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.SetTarget(targetIndex, targetNormalizedTime);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetBoneTransform(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			HumanBodyBones humanBoneId = (HumanBodyBones)ToLua.CheckObject(L, 2, typeof(HumanBodyBones));
			Transform boneTransform = obj.GetBoneTransform(humanBoneId);
			ToLua.Push(L, boneTransform);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartPlayback(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Animator)ToLua.CheckObject<Animator>(L, 1)).StartPlayback();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopPlayback(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Animator)ToLua.CheckObject<Animator>(L, 1)).StopPlayback();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartRecording(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			int frameCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.StartRecording(frameCount);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopRecording(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Animator)ToLua.CheckObject<Animator>(L, 1)).StopRecording();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HasState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			int layerIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			int stateID = (int)LuaDLL.luaL_checknumber(L, 3);
			bool value = obj.HasState(layerIndex, stateID);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StringToHash(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int n = Animator.StringToHash(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushinteger(L, n);
			return 1;
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
			ToLua.CheckArgsCount(L, 2);
			Animator obj = (Animator)ToLua.CheckObject<Animator>(L, 1);
			float deltaTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.Update(deltaTime);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Rebind(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Animator)ToLua.CheckObject<Animator>(L, 1)).Rebind();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ApplyBuiltinRootMotion(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Animator)ToLua.CheckObject<Animator>(L, 1)).ApplyBuiltinRootMotion();
			return 0;
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			float horizontalOrVerticalLayoutGroupSpacing = ((Animator)ToLua.CheckObject<Animator>(L, 1)).GetHorizontalOrVerticalLayoutGroupSpacing();
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
			int layoutGroupPaddingTop = ((Animator)ToLua.CheckObject<Animator>(L, 1)).GetLayoutGroupPaddingTop();
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
	private static int GetClipLength(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Animator animator = (Animator)ToLua.CheckObject<Animator>(L, 1);
			int layIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			string clipName = ToLua.CheckString(L, 3);
			float clipLength = animator.GetClipLength(layIndex, clipName);
			LuaDLL.lua_pushnumber(L, clipLength);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnCheckPlayingState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Animator animator = (Animator)ToLua.CheckObject<Animator>(L, 1);
			int layIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			string playingStateName = ToLua.CheckString(L, 3);
			bool value = animator.OnCheckPlayingState(layIndex, playingStateName);
			LuaDLL.lua_pushboolean(L, value);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			((Animator)ToLua.CheckObject<Animator>(L, 1)).GetRectSize(out var width, out var height);
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
			((Animator)ToLua.CheckObject<Animator>(L, 1)).GetRectHeight(out var height);
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
			float rectWidth = ((Animator)ToLua.CheckObject<Animator>(L, 1)).GetRectWidth();
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			((Animator)ToLua.CheckObject<Animator>(L, 1)).GetAnchoredPositionY(out var y);
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
			((Animator)ToLua.CheckObject<Animator>(L, 1)).GetAnchoredPositionX(out var x);
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
			((Animator)ToLua.CheckObject<Animator>(L, 1)).GetAnchoredPosition(out var x, out var y);
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
			((Animator)ToLua.CheckObject<Animator>(L, 1)).GetSizeDeltaY(out var y);
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
			((Animator)ToLua.CheckObject<Animator>(L, 1)).GetSizeDeltaX(out var x);
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
			((Animator)ToLua.CheckObject<Animator>(L, 1)).GetSizeDeltaEx(out var x, out var y);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
				Animator cmpt2 = (Animator)ToLua.CheckObject<Animator>(L, 1);
				float y2 = (float)LuaDLL.luaL_checknumber(L, 2);
				cmpt2.RotateAxisY(y2);
				return 0;
			}
			case 3:
			{
				Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
				float y = (float)LuaDLL.luaL_checknumber(L, 2);
				Space relativeTo = (Space)ToLua.CheckObject(L, 3, typeof(Space));
				cmpt.RotateAxisY(y, relativeTo);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Animator.RotateAxisY");
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
			float localEulerAngleZ = ((Animator)ToLua.CheckObject<Animator>(L, 1)).GetLocalEulerAngleZ();
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
			float localEulerAngleY = ((Animator)ToLua.CheckObject<Animator>(L, 1)).GetLocalEulerAngleY();
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
			float localEulerAngleX = ((Animator)ToLua.CheckObject<Animator>(L, 1)).GetLocalEulerAngleX();
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
			float eulerAngleY = ((Animator)ToLua.CheckObject<Animator>(L, 1)).GetEulerAngleY();
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
			Vector3 eulerAngle = ((Animator)ToLua.CheckObject<Animator>(L, 1)).GetEulerAngle();
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
			((Animator)ToLua.CheckObject<Animator>(L, 1)).GetLocalEulerAngle(out var x, out var y, out var z);
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
			Vector3 localEulerAngleOrigin = ((Animator)ToLua.CheckObject<Animator>(L, 1)).GetLocalEulerAngleOrigin();
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			((Animator)ToLua.CheckObject<Animator>(L, 1)).SetLocalRotationOne();
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
			float localScaleX = ((Animator)ToLua.CheckObject<Animator>(L, 1)).GetLocalScaleX();
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
			((Animator)ToLua.CheckObject<Animator>(L, 1)).GetLocalScaleEx(out var x, out var y, out var z);
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
			Vector3 localScale = ((Animator)ToLua.CheckObject<Animator>(L, 1)).GetLocalScale();
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			((Animator)ToLua.CheckObject<Animator>(L, 1)).SetLocalScaleOne();
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
			((Animator)ToLua.CheckObject<Animator>(L, 1)).SetLocalScaleZero();
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
			((Animator)ToLua.CheckObject<Animator>(L, 1)).GetPositionEx(out var x, out var y, out var z);
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
			float positionY = ((Animator)ToLua.CheckObject<Animator>(L, 1)).GetPositionY();
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
			float positionX = ((Animator)ToLua.CheckObject<Animator>(L, 1)).GetPositionX();
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
			Vector3 position = ((Animator)ToLua.CheckObject<Animator>(L, 1)).GetPosition();
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			((Animator)ToLua.CheckObject<Animator>(L, 1)).SetPostionZero();
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
			float localPositionY = ((Animator)ToLua.CheckObject<Animator>(L, 1)).GetLocalPositionY();
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
			float localPositionX = ((Animator)ToLua.CheckObject<Animator>(L, 1)).GetLocalPositionX();
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
			((Animator)ToLua.CheckObject<Animator>(L, 1)).GetLocalPositionEx(out var x, out var y, out var z);
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
			Vector3 localPosition = ((Animator)ToLua.CheckObject<Animator>(L, 1)).GetLocalPosition();
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			((Animator)ToLua.CheckObject<Animator>(L, 1)).SetLocalPositionZero();
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			Animator cmpt = (Animator)ToLua.CheckObject<Animator>(L, 1);
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
			((Animator)ToLua.CheckObject<Animator>(L, 1)).InitTransform();
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
	private static int get_isOptimizable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isOptimizable = ((Animator)obj).isOptimizable;
			LuaDLL.lua_pushboolean(L, isOptimizable);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isOptimizable on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isHuman(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isHuman = ((Animator)obj).isHuman;
			LuaDLL.lua_pushboolean(L, isHuman);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isHuman on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hasRootMotion(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool hasRootMotion = ((Animator)obj).hasRootMotion;
			LuaDLL.lua_pushboolean(L, hasRootMotion);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hasRootMotion on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_humanScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float humanScale = ((Animator)obj).humanScale;
			LuaDLL.lua_pushnumber(L, humanScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index humanScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isInitialized(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isInitialized = ((Animator)obj).isInitialized;
			LuaDLL.lua_pushboolean(L, isInitialized);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isInitialized on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_deltaPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 deltaPosition = ((Animator)obj).deltaPosition;
			ToLua.Push(L, deltaPosition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index deltaPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_deltaRotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Quaternion deltaRotation = ((Animator)obj).deltaRotation;
			ToLua.Push(L, deltaRotation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index deltaRotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_velocity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 velocity = ((Animator)obj).velocity;
			ToLua.Push(L, velocity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index velocity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_angularVelocity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 angularVelocity = ((Animator)obj).angularVelocity;
			ToLua.Push(L, angularVelocity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index angularVelocity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rootPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 rootPosition = ((Animator)obj).rootPosition;
			ToLua.Push(L, rootPosition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rootPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rootRotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Quaternion rootRotation = ((Animator)obj).rootRotation;
			ToLua.Push(L, rootRotation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rootRotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_applyRootMotion(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool applyRootMotion = ((Animator)obj).applyRootMotion;
			LuaDLL.lua_pushboolean(L, applyRootMotion);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index applyRootMotion on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_updateMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimatorUpdateMode updateMode = ((Animator)obj).updateMode;
			ToLua.Push(L, updateMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index updateMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hasTransformHierarchy(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool hasTransformHierarchy = ((Animator)obj).hasTransformHierarchy;
			LuaDLL.lua_pushboolean(L, hasTransformHierarchy);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hasTransformHierarchy on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_gravityWeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float gravityWeight = ((Animator)obj).gravityWeight;
			LuaDLL.lua_pushnumber(L, gravityWeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gravityWeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bodyPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 bodyPosition = ((Animator)obj).bodyPosition;
			ToLua.Push(L, bodyPosition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bodyPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bodyRotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Quaternion bodyRotation = ((Animator)obj).bodyRotation;
			ToLua.Push(L, bodyRotation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bodyRotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stabilizeFeet(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool stabilizeFeet = ((Animator)obj).stabilizeFeet;
			LuaDLL.lua_pushboolean(L, stabilizeFeet);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stabilizeFeet on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_layerCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int layerCount = ((Animator)obj).layerCount;
			LuaDLL.lua_pushinteger(L, layerCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index layerCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_parameters(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimatorControllerParameter[] parameters = ((Animator)obj).parameters;
			ToLua.Push(L, parameters);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index parameters on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_parameterCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int parameterCount = ((Animator)obj).parameterCount;
			LuaDLL.lua_pushinteger(L, parameterCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index parameterCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_feetPivotActive(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float feetPivotActive = ((Animator)obj).feetPivotActive;
			LuaDLL.lua_pushnumber(L, feetPivotActive);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index feetPivotActive on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pivotWeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float pivotWeight = ((Animator)obj).pivotWeight;
			LuaDLL.lua_pushnumber(L, pivotWeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pivotWeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pivotPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 pivotPosition = ((Animator)obj).pivotPosition;
			ToLua.Push(L, pivotPosition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pivotPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isMatchingTarget(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isMatchingTarget = ((Animator)obj).isMatchingTarget;
			LuaDLL.lua_pushboolean(L, isMatchingTarget);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isMatchingTarget on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_speed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float speed = ((Animator)obj).speed;
			LuaDLL.lua_pushnumber(L, speed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index speed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_targetPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 targetPosition = ((Animator)obj).targetPosition;
			ToLua.Push(L, targetPosition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_targetRotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Quaternion targetRotation = ((Animator)obj).targetRotation;
			ToLua.Push(L, targetRotation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetRotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cullingMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimatorCullingMode cullingMode = ((Animator)obj).cullingMode;
			ToLua.Push(L, cullingMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cullingMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_playbackTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float playbackTime = ((Animator)obj).playbackTime;
			LuaDLL.lua_pushnumber(L, playbackTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playbackTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_recorderStartTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float recorderStartTime = ((Animator)obj).recorderStartTime;
			LuaDLL.lua_pushnumber(L, recorderStartTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index recorderStartTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_recorderStopTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float recorderStopTime = ((Animator)obj).recorderStopTime;
			LuaDLL.lua_pushnumber(L, recorderStopTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index recorderStopTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_recorderMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimatorRecorderMode recorderMode = ((Animator)obj).recorderMode;
			ToLua.Push(L, recorderMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index recorderMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_runtimeAnimatorController(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RuntimeAnimatorController runtimeAnimatorController = ((Animator)obj).runtimeAnimatorController;
			ToLua.Push(L, runtimeAnimatorController);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index runtimeAnimatorController on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hasBoundPlayables(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool hasBoundPlayables = ((Animator)obj).hasBoundPlayables;
			LuaDLL.lua_pushboolean(L, hasBoundPlayables);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hasBoundPlayables on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_avatar(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Avatar avatar = ((Animator)obj).avatar;
			ToLua.Push(L, avatar);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index avatar on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_playableGraph(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PlayableGraph playableGraph = ((Animator)obj).playableGraph;
			ToLua.PushValue(L, playableGraph);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playableGraph on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_layersAffectMassCenter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool layersAffectMassCenter = ((Animator)obj).layersAffectMassCenter;
			LuaDLL.lua_pushboolean(L, layersAffectMassCenter);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index layersAffectMassCenter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_leftFeetBottomHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float leftFeetBottomHeight = ((Animator)obj).leftFeetBottomHeight;
			LuaDLL.lua_pushnumber(L, leftFeetBottomHeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index leftFeetBottomHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rightFeetBottomHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float rightFeetBottomHeight = ((Animator)obj).rightFeetBottomHeight;
			LuaDLL.lua_pushnumber(L, rightFeetBottomHeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rightFeetBottomHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_logWarnings(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool logWarnings = ((Animator)obj).logWarnings;
			LuaDLL.lua_pushboolean(L, logWarnings);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index logWarnings on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fireEvents(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool fireEvents = ((Animator)obj).fireEvents;
			LuaDLL.lua_pushboolean(L, fireEvents);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fireEvents on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_keepAnimatorControllerStateOnDisable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			_ = (Animator)obj;
			bool value = false;
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index keepAnimatorControllerStateOnDisable on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rootPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animator obj2 = (Animator)obj;
			Vector3 rootPosition = ToLua.ToVector3(L, 2);
			obj2.rootPosition = rootPosition;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rootPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rootRotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animator obj2 = (Animator)obj;
			Quaternion rootRotation = ToLua.ToQuaternion(L, 2);
			obj2.rootRotation = rootRotation;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rootRotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_applyRootMotion(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animator obj2 = (Animator)obj;
			bool applyRootMotion = LuaDLL.luaL_checkboolean(L, 2);
			obj2.applyRootMotion = applyRootMotion;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index applyRootMotion on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_updateMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animator obj2 = (Animator)obj;
			AnimatorUpdateMode updateMode = (AnimatorUpdateMode)ToLua.CheckObject(L, 2, typeof(AnimatorUpdateMode));
			obj2.updateMode = updateMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index updateMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bodyPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animator obj2 = (Animator)obj;
			Vector3 bodyPosition = ToLua.ToVector3(L, 2);
			obj2.bodyPosition = bodyPosition;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bodyPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bodyRotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animator obj2 = (Animator)obj;
			Quaternion bodyRotation = ToLua.ToQuaternion(L, 2);
			obj2.bodyRotation = bodyRotation;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bodyRotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_stabilizeFeet(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animator obj2 = (Animator)obj;
			bool stabilizeFeet = LuaDLL.luaL_checkboolean(L, 2);
			obj2.stabilizeFeet = stabilizeFeet;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stabilizeFeet on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_feetPivotActive(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animator obj2 = (Animator)obj;
			float feetPivotActive = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.feetPivotActive = feetPivotActive;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index feetPivotActive on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_speed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animator obj2 = (Animator)obj;
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
	private static int set_cullingMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animator obj2 = (Animator)obj;
			AnimatorCullingMode cullingMode = (AnimatorCullingMode)ToLua.CheckObject(L, 2, typeof(AnimatorCullingMode));
			obj2.cullingMode = cullingMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cullingMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_playbackTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animator obj2 = (Animator)obj;
			float playbackTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.playbackTime = playbackTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playbackTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_recorderStartTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animator obj2 = (Animator)obj;
			float recorderStartTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.recorderStartTime = recorderStartTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index recorderStartTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_recorderStopTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animator obj2 = (Animator)obj;
			float recorderStopTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.recorderStopTime = recorderStopTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index recorderStopTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_runtimeAnimatorController(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animator obj2 = (Animator)obj;
			RuntimeAnimatorController runtimeAnimatorController = (RuntimeAnimatorController)ToLua.CheckObject<RuntimeAnimatorController>(L, 2);
			obj2.runtimeAnimatorController = runtimeAnimatorController;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index runtimeAnimatorController on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_avatar(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animator obj2 = (Animator)obj;
			Avatar avatar = (Avatar)ToLua.CheckObject<Avatar>(L, 2);
			obj2.avatar = avatar;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index avatar on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_layersAffectMassCenter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animator obj2 = (Animator)obj;
			bool layersAffectMassCenter = LuaDLL.luaL_checkboolean(L, 2);
			obj2.layersAffectMassCenter = layersAffectMassCenter;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index layersAffectMassCenter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_logWarnings(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animator obj2 = (Animator)obj;
			bool logWarnings = LuaDLL.luaL_checkboolean(L, 2);
			obj2.logWarnings = logWarnings;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index logWarnings on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fireEvents(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animator obj2 = (Animator)obj;
			bool fireEvents = LuaDLL.luaL_checkboolean(L, 2);
			obj2.fireEvents = fireEvents;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fireEvents on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_keepAnimatorControllerStateOnDisable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			_ = (Animator)obj;
			LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index keepAnimatorControllerStateOnDisable on a nil value");
		}
	}
}
