using System;
using UnityEngine.Profiling;

namespace UnityEngine.Rendering;

[Obsolete("Please use ProfilingScope")]
public struct ProfilingSample : IDisposable
{
	private readonly CommandBuffer m_Cmd;

	private readonly string m_Name;

	private bool m_Disposed;

	private CustomSampler m_Sampler;

	public ProfilingSample(CommandBuffer cmd, string name, CustomSampler sampler = null)
	{
		m_Cmd = cmd;
		m_Name = name;
		m_Disposed = false;
		if (cmd != null && name != "")
		{
			cmd.BeginSample(name);
		}
		m_Sampler = sampler;
	}

	public ProfilingSample(CommandBuffer cmd, string format, object arg)
		: this(cmd, string.Format(format, arg))
	{
	}

	public ProfilingSample(CommandBuffer cmd, string format, params object[] args)
		: this(cmd, string.Format(format, args))
	{
	}

	public void Dispose()
	{
		Dispose(disposing: true);
	}

	private void Dispose(bool disposing)
	{
		if (!m_Disposed)
		{
			if (disposing && m_Cmd != null && m_Name != "")
			{
				m_Cmd.EndSample(m_Name);
			}
			m_Disposed = true;
		}
	}
}
