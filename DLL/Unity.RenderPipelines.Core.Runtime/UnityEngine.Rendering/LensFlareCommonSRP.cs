using System;
using System.Collections.Generic;
using UnityEngine.Experimental.Rendering;

namespace UnityEngine.Rendering;

public sealed class LensFlareCommonSRP
{
	private static LensFlareCommonSRP m_Instance = null;

	private static readonly object m_Padlock = new object();

	private static List<LensFlareComponentSRP> m_Data = new List<LensFlareComponentSRP>();

	public static int maxLensFlareWithOcclusion = 128;

	public static int maxLensFlareWithOcclusionTemporalSample = 8;

	public static int mergeNeeded = 1;

	public static RTHandle occlusionRT = null;

	private static int frameIdx = 0;

	public static LensFlareCommonSRP Instance
	{
		get
		{
			if (m_Instance == null)
			{
				lock (m_Padlock)
				{
					if (m_Instance == null)
					{
						m_Instance = new LensFlareCommonSRP();
					}
				}
			}
			return m_Instance;
		}
	}

	private List<LensFlareComponentSRP> Data => m_Data;

	private LensFlareCommonSRP()
	{
	}

	public static void Initialize()
	{
		if (occlusionRT == null && mergeNeeded > 0)
		{
			occlusionRT = RTHandles.Alloc(maxLensFlareWithOcclusion, maxLensFlareWithOcclusionTemporalSample + mergeNeeded, 1, DepthBits.None, GraphicsFormat.R16_SFloat, FilterMode.Point, TextureWrapMode.Repeat, TextureXR.dimension, enableRandomWrite: true);
		}
	}

	public static void Dispose()
	{
		if (occlusionRT != null)
		{
			RTHandles.Release(occlusionRT);
			occlusionRT = null;
		}
	}

	public List<LensFlareComponentSRP> GetData()
	{
		return Data;
	}

	public bool IsEmpty()
	{
		return Data.Count == 0;
	}

	public void AddData(LensFlareComponentSRP newData)
	{
		if (!m_Data.Contains(newData))
		{
			m_Data.Add(newData);
		}
	}

	public static float ShapeAttenuationPointLight()
	{
		return 1f;
	}

	public static float ShapeAttenuationDirLight(Vector3 forward, Vector3 wo)
	{
		return Mathf.Max(Vector3.Dot(forward, wo), 0f);
	}

	public static float ShapeAttenuationSpotConeLight(Vector3 forward, Vector3 wo, float spotAngle, float innerSpotPercent01)
	{
		float num = Mathf.Max(Mathf.Cos(0.5f * spotAngle * (MathF.PI / 180f)), 0f);
		float num2 = Mathf.Max(Mathf.Cos(0.5f * spotAngle * (MathF.PI / 180f) * innerSpotPercent01), 0f);
		return Mathf.Clamp01((Mathf.Max(Vector3.Dot(forward, wo), 0f) - num) / (num2 - num));
	}

	public static float ShapeAttenuationSpotBoxLight(Vector3 forward, Vector3 wo)
	{
		return Mathf.Max(Mathf.Sign(Vector3.Dot(forward, wo)), 0f);
	}

	public static float ShapeAttenuationSpotPyramidLight(Vector3 forward, Vector3 wo)
	{
		return ShapeAttenuationSpotBoxLight(forward, wo);
	}

	public static float ShapeAttenuationAreaTubeLight(Vector3 lightPositionWS, Vector3 lightSide, float lightWidth, Camera cam)
	{
		Vector3 position = lightPositionWS + lightSide * lightWidth * 0.5f;
		Vector3 position2 = lightPositionWS - lightSide * lightWidth * 0.5f;
		Vector3 position3 = lightPositionWS + cam.transform.right * lightWidth * 0.5f;
		Vector3 position4 = lightPositionWS - cam.transform.right * lightWidth * 0.5f;
		Vector3 p = cam.transform.InverseTransformPoint(position);
		Vector3 p2 = cam.transform.InverseTransformPoint(position2);
		Vector3 p3 = cam.transform.InverseTransformPoint(position3);
		Vector3 p4 = cam.transform.InverseTransformPoint(position4);
		float num = DiffLineIntegral(p3, p4);
		float num2 = DiffLineIntegral(p, p2);
		if (!(num > 0f))
		{
			return 1f;
		}
		return num2 / num;
		static float DiffLineIntegral(Vector3 vector2, Vector3 vector)
		{
			Vector3 normalized = (vector - vector2).normalized;
			if ((double)vector2.z <= 0.0 && (double)vector.z <= 0.0)
			{
				return 0f;
			}
			if ((double)vector2.z < 0.0)
			{
				vector2 = (vector2 * vector.z - vector * vector2.z) / (vector.z - vector2.z);
			}
			if ((double)vector.z < 0.0)
			{
				vector = (-vector2 * vector.z + vector * vector2.z) / (0f - vector.z + vector2.z);
			}
			float num3 = Vector3.Dot(vector2, normalized);
			float l = Vector3.Dot(vector, normalized);
			Vector3 vector3 = vector2 - num3 * normalized;
			float magnitude = vector3.magnitude;
			return ((Fpo(magnitude, l) - Fpo(magnitude, num3)) * vector3.z + (Fwt(magnitude, l) - Fwt(magnitude, num3)) * normalized.z) / MathF.PI;
		}
		static float Fpo(float d, float l)
		{
			return l / (d * (d * d + l * l)) + Mathf.Atan(l / d) / (d * d);
		}
		static float Fwt(float d, float l)
		{
			return l * l / (d * (d * d + l * l));
		}
	}

	public static float ShapeAttenuationAreaRectangleLight(Vector3 forward, Vector3 wo)
	{
		return ShapeAttenuationDirLight(forward, wo);
	}

	public static float ShapeAttenuationAreaDiscLight(Vector3 forward, Vector3 wo)
	{
		return ShapeAttenuationDirLight(forward, wo);
	}

	public static Vector4 GetFlareData0(Vector2 screenPos, Vector2 translationScale, Vector2 rayOff0, Vector2 vLocalScreenRatio, float angleDeg, float position, float angularOffset, Vector2 positionOffset, bool autoRotate)
	{
		if (!SystemInfo.graphicsUVStartsAtTop)
		{
			angleDeg *= -1f;
			positionOffset.y *= -1f;
		}
		float num = Mathf.Cos((0f - angularOffset) * (MathF.PI / 180f));
		float num2 = Mathf.Sin((0f - angularOffset) * (MathF.PI / 180f));
		Vector2 vector = -translationScale * (screenPos + screenPos * (position - 1f));
		vector = new Vector2(num * vector.x - num2 * vector.y, num2 * vector.x + num * vector.y);
		float num3 = angleDeg;
		num3 += 180f;
		if (autoRotate)
		{
			Vector2 vector2 = vector.normalized * vLocalScreenRatio * translationScale;
			num3 += -57.29578f * Mathf.Atan2(vector2.y, vector2.x);
		}
		num3 *= MathF.PI / 180f;
		float x = Mathf.Cos(0f - num3);
		float y = Mathf.Sin(0f - num3);
		return new Vector4(x, y, positionOffset.x + rayOff0.x * translationScale.x, 0f - positionOffset.y + rayOff0.y * translationScale.y);
	}

	private static Vector2 GetLensFlareRayOffset(Vector2 screenPos, float position, float globalCos0, float globalSin0)
	{
		Vector2 vector = -(screenPos + screenPos * (position - 1f));
		return new Vector2(globalCos0 * vector.x - globalSin0 * vector.y, globalSin0 * vector.x + globalCos0 * vector.y);
	}

	private static Vector3 WorldToViewport(Camera camera, bool isLocalLight, bool isCameraRelative, Matrix4x4 viewProjMatrix, Vector3 positionWS)
	{
		if (isLocalLight)
		{
			return WorldToViewportLocal(isCameraRelative, viewProjMatrix, camera.transform.position, positionWS);
		}
		return WorldToViewportDistance(camera, positionWS);
	}

	private static Vector3 WorldToViewportLocal(bool isCameraRelative, Matrix4x4 viewProjMatrix, Vector3 cameraPosWS, Vector3 positionWS)
	{
		Vector3 vector = positionWS;
		if (isCameraRelative)
		{
			vector -= cameraPosWS;
		}
		Vector4 vector2 = viewProjMatrix * vector;
		Vector3 result = new Vector3(vector2.x, vector2.y, 0f);
		result /= vector2.w;
		result.x = result.x * 0.5f + 0.5f;
		result.y = result.y * 0.5f + 0.5f;
		result.y = 1f - result.y;
		result.z = vector2.w;
		return result;
	}

	private static Vector3 WorldToViewportDistance(Camera cam, Vector3 positionWS)
	{
		Vector4 vector = cam.worldToCameraMatrix * positionWS;
		Vector4 vector2 = cam.projectionMatrix * vector;
		Vector3 result = new Vector3(vector2.x, vector2.y, 0f);
		result /= vector2.w;
		result.x = result.x * 0.5f + 0.5f;
		result.y = result.y * 0.5f + 0.5f;
		result.z = vector2.w;
		return result;
	}

	public static void ComputeOcclusion(Material lensFlareShader, LensFlareCommonSRP lensFlares, Camera cam, float actualWidth, float actualHeight, bool usePanini, float paniniDistance, float paniniCropToFit, bool isCameraRelative, Vector3 cameraPositionWS, Matrix4x4 viewProjMatrix, CommandBuffer cmd, bool taaEnabled, int _FlareOcclusionTex, int _FlareOcclusionIndex, int _FlareTex, int _FlareColorValue, int _FlareData0, int _FlareData1, int _FlareData2, int _FlareData3, int _FlareData4)
	{
		if (lensFlares.IsEmpty() || occlusionRT == null)
		{
			return;
		}
		Vector2 vector = new Vector2(actualWidth, actualHeight);
		float x = vector.x / vector.y;
		Vector2 vLocalScreenRatio = new Vector2(x, 1f);
		CoreUtils.SetRenderTarget(cmd, occlusionRT);
		if (!taaEnabled)
		{
			cmd.ClearRenderTarget(clearDepth: false, clearColor: true, Color.black);
		}
		float num = 1f / (float)maxLensFlareWithOcclusion;
		_ = 1f / (float)(maxLensFlareWithOcclusionTemporalSample + mergeNeeded);
		float num2 = 0.5f / (float)maxLensFlareWithOcclusion;
		float y = 0.5f / (float)(maxLensFlareWithOcclusionTemporalSample + mergeNeeded);
		int num3 = (taaEnabled ? 1 : 0);
		int num4 = 0;
		foreach (LensFlareComponentSRP datum in lensFlares.GetData())
		{
			if (datum == null)
			{
				continue;
			}
			LensFlareDataSRP lensFlareData = datum.lensFlareData;
			if (!datum.enabled || !datum.gameObject.activeSelf || !datum.gameObject.activeInHierarchy || lensFlareData == null || lensFlareData.elements == null || lensFlareData.elements.Length == 0 || !datum.useOcclusion || (datum.useOcclusion && datum.sampleCount == 0) || datum.intensity <= 0f)
			{
				continue;
			}
			Light component = datum.GetComponent<Light>();
			bool flag = false;
			Vector3 vector2;
			if (component != null && component.type == LightType.Directional)
			{
				vector2 = -component.transform.forward * cam.farClipPlane;
				flag = true;
			}
			else
			{
				vector2 = datum.transform.position;
			}
			Vector3 vector3 = WorldToViewport(cam, !flag, isCameraRelative, viewProjMatrix, vector2);
			if (usePanini && cam == Camera.main)
			{
				vector3 = DoPaniniProjection(vector3, actualWidth, actualHeight, cam.fieldOfView, paniniCropToFit, paniniDistance);
			}
			if (!(vector3.z < 0f) && (datum.allowOffScreen || (!(vector3.x < 0f) && !(vector3.x > 1f) && !(vector3.y < 0f) && !(vector3.y > 1f))))
			{
				float magnitude = (vector2 - cameraPositionWS).magnitude;
				float time = magnitude / datum.maxAttenuationDistance;
				float time2 = magnitude / datum.maxAttenuationScale;
				float num5 = ((!flag && datum.distanceAttenuationCurve.length > 0) ? datum.distanceAttenuationCurve.Evaluate(time) : 1f);
				if (!flag && datum.scaleByDistanceCurve.length >= 1)
				{
					datum.scaleByDistanceCurve.Evaluate(time2);
				}
				Vector3 vector4 = ((!flag) ? (cam.transform.position - datum.transform.position).normalized : datum.transform.forward);
				Vector3 vector5 = WorldToViewport(cam, !flag, isCameraRelative, viewProjMatrix, vector2 + vector4 * datum.occlusionOffset);
				float num6 = (flag ? datum.celestialProjectedOcclusionRadius(cam) : datum.occlusionRadius);
				Vector2 vector6 = vector3;
				float magnitude2 = ((Vector2)WorldToViewport(cam, !flag, isCameraRelative, viewProjMatrix, vector2 + cam.transform.up * num6) - vector6).magnitude;
				cmd.SetGlobalVector(_FlareData1, new Vector4(magnitude2, datum.sampleCount, vector5.z, actualHeight / actualWidth));
				cmd.EnableShaderKeyword("FLARE_COMPUTE_OCCLUSION");
				Vector2 screenPos = new Vector2(2f * vector3.x - 1f, 1f - 2f * vector3.y);
				Vector2 vector7 = new Vector2(Mathf.Abs(screenPos.x), Mathf.Abs(screenPos.y));
				float time3 = Mathf.Max(vector7.x, vector7.y);
				float num7 = ((datum.radialScreenAttenuationCurve.length > 0) ? datum.radialScreenAttenuationCurve.Evaluate(time3) : 1f);
				if (!(datum.intensity * num7 * num5 <= 0f))
				{
					cmd.SetGlobalVector(_FlareOcclusionIndex, new Vector4((float)num4 * num + num2, y, 0f, frameIdx + 1));
					float globalCos = Mathf.Cos(0f);
					float globalSin = Mathf.Sin(0f);
					float position = 0f;
					float y2 = Mathf.Clamp01(0.999999f);
					cmd.SetGlobalVector(_FlareData3, new Vector4(datum.allowOffScreen ? 1f : (-1f), y2, Mathf.Exp(Mathf.Lerp(0f, 4f, 1f)), 1f / 3f));
					Vector2 lensFlareRayOffset = GetLensFlareRayOffset(screenPos, position, globalCos, globalSin);
					Vector4 flareData = GetFlareData0(screenPos, Vector2.one, lensFlareRayOffset, vLocalScreenRatio, 0f, position, 0f, Vector2.zero, autoRotate: false);
					cmd.SetGlobalVector(_FlareData0, flareData);
					cmd.SetGlobalVector(_FlareData2, new Vector4(screenPos.x, screenPos.y, 0f, 0f));
					cmd.SetViewport(new Rect
					{
						x = num4,
						y = (frameIdx + mergeNeeded) * num3,
						width = 1f,
						height = 1f
					});
					Blitter.DrawQuad(cmd, lensFlareShader, 4);
					num4++;
				}
			}
		}
		frameIdx++;
		frameIdx %= maxLensFlareWithOcclusionTemporalSample;
	}

	public static void DoLensFlareDataDrivenCommon(Material lensFlareShader, LensFlareCommonSRP lensFlares, Camera cam, float actualWidth, float actualHeight, bool usePanini, float paniniDistance, float paniniCropToFit, bool isCameraRelative, Vector3 cameraPositionWS, Matrix4x4 viewProjMatrix, CommandBuffer cmd, RenderTargetIdentifier colorBuffer, Func<Light, Camera, Vector3, float> GetLensFlareLightAttenuation, int _FlareOcclusionTex, int _FlareOcclusionIndex, int _FlareTex, int _FlareColorValue, int _FlareData0, int _FlareData1, int _FlareData2, int _FlareData3, int _FlareData4, bool debugView)
	{
		if (lensFlares.IsEmpty())
		{
			return;
		}
		Vector2 vector = new Vector2(actualWidth, actualHeight);
		float x = vector.x / vector.y;
		Vector2 vLocalScreenRatio = new Vector2(x, 1f);
		CoreUtils.SetRenderTarget(cmd, colorBuffer);
		cmd.SetViewport(new Rect
		{
			width = vector.x,
			height = vector.y
		});
		if (debugView)
		{
			cmd.ClearRenderTarget(clearDepth: false, clearColor: true, Color.black);
		}
		int num = 0;
		foreach (LensFlareComponentSRP datum in lensFlares.GetData())
		{
			if (datum == null)
			{
				continue;
			}
			LensFlareDataSRP lensFlareData = datum.lensFlareData;
			if (!datum.enabled || !datum.gameObject.activeSelf || !datum.gameObject.activeInHierarchy || lensFlareData == null || lensFlareData.elements == null || lensFlareData.elements.Length == 0 || datum.intensity <= 0f)
			{
				continue;
			}
			Light component = datum.GetComponent<Light>();
			bool flag = false;
			Vector3 vector2;
			if (component != null && component.type == LightType.Directional)
			{
				vector2 = -component.transform.forward * cam.farClipPlane;
				flag = true;
			}
			else
			{
				vector2 = datum.transform.position;
			}
			Vector3 vector3 = WorldToViewport(cam, !flag, isCameraRelative, viewProjMatrix, vector2);
			if (usePanini && cam == Camera.main)
			{
				vector3 = DoPaniniProjection(vector3, actualWidth, actualHeight, cam.fieldOfView, paniniCropToFit, paniniDistance);
			}
			if (vector3.z < 0f || (!datum.allowOffScreen && (vector3.x < 0f || vector3.x > 1f || vector3.y < 0f || vector3.y > 1f)))
			{
				continue;
			}
			Vector3 rhs = vector2 - cameraPositionWS;
			if (Vector3.Dot(cam.transform.forward, rhs) < 0f)
			{
				continue;
			}
			float magnitude = rhs.magnitude;
			float time = magnitude / datum.maxAttenuationDistance;
			float time2 = magnitude / datum.maxAttenuationScale;
			float num2 = ((!flag && datum.distanceAttenuationCurve.length > 0) ? datum.distanceAttenuationCurve.Evaluate(time) : 1f);
			float num3 = ((!flag && datum.scaleByDistanceCurve.length >= 1) ? datum.scaleByDistanceCurve.Evaluate(time2) : 1f);
			Color white = Color.white;
			if (component != null && datum.attenuationByLightShape)
			{
				white *= GetLensFlareLightAttenuation(component, cam, -rhs.normalized);
			}
			white *= num2;
			Vector3 normalized = (cam.transform.position - datum.transform.position).normalized;
			Vector3 vector4 = WorldToViewport(cam, !flag, isCameraRelative, viewProjMatrix, vector2 + normalized * datum.occlusionOffset);
			float num4 = (flag ? datum.celestialProjectedOcclusionRadius(cam) : datum.occlusionRadius);
			Vector2 vector5 = vector3;
			float magnitude2 = ((Vector2)WorldToViewport(cam, !flag, isCameraRelative, viewProjMatrix, vector2 + cam.transform.up * num4) - vector5).magnitude;
			cmd.SetGlobalVector(_FlareData1, new Vector4(magnitude2, datum.sampleCount, vector4.z, actualHeight / actualWidth));
			if (datum.useOcclusion)
			{
				cmd.EnableShaderKeyword("FLARE_OCCLUSION");
			}
			else
			{
				cmd.DisableShaderKeyword("FLARE_OCCLUSION");
			}
			if (occlusionRT != null)
			{
				cmd.SetGlobalTexture(_FlareOcclusionTex, occlusionRT);
			}
			cmd.SetGlobalVector(_FlareOcclusionIndex, new Vector4((float)num / (float)maxLensFlareWithOcclusion + 0.5f / (float)maxLensFlareWithOcclusion, 0.5f, 0f, 0f));
			if (datum.useOcclusion && datum.sampleCount != 0)
			{
				num++;
			}
			LensFlareDataElementSRP[] elements = lensFlareData.elements;
			foreach (LensFlareDataElementSRP element in elements)
			{
				if (element == null || !element.visible || (element.lensFlareTexture == null && element.flareType == SRPLensFlareType.Image) || element.localIntensity <= 0f || element.count <= 0 || element.localIntensity <= 0f)
				{
					continue;
				}
				Color color = white;
				if (component != null && element.modulateByLightColor)
				{
					if (component.useColorTemperature)
					{
						color *= component.color * Mathf.CorrelatedColorTemperatureToRGB(component.colorTemperature);
					}
					else
					{
						color *= component.color;
					}
				}
				Color color2 = color;
				Vector2 screenPos = new Vector2(2f * vector3.x - 1f, 0f - (2f * vector3.y - 1f));
				if (!SystemInfo.graphicsUVStartsAtTop & flag)
				{
					screenPos.y = 0f - screenPos.y;
				}
				Vector2 vector6 = new Vector2(Mathf.Abs(screenPos.x), Mathf.Abs(screenPos.y));
				float time3 = Mathf.Max(vector6.x, vector6.y);
				float num5 = ((datum.radialScreenAttenuationCurve.length > 0) ? datum.radialScreenAttenuationCurve.Evaluate(time3) : 1f);
				float num6 = datum.intensity * element.localIntensity * num5 * num2;
				if (num6 <= 0f)
				{
					continue;
				}
				Texture lensFlareTexture = element.lensFlareTexture;
				float usedAspectRatio;
				if (element.flareType == SRPLensFlareType.Image)
				{
					usedAspectRatio = (element.preserveAspectRatio ? ((float)lensFlareTexture.height / (float)lensFlareTexture.width) : 1f);
				}
				else
				{
					usedAspectRatio = 1f;
				}
				float rotation = element.rotation;
				Vector2 vector7 = ((!element.preserveAspectRatio) ? new Vector2(element.sizeXY.x, element.sizeXY.y) : ((!(usedAspectRatio >= 1f)) ? new Vector2(element.sizeXY.x, element.sizeXY.y * usedAspectRatio) : new Vector2(element.sizeXY.x / usedAspectRatio, element.sizeXY.y)));
				float num7 = 0.1f;
				Vector2 vector8 = new Vector2(vector7.x, vector7.y);
				float combinedScale = num3 * num7 * element.uniformScale * datum.scale;
				vector8 *= combinedScale;
				color2 *= element.tint;
				color2 *= num6;
				float num8 = (SystemInfo.graphicsUVStartsAtTop ? element.angularOffset : (0f - element.angularOffset));
				float globalCos0 = Mathf.Cos((0f - num8) * (MathF.PI / 180f));
				float globalSin0 = Mathf.Sin((0f - num8) * (MathF.PI / 180f));
				float position = 2f * element.position;
				int shaderPass = element.blendMode switch
				{
					SRPLensFlareBlendMode.Additive => 0, 
					SRPLensFlareBlendMode.Screen => 1, 
					SRPLensFlareBlendMode.Premultiply => 2, 
					SRPLensFlareBlendMode.Lerp => 3, 
					_ => 0, 
				};
				if (element.flareType == SRPLensFlareType.Image)
				{
					cmd.DisableShaderKeyword("FLARE_CIRCLE");
					cmd.DisableShaderKeyword("FLARE_POLYGON");
				}
				else if (element.flareType == SRPLensFlareType.Circle)
				{
					cmd.EnableShaderKeyword("FLARE_CIRCLE");
					cmd.DisableShaderKeyword("FLARE_POLYGON");
				}
				else if (element.flareType == SRPLensFlareType.Polygon)
				{
					cmd.DisableShaderKeyword("FLARE_CIRCLE");
					cmd.EnableShaderKeyword("FLARE_POLYGON");
				}
				if (element.flareType == SRPLensFlareType.Circle || element.flareType == SRPLensFlareType.Polygon)
				{
					if (element.inverseSDF)
					{
						cmd.EnableShaderKeyword("FLARE_INVERSE_SDF");
					}
					else
					{
						cmd.DisableShaderKeyword("FLARE_INVERSE_SDF");
					}
				}
				else
				{
					cmd.DisableShaderKeyword("FLARE_INVERSE_SDF");
				}
				if (element.lensFlareTexture != null)
				{
					cmd.SetGlobalTexture(_FlareTex, element.lensFlareTexture);
				}
				float num9 = Mathf.Clamp01(1f - element.edgeOffset - 1E-06f);
				if (element.flareType == SRPLensFlareType.Polygon)
				{
					num9 = Mathf.Pow(num9 + 1f, 5f);
				}
				float sdfRoundness = element.sdfRoundness;
				cmd.SetGlobalVector(_FlareData3, new Vector4(datum.allowOffScreen ? 1f : (-1f), num9, Mathf.Exp(Mathf.Lerp(0f, 4f, Mathf.Clamp01(1f - element.fallOff))), 1f / (float)element.sideCount));
				if (element.flareType == SRPLensFlareType.Polygon)
				{
					float num10 = 1f / (float)element.sideCount;
					float num11 = Mathf.Cos(MathF.PI * num10);
					float num12 = num11 * sdfRoundness;
					float num13 = num11 - num12;
					float num14 = MathF.PI * 2f * num10;
					float w = num13 * Mathf.Tan(0.5f * num14);
					cmd.SetGlobalVector(_FlareData4, new Vector4(sdfRoundness, num13, num14, w));
				}
				else
				{
					cmd.SetGlobalVector(_FlareData4, new Vector4(sdfRoundness, 0f, 0f, 0f));
				}
				if (!element.allowMultipleElement || element.count == 1)
				{
					Vector2 curSize = vector8;
					Vector2 lensFlareRayOffset = GetLensFlareRayOffset(screenPos, position, globalCos0, globalSin0);
					if (element.enableRadialDistortion)
					{
						Vector2 lensFlareRayOffset2 = GetLensFlareRayOffset(screenPos, 0f, globalCos0, globalSin0);
						curSize = ComputeLocalSize(lensFlareRayOffset, lensFlareRayOffset2, curSize, element.distortionCurve);
					}
					Vector4 flareData = GetFlareData0(screenPos, element.translationScale, lensFlareRayOffset, vLocalScreenRatio, rotation, position, num8, element.positionOffset, element.autoRotate);
					cmd.SetGlobalVector(_FlareData0, flareData);
					cmd.SetGlobalVector(_FlareData2, new Vector4(screenPos.x, screenPos.y, curSize.x, curSize.y));
					cmd.SetGlobalVector(_FlareColorValue, color2);
					Blitter.DrawQuad(cmd, lensFlareShader, shaderPass);
					continue;
				}
				float num15 = 2f * element.lengthSpread / (float)(element.count - 1);
				if (element.distribution == SRPLensFlareDistribution.Uniform)
				{
					float num16 = 0f;
					for (int j = 0; j < element.count; j++)
					{
						Vector2 curSize2 = vector8;
						Vector2 lensFlareRayOffset3 = GetLensFlareRayOffset(screenPos, position, globalCos0, globalSin0);
						if (element.enableRadialDistortion)
						{
							Vector2 lensFlareRayOffset4 = GetLensFlareRayOffset(screenPos, 0f, globalCos0, globalSin0);
							curSize2 = ComputeLocalSize(lensFlareRayOffset3, lensFlareRayOffset4, curSize2, element.distortionCurve);
						}
						float time4 = ((element.count >= 2) ? ((float)j / (float)(element.count - 1)) : 0.5f);
						Color color3 = element.colorGradient.Evaluate(time4);
						Vector4 flareData2 = GetFlareData0(screenPos, element.translationScale, lensFlareRayOffset3, vLocalScreenRatio, rotation + num16, position, num8, element.positionOffset, element.autoRotate);
						cmd.SetGlobalVector(_FlareData0, flareData2);
						cmd.SetGlobalVector(_FlareData2, new Vector4(screenPos.x, screenPos.y, curSize2.x, curSize2.y));
						cmd.SetGlobalVector(_FlareColorValue, color2 * color3);
						Blitter.DrawQuad(cmd, lensFlareShader, shaderPass);
						position += num15;
						num16 += element.uniformAngle;
					}
				}
				else if (element.distribution == SRPLensFlareDistribution.Random)
				{
					Random.State state = Random.state;
					Random.InitState(element.seed);
					Vector2 vector9 = new Vector2(globalSin0, globalCos0);
					vector9 *= element.positionVariation.y;
					for (int k = 0; k < element.count; k++)
					{
						float num17 = RandomRange(-1f, 1f) * element.intensityVariation + 1f;
						Vector2 lensFlareRayOffset5 = GetLensFlareRayOffset(screenPos, position, globalCos0, globalSin0);
						Vector2 vector10 = vector8;
						if (element.enableRadialDistortion)
						{
							Vector2 lensFlareRayOffset6 = GetLensFlareRayOffset(screenPos, 0f, globalCos0, globalSin0);
							vector10 = ComputeLocalSize(lensFlareRayOffset5, lensFlareRayOffset6, vector10, element.distortionCurve);
						}
						vector10 += vector10 * (element.scaleVariation * RandomRange(-1f, 1f));
						Color color4 = element.colorGradient.Evaluate(RandomRange(0f, 1f));
						Vector2 positionOffset = element.positionOffset + RandomRange(-1f, 1f) * vector9;
						float angleDeg = rotation + RandomRange(-MathF.PI, MathF.PI) * element.rotationVariation;
						if (num17 > 0f)
						{
							Vector4 flareData3 = GetFlareData0(screenPos, element.translationScale, lensFlareRayOffset5, vLocalScreenRatio, angleDeg, position, num8, positionOffset, element.autoRotate);
							cmd.SetGlobalVector(_FlareData0, flareData3);
							cmd.SetGlobalVector(_FlareData2, new Vector4(screenPos.x, screenPos.y, vector10.x, vector10.y));
							cmd.SetGlobalVector(_FlareColorValue, color2 * color4 * num17);
							Blitter.DrawQuad(cmd, lensFlareShader, shaderPass);
						}
						position += num15;
						position += 0.5f * num15 * RandomRange(-1f, 1f) * element.positionVariation.x;
					}
					Random.state = state;
				}
				else
				{
					if (element.distribution != SRPLensFlareDistribution.Curve)
					{
						continue;
					}
					for (int l = 0; l < element.count; l++)
					{
						float time5 = ((element.count >= 2) ? ((float)l / (float)(element.count - 1)) : 0.5f);
						Color color5 = element.colorGradient.Evaluate(time5);
						float num18 = ((element.positionCurve.length > 0) ? element.positionCurve.Evaluate(time5) : 1f);
						float position2 = position + 2f * element.lengthSpread * num18;
						Vector2 lensFlareRayOffset7 = GetLensFlareRayOffset(screenPos, position2, globalCos0, globalSin0);
						Vector2 curSize3 = vector8;
						if (element.enableRadialDistortion)
						{
							Vector2 lensFlareRayOffset8 = GetLensFlareRayOffset(screenPos, 0f, globalCos0, globalSin0);
							curSize3 = ComputeLocalSize(lensFlareRayOffset7, lensFlareRayOffset8, curSize3, element.distortionCurve);
						}
						float num19 = ((element.scaleCurve.length > 0) ? element.scaleCurve.Evaluate(time5) : 1f);
						curSize3 *= num19;
						float num20 = element.uniformAngleCurve.Evaluate(time5) * (180f - 180f / (float)element.count);
						Vector4 flareData4 = GetFlareData0(screenPos, element.translationScale, lensFlareRayOffset7, vLocalScreenRatio, rotation + num20, position2, num8, element.positionOffset, element.autoRotate);
						cmd.SetGlobalVector(_FlareData0, flareData4);
						cmd.SetGlobalVector(_FlareData2, new Vector4(screenPos.x, screenPos.y, curSize3.x, curSize3.y));
						cmd.SetGlobalVector(_FlareColorValue, color2 * color5);
						Blitter.DrawQuad(cmd, lensFlareShader, shaderPass);
					}
				}
				Vector2 ComputeLocalSize(Vector2 rayOff, Vector2 rayOff0, Vector2 vector12, AnimationCurve distortionCurve)
				{
					GetLensFlareRayOffset(screenPos, position, globalCos0, globalSin0);
					float time6;
					if (!element.distortionRelativeToCenter)
					{
						Vector2 vector11 = (rayOff - rayOff0) * 0.5f;
						time6 = Mathf.Clamp01(Mathf.Max(Mathf.Abs(vector11.x), Mathf.Abs(vector11.y)));
					}
					else
					{
						time6 = Mathf.Clamp01((screenPos + (rayOff + new Vector2(element.positionOffset.x, 0f - element.positionOffset.y)) * element.translationScale).magnitude);
					}
					float t = Mathf.Clamp01(distortionCurve.Evaluate(time6));
					return new Vector2(Mathf.Lerp(vector12.x, element.targetSizeDistortion.x * combinedScale / usedAspectRatio, t), Mathf.Lerp(vector12.y, element.targetSizeDistortion.y * combinedScale, t));
				}
			}
		}
		static float RandomRange(float min, float max)
		{
			return Random.Range(min, max);
		}
	}

	public void RemoveData(LensFlareComponentSRP data)
	{
		if (m_Data.Contains(data))
		{
			m_Data.Remove(data);
		}
	}

	private static Vector2 DoPaniniProjection(Vector2 screenPos, float actualWidth, float actualHeight, float fieldOfView, float paniniProjectionCropToFit, float paniniProjectionDistance)
	{
		Vector2 vector = CalcViewExtents(actualWidth, actualHeight, fieldOfView);
		Vector2 vector2 = CalcCropExtents(actualWidth, actualHeight, fieldOfView, paniniProjectionDistance);
		float a = vector2.x / vector.x;
		float b = vector2.y / vector.y;
		float value = Mathf.Min(a, b);
		float num = Mathf.Lerp(1f, Mathf.Clamp01(value), paniniProjectionCropToFit);
		Vector2 vector3 = Panini_Generic_Inv(new Vector2(2f * screenPos.x - 1f, 2f * screenPos.y - 1f) * vector, paniniProjectionDistance) / (vector * num);
		return new Vector2(0.5f * vector3.x + 0.5f, 0.5f * vector3.y + 0.5f);
	}

	private static Vector2 CalcViewExtents(float actualWidth, float actualHeight, float fieldOfView)
	{
		float num = fieldOfView * (MathF.PI / 180f);
		float num2 = actualWidth / actualHeight;
		float num3 = Mathf.Tan(0.5f * num);
		return new Vector2(num2 * num3, num3);
	}

	private static Vector2 CalcCropExtents(float actualWidth, float actualHeight, float fieldOfView, float d)
	{
		float num = 1f + d;
		Vector2 vector = CalcViewExtents(actualWidth, actualHeight, fieldOfView);
		float num2 = Mathf.Sqrt(vector.x * vector.x + 1f);
		float num3 = 1f / num2;
		float num4 = num3 + d;
		return vector * num3 * (num / num4);
	}

	private static Vector2 Panini_Generic_Inv(Vector2 projPos, float d)
	{
		float num = 1f + d;
		float num2 = Mathf.Sqrt(projPos.x * projPos.x + 1f);
		float num3 = 1f / num2;
		float num4 = num3 + d;
		return projPos * num3 * (num / num4);
	}
}
