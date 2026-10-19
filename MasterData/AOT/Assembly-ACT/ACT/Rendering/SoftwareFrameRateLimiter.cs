using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Threading;
using UnityEngine;
using UnityEngine.LowLevel;
using UnityEngine.PlayerLoop;

namespace ACT.Rendering;

public sealed class SoftwareFrameRateLimiter : IDisposable
{
	private const int Uninitialized = int.MinValue;

	private const int ManualPacingTargetFrameRate = 45;

	private const double SpinWindowMilliseconds = 0.25;

	private int m_TargetFrameRate = int.MinValue;

	private int m_RequestedVSyncCount = int.MinValue;

	private long m_NextFrameTimestamp;

	private bool m_Enabled = true;

	private bool m_UseManualPacing;

	private bool m_PlayerLoopInstalled;

	private bool m_Disposed;

	public bool Enabled => m_Enabled;

	public void SetTargetFrameRate(int targetFrameRate)
	{
		if (!m_Disposed)
		{
			m_TargetFrameRate = targetFrameRate;
			EnsureRequestedVSyncCount();
			if (!m_Enabled)
			{
				RestoreRequestedSettings();
				return;
			}
			SetPlayerLoopInstalled(installed: true);
			ConfigureFrameRate();
		}
	}

	public void SetVSyncCount(int vSyncCount)
	{
		if (!m_Disposed)
		{
			m_RequestedVSyncCount = Mathf.Max(0, vSyncCount);
			if (!m_Enabled || m_TargetFrameRate == int.MinValue)
			{
				ApplyVSyncCount(m_RequestedVSyncCount);
			}
			else
			{
				ConfigureFrameRate();
			}
		}
	}

	public void SetEnabled(bool enabled)
	{
		if (!m_Disposed && m_Enabled != enabled)
		{
			m_Enabled = enabled;
			if (!enabled)
			{
				SetPlayerLoopInstalled(installed: false);
				RestoreRequestedSettings();
			}
			else if (m_TargetFrameRate != int.MinValue)
			{
				SetPlayerLoopInstalled(installed: true);
				ConfigureFrameRate();
			}
		}
	}

	public void Dispose()
	{
		if (!m_Disposed)
		{
			SetPlayerLoopInstalled(installed: false);
			RestoreRequestedSettings();
			m_Disposed = true;
		}
	}

	private void SetPlayerLoopInstalled(bool installed)
	{
		if (m_PlayerLoopInstalled == installed)
		{
			return;
		}
		PlayerLoopSystem currentPlayerLoop = PlayerLoop.GetCurrentPlayerLoop();
		if (currentPlayerLoop.subSystemList == null)
		{
			m_PlayerLoopInstalled = false;
			return;
		}
		List<PlayerLoopSystem> list = new List<PlayerLoopSystem>(currentPlayerLoop.subSystemList);
		for (int num = list.Count - 1; num >= 0; num--)
		{
			if (list[num].type == typeof(SoftwareFrameRateLimiter))
			{
				list.RemoveAt(num);
			}
		}
		if (installed)
		{
			int index = 0;
			for (int i = 0; i < list.Count; i++)
			{
				if (list[i].type == typeof(TimeUpdate))
				{
					index = i;
					break;
				}
			}
			list.Insert(index, new PlayerLoopSystem
			{
				type = typeof(SoftwareFrameRateLimiter),
				updateDelegate = UpdateFramePacing
			});
		}
		currentPlayerLoop.subSystemList = list.ToArray();
		PlayerLoop.SetPlayerLoop(currentPlayerLoop);
		m_PlayerLoopInstalled = installed;
	}

	private void UpdateFramePacing()
	{
		if (!m_Disposed && m_Enabled && m_TargetFrameRate != int.MinValue && m_UseManualPacing && m_TargetFrameRate > 0)
		{
			PaceFrame();
		}
	}

	private void ConfigureFrameRate()
	{
		int targetFrameRate = m_TargetFrameRate;
		bool useManualPacing = m_TargetFrameRate == 45;
		m_UseManualPacing = useManualPacing;
		Application.targetFrameRate = targetFrameRate;
		m_NextFrameTimestamp = 0L;
	}

	private void PaceFrame()
	{
		long timestamp = Stopwatch.GetTimestamp();
		long num = Math.Max(1L, (long)Math.Round((double)Stopwatch.Frequency / (double)m_TargetFrameRate));
		if (m_NextFrameTimestamp == 0L)
		{
			m_NextFrameTimestamp = timestamp + num;
			return;
		}
		if (timestamp < m_NextFrameTimestamp)
		{
			WaitUntil(m_NextFrameTimestamp);
			timestamp = Stopwatch.GetTimestamp();
		}
		m_NextFrameTimestamp = timestamp + num;
	}

	private static void WaitUntil(long targetTimestamp)
	{
		double num = (double)Stopwatch.Frequency / 1000.0;
		while (true)
		{
			long num2 = targetTimestamp - Stopwatch.GetTimestamp();
			if (num2 <= 0)
			{
				break;
			}
			double num3 = (double)num2 / num;
			if (num3 > 1.25)
			{
				Thread.Sleep((int)(num3 - 0.25));
			}
			else
			{
				Thread.SpinWait(1);
			}
		}
	}

	private void RestoreRequestedSettings()
	{
		EnsureRequestedVSyncCount();
		m_UseManualPacing = false;
		m_NextFrameTimestamp = 0L;
		ApplyVSyncCount(m_RequestedVSyncCount);
		if (m_TargetFrameRate != int.MinValue)
		{
			Application.targetFrameRate = m_TargetFrameRate;
		}
	}

	private void EnsureRequestedVSyncCount()
	{
		if (m_RequestedVSyncCount == int.MinValue)
		{
			m_RequestedVSyncCount = Mathf.Max(0, QualitySettings.vSyncCount);
		}
	}

	private static void ApplyVSyncCount(int vSyncCount)
	{
	}
}
