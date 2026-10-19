using System;
using Unity.Collections;

namespace UnityEngine.Rendering.Universal.Internal;

internal sealed class PassStencilStateOverride : IDisposable
{
	private static readonly ShaderTagId s_LightModeTag = new ShaderTagId("LightMode");

	private NativeArray<ShaderTagId> m_TagValues;

	private NativeArray<RenderStateBlock> m_StateBlocks;

	internal PassStencilStateOverride(ShaderTagId passTag, RenderStateBlock overrideState, RenderStateBlock fallbackState)
	{
		m_TagValues = new NativeArray<ShaderTagId>(2, Allocator.Persistent);
		m_TagValues[0] = passTag;
		m_TagValues[1] = default;
		m_StateBlocks = new NativeArray<RenderStateBlock>(2, Allocator.Persistent);
		m_StateBlocks[0] = overrideState;
		m_StateBlocks[1] = fallbackState;
	}

	internal void DrawRenderers(ref ScriptableRenderContext context, CullingResults cullingResults, ref DrawingSettings drawingSettings, ref FilteringSettings filteringSettings)
	{
		context.DrawRenderers(cullingResults, ref drawingSettings, ref filteringSettings, s_LightModeTag, isPassTagName: true, m_TagValues, m_StateBlocks);
	}

	public void Dispose()
	{
		if (m_TagValues.IsCreated)
		{
			m_TagValues.Dispose();
		}
		if (m_StateBlocks.IsCreated)
		{
			m_StateBlocks.Dispose();
		}
	}
}
