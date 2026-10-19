using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

namespace Fundamental;

public static class LogCollector
{
	public static readonly Dictionary<string, List<LogData>> Logs = new Dictionary<string, List<LogData>>();

	public static readonly List<LogData> LogQueue = new List<LogData>();

	public static bool BanAddAll = false;

	public static bool CollapseLogs = true;

	public const string LogPathPrefBehind = "_LogPath";

	public const string LogCollapsePrefBehind = "_Collapse";

	public const string LogEnablePrefBehind = "_OutputFile";

	public const string LogFileBehind = "_Log.log";

	public const string DefaultLogPath = "../Logs";

	public static string DefaultLogFullPath = Path.GetFullPath("../Logs", Application.dataPath);

	public static int Revision { get; private set; }

	public static void AddInfo(string catalog, object message, object context)
	{
		LogData data = new LogData
		{
			message = message,
			context = context,
			logTime = DateTime.Now.TimeOfDay,
			logLevel = 0,
			count = 1,
			stackTrace = Environment.StackTrace
		};
		AddToDic(catalog, data);
	}

	public static void AddWarning(string catalog, object message, object context)
	{
		LogData data = new LogData
		{
			message = message,
			context = context,
			logTime = DateTime.Now.TimeOfDay,
			logLevel = 1,
			count = 1,
			stackTrace = Environment.StackTrace
		};
		AddToDic(catalog, data);
	}

	public static void AddError(string catalog, object message, object context)
	{
		LogData data = new LogData
		{
			message = message,
			context = context,
			logTime = DateTime.Now.TimeOfDay,
			logLevel = 2,
			count = 1,
			stackTrace = Environment.StackTrace
		};
		AddToDic(catalog, data);
	}

	private static void AddToDic(string catalog, LogData data)
	{
		if (string.IsNullOrEmpty(catalog))
		{
			catalog = "UnknownLog";
		}
		data.category = catalog;
		if (Logs.TryGetValue(catalog, out var value))
		{
			if (CollapseLogs)
			{
				int num = value.FindIndex((LogData l) => l.IsSameContent(data));
				if (num >= 0)
				{
					LogData value2 = value[num];
					value2.count++;
					value[num] = value2;
					if (!BanAddAll)
					{
						int num2 = LogQueue.FindIndex((LogData l) => l.IsSameContent(data));
						if (num2 >= 0)
						{
							LogData value3 = LogQueue[num2];
							value3.count++;
							LogQueue[num2] = value3;
						}
					}
					MarkChanged();
					return;
				}
			}
			data.index = value.Count;
			value.Add(data);
		}
		else
		{
			data.index = 0;
			List<LogData> value4 = new List<LogData> { data };
			Logs.Add(catalog, value4);
		}
		if (!BanAddAll)
		{
			if (CollapseLogs)
			{
				int num3 = LogQueue.FindIndex((LogData l) => l.IsSameContent(data));
				if (num3 >= 0)
				{
					LogData value5 = LogQueue[num3];
					value5.count++;
					LogQueue[num3] = value5;
				}
				else
				{
					data.index = LogQueue.Count;
					LogQueue.Add(data);
				}
			}
			else
			{
				data.index = LogQueue.Count;
				LogQueue.Add(data);
			}
		}
		MarkChanged();
	}

	public static void Clear()
	{
		LogQueue.Clear();
		Logs.Clear();
		MarkChanged();
	}

	public static void RemoveLogs(Predicate<LogData> predicate)
	{
		if (predicate == null)
		{
			return;
		}
		foreach (KeyValuePair<string, List<LogData>> log in Logs)
		{
			log.Value.RemoveAll(predicate);
			ResetIndexes(log.Value);
		}
		LogQueue.RemoveAll(predicate);
		ResetIndexes(LogQueue);
		MarkChanged();
	}

	private static void MarkChanged()
	{
		Revision++;
	}

	private static void ResetIndexes(List<LogData> logs)
	{
		for (int i = 0; i < logs.Count; i++)
		{
			LogData value = logs[i];
			value.index = i;
			logs[i] = value;
		}
	}
}
