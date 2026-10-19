using System;
using Unity.Profiling;
using UnityEngine.Profiling;

namespace UnityEngine.Rendering;

[IgnoredByDeepProfiler]
public class ProfilingSampler
{
	private Recorder m_Recorder;

	private Recorder m_InlineRecorder;

	internal CustomSampler sampler { get; private set; }

	internal CustomSampler inlineSampler { get; private set; }

	public string name { get; private set; }

	public bool enableRecording
	{
		set
		{
			m_Recorder.enabled = value;
			m_InlineRecorder.enabled = value;
		}
	}

	public float gpuElapsedTime
	{
		get
		{
			if (!m_Recorder.enabled)
			{
				return 0f;
			}
			return (float)m_Recorder.gpuElapsedNanoseconds / 1000000f;
		}
	}

	public int gpuSampleCount
	{
		get
		{
			if (!m_Recorder.enabled)
			{
				return 0;
			}
			return m_Recorder.gpuSampleBlockCount;
		}
	}

	public float cpuElapsedTime
	{
		get
		{
			if (!m_Recorder.enabled)
			{
				return 0f;
			}
			return (float)m_Recorder.elapsedNanoseconds / 1000000f;
		}
	}

	public int cpuSampleCount
	{
		get
		{
			if (!m_Recorder.enabled)
			{
				return 0;
			}
			return m_Recorder.sampleBlockCount;
		}
	}

	public float inlineCpuElapsedTime
	{
		get
		{
			if (!m_InlineRecorder.enabled)
			{
				return 0f;
			}
			return (float)m_InlineRecorder.elapsedNanoseconds / 1000000f;
		}
	}

	public int inlineCpuSampleCount
	{
		get
		{
			if (!m_InlineRecorder.enabled)
			{
				return 0;
			}
			return m_InlineRecorder.sampleBlockCount;
		}
	}

	public static ProfilingSampler Get<TEnum>(TEnum marker) where TEnum : Enum
	{
		TProfilingSampler<TEnum>.samples.TryGetValue(marker, out var value);
		return value;
	}

	public ProfilingSampler(string name)
	{
		sampler = CustomSampler.Create(name, collectGpuData: true);
		inlineSampler = CustomSampler.Create("Inl_" + name);
		this.name = name;
		m_Recorder = sampler.GetRecorder();
		m_Recorder.enabled = false;
		m_InlineRecorder = inlineSampler.GetRecorder();
		m_InlineRecorder.enabled = false;
	}

	public void Begin(CommandBuffer cmd)
	{
		if (cmd != null)
		{
			if (sampler != null && sampler.isValid)
			{
				cmd.BeginSample(sampler);
			}
			else
			{
				cmd.BeginSample(name);
			}
		}
	}

	public void End(CommandBuffer cmd)
	{
		if (cmd != null)
		{
			if (sampler != null && sampler.isValid)
			{
				cmd.EndSample(sampler);
			}
			else
			{
				cmd.EndSample(name);
			}
		}
	}

	internal bool IsValid()
	{
		if (sampler != null)
		{
			return inlineSampler != null;
		}
		return false;
	}

	private ProfilingSampler()
	{
	}
}
