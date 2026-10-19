using System.Collections.Generic;
using UnityEngine;

namespace ACT.DebugGUI;

public abstract class DebugGUIWindow : DebugWindow
{
	private List<DebugGUI> m_GUIControls = new List<DebugGUI>();

	private List<DebugMonitor> m_Monitors = new List<DebugMonitor>();

	protected override void OnDraw()
	{
		GUILayout.BeginVertical();
		foreach (DebugGUI gUIControl in m_GUIControls)
		{
			gUIControl.Draw();
		}
		foreach (DebugMonitor monitor in m_Monitors)
		{
			monitor.OnDraw();
		}
		GUILayout.EndVertical();
	}

	protected override void OnUpdate()
	{
		foreach (DebugMonitor monitor in m_Monitors)
		{
			monitor.OnUpdate();
		}
	}

	public TDebugGUI AddGUI<TDebugGUI>(TDebugGUI debugGUI) where TDebugGUI : DebugGUI
	{
		m_GUIControls.Add(debugGUI);
		return debugGUI;
	}

	public void RemoveGUI(DebugGUI debugGUI)
	{
		m_GUIControls.Remove(debugGUI);
	}

	public void ClearGUIs()
	{
		m_GUIControls.Clear();
	}

	public void AddMonitor(DebugMonitor monitor)
	{
		if (monitor != null)
		{
			m_Monitors.Add(monitor);
		}
	}

	public void RemoveMonitors()
	{
		foreach (DebugMonitor monitor in m_Monitors)
		{
			monitor.Remove();
		}
	}
}
