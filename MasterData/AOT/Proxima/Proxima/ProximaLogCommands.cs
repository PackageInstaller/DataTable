using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

namespace Proxima;

internal class ProximaLogCommands
{
	[Serializable]
	public struct LogInfo
	{
		public long LogTime;

		public string LogString;

		public string StackTrace;

		public LogType Type;
	}

	private static HashSet<string> _pendingStreamIds;

	private static CircularList<LogInfo> _logs;

	private static IEnumerable<LogInfo> _streamLogs;

	private static int _streamIndex;

	private static int _lastUpdateFrame;

	public static void SetLogCapacity(int capacity)
	{
		_logs = new CircularList<LogInfo>(capacity);
	}

	[ProximaInitialize]
	public static void Initialize()
	{
		_pendingStreamIds = new HashSet<string>();
		Application.logMessageReceived += OnLogMessageReceived;
	}

	[ProximaTeardown]
	public static void Teardown()
	{
		_pendingStreamIds = null;
		Application.logMessageReceived -= OnLogMessageReceived;
	}

	[ProximaStreamStart("LogStream", false)]
	public static void StartStream(string id)
	{
		_pendingStreamIds.Add(id);
	}

	[ProximaStreamUpdate("LogStream", false)]
	public static IEnumerable<LogInfo> UpdateStream(string id)
	{
		if (_lastUpdateFrame != Time.frameCount)
		{
			_lastUpdateFrame = Time.frameCount;
			_streamLogs = ((_streamIndex != _logs.ItemsAdded) ? _logs.GetRange(_streamIndex) : null);
			_streamIndex = _logs.ItemsAdded;
		}
		if (_pendingStreamIds.Contains(id))
		{
			_pendingStreamIds.Remove(id);
			if (_logs.ItemsAdded <= 0)
			{
				return null;
			}
			return _logs;
		}
		return _streamLogs;
	}

	[ProximaStreamStop("LogStream", false)]
	public static void StopStream(string id)
	{
		_pendingStreamIds.Remove(id);
	}

	private static void OnLogMessageReceived(string message, string stackTrace, LogType type)
	{
		LogInfo t = new LogInfo
		{
			LogTime = (long)DateTime.UtcNow.Subtract(new DateTime(1970, 1, 1)).TotalMilliseconds,
			LogString = message,
			StackTrace = stackTrace,
			Type = type
		};
		_logs.Add(t);
	}

	[ProximaCommand("Internal", "", "", "", "")]
	public static string GetLogFile()
	{
		if (string.IsNullOrEmpty(Application.consoleLogPath))
		{
			throw new Exception("Log file not available");
		}
		try
		{
			string text = Path.Combine(Application.temporaryCachePath, Path.GetTempFileName());
			File.Copy(Application.consoleLogPath, text, overwrite: true);
			string result = File.ReadAllText(text);
			File.Delete(text);
			return result;
		}
		catch (Exception ex)
		{
			Log.Error("Failed to get log file: " + ex.Message);
			return "Failed to get log file: " + ex.Message;
		}
	}

	[ProximaCommand("Internal", "", "", "", "")]
	public static string GetPreviousLogFile()
	{
		if (string.IsNullOrEmpty(Application.consoleLogPath))
		{
			throw new Exception("Log file not available");
		}
		try
		{
			return File.ReadAllText(Application.consoleLogPath.Replace(".log", "-prev.log"));
		}
		catch (Exception ex)
		{
			Log.Error("Failed to get previous log file: " + ex.Message);
			return "Failed to get previous log file: " + ex.Message;
		}
	}

	[ProximaCommand("Internal", "", "", "", "")]
	public static bool GetLogFilesAvailable()
	{
		if (!string.IsNullOrEmpty(Application.consoleLogPath))
		{
			return File.Exists(Application.consoleLogPath);
		}
		return false;
	}
}
