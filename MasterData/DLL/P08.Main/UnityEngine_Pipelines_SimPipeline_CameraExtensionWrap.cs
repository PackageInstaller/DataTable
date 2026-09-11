using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;

public class UnityEngine_Pipelines_SimPipeline_CameraExtensionWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(CameraExtension), typeof(MonoBehaviour));
		L.RegFunction("CaptureSnapshot", CaptureSnapshot);
		L.RegFunction("FreeSnapshot", FreeSnapshot);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("AfterRender", get_AfterRender, set_AfterRender);
		L.RegVar("hdr", get_hdr, set_hdr);
		L.RegVar("fxaa", get_fxaa, set_fxaa);
		L.RegVar("taa", get_taa, set_taa);
		L.RegVar("msaa", get_msaa, set_msaa);
		L.RegVar("shadowRotationImmediately", get_shadowRotationImmediately, set_shadowRotationImmediately);
		L.RegVar("shadowRotationSpeed", get_shadowRotationSpeed, set_shadowRotationSpeed);
		L.RegVar("bloomQuality", get_bloomQuality, set_bloomQuality);
		L.RegVar("newVersionBloom", get_newVersionBloom, set_newVersionBloom);
		L.RegVar("contrast", get_contrast, set_contrast);
		L.RegVar("exposure", get_exposure, set_exposure);
		L.RegVar("threshold", get_threshold, set_threshold);
		L.RegVar("uiFov", get_uiFov, set_uiFov);
		L.RegVar("uiDistance", get_uiDistance, set_uiDistance);
		L.RegVar("uiSeparateRender", get_uiSeparateRender, set_uiSeparateRender);
		L.RegVar("reflectionBlur", get_reflectionBlur, set_reflectionBlur);
		L.RegVar("radialBlurScale", get_radialBlurScale, set_radialBlurScale);
		L.RegVar("radialBlurRange", get_radialBlurRange, set_radialBlurRange);
		L.RegVar("radialBlurSoft", get_radialBlurSoft, set_radialBlurSoft);
		L.RegVar("radialBlurGradient", get_radialBlurGradient, set_radialBlurGradient);
		L.RegVar("radialBlurIntensity", get_radialBlurIntensity, set_radialBlurIntensity);
		L.RegVar("radialWarpLerp", get_radialWarpLerp, set_radialWarpLerp);
		L.RegVar("radialWarpScale", get_radialWarpScale, set_radialWarpScale);
		L.RegVar("radialWarpDensity", get_radialWarpDensity, set_radialWarpDensity);
		L.RegVar("radialAbberationIntensity", get_radialAbberationIntensity, set_radialAbberationIntensity);
		L.RegVar("isRadialOutward", get_isRadialOutward, set_isRadialOutward);
		L.RegVar("showGUICenter", get_showGUICenter, set_showGUICenter);
		L.RegVar("isUseRadialCenterTransform", get_isUseRadialCenterTransform, set_isUseRadialCenterTransform);
		L.RegVar("abberationIntensity", get_abberationIntensity, set_abberationIntensity);
		L.RegVar("isMotion", get_isMotion, set_isMotion);
		L.RegVar("motionCentre", get_motionCentre, set_motionCentre);
		L.RegVar("motionRotation", get_motionRotation, set_motionRotation);
		L.RegVar("glitchIntensity", get_glitchIntensity, set_glitchIntensity);
		L.RegVar("glitchFrequency", get_glitchFrequency, set_glitchFrequency);
		L.RegVar("radialBlurCenterTransform", get_radialBlurCenterTransform, set_radialBlurCenterTransform);
		L.RegVar("radialBlurTarget", get_radialBlurTarget, set_radialBlurTarget);
		L.RegVar("vignetteTarget", get_vignetteTarget, set_vignetteTarget);
		L.RegVar("vignetteTransform", get_vignetteTransform, set_vignetteTransform);
		L.RegVar("vignetteColor", get_vignetteColor, set_vignetteColor);
		L.RegVar("vignetteStrength", get_vignetteStrength, set_vignetteStrength);
		L.RegVar("vignetteSoft", get_vignetteSoft, set_vignetteSoft);
		L.RegVar("vignetteBounded", get_vignetteBounded, set_vignetteBounded);
		L.RegVar("motionBlurScale", get_motionBlurScale, set_motionBlurScale);
		L.RegVar("dofType", get_dofType, set_dofType);
		L.RegVar("dofScale", get_dofScale, set_dofScale);
		L.RegVar("dofNear", get_dofNear, set_dofNear);
		L.RegVar("dofFar", get_dofFar, set_dofFar);
		L.RegVar("radialBlurEffective", get_radialBlurEffective, null);
		L.RegVar("radialBlurCenter", get_radialBlurCenter, null);
		L.RegVar("vignetteCenter", get_vignetteCenter, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CaptureSnapshot(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 1:
				((CameraExtension)ToLua.CheckObject<CameraExtension>(L, 1)).CaptureSnapshot();
				return 0;
			case 2:
				if (TypeChecker.CheckTypes<bool>(L, 2))
				{
					CameraExtension obj = (CameraExtension)ToLua.CheckObject<CameraExtension>(L, 1);
					bool isAfterPost = LuaDLL.lua_toboolean(L, 2);
					obj.CaptureSnapshot(isAfterPost);
					return 0;
				}
				break;
			}
			if (num == 2 && TypeChecker.CheckTypes<RenderTexture>(L, 2))
			{
				CameraExtension obj2 = (CameraExtension)ToLua.CheckObject<CameraExtension>(L, 1);
				RenderTexture saveTo = (RenderTexture)ToLua.ToObject(L, 2);
				obj2.CaptureSnapshot(saveTo);
				return 0;
			}
			if (num == 3)
			{
				CameraExtension obj3 = (CameraExtension)ToLua.CheckObject<CameraExtension>(L, 1);
				RenderTexture saveTo2 = (RenderTexture)ToLua.CheckObject<RenderTexture>(L, 2);
				bool isAfterPost2 = LuaDLL.luaL_checkboolean(L, 3);
				obj3.CaptureSnapshot(saveTo2, isAfterPost2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Pipelines.SimPipeline.CameraExtension.CaptureSnapshot");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FreeSnapshot(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CameraExtension)ToLua.CheckObject<CameraExtension>(L, 1)).FreeSnapshot();
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
	private static int get_AfterRender(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action afterRender = ((CameraExtension)obj).AfterRender;
			ToLua.Push(L, afterRender);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AfterRender on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hdr(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool hdr = ((CameraExtension)obj).hdr;
			LuaDLL.lua_pushboolean(L, hdr);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hdr on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fxaa(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool fxaa = ((CameraExtension)obj).fxaa;
			LuaDLL.lua_pushboolean(L, fxaa);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fxaa on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_taa(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool taa = ((CameraExtension)obj).taa;
			LuaDLL.lua_pushboolean(L, taa);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index taa on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_msaa(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension.MsaaQuality msaa = ((CameraExtension)obj).msaa;
			ToLua.Push(L, msaa);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index msaa on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_shadowRotationImmediately(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool shadowRotationImmediately = ((CameraExtension)obj).shadowRotationImmediately;
			LuaDLL.lua_pushboolean(L, shadowRotationImmediately);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shadowRotationImmediately on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_shadowRotationSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float shadowRotationSpeed = ((CameraExtension)obj).shadowRotationSpeed;
			LuaDLL.lua_pushnumber(L, shadowRotationSpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shadowRotationSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bloomQuality(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension.BloomQuality bloomQuality = ((CameraExtension)obj).bloomQuality;
			ToLua.Push(L, bloomQuality);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bloomQuality on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_newVersionBloom(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool newVersionBloom = ((CameraExtension)obj).newVersionBloom;
			LuaDLL.lua_pushboolean(L, newVersionBloom);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index newVersionBloom on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_contrast(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float contrast = ((CameraExtension)obj).contrast;
			LuaDLL.lua_pushnumber(L, contrast);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index contrast on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_exposure(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float exposure = ((CameraExtension)obj).exposure;
			LuaDLL.lua_pushnumber(L, exposure);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index exposure on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_threshold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float threshold = ((CameraExtension)obj).threshold;
			LuaDLL.lua_pushnumber(L, threshold);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index threshold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_uiFov(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float uiFov = ((CameraExtension)obj).uiFov;
			LuaDLL.lua_pushnumber(L, uiFov);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uiFov on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_uiDistance(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float uiDistance = ((CameraExtension)obj).uiDistance;
			LuaDLL.lua_pushnumber(L, uiDistance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uiDistance on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_uiSeparateRender(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool uiSeparateRender = ((CameraExtension)obj).uiSeparateRender;
			LuaDLL.lua_pushboolean(L, uiSeparateRender);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uiSeparateRender on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_reflectionBlur(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float reflectionBlur = ((CameraExtension)obj).reflectionBlur;
			LuaDLL.lua_pushnumber(L, reflectionBlur);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index reflectionBlur on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_radialBlurScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float radialBlurScale = ((CameraExtension)obj).radialBlurScale;
			LuaDLL.lua_pushnumber(L, radialBlurScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index radialBlurScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_radialBlurRange(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float radialBlurRange = ((CameraExtension)obj).radialBlurRange;
			LuaDLL.lua_pushnumber(L, radialBlurRange);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index radialBlurRange on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_radialBlurSoft(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float radialBlurSoft = ((CameraExtension)obj).radialBlurSoft;
			LuaDLL.lua_pushnumber(L, radialBlurSoft);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index radialBlurSoft on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_radialBlurGradient(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float radialBlurGradient = ((CameraExtension)obj).radialBlurGradient;
			LuaDLL.lua_pushnumber(L, radialBlurGradient);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index radialBlurGradient on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_radialBlurIntensity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float radialBlurIntensity = ((CameraExtension)obj).radialBlurIntensity;
			LuaDLL.lua_pushnumber(L, radialBlurIntensity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index radialBlurIntensity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_radialWarpLerp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float radialWarpLerp = ((CameraExtension)obj).radialWarpLerp;
			LuaDLL.lua_pushnumber(L, radialWarpLerp);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index radialWarpLerp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_radialWarpScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float radialWarpScale = ((CameraExtension)obj).radialWarpScale;
			LuaDLL.lua_pushnumber(L, radialWarpScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index radialWarpScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_radialWarpDensity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float radialWarpDensity = ((CameraExtension)obj).radialWarpDensity;
			LuaDLL.lua_pushnumber(L, radialWarpDensity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index radialWarpDensity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_radialAbberationIntensity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float radialAbberationIntensity = ((CameraExtension)obj).radialAbberationIntensity;
			LuaDLL.lua_pushnumber(L, radialAbberationIntensity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index radialAbberationIntensity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isRadialOutward(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isRadialOutward = ((CameraExtension)obj).isRadialOutward;
			LuaDLL.lua_pushboolean(L, isRadialOutward);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isRadialOutward on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_showGUICenter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool showGUICenter = ((CameraExtension)obj).showGUICenter;
			LuaDLL.lua_pushboolean(L, showGUICenter);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index showGUICenter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isUseRadialCenterTransform(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isUseRadialCenterTransform = ((CameraExtension)obj).isUseRadialCenterTransform;
			LuaDLL.lua_pushboolean(L, isUseRadialCenterTransform);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isUseRadialCenterTransform on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_abberationIntensity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float abberationIntensity = ((CameraExtension)obj).abberationIntensity;
			LuaDLL.lua_pushnumber(L, abberationIntensity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index abberationIntensity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isMotion(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isMotion = ((CameraExtension)obj).isMotion;
			LuaDLL.lua_pushboolean(L, isMotion);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isMotion on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_motionCentre(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 motionCentre = ((CameraExtension)obj).motionCentre;
			ToLua.Push(L, motionCentre);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index motionCentre on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_motionRotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float motionRotation = ((CameraExtension)obj).motionRotation;
			LuaDLL.lua_pushnumber(L, motionRotation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index motionRotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_glitchIntensity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float glitchIntensity = ((CameraExtension)obj).glitchIntensity;
			LuaDLL.lua_pushnumber(L, glitchIntensity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index glitchIntensity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_glitchFrequency(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float glitchFrequency = ((CameraExtension)obj).glitchFrequency;
			LuaDLL.lua_pushnumber(L, glitchFrequency);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index glitchFrequency on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_radialBlurCenterTransform(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 radialBlurCenterTransform = ((CameraExtension)obj).radialBlurCenterTransform;
			ToLua.Push(L, radialBlurCenterTransform);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index radialBlurCenterTransform on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_radialBlurTarget(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform radialBlurTarget = ((CameraExtension)obj).radialBlurTarget;
			ToLua.Push(L, radialBlurTarget);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index radialBlurTarget on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_vignetteTarget(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform vignetteTarget = ((CameraExtension)obj).vignetteTarget;
			ToLua.Push(L, vignetteTarget);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index vignetteTarget on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_vignetteTransform(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 vignetteTransform = ((CameraExtension)obj).vignetteTransform;
			ToLua.Push(L, vignetteTransform);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index vignetteTransform on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_vignetteColor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Color vignetteColor = ((CameraExtension)obj).vignetteColor;
			ToLua.Push(L, vignetteColor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index vignetteColor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_vignetteStrength(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float vignetteStrength = ((CameraExtension)obj).vignetteStrength;
			LuaDLL.lua_pushnumber(L, vignetteStrength);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index vignetteStrength on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_vignetteSoft(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float vignetteSoft = ((CameraExtension)obj).vignetteSoft;
			LuaDLL.lua_pushnumber(L, vignetteSoft);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index vignetteSoft on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_vignetteBounded(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool vignetteBounded = ((CameraExtension)obj).vignetteBounded;
			LuaDLL.lua_pushboolean(L, vignetteBounded);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index vignetteBounded on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_motionBlurScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float motionBlurScale = ((CameraExtension)obj).motionBlurScale;
			LuaDLL.lua_pushnumber(L, motionBlurScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index motionBlurScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dofType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DepthOfFieldType dofType = ((CameraExtension)obj).dofType;
			ToLua.Push(L, dofType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dofType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dofScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float dofScale = ((CameraExtension)obj).dofScale;
			LuaDLL.lua_pushnumber(L, dofScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dofScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dofNear(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float dofNear = ((CameraExtension)obj).dofNear;
			LuaDLL.lua_pushnumber(L, dofNear);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dofNear on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dofFar(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float dofFar = ((CameraExtension)obj).dofFar;
			LuaDLL.lua_pushnumber(L, dofFar);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dofFar on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_radialBlurEffective(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool radialBlurEffective = ((CameraExtension)obj).radialBlurEffective;
			LuaDLL.lua_pushboolean(L, radialBlurEffective);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index radialBlurEffective on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_radialBlurCenter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 radialBlurCenter = ((CameraExtension)obj).radialBlurCenter;
			ToLua.Push(L, radialBlurCenter);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index radialBlurCenter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_vignetteCenter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 vignetteCenter = ((CameraExtension)obj).vignetteCenter;
			ToLua.Push(L, vignetteCenter);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index vignetteCenter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_AfterRender(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			Action afterRender = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj2.AfterRender = afterRender;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AfterRender on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_hdr(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			bool hdr = LuaDLL.luaL_checkboolean(L, 2);
			obj2.hdr = hdr;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hdr on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fxaa(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			bool fxaa = LuaDLL.luaL_checkboolean(L, 2);
			obj2.fxaa = fxaa;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fxaa on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_taa(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			bool taa = LuaDLL.luaL_checkboolean(L, 2);
			obj2.taa = taa;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index taa on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_msaa(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			CameraExtension.MsaaQuality msaa = (CameraExtension.MsaaQuality)ToLua.CheckObject(L, 2, typeof(CameraExtension.MsaaQuality));
			obj2.msaa = msaa;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index msaa on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_shadowRotationImmediately(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			bool shadowRotationImmediately = LuaDLL.luaL_checkboolean(L, 2);
			obj2.shadowRotationImmediately = shadowRotationImmediately;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shadowRotationImmediately on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_shadowRotationSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			float shadowRotationSpeed = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.shadowRotationSpeed = shadowRotationSpeed;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shadowRotationSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bloomQuality(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			CameraExtension.BloomQuality bloomQuality = (CameraExtension.BloomQuality)ToLua.CheckObject(L, 2, typeof(CameraExtension.BloomQuality));
			obj2.bloomQuality = bloomQuality;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bloomQuality on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_newVersionBloom(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			bool newVersionBloom = LuaDLL.luaL_checkboolean(L, 2);
			obj2.newVersionBloom = newVersionBloom;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index newVersionBloom on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_contrast(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			float contrast = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.contrast = contrast;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index contrast on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_exposure(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			float exposure = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.exposure = exposure;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index exposure on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_threshold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			float threshold = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.threshold = threshold;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index threshold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_uiFov(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			float uiFov = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.uiFov = uiFov;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uiFov on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_uiDistance(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			float uiDistance = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.uiDistance = uiDistance;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uiDistance on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_uiSeparateRender(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			bool uiSeparateRender = LuaDLL.luaL_checkboolean(L, 2);
			obj2.uiSeparateRender = uiSeparateRender;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uiSeparateRender on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_reflectionBlur(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			float reflectionBlur = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.reflectionBlur = reflectionBlur;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index reflectionBlur on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_radialBlurScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			float radialBlurScale = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.radialBlurScale = radialBlurScale;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index radialBlurScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_radialBlurRange(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			float radialBlurRange = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.radialBlurRange = radialBlurRange;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index radialBlurRange on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_radialBlurSoft(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			float radialBlurSoft = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.radialBlurSoft = radialBlurSoft;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index radialBlurSoft on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_radialBlurGradient(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			float radialBlurGradient = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.radialBlurGradient = radialBlurGradient;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index radialBlurGradient on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_radialBlurIntensity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			float radialBlurIntensity = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.radialBlurIntensity = radialBlurIntensity;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index radialBlurIntensity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_radialWarpLerp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			float radialWarpLerp = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.radialWarpLerp = radialWarpLerp;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index radialWarpLerp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_radialWarpScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			float radialWarpScale = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.radialWarpScale = radialWarpScale;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index radialWarpScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_radialWarpDensity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			float radialWarpDensity = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.radialWarpDensity = radialWarpDensity;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index radialWarpDensity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_radialAbberationIntensity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			float radialAbberationIntensity = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.radialAbberationIntensity = radialAbberationIntensity;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index radialAbberationIntensity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isRadialOutward(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			bool isRadialOutward = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isRadialOutward = isRadialOutward;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isRadialOutward on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_showGUICenter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			bool showGUICenter = LuaDLL.luaL_checkboolean(L, 2);
			obj2.showGUICenter = showGUICenter;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index showGUICenter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isUseRadialCenterTransform(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			bool isUseRadialCenterTransform = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isUseRadialCenterTransform = isUseRadialCenterTransform;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isUseRadialCenterTransform on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_abberationIntensity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			float abberationIntensity = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.abberationIntensity = abberationIntensity;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index abberationIntensity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isMotion(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			bool isMotion = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isMotion = isMotion;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isMotion on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_motionCentre(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			Vector2 motionCentre = ToLua.ToVector2(L, 2);
			obj2.motionCentre = motionCentre;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index motionCentre on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_motionRotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			float motionRotation = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.motionRotation = motionRotation;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index motionRotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_glitchIntensity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			float glitchIntensity = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.glitchIntensity = glitchIntensity;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index glitchIntensity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_glitchFrequency(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			float glitchFrequency = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.glitchFrequency = glitchFrequency;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index glitchFrequency on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_radialBlurCenterTransform(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			Vector2 radialBlurCenterTransform = ToLua.ToVector2(L, 2);
			obj2.radialBlurCenterTransform = radialBlurCenterTransform;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index radialBlurCenterTransform on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_radialBlurTarget(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			Transform radialBlurTarget = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.radialBlurTarget = radialBlurTarget;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index radialBlurTarget on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_vignetteTarget(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			Transform vignetteTarget = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.vignetteTarget = vignetteTarget;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index vignetteTarget on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_vignetteTransform(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			Vector2 vignetteTransform = ToLua.ToVector2(L, 2);
			obj2.vignetteTransform = vignetteTransform;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index vignetteTransform on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_vignetteColor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			Color vignetteColor = ToLua.ToColor(L, 2);
			obj2.vignetteColor = vignetteColor;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index vignetteColor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_vignetteStrength(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			float vignetteStrength = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.vignetteStrength = vignetteStrength;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index vignetteStrength on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_vignetteSoft(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			float vignetteSoft = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.vignetteSoft = vignetteSoft;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index vignetteSoft on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_vignetteBounded(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			bool vignetteBounded = LuaDLL.luaL_checkboolean(L, 2);
			obj2.vignetteBounded = vignetteBounded;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index vignetteBounded on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_motionBlurScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			float motionBlurScale = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.motionBlurScale = motionBlurScale;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index motionBlurScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dofType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			DepthOfFieldType dofType = (DepthOfFieldType)ToLua.CheckObject(L, 2, typeof(DepthOfFieldType));
			obj2.dofType = dofType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dofType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dofScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			float dofScale = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.dofScale = dofScale;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dofScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dofNear(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			float dofNear = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.dofNear = dofNear;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dofNear on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dofFar(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CameraExtension obj2 = (CameraExtension)obj;
			float dofFar = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.dofFar = dofFar;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dofFar on a nil value");
		}
	}
}
