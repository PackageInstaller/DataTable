using UnityEngine.InputSystem.LowLevel;

namespace UnityEngine.InputSystem.Editor;

internal struct SampleFrequencyCalculator(float targetFrequency, double realtimeSinceStartup)
{
	private double m_LastUpdateTime = realtimeSinceStartup;

	private int m_SampleCount = 0;

	public float targetFrequency { get; private set; } = targetFrequency;

	public float frequency { get; private set; } = 0f;

	public void ProcessSample(InputEventPtr eventPtr)
	{
		if (eventPtr != null)
		{
			m_SampleCount++;
		}
	}

	public bool Update()
	{
		return Update(Time.realtimeSinceStartupAsDouble);
	}

	public bool Update(double realtimeSinceStartup)
	{
		double num = realtimeSinceStartup - m_LastUpdateTime;
		if (num < 1.0)
		{
			return false;
		}
		m_LastUpdateTime = realtimeSinceStartup;
		frequency = (float)((double)m_SampleCount / num);
		m_SampleCount = 0;
		return true;
	}
}
