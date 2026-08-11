using System;
using System.Diagnostics;
using System.IO;
using System.Threading.Tasks;
using Cysharp.Text;
using UnityEngine;

namespace Ase;

public class BattleProgressLog
{
	private static BattleProgressLog _instance;

	private string _dumpPath = Path.Combine(Application.dataPath, "../BattleProgressData");

	private Utf16ValueStringBuilder sb_property;

	private Utf16ValueStringBuilder sb_damage;

	private int _actorId;

	private long _roomId;

	private int _playerNumber;

	private int _heroConfigId;

	private bool isWriteLog;

	public static bool IsOpen;

	public static BattleProgressLog Instance
	{
		get
		{
			if (_instance == null)
			{
				_instance = new BattleProgressLog();
			}
			return _instance;
		}
	}

	public BattleProgressLog()
	{
		sb_property = ZString.CreateStringBuilder();
		sb_damage = ZString.CreateStringBuilder();
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void WriteLog(BattleProgressLogEnum logEnum, string str)
	{
		if (IsOpen)
		{
			Instance?.Append(logEnum, str);
		}
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void WriteLine(BattleProgressLogEnum logEnum, string str = "")
	{
		if (IsOpen)
		{
			Instance?.AppendLine(logEnum, str);
		}
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_DEBUG_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	public static void WriteLine(BattleProgressLogEnum logEnum, int line)
	{
		if (IsOpen)
		{
			Instance?.AppendLine(logEnum, line);
		}
	}

	public static void SyncSave()
	{
		if (IsOpen)
		{
			Instance?.Save();
		}
	}

	public static void Clear()
	{
		if (IsOpen)
		{
			Instance?.OnDispose();
		}
	}

	private void Append(BattleProgressLogEnum logEnum, string str)
	{
		switch (logEnum)
		{
		case BattleProgressLogEnum.Property:
			sb_property.Append(str);
			break;
		case BattleProgressLogEnum.Damage:
			sb_damage.Append(str);
			break;
		}
	}

	private void AppendLine(BattleProgressLogEnum logEnum, string str)
	{
		switch (logEnum)
		{
		case BattleProgressLogEnum.Property:
			sb_property.AppendLine(str);
			break;
		case BattleProgressLogEnum.Damage:
			sb_damage.AppendLine(str);
			break;
		}
	}

	private void AppendLine(BattleProgressLogEnum logEnum, int line = 1)
	{
		switch (logEnum)
		{
		case BattleProgressLogEnum.Property:
		{
			for (int j = 0; j < line; j++)
			{
				sb_property.AppendLine();
			}
			break;
		}
		case BattleProgressLogEnum.Damage:
		{
			for (int i = 0; i < line; i++)
			{
				sb_damage.AppendLine();
			}
			break;
		}
		}
	}

	public void Save()
	{
		Task.Run((Action)RecodeData);
	}

	private void RecodeData()
	{
		if (!Directory.Exists(_dumpPath))
		{
			Directory.CreateDirectory(_dumpPath);
		}
		string path = _dumpPath + "/Log_属性_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".txt";
		WriteFile(path, sb_property);
		path = _dumpPath + "/Log_伤害_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".txt";
		WriteFile(path, sb_damage);
	}

	private void WriteFile(string path, Utf16ValueStringBuilder content)
	{
		using StreamWriter streamWriter = new StreamWriter(path, append: true);
		streamWriter.WriteLine(content);
		streamWriter.Flush();
		streamWriter.Dispose();
	}

	public void OnDispose()
	{
		sb_property.Clear();
		sb_damage.Clear();
	}
}
