using System;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering.Universal.Internal;

namespace UnityEngine.Rendering.Universal;

public static class ShadowUtils
{
	private static readonly Matrix4x4 textureScaleAndBias;

	public static RenderTextureDescriptor shadowTexDes;

	static ShadowUtils()
	{
		textureScaleAndBias = Matrix4x4.identity;
		textureScaleAndBias.m00 = 0.5f;
		textureScaleAndBias.m11 = 0.5f;
		if (RenderingUtils.UsesReversedZBuffer)
		{
			textureScaleAndBias.m22 = -0.5f;
		}
		else
		{
			textureScaleAndBias.m22 = 0.5f;
		}
		textureScaleAndBias.m03 = 0.5f;
		textureScaleAndBias.m13 = 0.5f;
		textureScaleAndBias.m23 = 0.5f;
		GraphicsFormat depthStencilFormat = GraphicsFormatUtility.GetDepthStencilFormat(16, 0);
		shadowTexDes = new RenderTextureDescriptor(1, 1, GraphicsFormat.None, depthStencilFormat)
		{
			shadowSamplingMode = ShadowSamplingMode.CompareDepths
		};
	}

	public static bool ExtractDirectionalLightMatrix(ref CullingResults cullResults, ref ShadowData shadowData, int shadowLightIndex, int cascadeIndex, int shadowmapWidth, int shadowmapHeight, int shadowResolution, float shadowNearPlane, out Vector4 cascadeSplitDistance, out ShadowSliceData shadowSliceData, out Matrix4x4 viewMatrix, out Matrix4x4 projMatrix)
	{
		bool result = ExtractDirectionalLightMatrix(ref cullResults, ref shadowData, shadowLightIndex, cascadeIndex, shadowmapWidth, shadowmapHeight, shadowResolution, shadowNearPlane, out cascadeSplitDistance, out shadowSliceData);
		viewMatrix = shadowSliceData.viewMatrix;
		projMatrix = shadowSliceData.projectionMatrix;
		return result;
	}

	public static bool ExtractDirectionalLightMatrix(ref CullingResults cullResults, ref ShadowData shadowData, int shadowLightIndex, int cascadeIndex, int shadowmapWidth, int shadowmapHeight, int shadowResolution, float shadowNearPlane, out Vector4 cascadeSplitDistance, out ShadowSliceData shadowSliceData)
	{
		bool result = cullResults.ComputeDirectionalShadowMatricesAndCullingPrimitives(shadowLightIndex, cascadeIndex, shadowData.mainLightShadowCascadesCount, shadowData.mainLightShadowCascadesSplit, shadowResolution, shadowNearPlane, out shadowSliceData.viewMatrix, out shadowSliceData.projectionMatrix, out shadowSliceData.splitData);
		cascadeSplitDistance = shadowSliceData.splitData.cullingSphere;
		shadowSliceData.offsetX = cascadeIndex % 2 * shadowResolution;
		shadowSliceData.offsetY = cascadeIndex / 2 * shadowResolution;
		shadowSliceData.resolution = shadowResolution;
		shadowSliceData.shadowTransform = GetShadowTransform(shadowSliceData.projectionMatrix, shadowSliceData.viewMatrix);
		shadowSliceData.splitData.shadowCascadeBlendCullingFactor = 1f;
		if (shadowData.mainLightShadowCascadesCount > 1)
		{
			ApplySliceTransform(ref shadowSliceData, shadowmapWidth, shadowmapHeight);
		}
		return result;
	}

	public static bool ExtractSpotLightMatrix(ref CullingResults cullResults, ref ShadowData shadowData, int shadowLightIndex, out Matrix4x4 shadowMatrix, out Matrix4x4 viewMatrix, out Matrix4x4 projMatrix, out ShadowSplitData splitData)
	{
		bool result = cullResults.ComputeSpotShadowMatricesAndCullingPrimitives(shadowLightIndex, out viewMatrix, out projMatrix, out splitData);
		shadowMatrix = GetShadowTransform(projMatrix, viewMatrix);
		return result;
	}

	public static bool ExtractPointLightMatrix(ref CullingResults cullResults, ref ShadowData shadowData, int shadowLightIndex, CubemapFace cubemapFace, float fovBias, out Matrix4x4 shadowMatrix, out Matrix4x4 viewMatrix, out Matrix4x4 projMatrix, out ShadowSplitData splitData)
	{
		bool result = cullResults.ComputePointShadowMatricesAndCullingPrimitives(shadowLightIndex, cubemapFace, fovBias, out viewMatrix, out projMatrix, out splitData);
		viewMatrix.m10 = 0f - viewMatrix.m10;
		viewMatrix.m11 = 0f - viewMatrix.m11;
		viewMatrix.m12 = 0f - viewMatrix.m12;
		viewMatrix.m13 = 0f - viewMatrix.m13;
		shadowMatrix = GetShadowTransform(projMatrix, viewMatrix);
		return result;
	}

	public static void RenderShadowSlice(CommandBuffer cmd, ref ScriptableRenderContext context, ref ShadowSliceData shadowSliceData, ref ShadowDrawingSettings settings, Matrix4x4 proj, Matrix4x4 view, float depthBias, float slopeBias)
	{
		cmd.SetGlobalDepthBias(depthBias, slopeBias);
		cmd.SetViewport(new Rect(shadowSliceData.offsetX, shadowSliceData.offsetY, shadowSliceData.resolution, shadowSliceData.resolution));
		cmd.SetViewProjectionMatrices(view, proj);
		context.ExecuteCommandBuffer(cmd);
		cmd.Clear();
		context.DrawShadows(ref settings);
		cmd.DisableScissorRect();
		context.ExecuteCommandBuffer(cmd);
		cmd.Clear();
		cmd.SetGlobalDepthBias(0f, 0f);
	}

	public static void RenderShadowSlice(CommandBuffer cmd, ref ScriptableRenderContext context, ref ShadowSliceData shadowSliceData, ref ShadowDrawingSettings settings, float depthBias, float slopeBias)
	{
		RenderShadowSlice(cmd, ref context, ref shadowSliceData, ref settings, shadowSliceData.projectionMatrix, shadowSliceData.viewMatrix, depthBias, slopeBias);
	}

	public static int GetMaxTileResolutionInAtlas(int atlasWidth, int atlasHeight, int tileCount)
	{
		int num = Mathf.Min(atlasWidth, atlasHeight);
		for (int num2 = atlasWidth / num * atlasHeight / num; num2 < tileCount; num2 = atlasWidth / num * atlasHeight / num)
		{
			num >>= 1;
		}
		return num;
	}

	public static void ApplySliceTransform(ref ShadowSliceData shadowSliceData, int atlasWidth, int atlasHeight)
	{
		Matrix4x4 identity = Matrix4x4.identity;
		float num = 1f / (float)atlasWidth;
		float num2 = 1f / (float)atlasHeight;
		identity.m00 = (float)shadowSliceData.resolution * num;
		identity.m11 = (float)shadowSliceData.resolution * num2;
		identity.m03 = (float)shadowSliceData.offsetX * num;
		identity.m13 = (float)shadowSliceData.offsetY * num2;
		shadowSliceData.shadowTransform = identity * shadowSliceData.shadowTransform;
	}

	public static float GetPunctualReceiverNormalBias(ref VisibleLight shadowLight, int shadowResolution, float authoredNormalBias)
	{
		float num;
		if (shadowLight.lightType == LightType.Spot)
		{
			num = Mathf.Tan(shadowLight.spotAngle * 0.5f * (MathF.PI / 180f)) * shadowLight.range;
		}
		else
		{
			if (shadowLight.lightType != LightType.Point)
			{
				return 0f;
			}
			num = shadowLight.range;
		}
		float num2 = num / (float)Mathf.Max(1, shadowResolution);
		return authoredNormalBias * num2 * 5f;
	}

	internal static void GetScaleAndBiasForLinearDistanceFade(float fadeDistance, float border, out float scale, out float bias)
	{
		if (border < 0.0001f)
		{
			bias = (0f - fadeDistance) * (scale = 1000f);
			return;
		}
		border = 1f - border;
		border *= border;
		float num = border * fadeDistance;
		scale = 1f / (fadeDistance - num);
		bias = (0f - num) / (fadeDistance - num);
	}

	public static void SetupLightConstantBuffer(CommandBuffer cmd, ref VisibleLight shadowLight)
	{
		Vector3 vector = -shadowLight.localToWorldMatrix.GetColumn(2);
		cmd.SetGlobalVector(DeferredLights.ShaderConstants._LightDirection, new Vector4(vector.x, vector.y, vector.z, 0f));
		Vector3 vector2 = shadowLight.localToWorldMatrix.GetColumn(3);
		cmd.SetGlobalVector(DeferredLights.ShaderConstants._LightPosition, new Vector4(vector2.x, vector2.y, vector2.z, 1f));
	}

	public static void SetupShadowCasterConstantBuffer(CommandBuffer cmd, ref VisibleLight shadowLight, Vector4 shadowBias)
	{
		cmd.SetGlobalVector(DeferredLights.ShaderConstants._ShadowBias, shadowBias);
		SetupLightConstantBuffer(cmd, ref shadowLight);
	}

	public static RenderTexture GetTemporaryShadowTexture(int width, int height, int bits)
	{
		GraphicsFormat depthStencilFormat = GraphicsFormatUtility.GetDepthStencilFormat(bits, 0);
		RenderTextureDescriptor desc = new RenderTextureDescriptor(width, height, GraphicsFormat.None, depthStencilFormat);
		desc.shadowSamplingMode = ShadowSamplingMode.CompareDepths;
		RenderTexture temporary = RenderTexture.GetTemporary(desc);
		temporary.filterMode = FilterMode.Bilinear;
		temporary.wrapMode = TextureWrapMode.Clamp;
		return temporary;
	}

	public static void GetRT(CommandBuffer cmd, int width, int height, int id)
	{
		shadowTexDes.width = width;
		shadowTexDes.height = height;
		cmd.GetTemporaryRT(id, shadowTexDes, FilterMode.Bilinear);
	}

	internal static Matrix4x4 GetShadowTransform(Matrix4x4 proj, Matrix4x4 view)
	{
		Matrix4x4 matrix4x = proj * view;
		return textureScaleAndBias * matrix4x;
	}
}
