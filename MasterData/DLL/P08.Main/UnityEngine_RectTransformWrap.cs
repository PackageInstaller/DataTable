using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.UI;

public class UnityEngine_RectTransformWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(RectTransform), typeof(Transform));
		L.RegFunction("ForceUpdateRectTransforms", ForceUpdateRectTransforms);
		L.RegFunction("GetLocalCorners", GetLocalCorners);
		L.RegFunction("GetWorldCorners", GetWorldCorners);
		L.RegFunction("SetInsetAndSizeFromParentEdge", SetInsetAndSizeFromParentEdge);
		L.RegFunction("SetSizeWithCurrentAnchors", SetSizeWithCurrentAnchors);
		L.RegFunction("ShowHideByScale", ShowHideByScale);
		L.RegFunction("SetHorizontalOrVerticalLayoutGroupSpacing", SetHorizontalOrVerticalLayoutGroupSpacing);
		L.RegFunction("GetHorizontalOrVerticalLayoutGroupSpacing", GetHorizontalOrVerticalLayoutGroupSpacing);
		L.RegFunction("GetLayoutGroupPaddingTop", GetLayoutGroupPaddingTop);
		L.RegFunction("GetChildMeshRender", GetChildMeshRender);
		L.RegFunction("RevertMaterials", RevertMaterials);
		L.RegFunction("ChangeMaterials", ChangeMaterials);
		L.RegFunction("GetChildMaterials", GetChildMaterials);
		L.RegFunction("ChangeMaterial", ChangeMaterial);
		L.RegFunction("SetShadowsColor", SetShadowsColor);
		L.RegFunction("RotateHorizontalToDirectionXZ", RotateHorizontalToDirectionXZ);
		L.RegFunction("SetTargetAngle", SetTargetAngle);
		L.RegFunction("GetRightXYZ", GetRightXYZ);
		L.RegFunction("SetUpXYZ", SetUpXYZ);
		L.RegFunction("GetUpXYZ", GetUpXYZ);
		L.RegFunction("SetForward", SetForward);
		L.RegFunction("GetForwardXYZ", GetForwardXYZ);
		L.RegFunction("SetTargetDirection", SetTargetDirection);
		L.RegFunction("AngleYLocalToPos", AngleYLocalToPos);
		L.RegFunction("SqrDisToPos", SqrDisToPos);
		L.RegFunction("DistanceToTarget", DistanceToTarget);
		L.RegFunction("DistanceToPos", DistanceToPos);
		L.RegFunction("DistanceLocalToPos", DistanceLocalToPos);
		L.RegFunction("SetRaycastTarget", SetRaycastTarget);
		L.RegFunction("SetAlpha", SetAlpha);
		L.RegFunction("SetColor", SetColor);
		L.RegFunction("ForceRebuildLayoutImmediate", ForceRebuildLayoutImmediate);
		L.RegFunction("SetRectOffset", SetRectOffset);
		L.RegFunction("CopyAnchoredPosition", CopyAnchoredPosition);
		L.RegFunction("CopyRectTransform", CopyRectTransform);
		L.RegFunction("SetAnchorEx", SetAnchorEx);
		L.RegFunction("SetAnchor", SetAnchor);
		L.RegFunction("SetPivotEx", SetPivotEx);
		L.RegFunction("GetRectEx", GetRectEx);
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
		L.RegFunction("GetY", GetY);
		L.RegFunction("GetX", GetX);
		L.RegFunction("GetHalfWidth", GetHalfWidth);
		L.RegFunction("GetWidth", GetWidth);
		L.RegFunction("GetHalfHeight", GetHalfHeight);
		L.RegFunction("GetHeight", GetHeight);
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
		L.RegFunction("SetRotation", SetRotation);
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
		L.RegFunction("OffsetPositionInSelf", OffsetPositionInSelf);
		L.RegFunction("GetPositionOffset", GetPositionOffset);
		L.RegFunction("GetPositionEx", GetPositionEx);
		L.RegFunction("GetPositionY", GetPositionY);
		L.RegFunction("GetPositionX", GetPositionX);
		L.RegFunction("GetPosition", GetPosition);
		L.RegFunction("MovePercentToTargetPos", MovePercentToTargetPos);
		L.RegFunction("SetPosRotByTarget", SetPosRotByTarget);
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
		L.RegFunction("SetLocalPositionDeltaZ", SetLocalPositionDeltaZ);
		L.RegFunction("SetLocalPositionDeltaY", SetLocalPositionDeltaY);
		L.RegFunction("SetLocalPositionDeltaX", SetLocalPositionDeltaX);
		L.RegFunction("SetLocalPositionDelta", SetLocalPositionDelta);
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
		L.RegFunction("New", _CreateUnityEngine_RectTransform);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("rect", get_rect, null);
		L.RegVar("anchorMin", get_anchorMin, set_anchorMin);
		L.RegVar("anchorMax", get_anchorMax, set_anchorMax);
		L.RegVar("anchoredPosition", get_anchoredPosition, set_anchoredPosition);
		L.RegVar("sizeDelta", get_sizeDelta, set_sizeDelta);
		L.RegVar("pivot", get_pivot, set_pivot);
		L.RegVar("anchoredPosition3D", get_anchoredPosition3D, set_anchoredPosition3D);
		L.RegVar("offsetMin", get_offsetMin, set_offsetMin);
		L.RegVar("offsetMax", get_offsetMax, set_offsetMax);
		L.RegVar("drivenByObject", get_drivenByObject, null);
		L.RegVar("reapplyDrivenProperties", get_reapplyDrivenProperties, set_reapplyDrivenProperties);
		L.RegFunction("ReapplyDrivenProperties", UnityEngine_RectTransform_ReapplyDrivenProperties);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_RectTransform(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				RectTransform o = new RectTransform();
				ToLua.PushSealed(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.RectTransform.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ForceUpdateRectTransforms(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).ForceUpdateRectTransforms();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLocalCorners(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RectTransform obj = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			Vector3[] fourCornersArray = ToLua.CheckStructArray<Vector3>(L, 2);
			obj.GetLocalCorners(fourCornersArray);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetWorldCorners(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RectTransform obj = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			Vector3[] fourCornersArray = ToLua.CheckStructArray<Vector3>(L, 2);
			obj.GetWorldCorners(fourCornersArray);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetInsetAndSizeFromParentEdge(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			RectTransform obj = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			RectTransform.Edge edge = (RectTransform.Edge)ToLua.CheckObject(L, 2, typeof(RectTransform.Edge));
			float inset = (float)LuaDLL.luaL_checknumber(L, 3);
			float size = (float)LuaDLL.luaL_checknumber(L, 4);
			obj.SetInsetAndSizeFromParentEdge(edge, inset, size);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSizeWithCurrentAnchors(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RectTransform obj = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			RectTransform.Axis axis = (RectTransform.Axis)ToLua.CheckObject(L, 2, typeof(RectTransform.Axis));
			float size = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.SetSizeWithCurrentAnchors(axis, size);
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			float horizontalOrVerticalLayoutGroupSpacing = ((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetHorizontalOrVerticalLayoutGroupSpacing();
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
			int layoutGroupPaddingTop = ((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetLayoutGroupPaddingTop();
			LuaDLL.lua_pushinteger(L, layoutGroupPaddingTop);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetChildMeshRender(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			SkinnedMeshRenderer[] childMeshRender = ((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetChildMeshRender();
			ToLua.Push(L, childMeshRender);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RevertMaterials(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RectTransform transform = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			Material[] materials = ToLua.CheckObjectArray<Material>(L, 2);
			transform.RevertMaterials(materials);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeMaterials(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RectTransform transform = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			Material material = (Material)ToLua.CheckObject<Material>(L, 2);
			transform.ChangeMaterials(material);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetChildMaterials(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Material[] childMaterials = ((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetChildMaterials();
			ToLua.Push(L, childMaterials);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeMaterial(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RectTransform transform = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			Material material = (Material)ToLua.CheckObject<Material>(L, 2);
			transform.ChangeMaterial(material);
			return 0;
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
	private static int RotateHorizontalToDirectionXZ(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RectTransform tran = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			float dirX = (float)LuaDLL.luaL_checknumber(L, 2);
			float dirZ = (float)LuaDLL.luaL_checknumber(L, 3);
			tran.RotateHorizontalToDirectionXZ(dirX, dirZ);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetTargetAngle(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			RectTransform target = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			float xAngle = (float)LuaDLL.luaL_checknumber(L, 2);
			float yAngle = (float)LuaDLL.luaL_checknumber(L, 3);
			float zAngle = (float)LuaDLL.luaL_checknumber(L, 4);
			target.SetTargetAngle(xAngle, yAngle, zAngle);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRightXYZ(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetRightXYZ(out var x, out var y, out var z);
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
	private static int SetUpXYZ(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			RectTransform tran = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			float y = (float)LuaDLL.luaL_checknumber(L, 3);
			float z = (float)LuaDLL.luaL_checknumber(L, 4);
			tran.SetUpXYZ(x, y, z);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetUpXYZ(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetUpXYZ(out var x, out var y, out var z);
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
	private static int SetForward(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			RectTransform tran = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			float y = (float)LuaDLL.luaL_checknumber(L, 3);
			float z = (float)LuaDLL.luaL_checknumber(L, 4);
			tran.SetForward(x, y, z);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetForwardXYZ(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetForwardXYZ(out var x, out var y, out var z);
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
	private static int SetTargetDirection(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			RectTransform target = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			float forwardX = (float)LuaDLL.luaL_checknumber(L, 2);
			float forwardY = (float)LuaDLL.luaL_checknumber(L, 3);
			float forwardZ = (float)LuaDLL.luaL_checknumber(L, 4);
			target.SetTargetDirection(forwardX, forwardY, forwardZ, out var yAngleAfterSet);
			LuaDLL.lua_pushnumber(L, yAngleAfterSet);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AngleYLocalToPos(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RectTransform trans = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			Vector3 pos = ToLua.ToVector3(L, 2);
			float num = trans.AngleYLocalToPos(pos);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SqrDisToPos(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RectTransform trans = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			Vector3 pos = ToLua.ToVector3(L, 2);
			float num = trans.SqrDisToPos(pos);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DistanceToTarget(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RectTransform trans = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			Transform target = (Transform)ToLua.CheckObject<Transform>(L, 2);
			float num = trans.DistanceToTarget(target);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DistanceToPos(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RectTransform trans = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			Vector3 pos = ToLua.ToVector3(L, 2);
			float num = trans.DistanceToPos(pos);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DistanceLocalToPos(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RectTransform trans = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			Vector3 pos = ToLua.ToVector3(L, 2);
			float num = trans.DistanceLocalToPos(pos);
			LuaDLL.lua_pushnumber(L, num);
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
	private static int ForceRebuildLayoutImmediate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).ForceRebuildLayoutImmediate();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetRectOffset(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			float left = (float)LuaDLL.luaL_checknumber(L, 2);
			float right = (float)LuaDLL.luaL_checknumber(L, 3);
			float up = (float)LuaDLL.luaL_checknumber(L, 4);
			float bottom = (float)LuaDLL.luaL_checknumber(L, 5);
			cmpt.SetRectOffset(left, right, up, bottom);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CopyAnchoredPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			Vector2 pos = ToLua.ToVector2(L, 2);
			bool value = cmpt.CopyAnchoredPosition(pos);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CopyRectTransform(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			Button tarBtn = (Button)ToLua.CheckObject<Button>(L, 2);
			bool value = cmpt.CopyRectTransform(tarBtn);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAnchorEx(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			float minX = (float)LuaDLL.luaL_checknumber(L, 2);
			float minY = (float)LuaDLL.luaL_checknumber(L, 3);
			float maxX = (float)LuaDLL.luaL_checknumber(L, 4);
			float maxY = (float)LuaDLL.luaL_checknumber(L, 5);
			cmpt.SetAnchorEx(minX, minY, maxX, maxY);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAnchor(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
				int a = (int)LuaDLL.lua_tonumber(L, 2);
				cmpt.SetAnchor(a);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<TextAnchor>(L, 2))
			{
				RectTransform cmpt2 = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
				TextAnchor anchor = (TextAnchor)ToLua.ToObject(L, 2);
				cmpt2.SetAnchor(anchor);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.RectTransform.SetAnchor");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPivotEx(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RectTransform rectTran = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			float y = (float)LuaDLL.luaL_checknumber(L, 3);
			rectTran.SetPivotEx(x, y);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRectEx(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetRectEx(out var x, out var y, out var width, out var height);
			LuaDLL.lua_pushnumber(L, x);
			LuaDLL.lua_pushnumber(L, y);
			LuaDLL.lua_pushnumber(L, width);
			LuaDLL.lua_pushnumber(L, height);
			return 4;
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
			((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetRectSize(out var width, out var height);
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
			((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetRectHeight(out var height);
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
			float rectWidth = ((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetRectWidth();
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetAnchoredPositionY(out var y);
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
			((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetAnchoredPositionX(out var x);
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
			((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetAnchoredPosition(out var x, out var y);
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
			((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetSizeDeltaY(out var y);
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
			((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetSizeDeltaX(out var x);
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
			((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetSizeDeltaEx(out var x, out var y);
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
	private static int GetY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float y = ((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetY();
			LuaDLL.lua_pushnumber(L, y);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float x = ((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetX();
			LuaDLL.lua_pushnumber(L, x);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetHalfWidth(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float halfWidth = ((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetHalfWidth();
			LuaDLL.lua_pushnumber(L, halfWidth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetWidth(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float width = ((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetWidth();
			LuaDLL.lua_pushnumber(L, width);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetHalfHeight(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float halfHeight = ((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetHalfHeight();
			LuaDLL.lua_pushnumber(L, halfHeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetHeight(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float height = ((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetHeight();
			LuaDLL.lua_pushnumber(L, height);
			return 1;
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
				RectTransform cmpt2 = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
				float y2 = (float)LuaDLL.luaL_checknumber(L, 2);
				cmpt2.RotateAxisY(y2);
				return 0;
			}
			case 3:
			{
				RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
				float y = (float)LuaDLL.luaL_checknumber(L, 2);
				Space relativeTo = (Space)ToLua.CheckObject(L, 3, typeof(Space));
				cmpt.RotateAxisY(y, relativeTo);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.RectTransform.RotateAxisY");
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
			float localEulerAngleZ = ((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetLocalEulerAngleZ();
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
			float localEulerAngleY = ((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetLocalEulerAngleY();
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
			float localEulerAngleX = ((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetLocalEulerAngleX();
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
			float eulerAngleY = ((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetEulerAngleY();
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
			Vector3 eulerAngle = ((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetEulerAngle();
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
			((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetLocalEulerAngle(out var x, out var y, out var z);
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
			Vector3 localEulerAngleOrigin = ((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetLocalEulerAngleOrigin();
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).SetLocalRotationOne();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetRotation(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			RectTransform tran = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			float y = (float)LuaDLL.luaL_checknumber(L, 3);
			float z = (float)LuaDLL.luaL_checknumber(L, 4);
			float w = (float)LuaDLL.luaL_checknumber(L, 5);
			tran.SetRotation(x, y, z, w);
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
			float localScaleX = ((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetLocalScaleX();
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
			((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetLocalScaleEx(out var x, out var y, out var z);
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
			Vector3 localScale = ((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetLocalScale();
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).SetLocalScaleOne();
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
			((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).SetLocalScaleZero();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OffsetPositionInSelf(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 10);
			RectTransform tran = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			float posX = (float)LuaDLL.luaL_checknumber(L, 2);
			float posY = (float)LuaDLL.luaL_checknumber(L, 3);
			float posZ = (float)LuaDLL.luaL_checknumber(L, 4);
			float offsetX = (float)LuaDLL.luaL_checknumber(L, 5);
			float offsetY = (float)LuaDLL.luaL_checknumber(L, 6);
			float offsetZ = (float)LuaDLL.luaL_checknumber(L, 7);
			tran.OffsetPositionInSelf(posX, posY, posZ, offsetX, offsetY, offsetZ, out var x, out var y, out var z);
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
	private static int GetPositionOffset(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 7);
			RectTransform tran = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			float offsetX = (float)LuaDLL.luaL_checknumber(L, 2);
			float offsetY = (float)LuaDLL.luaL_checknumber(L, 3);
			float offsetZ = (float)LuaDLL.luaL_checknumber(L, 4);
			tran.GetPositionOffset(offsetX, offsetY, offsetZ, out var x, out var y, out var z);
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
	private static int GetPositionEx(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetPositionEx(out var x, out var y, out var z);
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
			float positionY = ((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetPositionY();
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
			float positionX = ((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetPositionX();
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
			Vector3 position = ((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetPosition();
			ToLua.Push(L, position);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MovePercentToTargetPos(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 8);
			RectTransform tran = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			float targetX = (float)LuaDLL.luaL_checknumber(L, 2);
			float targetY = (float)LuaDLL.luaL_checknumber(L, 3);
			float targetZ = (float)LuaDLL.luaL_checknumber(L, 4);
			float percent = (float)LuaDLL.luaL_checknumber(L, 5);
			tran.MovePercentToTargetPos(targetX, targetY, targetZ, percent, out var finalPosX, out var finalPosY, out var finalPosZ);
			LuaDLL.lua_pushnumber(L, finalPosX);
			LuaDLL.lua_pushnumber(L, finalPosY);
			LuaDLL.lua_pushnumber(L, finalPosZ);
			return 3;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPosRotByTarget(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RectTransform tran = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			Transform target = (Transform)ToLua.CheckObject<Transform>(L, 2);
			tran.SetPosRotByTarget(target);
			return 0;
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).SetPostionZero();
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
			float localPositionY = ((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetLocalPositionY();
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
			float localPositionX = ((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetLocalPositionX();
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
			((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetLocalPositionEx(out var x, out var y, out var z);
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
			Vector3 localPosition = ((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).GetLocalPosition();
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
	private static int SetLocalPositionDeltaZ(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			float deltaZ = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetLocalPositionDeltaZ(deltaZ);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalPositionDeltaY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			float deltaY = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetLocalPositionDeltaY(deltaY);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalPositionDeltaX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			float deltaX = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetLocalPositionDeltaX(deltaX);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalPositionDelta(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			float deltaX = (float)LuaDLL.luaL_checknumber(L, 2);
			float deltaY = (float)LuaDLL.luaL_checknumber(L, 3);
			float deltaZ = (float)LuaDLL.luaL_checknumber(L, 4);
			cmpt.SetLocalPositionDelta(deltaX, deltaY, deltaZ);
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).SetLocalPositionZero();
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			RectTransform cmpt = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
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
			((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform))).InitTransform();
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
	private static int get_rect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rect rect = ((RectTransform)obj).rect;
			ToLua.PushValue(L, rect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_anchorMin(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 anchorMin = ((RectTransform)obj).anchorMin;
			ToLua.Push(L, anchorMin);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index anchorMin on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_anchorMax(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 anchorMax = ((RectTransform)obj).anchorMax;
			ToLua.Push(L, anchorMax);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index anchorMax on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_anchoredPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 anchoredPosition = ((RectTransform)obj).anchoredPosition;
			ToLua.Push(L, anchoredPosition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index anchoredPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sizeDelta(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 sizeDelta = ((RectTransform)obj).sizeDelta;
			ToLua.Push(L, sizeDelta);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sizeDelta on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pivot(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 pivot = ((RectTransform)obj).pivot;
			ToLua.Push(L, pivot);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pivot on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_anchoredPosition3D(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 anchoredPosition3D = ((RectTransform)obj).anchoredPosition3D;
			ToLua.Push(L, anchoredPosition3D);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index anchoredPosition3D on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_offsetMin(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 offsetMin = ((RectTransform)obj).offsetMin;
			ToLua.Push(L, offsetMin);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index offsetMin on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_offsetMax(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 offsetMax = ((RectTransform)obj).offsetMax;
			ToLua.Push(L, offsetMax);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index offsetMax on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_drivenByObject(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UnityEngine.Object drivenByObject = ((RectTransform)obj).drivenByObject;
			ToLua.Push(L, drivenByObject);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index drivenByObject on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_reapplyDrivenProperties(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(RectTransform.ReapplyDrivenProperties)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_anchorMin(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform obj2 = (RectTransform)obj;
			Vector2 anchorMin = ToLua.ToVector2(L, 2);
			obj2.anchorMin = anchorMin;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index anchorMin on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_anchorMax(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform obj2 = (RectTransform)obj;
			Vector2 anchorMax = ToLua.ToVector2(L, 2);
			obj2.anchorMax = anchorMax;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index anchorMax on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_anchoredPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform obj2 = (RectTransform)obj;
			Vector2 anchoredPosition = ToLua.ToVector2(L, 2);
			obj2.anchoredPosition = anchoredPosition;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index anchoredPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sizeDelta(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform obj2 = (RectTransform)obj;
			Vector2 sizeDelta = ToLua.ToVector2(L, 2);
			obj2.sizeDelta = sizeDelta;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sizeDelta on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_pivot(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform obj2 = (RectTransform)obj;
			Vector2 pivot = ToLua.ToVector2(L, 2);
			obj2.pivot = pivot;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pivot on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_anchoredPosition3D(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform obj2 = (RectTransform)obj;
			Vector3 anchoredPosition3D = ToLua.ToVector3(L, 2);
			obj2.anchoredPosition3D = anchoredPosition3D;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index anchoredPosition3D on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_offsetMin(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform obj2 = (RectTransform)obj;
			Vector2 offsetMin = ToLua.ToVector2(L, 2);
			obj2.offsetMin = offsetMin;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index offsetMin on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_offsetMax(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform obj2 = (RectTransform)obj;
			Vector2 offsetMax = ToLua.ToVector2(L, 2);
			obj2.offsetMax = offsetMax;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index offsetMax on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_reapplyDrivenProperties(IntPtr L)
	{
		try
		{
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					RectTransform.reapplyDrivenProperties += (RectTransform.ReapplyDrivenProperties)eventObject.func;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					RectTransform.reapplyDrivenProperties -= (RectTransform.ReapplyDrivenProperties)eventObject.func;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'UnityEngine.RectTransform.reapplyDrivenProperties' can only appear on the left hand side of += or -= when used outside of the type 'UnityEngine.RectTransform'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_RectTransform_ReapplyDrivenProperties(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<RectTransform.ReapplyDrivenProperties>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<RectTransform.ReapplyDrivenProperties>.Create(func, self);
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
