using Unity.Profiling;
using Unity.Profiling.LowLevel;
using Unity.Profiling.LowLevel.Unsafe;
using UnityEngine.Scripting;

namespace UnityEngine.Profiling;

[UsedByNativeCode]
public sealed class Recorder
{
	private const ProfilerRecorderOptions s_RecorderDefaultOptions = (ProfilerRecorderOptions)153;

	internal static Recorder s_InvalidRecorder = new Recorder();

	private ProfilerRecorder m_RecorderCPU;

	private ProfilerRecorder m_RecorderGPU;

	public bool enabled
	{
		get
		{
			return m_RecorderCPU.IsRunning;
		}
		set
		{
			SetEnabled(value);
		}
	}

	public long elapsedNanoseconds
	{
		get
		{
			if (!m_RecorderCPU.Valid)
			{
				return 0L;
			}
			return m_RecorderCPU.LastValue;
		}
	}

	public long gpuElapsedNanoseconds
	{
		get
		{
			if (!m_RecorderGPU.Valid)
			{
				return 0L;
			}
			return m_RecorderGPU.LastValue;
		}
	}

	public int sampleBlockCount
	{
		get
		{
			if (!m_RecorderCPU.Valid)
			{
				return 0;
			}
			if (m_RecorderCPU.Count != 1)
			{
				return 0;
			}
			return (int)m_RecorderCPU.GetSample(0).Count;
		}
	}

	public int gpuSampleBlockCount
	{
		get
		{
			if (!m_RecorderGPU.Valid)
			{
				return 0;
			}
			if (m_RecorderGPU.Count != 1)
			{
				return 0;
			}
			return (int)m_RecorderGPU.GetSample(0).Count;
		}
	}

	internal Recorder()
	{
	}

	internal Recorder(ProfilerRecorderHandle handle)
	{
		if (handle.Valid)
		{
			m_RecorderCPU = new ProfilerRecorder(handle, 1, (ProfilerRecorderOptions)153);
			if ((ProfilerRecorderHandle.GetDescription(handle).Flags & MarkerFlags.SampleGPU) != MarkerFlags.Default)
			{
				m_RecorderGPU = new ProfilerRecorder(handle, 1, (ProfilerRecorderOptions)217);
			}
		}
	}

	~Recorder()
	{
		m_RecorderCPU.Dispose();
		m_RecorderGPU.Dispose();
	}

	private void SetEnabled(bool state)
	{
		if (state)
		{
			m_RecorderCPU.Start();
			if (m_RecorderGPU.Valid)
			{
				m_RecorderGPU.Start();
			}
		}
		else
		{
			m_RecorderCPU.Stop();
			if (m_RecorderGPU.Valid)
			{
				m_RecorderGPU.Stop();
			}
		}
	}
}
