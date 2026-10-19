using System;

namespace UnityEngine.Rendering;

public struct ScopedRenderPass : IDisposable
{
	private ScriptableRenderContext m_Context;

	internal ScopedRenderPass(ScriptableRenderContext context)
	{
		m_Context = context;
	}

	public void Dispose()
	{
		try
		{
			m_Context.EndRenderPass();
		}
		catch (Exception innerException)
		{
			throw new InvalidOperationException("The ScopedRenderPass instance is not valid. This can happen if it was constructed using the default constructor.", innerException);
		}
	}
}
