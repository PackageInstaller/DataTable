using UnityEngine;

public class HighFPSMonitor : MonoBehaviour
{
	[SerializeField]
	private int m_averageSamples = 240;

	[SerializeField]
	private int m_fps_threshold = 60;

	[SerializeField]
	private float m_hold_low_fps_time = 10f;

	private float m_unscaledDeltaTime;

	private float m_currentFps;

	private float m_avgFps;

	private float m_minFps;

	private float m_maxFps;

	private int m_avgFpsSamplesCapacity;

	private int m_avgFpsSamplesOffset;

	private int m_indexMask;

	private int m_avgFpsSamplesCount;

	private float[] m_averageFpsSamples;

	private bool m_has_show_tips;

	private float m_low_fps_time;

	public bool need_show_tip { get; private set; }

	private void OnEnable()
	{
		ResizeSamplesBuffer(m_averageSamples);
	}

	private void ResizeSamplesBuffer(int size)
	{
		m_avgFpsSamplesCapacity = Mathf.NextPowerOfTwo(size);
		m_averageFpsSamples = new float[m_avgFpsSamplesCapacity];
		m_indexMask = m_avgFpsSamplesCapacity - 1;
		m_avgFpsSamplesOffset = 0;
		m_low_fps_time = 0f;
		need_show_tip = false;
	}

	private int ToBufferIndex(int index)
	{
		return (index + m_avgFpsSamplesOffset) & m_indexMask;
	}

	private void Update()
	{
		m_unscaledDeltaTime = Time.unscaledDeltaTime;
		m_currentFps = 1f / m_unscaledDeltaTime;
		m_avgFps = 0f;
		m_averageFpsSamples[ToBufferIndex(m_avgFpsSamplesCount)] = m_currentFps;
		m_avgFpsSamplesOffset = ToBufferIndex(m_avgFpsSamplesOffset + 1);
		if (m_avgFpsSamplesCount < m_avgFpsSamplesCapacity)
		{
			m_avgFpsSamplesCount++;
		}
		for (int i = 0; i < m_avgFpsSamplesCount; i++)
		{
			m_avgFps += m_averageFpsSamples[i];
		}
		m_avgFps /= m_avgFpsSamplesCount;
		if (m_avgFps < (float)m_fps_threshold)
		{
			m_low_fps_time += Time.unscaledDeltaTime;
		}
		if (m_low_fps_time > m_hold_low_fps_time && !m_has_show_tips)
		{
			need_show_tip = true;
			m_has_show_tips = true;
			base.gameObject.SetActive(value: false);
		}
	}
}
