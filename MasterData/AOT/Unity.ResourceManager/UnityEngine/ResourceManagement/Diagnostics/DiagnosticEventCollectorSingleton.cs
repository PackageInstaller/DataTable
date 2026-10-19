using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine.Networking.PlayerConnection;
using UnityEngine.Profiling;
using UnityEngine.ResourceManagement.Util;

namespace UnityEngine.ResourceManagement.Diagnostics;

public class DiagnosticEventCollectorSingleton : ComponentSingleton<DiagnosticEventCollectorSingleton>
{
	private static Guid s_editorConnectionGuid;

	internal Dictionary<int, DiagnosticEvent> m_CreatedEvents = new Dictionary<int, DiagnosticEvent>();

	internal List<DiagnosticEvent> m_UnhandledEvents = new List<DiagnosticEvent>();

	internal DelegateList<DiagnosticEvent> s_EventHandlers = DelegateList<DiagnosticEvent>.CreateWithGlobalCache();

	private float m_lastTickSent;

	private int m_lastFrame;

	private float fpsAvg = 30f;

	public static Guid PlayerConnectionGuid
	{
		get
		{
			if (s_editorConnectionGuid == Guid.Empty)
			{
				s_editorConnectionGuid = new Guid(1, 2, 3, new byte[8] { 20, 1, 32, 32, 4, 9, 6, 44 });
			}
			return s_editorConnectionGuid;
		}
	}

	protected override string GetGameObjectName()
	{
		return "EventCollector";
	}

	public static bool RegisterEventHandler(Action<DiagnosticEvent> handler, bool register, bool create)
	{
		if (register && (create || ComponentSingleton<DiagnosticEventCollectorSingleton>.Exists))
		{
			ComponentSingleton<DiagnosticEventCollectorSingleton>.Instance.RegisterEventHandler(handler);
			return true;
		}
		if (!register && ComponentSingleton<DiagnosticEventCollectorSingleton>.Exists)
		{
			ComponentSingleton<DiagnosticEventCollectorSingleton>.Instance.UnregisterEventHandler(handler);
		}
		return false;
	}

	internal void RegisterEventHandler(Action<DiagnosticEvent> handler)
	{
		if (handler == null)
		{
			throw new ArgumentNullException("handler");
		}
		s_EventHandlers.Add(handler);
		foreach (DiagnosticEvent item in from evt in m_UnhandledEvents.Concat(m_CreatedEvents.Values)
			orderby evt.Frame
			select evt)
		{
			handler(item);
		}
		m_UnhandledEvents.Clear();
	}

	public void UnregisterEventHandler(Action<DiagnosticEvent> handler)
	{
		if (handler == null)
		{
			throw new ArgumentNullException("handler");
		}
		s_EventHandlers.Remove(handler);
	}

	public void PostEvent(DiagnosticEvent diagnosticEvent)
	{
		if (diagnosticEvent.Stream == 1 && !m_CreatedEvents.ContainsKey(diagnosticEvent.ObjectId))
		{
			m_CreatedEvents.Add(diagnosticEvent.ObjectId, diagnosticEvent);
		}
		else if (diagnosticEvent.Stream == 5)
		{
			m_CreatedEvents.Remove(diagnosticEvent.ObjectId);
		}
		if (s_EventHandlers.Count > 0)
		{
			s_EventHandlers.Invoke(diagnosticEvent);
		}
		else
		{
			m_UnhandledEvents.Add(diagnosticEvent);
		}
	}

	private void Awake()
	{
		RegisterEventHandler((DiagnosticEvent diagnosticEvent) =>
		{
			PlayerConnection.instance.Send(PlayerConnectionGuid, diagnosticEvent.Serialize());
		});
	}

	private void Update()
	{
		if (s_EventHandlers.Count > 0)
		{
			float num = Time.realtimeSinceStartup - m_lastTickSent;
			if (num > 0.25f)
			{
				float num2 = (float)(Time.frameCount - m_lastFrame) / num;
				m_lastFrame = Time.frameCount;
				fpsAvg = (fpsAvg + num2) * 0.5f;
				m_lastTickSent = Time.realtimeSinceStartup;
				int value = (int)(Profiler.GetMonoUsedSizeLong() / 1024);
				PostEvent(new DiagnosticEvent("FrameCount", "FPS", 2, 1, Time.frameCount, (int)fpsAvg, null));
				PostEvent(new DiagnosticEvent("MemoryCount", "MonoHeap", 3, 2, Time.frameCount, value, null));
			}
		}
	}
}
