using System;

namespace UnityEngine.Rendering;

public struct ScopedSubPass : IDisposable
{
	private ScriptableRenderContext m_Context;

	internal ScopedSubPass(ScriptableRenderContext context)
	{
		m_Context = context;
	}

	public void Dispose()
	{
		try
		{
			m_Context.EndSubPass();
		}
		catch (Exception innerException)
		{
			throw new InvalidOperationException("The ScopedSubPass instance is not valid. This can happen if it was constructed using the default constructor.", innerException);
		}
	}
}
