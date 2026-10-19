namespace UnityEngine.Rendering.Universal;

public class HDCharShadowPass : ScriptableRenderPass
{
	public enum HDShadowQuality
	{
		None,
		Low,
		High
	}

	private static class ShaderConstants
	{
		internal static readonly int HDWorldToShadow = Shader.PropertyToID("_HDCharShadowWorldToShadow");

		internal static readonly int HDCharShadowCount = Shader.PropertyToID("_HDCharShadowCount");

		internal static readonly int HDCharShadowValidMask = Shader.PropertyToID("_HDCharShadowValidMask");

		internal static readonly int HDCharShadowAtlasRect = Shader.PropertyToID("_HDCharShadowAtlasRect");

		internal static readonly int HDCharShadowParams = Shader.PropertyToID("_HDCharShadowParams");

		internal static readonly int HDCharShadowLightDirection = Shader.PropertyToID("_HDCharShadowLightDirection");

		internal static readonly int HDCharShadowMap = Shader.PropertyToID("_HDCharShadowMap");

		internal static readonly int HDCharShadowMapSize = Shader.PropertyToID("_HDCharShadowMapSize");

		internal static readonly int ShadowBias = Shader.PropertyToID("_ShadowBias");

		internal static readonly int LightDirection = Shader.PropertyToID("_LightDirection");
	}

	private const int k_SlotCount = 4;

	private const float k_MinProjectionExtent = 0.01f;

	private const float k_MinDepthRange = 0.02f;

	private const float k_ShadowNearPlane = 0.01f;

	private const float k_CharacterCenterHeight = 1f;

	private const float k_MaxRendererDistanceFromCharacterCenter = 2f;

	private const float k_MaxRendererDistanceFromCharacterCenterSqr = 4f;

	private const int k_FrustumPlaneCount = 6;

	private const int k_BoundsCornerCount = 8;

	private const int k_BoundsFaceCount = 6;

	private const int k_BoundsFaceCornerCount = 4;

	private const int k_MaxClippedFaceVertices = 16;

	private const float k_FrustumClipEpsilon = 0.0001f;

	private static readonly ShaderTagId s_ShadowCasterShaderTag = new ShaderTagId("ShadowCaster");

	private static readonly int[] s_BoundsFaceCorners = new int[24]
	{
		0, 4, 6, 2, 1, 3, 7, 5, 0, 1,
		5, 4, 2, 6, 7, 3, 0, 2, 3, 1,
		4, 5, 7, 6
	};

	private readonly Matrix4x4[] m_WorldToShadowMatrices = new Matrix4x4[4];

	private readonly Matrix4x4[] m_ViewMatrices = new Matrix4x4[4];

	private readonly Matrix4x4[] m_ProjectionMatrices = new Matrix4x4[4];

	private readonly Vector4[] m_AtlasRects = new Vector4[4];

	private readonly Vector4[] m_ShadowParams = new Vector4[4];

	private readonly Vector4[] m_LightDirections = new Vector4[4];

	private readonly int[] m_RendererCullingMasks = new int[4];

	private readonly bool[] m_ValidSlots = new bool[4];

	private readonly Plane[] m_CameraFrustumPlanes = new Plane[6];

	private readonly Vector3[] m_CameraFrustumCornersWS = new Vector3[8];

	private readonly Vector3[] m_BoundsCornersWS = new Vector3[8];

	private readonly Vector3[] m_ClippedFaceVerticesA = new Vector3[16];

	private readonly Vector3[] m_ClippedFaceVerticesB = new Vector3[16];

	private HDShadowQuality m_ShadowQuality;

	private float m_BoundsPadding;

	private float m_DepthBiasInTexels;

	private float m_NormalBiasInTexels;

	private float m_CasterDepthBias;

	private float m_CasterSlopeBias;

	private bool m_EnableTexelSnapping;

	private int m_ValidMask;

	private int m_ValidCount;

	private Camera m_CameraFrustumSource;

	private bool m_CameraFrustumCornersPrepared;

	private RenderTargetHandle m_ShadowMapHandle;

	private bool m_ShadowMapAllocatedThisFrame;

	public static RenderTargetIdentifier s_ShadowMapID;

	public HDCharShadowPass()
	{
		profilingSampler = new ProfilingSampler("HDCharShadowPass");
		renderPassEvent = RenderPassEvent.HDCharShadowPass;
		m_ShadowMapHandle.Init("_HDCharShadowMap");
		s_ShadowMapID = m_ShadowMapHandle.Identifier();
		ConfigureTarget(s_ShadowMapID, ShadowUtils.shadowTexDes.depthStencilFormat, depth: true);
		ConfigureDepthAttachment(RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store, ClearFlag.Depth, Color.black);
		for (int i = 0; i < 4; i++)
		{
			m_AtlasRects[i] = new Vector4((float)i * 0.25f, 0f, 0.25f, 1f);
		}
	}

	public bool Setup(CommandBuffer cmd, ref RenderingData renderingData, HDShadowQuality shadowQuality, float boundsPadding, float depthBiasInTexels, float normalBiasInTexels, float casterDepthBias, float casterSlopeBias, float projectionSizeStep, bool enableTexelSnapping)
	{
		m_ShadowQuality = shadowQuality;
		m_BoundsPadding = Mathf.Max(0f, boundsPadding);
		m_DepthBiasInTexels = Mathf.Max(0f, depthBiasInTexels);
		m_NormalBiasInTexels = Mathf.Max(0f, normalBiasInTexels);
		m_CasterDepthBias = Mathf.Max(0f, casterDepthBias);
		m_CasterSlopeBias = Mathf.Max(0f, casterSlopeBias);
		m_EnableTexelSnapping = enableTexelSnapping;
		m_ValidMask = 0;
		m_ValidCount = 0;
		m_ShadowMapAllocatedThisFrame = false;
		if (m_ShadowQuality == HDShadowQuality.None)
		{
			return false;
		}
		Light light = null;
		int mainLightIndex = renderingData.lightData.mainLightIndex;
		if (mainLightIndex >= 0)
		{
			VisibleLight visibleLight = renderingData.lightData.visibleLights[mainLightIndex];
			if (visibleLight.lightType == LightType.Directional)
			{
				light = visibleLight.light;
			}
		}
		Camera camera = renderingData.cameraData.camera;
		if (camera == null)
		{
			return false;
		}
		PrepareCameraFrustum(camera);
		int tileSize = GetTileSize(m_ShadowQuality);
		for (int i = 0; i < 4; i++)
		{
			m_ValidSlots[i] = false;
			m_WorldToShadowMatrices[i] = Matrix4x4.identity;
			m_ShadowParams[i] = Vector4.zero;
			m_LightDirections[i] = Vector4.zero;
			m_RendererCullingMasks[i] = 0;
			HDShadow.HDTarget target = HDShadow.GetTarget(i);
			if (target == null)
			{
				continue;
			}
			bool useCustomLightRotation = target.useCustomLightRotation;
			if (useCustomLightRotation || !(light == null))
			{
				Quaternion quaternion = (useCustomLightRotation ? target.mainLightRotation : light.transform.rotation);
				int cullingMask = camera.cullingMask;
				if (TryBuildShadowMatrices(target, quaternion, cullingMask, tileSize, out var viewMatrix, out var projectionMatrix, out var worldToShadow, out var worldUnitsPerTexel))
				{
					m_ValidSlots[i] = true;
					m_ViewMatrices[i] = viewMatrix;
					m_ProjectionMatrices[i] = projectionMatrix;
					m_WorldToShadowMatrices[i] = worldToShadow;
					m_ShadowParams[i] = new Vector4(m_DepthBiasInTexels * worldUnitsPerTexel, m_NormalBiasInTexels * worldUnitsPerTexel, 0f, 0f);
					Vector3 vector = quaternion * Vector3.forward;
					m_LightDirections[i] = new Vector4(vector.x, vector.y, vector.z, 0f);
					m_RendererCullingMasks[i] = cullingMask;
					m_ValidMask |= 1 << i;
					m_ValidCount++;
				}
			}
		}
		if (m_ValidCount == 0)
		{
			return false;
		}
		RenderTextureDescriptor shadowTexDes = ShadowUtils.shadowTexDes;
		shadowTexDes.width = tileSize * 4;
		shadowTexDes.height = tileSize;
		shadowTexDes.msaaSamples = 1;
		shadowTexDes.useMipMap = false;
		shadowTexDes.autoGenerateMips = false;
		cmd.GetTemporaryRT(m_ShadowMapHandle.id, shadowTexDes, FilterMode.Bilinear);
		m_ShadowMapAllocatedThisFrame = true;
		return true;
	}

	public void setHDShadowQuality(HDShadowQuality shadowQuality)
	{
		m_ShadowQuality = shadowQuality;
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		CommandBuffer cmd = renderingData.cmd;
		using (new ProfilingScope(cmd, profilingSampler))
		{
			ExecutePass(ref context, ref renderingData, cmd);
		}
	}

	private void ExecutePass(ref ScriptableRenderContext context, ref RenderingData renderingData, CommandBuffer cmd)
	{
		cmd.SetGlobalInteger(ShaderConstants.HDCharShadowCount, 0);
		cmd.SetGlobalInteger(ShaderConstants.HDCharShadowValidMask, 0);
		if (m_ShadowQuality == HDShadowQuality.None)
		{
			return;
		}
		int tileSize = GetTileSize(m_ShadowQuality);
		if (m_ValidCount == 0)
		{
			return;
		}
		int num = tileSize * 4;
		DrawingSettings drawingSettings = CreateDrawingSettings(s_ShadowCasterShaderTag, ref renderingData, SortingCriteria.None);
		cmd.SetGlobalDepthBias(m_CasterDepthBias, m_CasterSlopeBias);
		for (int i = 0; i < 4; i++)
		{
			if (m_ValidSlots[i])
			{
				Matrix4x4 proj = m_ProjectionMatrices[i];
				cmd.SetViewport(new Rect(i * tileSize, 0f, tileSize, tileSize));
				cmd.SetViewProjectionMatrices(m_ViewMatrices[i], proj);
				Vector4 vector = m_LightDirections[i];
				cmd.SetGlobalVector(ShaderConstants.LightDirection, new Vector4(0f - vector.x, 0f - vector.y, 0f - vector.z, 0f));
				cmd.SetGlobalVector(ShaderConstants.ShadowBias, Vector4.zero);
				context.ExecuteCommandBuffer(cmd);
				cmd.Clear();
				uint renderingLayerMask = (uint)(1 << 8 + i);
				FilteringSettings filteringSettings = new FilteringSettings(RenderQueueRange.all, m_RendererCullingMasks[i], renderingLayerMask);
				context.DrawRenderers(renderingData.cullResults, ref drawingSettings, ref filteringSettings);
			}
		}
		cmd.SetGlobalDepthBias(0f, 0f);
		cmd.SetGlobalTexture(ShaderConstants.HDCharShadowMap, m_ShadowMapHandle.id);
		cmd.SetGlobalInteger(ShaderConstants.HDCharShadowCount, m_ValidCount);
		cmd.SetGlobalInteger(ShaderConstants.HDCharShadowValidMask, m_ValidMask);
		cmd.SetGlobalMatrixArray(ShaderConstants.HDWorldToShadow, m_WorldToShadowMatrices);
		cmd.SetGlobalVectorArray(ShaderConstants.HDCharShadowAtlasRect, m_AtlasRects);
		cmd.SetGlobalVectorArray(ShaderConstants.HDCharShadowParams, m_ShadowParams);
		cmd.SetGlobalVectorArray(ShaderConstants.HDCharShadowLightDirection, m_LightDirections);
		cmd.SetGlobalVector(ShaderConstants.HDCharShadowMapSize, new Vector4(1f / (float)num, 1f / (float)tileSize, num, tileSize));
		cmd.SetViewport(renderingData.cameraData.pixelRect);
		cmd.SetViewProjectionMatrices(renderingData.cameraData.GetViewMatrix(), renderingData.cameraData.GetProjectionMatrix());
	}

	public override void OnCameraCleanup(CommandBuffer cmd)
	{
		if (m_ShadowMapAllocatedThisFrame)
		{
			cmd.ReleaseTemporaryRT(m_ShadowMapHandle.id);
			m_ShadowMapAllocatedThisFrame = false;
		}
	}

	private static int GetTileSize(HDShadowQuality quality)
	{
		return quality switch
		{
			HDShadowQuality.Low => 1024, 
			HDShadowQuality.High => 2048, 
			_ => 0, 
		};
	}

	private bool TryBuildShadowMatrices(HDShadow.HDTarget target, Quaternion lightRotation, int rendererCullingMask, int tileSize, out Matrix4x4 viewMatrix, out Matrix4x4 projectionMatrix, out Matrix4x4 worldToShadow, out float worldUnitsPerTexel)
	{
		viewMatrix = Matrix4x4.identity;
		projectionMatrix = Matrix4x4.identity;
		worldToShadow = Matrix4x4.identity;
		worldUnitsPerTexel = 0f;
		Matrix4x4 matrix4x = Matrix4x4.Rotate(Quaternion.Inverse(lightRotation));
		float minX = float.MaxValue;
		float minY = float.MaxValue;
		float maxX = float.MinValue;
		float maxY = float.MinValue;
		bool flag = false;
		Renderer[] renderers = target.renderers;
		if (!PrepareRendererBounds(target, rendererCullingMask))
		{
			return false;
		}
		for (int i = 0; i < renderers.Length; i++)
		{
			if (target.validRendererScratch[i])
			{
				Bounds bounds = target.worldBoundsScratch[i];
				if (GeometryUtility.TestPlanesAABB(m_CameraFrustumPlanes, bounds))
				{
					flag |= AccumulateVisibleLightBounds(target.localBoundsScratch[i], target.localToWorldScratch[i], bounds, matrix4x, ref minX, ref minY, ref maxX, ref maxY);
				}
			}
		}
		if (!flag)
		{
			return false;
		}
		float num = 0.5f * (1f + m_BoundsPadding);
		float num2 = Mathf.Max(Mathf.Max(maxX - minX, maxY - minY) * num, 0.01f);
		if (tileSize > 6)
		{
			num2 /= 1f - 6f / (float)tileSize;
		}
		worldUnitsPerTexel = num2 * 2f / (float)tileSize;
		float num3 = (minX + maxX) * 0.5f;
		float num4 = (minY + maxY) * 0.5f;
		if (m_EnableTexelSnapping)
		{
			num3 = Mathf.Round(num3 / worldUnitsPerTexel) * worldUnitsPerTexel;
			num4 = Mathf.Round(num4 / worldUnitsPerTexel) * worldUnitsPerTexel;
		}
		float num5 = num3 - num2;
		float num6 = num4 - num2;
		float num7 = num3 + num2;
		float num8 = num4 + num2;
		float num9 = float.MaxValue;
		float num10 = float.MinValue;
		bool flag2 = false;
		for (int j = 0; j < renderers.Length; j++)
		{
			if (target.validRendererScratch[j])
			{
				Matrix4x4 localToTarget = matrix4x * target.localToWorldScratch[j];
				GetTransformedBoundsAabb(target.localBoundsScratch[j], localToTarget, out var min, out var max);
				if (!(max.x < num5) && !(min.x > num7) && !(max.y < num6) && !(min.y > num8))
				{
					num9 = Mathf.Min(num9, min.z);
					num10 = Mathf.Max(num10, max.z);
					flag2 = true;
				}
			}
		}
		if (!flag2)
		{
			return false;
		}
		Vector3 vector = new Vector3(num3, num4, num9 - 0.01f);
		Vector3 pos = lightRotation * vector;
		viewMatrix = Matrix4x4.Scale(new Vector3(1f, 1f, -1f)) * Matrix4x4.TRS(pos, lightRotation, Vector3.one).inverse;
		float zFar = Mathf.Max(num10 - num9 + 0.02f, 0.02f);
		projectionMatrix = Matrix4x4.Ortho(0f - num2, num2, 0f - num2, num2, 0.01f, zFar);
		worldToShadow = ShadowUtils.GetShadowTransform(projectionMatrix, viewMatrix);
		return true;
	}

	private static bool PrepareRendererBounds(HDShadow.HDTarget target, int rendererCullingMask)
	{
		Transform ownerTransform = target.ownerTransform;
		if (ownerTransform == null)
		{
			return false;
		}
		Vector3 vector = ownerTransform.position + ownerTransform.up * 1f;
		Renderer[] renderers = target.renderers;
		bool result = false;
		for (int i = 0; i < renderers.Length; i++)
		{
			target.validRendererScratch[i] = false;
			Renderer renderer = renderers[i];
			if (!IsShadowCasterRenderer(renderer, rendererCullingMask))
			{
				continue;
			}
			Bounds localBounds = renderer.localBounds;
			if (IsUsableBounds(localBounds))
			{
				Matrix4x4 localToWorldMatrix = renderer.localToWorldMatrix;
				GetTransformedBoundsAabb(localBounds, localToWorldMatrix, out var min, out var max);
				Bounds bounds = new Bounds((min + max) * 0.5f, max - min);
				if (IsUsableBounds(bounds) && !((bounds.ClosestPoint(vector) - vector).sqrMagnitude > 4f))
				{
					target.validRendererScratch[i] = true;
					target.localBoundsScratch[i] = localBounds;
					target.localToWorldScratch[i] = localToWorldMatrix;
					target.worldBoundsScratch[i] = bounds;
					result = true;
				}
			}
		}
		return result;
	}

	private void PrepareCameraFrustum(Camera camera)
	{
		GeometryUtility.CalculateFrustumPlanes(camera, m_CameraFrustumPlanes);
		m_CameraFrustumSource = camera;
		m_CameraFrustumCornersPrepared = false;
	}

	private void PrepareCameraFrustumCorners()
	{
		if (!m_CameraFrustumCornersPrepared)
		{
			Camera cameraFrustumSource = m_CameraFrustumSource;
			float nearClipPlane = cameraFrustumSource.nearClipPlane;
			float farClipPlane = cameraFrustumSource.farClipPlane;
			for (int i = 0; i < 8; i++)
			{
				m_CameraFrustumCornersWS[i] = cameraFrustumSource.ViewportToWorldPoint(new Vector3(((i & 1) == 0) ? 0f : 1f, ((i & 2) == 0) ? 0f : 1f, ((i & 4) == 0) ? nearClipPlane : farClipPlane));
			}
			m_CameraFrustumCornersPrepared = true;
		}
	}

	private bool AccumulateVisibleLightBounds(Bounds localBounds, Matrix4x4 rendererLocalToWorld, Bounds worldBounds, Matrix4x4 worldToLightRotation, ref float minX, ref float minY, ref float maxX, ref float maxY)
	{
		BuildBoundsCorners(localBounds, rendererLocalToWorld);
		bool result = false;
		bool flag = true;
		for (int i = 0; i < 8; i++)
		{
			Vector3 point = m_BoundsCornersWS[i];
			for (int j = 0; j < 6; j++)
			{
				if (!(m_CameraFrustumPlanes[j].GetDistanceToPoint(point) >= -0.0001f))
				{
					flag = false;
					break;
				}
			}
			if (!flag)
			{
				break;
			}
		}
		if (flag)
		{
			for (int k = 0; k < 8; k++)
			{
				AccumulateLightSpaceXY(m_BoundsCornersWS[k], worldToLightRotation, ref minX, ref minY, ref maxX, ref maxY);
			}
			return true;
		}
		for (int l = 0; l < 6; l++)
		{
			int num = l * 4;
			for (int m = 0; m < 4; m++)
			{
				m_ClippedFaceVerticesA[m] = m_BoundsCornersWS[s_BoundsFaceCorners[num + m]];
			}
			Vector3[] array = m_ClippedFaceVerticesA;
			Vector3[] array2 = m_ClippedFaceVerticesB;
			int num2 = 4;
			for (int n = 0; n < 6; n++)
			{
				if (num2 <= 0)
				{
					break;
				}
				num2 = ClipPolygonAgainstPlane(array, num2, m_CameraFrustumPlanes[n], array2);
				Vector3[] array3 = array;
				array = array2;
				array2 = array3;
			}
			for (int num3 = 0; num3 < num2; num3++)
			{
				AccumulateLightSpaceXY(array[num3], worldToLightRotation, ref minX, ref minY, ref maxX, ref maxY);
				result = true;
			}
		}
		PrepareCameraFrustumCorners();
		bool flag2 = false;
		for (int num4 = 0; num4 < 8; num4++)
		{
			if (ContainsPoint(worldBounds, m_CameraFrustumCornersWS[num4]))
			{
				flag2 = true;
				break;
			}
		}
		if (flag2 && Mathf.Abs(rendererLocalToWorld.determinant) > 1E-07f)
		{
			Matrix4x4 inverse = rendererLocalToWorld.inverse;
			for (int num5 = 0; num5 < 8; num5++)
			{
				Vector3 vector = m_CameraFrustumCornersWS[num5];
				if (ContainsPoint(worldBounds, vector))
				{
					Vector3 point2 = inverse.MultiplyPoint3x4(vector);
					if (ContainsPoint(localBounds, point2))
					{
						AccumulateLightSpaceXY(vector, worldToLightRotation, ref minX, ref minY, ref maxX, ref maxY);
						result = true;
					}
				}
			}
		}
		return result;
	}

	private void BuildBoundsCorners(Bounds localBounds, Matrix4x4 rendererLocalToWorld)
	{
		Vector3 center = localBounds.center;
		Vector3 extents = localBounds.extents;
		for (int i = 0; i < 8; i++)
		{
			Vector3 point = center + new Vector3(((i & 1) == 0) ? (0f - extents.x) : extents.x, ((i & 2) == 0) ? (0f - extents.y) : extents.y, ((i & 4) == 0) ? (0f - extents.z) : extents.z);
			m_BoundsCornersWS[i] = rendererLocalToWorld.MultiplyPoint3x4(point);
		}
	}

	private static int ClipPolygonAgainstPlane(Vector3[] input, int inputCount, Plane plane, Vector3[] output)
	{
		int result = 0;
		Vector3 vector = input[inputCount - 1];
		float num = plane.GetDistanceToPoint(vector);
		bool flag = num >= -0.0001f;
		for (int i = 0; i < inputCount; i++)
		{
			Vector3 vector2 = input[i];
			float distanceToPoint = plane.GetDistanceToPoint(vector2);
			bool flag2 = distanceToPoint >= -0.0001f;
			if (flag2 != flag)
			{
				float num2 = num - distanceToPoint;
				float t = ((Mathf.Abs(num2) > 1E-07f) ? Mathf.Clamp01(num / num2) : 0f);
				output[result++] = Vector3.LerpUnclamped(vector, vector2, t);
			}
			if (flag2)
			{
				output[result++] = vector2;
			}
			vector = vector2;
			num = distanceToPoint;
			flag = flag2;
		}
		return result;
	}

	private static bool ContainsPoint(Bounds bounds, Vector3 point)
	{
		Vector3 min = bounds.min;
		Vector3 max = bounds.max;
		if (point.x >= min.x - 0.0001f && point.y >= min.y - 0.0001f && point.z >= min.z - 0.0001f && point.x <= max.x + 0.0001f && point.y <= max.y + 0.0001f)
		{
			return point.z <= max.z + 0.0001f;
		}
		return false;
	}

	private static void AccumulateLightSpaceXY(Vector3 pointWS, Matrix4x4 worldToLightRotation, ref float minX, ref float minY, ref float maxX, ref float maxY)
	{
		Vector3 vector = worldToLightRotation.MultiplyPoint3x4(pointWS);
		minX = Mathf.Min(minX, vector.x);
		minY = Mathf.Min(minY, vector.y);
		maxX = Mathf.Max(maxX, vector.x);
		maxY = Mathf.Max(maxY, vector.y);
	}

	private static bool IsShadowCasterRenderer(Renderer renderer, int rendererCullingMask)
	{
		if (renderer != null && renderer.enabled && renderer.gameObject.activeInHierarchy && renderer.shadowCastingMode != ShadowCastingMode.Off)
		{
			return ((1 << renderer.gameObject.layer) & rendererCullingMask) != 0;
		}
		return false;
	}

	private static void GetTransformedBoundsAabb(Bounds localBounds, Matrix4x4 localToTarget, out Vector3 min, out Vector3 max)
	{
		Vector3 vector = localToTarget.MultiplyPoint3x4(localBounds.center);
		Vector3 extents = localBounds.extents;
		Vector3 vector2 = new Vector3(Mathf.Abs(localToTarget.m00) * extents.x + Mathf.Abs(localToTarget.m01) * extents.y + Mathf.Abs(localToTarget.m02) * extents.z, Mathf.Abs(localToTarget.m10) * extents.x + Mathf.Abs(localToTarget.m11) * extents.y + Mathf.Abs(localToTarget.m12) * extents.z, Mathf.Abs(localToTarget.m20) * extents.x + Mathf.Abs(localToTarget.m21) * extents.y + Mathf.Abs(localToTarget.m22) * extents.z);
		min = vector - vector2;
		max = vector + vector2;
	}

	private static bool IsUsableBounds(Bounds bounds)
	{
		Vector3 center = bounds.center;
		Vector3 size = bounds.size;
		if (IsFinite(center.x) && IsFinite(center.y) && IsFinite(center.z) && IsFinite(size.x) && IsFinite(size.y) && IsFinite(size.z))
		{
			return size.sqrMagnitude > 1E-06f;
		}
		return false;
	}

	private static bool IsFinite(float value)
	{
		if (!float.IsNaN(value))
		{
			return !float.IsInfinity(value);
		}
		return false;
	}
}
