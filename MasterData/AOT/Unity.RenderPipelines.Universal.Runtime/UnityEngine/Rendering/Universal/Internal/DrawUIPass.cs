using System.Collections.Generic;
using UnityEngine.Experimental.Rendering;

namespace UnityEngine.Rendering.Universal.Internal;

public class DrawUIPass : ScriptableRenderPass
{
	private List<ShaderTagId> m_ShaderTagIdList;

	public static readonly List<UIEffectRendering> UIEffectRenderingList = new List<UIEffectRendering>();

	private static int EffectTexTagIDB = Shader.PropertyToID("_UI_EffectTexB");

	private static int EffectTexTagID = Shader.PropertyToID("_UI_EffectTex");

	private static int CatchNativeRenderPassTagID = Shader.PropertyToID("_CatchNativeRenderPass");

	private RenderTargetHandle m_RenderTargetHandleB;

	private static bool m_DoCatch;

	private static bool Is_Caught;

	private static bool RT_Created;

	private static bool s_ReleaseRequested;

	private static int m_CatchIndex;

	private static RenderTexture m_CaughtTexture;

	private static int s_InstanceCount;

	private Material m_CaughtMaterial;

	private bool m_Disposed;

	public static void DoCatch(int index)
	{
		ReleaseCatch();
		if (index >= 0 && index < UIEffectRenderingList.Count)
		{
			UIEffectRendering uIEffectRendering = UIEffectRenderingList[index];
			if (uIEffectRendering != null && uIEffectRendering.RenderDirectly)
			{
				m_DoCatch = true;
				m_CatchIndex = index;
			}
		}
	}

	public static bool IsDoCatchInThisFrame()
	{
		if (!m_DoCatch)
		{
			return Is_Caught;
		}
		return true;
	}

	internal static bool CanUseNativeRenderPass()
	{
		if (m_DoCatch)
		{
			return false;
		}
		int count = UIEffectRenderingList.Count;
		if (count == 0)
		{
			return true;
		}
		if (!Is_Caught)
		{
			return false;
		}
		for (int i = Mathf.Min(m_CatchIndex, count - 1) + 1; i < count; i++)
		{
			List<AbstractUIEffectRenderer> list = UIEffectRenderingList[i]?.rendererList;
			if (list != null && list.Count > 0)
			{
				return false;
			}
		}
		return true;
	}

	public static void ReleaseCatch()
	{
		s_ReleaseRequested = true;
		Is_Caught = false;
		RT_Created = false;
		m_DoCatch = false;
	}

	internal static void ReconcilePersistentRenderResources()
	{
		if (s_ReleaseRequested)
		{
			ReleaseCatchTextures(destroyTextures: false);
			s_ReleaseRequested = false;
		}
	}

	public DrawUIPass()
	{
		profilingSampler = new ProfilingSampler("DrawUIPass");
		m_ShaderTagIdList = new List<ShaderTagId>(ShaderPassTags.ForwardShaderTags);
		renderPassEvent = RenderPassEvent.DrawUIPass;
		ConfigureDepthAttachment();
		m_RenderTargetHandleB.Init(EffectTexTagIDB);
		m_CaughtMaterial = CoreUtils.CreateEngineMaterial(Shader.Find("Hidden/CatchUI"));
		if (m_CaughtTexture == null)
		{
			m_CaughtTexture = CreateCatchTextureShell("UI_Caught");
		}
		s_InstanceCount++;
	}

	private static RenderTexture CreateCatchTextureShell(string name)
	{
		return new RenderTexture(1, 1, 0)
		{
			hideFlags = HideFlags.HideAndDontSave,
			name = name
		};
	}

	private static void EnsureCatchTextures(RenderTextureDescriptor descriptor)
	{
		if (!RT_Created || !(m_CaughtTexture != null) || m_CaughtTexture.width != descriptor.width || m_CaughtTexture.height != descriptor.height)
		{
			if (RT_Created)
			{
				ReleaseCatchTextures(destroyTextures: false);
				RT_Created = false;
			}
			CreateCatchTextureStorage(m_CaughtTexture, descriptor, "UI_Caught");
			RT_Created = true;
		}
	}

	private static void CreateCatchTextureStorage(RenderTexture texture, RenderTextureDescriptor descriptor, string name)
	{
		descriptor.memoryless = RenderTextureMemoryless.None;
		texture.descriptor = descriptor;
		texture.name = name;
		texture.Create();
	}

	private static void ReleaseCatchTextures(bool destroyTextures)
	{
		if (m_CaughtTexture != null)
		{
			if (m_CaughtTexture.IsCreated())
			{
				m_CaughtTexture.Release();
			}
			if (destroyTextures)
			{
				CoreUtils.Destroy(m_CaughtTexture);
				m_CaughtTexture = null;
			}
		}
	}

	private void DrawCaughtUI(CommandBuffer cmd, bool nativeRenderPass)
	{
		cmd.SetGlobalFloat(CatchNativeRenderPassTagID, nativeRenderPass ? 1f : 0f);
		ACTRenderingFunction.ACT_DrawFullScreenMesh(cmd, m_CaughtMaterial, 0, m_CaughtTexture);
		cmd.SetGlobalTexture(EffectTexTagID, m_CaughtTexture);
	}

	public void Dispose()
	{
		if (!m_Disposed)
		{
			m_Disposed = true;
			CoreUtils.Destroy(m_CaughtMaterial);
			m_CaughtMaterial = null;
			if (--s_InstanceCount == 0)
			{
				ReleaseCatchTextures(destroyTextures: true);
				Is_Caught = false;
				RT_Created = false;
				m_DoCatch = false;
				s_ReleaseRequested = false;
			}
		}
	}

	public override void OnCameraCleanup(CommandBuffer cmd)
	{
		cmd.ReleaseTemporaryRT(m_RenderTargetHandleB.id);
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		CommandBuffer cmd = renderingData.cmd;
		using (new ProfilingScope(cmd, profilingSampler))
		{
			List<UIEffectRendering> uIEffectRenderingList = UIEffectRenderingList;
			int count = uIEffectRenderingList.Count;
			int num = count + 1;
			SortingCriteria sortingCriteria = SortingCriteria.CommonTransparent;
			DrawingSettings drawingSettings = CreateDrawingSettings(m_ShaderTagIdList, ref renderingData, sortingCriteria);
			FilteringSettings filteringSettings = new FilteringSettings(RenderQueueRange.all);
			UniversalRenderer renderer = renderingData.cameraData.renderer;
			cmd.SetGlobalFloat(ShaderPropertyId.isInUICamera, 1f);
			if (renderingData.nativeRenderPass && nativeRenderPassType == NativeRenderPassType.Post_To_Screen && Is_Caught && CanUseNativeRenderPass())
			{
				int num2 = Mathf.Min(m_CatchIndex, count - 1);
				if (num2 >= 0)
				{
					filteringSettings.sortingLayerRange = new SortingLayerRange((short)uIEffectRenderingList[num2].layer, short.MaxValue);
				}
				cmd.BeginSample("Draw UI");
				DrawCaughtUI(cmd, nativeRenderPass: true);
				context.ExecuteCommandBuffer(cmd);
				cmd.Clear();
				context.DrawRenderers(renderingData.cullResults, ref drawingSettings, ref filteringSettings);
				cmd.EndSample("Draw UI");
			}
			else if (num > 1)
			{
				short lowerBound = short.MinValue;
				short num3 = short.MinValue;
				int num4 = Mathf.Min(m_CatchIndex, num - 2);
				RenderTargetIdentifier cameraColorTarget = renderer.cameraColorTarget;
				RenderTargetIdentifier renderTargetIdentifier = default;
				bool flag = false;
				bool flag2 = false;
				if (m_DoCatch)
				{
					RenderTextureDescriptor currentColorBufferDescriptor = renderer.GetCurrentColorBufferDescriptor();
					currentColorBufferDescriptor.depthBufferBits = 0;
					currentColorBufferDescriptor.depthStencilFormat = GraphicsFormat.None;
					currentColorBufferDescriptor.enableRandomWrite = false;
					EnsureCatchTextures(currentColorBufferDescriptor);
				}
				for (int i = 0; i < num; i++)
				{
					if (i > 0)
					{
						UIEffectRendering uIEffectRendering = uIEffectRenderingList[i - 1];
						List<AbstractUIEffectRenderer> list = uIEffectRendering?.rendererList;
						int num5 = list?.Count ?? 0;
						if (num5 > 0 && uIEffectRendering != null && (!Is_Caught || num4 <= i - 2))
						{
							if (uIEffectRendering.RenderDirectly)
							{
								for (int j = 0; j < num5; j++)
								{
									AbstractUIEffectRenderer abstractUIEffectRenderer = list[j];
									if (abstractUIEffectRenderer != null)
									{
										RenderTargetIdentifier renderTargetIdentifier2 = cameraColorTarget;
										RenderTargetIdentifier cameraColorFrontBuffer = renderer.GetCameraColorFrontBuffer(cmd);
										cmd.BeginSample(abstractUIEffectRenderer.EffectName);
										bool flag3 = abstractUIEffectRenderer.Renderer(ref context, renderTargetIdentifier2, cameraColorFrontBuffer, ref renderingData, cmd, uIEffectRendering.Intensity);
										cmd.EndSample(abstractUIEffectRenderer.EffectName);
										if (flag3)
										{
											cmd.SetGlobalTexture(EffectTexTagID, renderTargetIdentifier2);
											renderer.SwapColorBuffer();
											cameraColorTarget = renderer.cameraColorTarget;
										}
									}
								}
							}
							else if (num5 == 1)
							{
								AbstractUIEffectRenderer abstractUIEffectRenderer2 = list[0];
								if (abstractUIEffectRenderer2 != null)
								{
									RenderTargetIdentifier cameraColorFrontBuffer2 = renderer.GetCameraColorFrontBuffer(cmd);
									cmd.BeginSample(abstractUIEffectRenderer2.EffectName);
									bool flag4 = abstractUIEffectRenderer2.Renderer(ref context, cameraColorTarget, cameraColorFrontBuffer2, ref renderingData, cmd, uIEffectRendering.Intensity);
									cmd.EndSample(abstractUIEffectRenderer2.EffectName);
									if (flag4)
									{
										cmd.SetGlobalTexture(EffectTexTagID, cameraColorFrontBuffer2);
										cmd.SetRenderTarget(cameraColorTarget, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, renderer.cameraDepthTarget, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store);
										renderer.ConfigureCameraColorTarget(cameraColorTarget);
									}
								}
							}
							else
							{
								if (!flag)
								{
									RenderTextureDescriptor currentColorBufferDescriptor2 = renderer.GetCurrentColorBufferDescriptor();
									currentColorBufferDescriptor2.depthBufferBits = 0;
									currentColorBufferDescriptor2.depthStencilFormat = GraphicsFormat.None;
									currentColorBufferDescriptor2.enableRandomWrite = false;
									cmd.GetTemporaryRT(m_RenderTargetHandleB.id, currentColorBufferDescriptor2);
									renderTargetIdentifier = m_RenderTargetHandleB.Identifier();
									flag = true;
								}
								RenderTargetIdentifier cameraColorFrontBuffer3 = renderer.GetCameraColorFrontBuffer(cmd);
								RenderTargetIdentifier renderTargetIdentifier3 = cameraColorTarget;
								RenderTargetIdentifier renderTargetIdentifier4 = cameraColorFrontBuffer3;
								bool flag5 = true;
								bool flag6 = false;
								for (int k = 0; k < num5; k++)
								{
									AbstractUIEffectRenderer abstractUIEffectRenderer3 = list[k];
									if (abstractUIEffectRenderer3 != null)
									{
										cmd.BeginSample(abstractUIEffectRenderer3.EffectName);
										bool flag7 = abstractUIEffectRenderer3.Renderer(ref context, renderTargetIdentifier3, renderTargetIdentifier4, ref renderingData, cmd, uIEffectRendering.Intensity);
										cmd.EndSample(abstractUIEffectRenderer3.EffectName);
										if (flag7)
										{
											flag6 = true;
											renderTargetIdentifier3 = renderTargetIdentifier4;
											renderTargetIdentifier4 = (flag5 ? renderTargetIdentifier : cameraColorFrontBuffer3);
											flag5 = !flag5;
										}
									}
								}
								if (flag6)
								{
									cmd.SetGlobalTexture(EffectTexTagID, renderTargetIdentifier3);
									cmd.SetRenderTarget(cameraColorTarget, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, renderer.cameraDepthTarget, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store);
									renderer.ConfigureCameraColorTarget(cameraColorTarget);
								}
							}
						}
					}
					if (i == num - 1)
					{
						num3 = short.MaxValue;
					}
					else
					{
						UIEffectRendering uIEffectRendering2 = uIEffectRenderingList[i];
						num3 = ((uIEffectRendering2 != null) ? ((short)(uIEffectRendering2.layer - 1)) : short.MaxValue);
					}
					filteringSettings.sortingLayerRange = new SortingLayerRange(lowerBound, num3);
					lowerBound = (short)(num3 + 1);
					cmd.BeginSample("Draw UI");
					if (m_DoCatch && num4 == i - 1)
					{
						cmd.CopyTexture(cameraColorTarget, m_CaughtTexture);
						cmd.SetGlobalTexture(EffectTexTagID, m_CaughtTexture);
						m_DoCatch = false;
						Is_Caught = true;
						flag2 = true;
					}
					if (Is_Caught && num4 == i - 1 && !flag2)
					{
						DrawCaughtUI(cmd, nativeRenderPass: false);
					}
					cmd.SetRenderTarget(cameraColorTarget, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, renderer.cameraDepthTarget, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store);
					renderer.ManualSetColorAttachment(cameraColorTarget);
					renderer.ManualSetDepthAttachment(renderer.cameraDepthTarget);
					context.ExecuteCommandBuffer(cmd);
					cmd.Clear();
					if (!Is_Caught || num4 <= i - 1)
					{
						context.DrawRenderers(renderingData.cullResults, ref drawingSettings, ref filteringSettings);
					}
					cmd.EndSample("Draw UI");
				}
			}
			else
			{
				context.ExecuteCommandBuffer(cmd);
				cmd.Clear();
				RenderTextureDescriptor currentColorBufferDescriptor3 = renderingData.cameraData.renderer.GetCurrentColorBufferDescriptor();
				currentColorBufferDescriptor3.depthBufferBits = 0;
				currentColorBufferDescriptor3.depthStencilFormat = GraphicsFormat.None;
				currentColorBufferDescriptor3.enableRandomWrite = false;
				if (m_DoCatch)
				{
					EnsureCatchTextures(currentColorBufferDescriptor3);
				}
				if (m_DoCatch)
				{
					cmd.CopyTexture(renderingData.cameraData.renderer.cameraColorTarget, m_CaughtTexture);
					m_DoCatch = false;
					Is_Caught = true;
					m_CatchIndex = -1;
				}
				if (Is_Caught)
				{
					DrawCaughtUI(cmd, nativeRenderPass: false);
				}
				context.ExecuteCommandBuffer(cmd);
				cmd.Clear();
				context.DrawRenderers(renderingData.cullResults, ref drawingSettings, ref filteringSettings);
			}
			cmd.SetGlobalFloat(ShaderPropertyId.isInUICamera, 0f);
		}
	}
}
