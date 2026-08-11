using System;

namespace UnityEngine.Experimental.Rendering.RenderGraphModule;

internal struct RenderGraphLogIndent : IDisposable
{
	private int m_Indentation;

	private RenderGraphLogger m_Logger;

	private bool m_Disposed;

	public RenderGraphLogIndent(RenderGraphLogger logger, int indentation = 1)
	{
		m_Disposed = false;
		m_Indentation = indentation;
		m_Logger = logger;
		m_Logger.IncrementIndentation(m_Indentation);
	}

	public void Dispose()
	{
		Dispose(disposing: true);
	}

	private void Dispose(bool disposing)
	{
		if (!m_Disposed)
		{
			if (disposing && m_Logger != null)
			{
				m_Logger.DecrementIndentation(m_Indentation);
			}
			m_Disposed = true;
		}
	}
}
