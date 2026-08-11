using System;
using System.Collections.Generic;
using System.Text;

namespace UnityEngine.Experimental.Rendering.RenderGraphModule;

internal class RenderGraphLogger
{
	private Dictionary<string, StringBuilder> m_LogMap = new Dictionary<string, StringBuilder>();

	private StringBuilder m_CurrentBuilder;

	private int m_CurrentIndentation;

	public void Initialize(string logName)
	{
		if (!m_LogMap.TryGetValue(logName, out var value))
		{
			value = new StringBuilder();
			m_LogMap.Add(logName, value);
		}
		m_CurrentBuilder = value;
		m_CurrentBuilder.Clear();
		m_CurrentIndentation = 0;
	}

	public void IncrementIndentation(int value)
	{
		m_CurrentIndentation += Math.Abs(value);
	}

	public void DecrementIndentation(int value)
	{
		m_CurrentIndentation = Math.Max(0, m_CurrentIndentation - Math.Abs(value));
	}

	public void LogLine(string format, params object[] args)
	{
		for (int i = 0; i < m_CurrentIndentation; i++)
		{
			m_CurrentBuilder.Append('\t');
		}
		m_CurrentBuilder.AppendFormat(format, args);
		m_CurrentBuilder.AppendLine();
	}

	public string GetLog(string logName)
	{
		if (m_LogMap.TryGetValue(logName, out var value))
		{
			return value.ToString();
		}
		return "";
	}

	public string GetAllLogs()
	{
		string text = "";
		foreach (KeyValuePair<string, StringBuilder> item in m_LogMap)
		{
			StringBuilder value = item.Value;
			value.AppendLine();
			text += value.ToString();
		}
		return text;
	}
}
