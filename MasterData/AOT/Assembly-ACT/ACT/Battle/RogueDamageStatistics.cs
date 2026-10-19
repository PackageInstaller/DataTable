using System.Collections.Generic;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public sealed class RogueDamageStatistics
{
	public const int MagicPointsKey = 0;

	private const int TotalKillCountKey = 1;

	private const int TotalDamageTakenKey = 2;

	private const int TotalDamageDealtKey = 3;

	private const int DamageCountKey = 4;

	private const int CriticalCountKey = 5;

	private const int MaxDamageDealtKey = 6;

	private const int MinDamageDealtKey = 7;

	private const int ElapsedSecondsKey = 8;

	private const int NormalKillCountKey = 9;

	private const int EliteKillCountKey = 10;

	private readonly Dictionary<int, int> m_MapDamageAccumulation = new Dictionary<int, int>();

	private readonly Dictionary<int, int> m_MapKillCount = new Dictionary<int, int>();

	private float m_ElapsedSecondsBeforeCurrentSession;

	public bool IsRecording { get; private set; }

	public int TotalDamageDealt { get; private set; }

	public int DamageCount { get; private set; }

	public int MaxDamageDealt { get; private set; }

	public int MinDamageDealt { get; private set; }

	public int CriticalCount { get; private set; }

	public int TotalDamageTaken { get; private set; }

	public int TotalKillCount { get; private set; }

	public int NormalKillCount { get; private set; }

	public int EliteKillCount { get; private set; }

	public float ElapsedTime
	{
		get
		{
			if (!IsRecording)
			{
				return m_ElapsedSecondsBeforeCurrentSession;
			}
			return m_ElapsedSecondsBeforeCurrentSession + GetCurrentWorldRuntime();
		}
	}

	public float DamagePerSecond
	{
		get
		{
			if (!(ElapsedTime > 0f))
			{
				return 0f;
			}
			return (float)TotalDamageDealt / ElapsedTime;
		}
	}

	public void RestoreFromBattleInfo(IDictionary<int, int> battleInfo)
	{
		m_MapDamageAccumulation.Clear();
		m_MapKillCount.Clear();
		TotalKillCount = GetBattleInfoValueOrDefault(battleInfo, 1);
		TotalDamageTaken = GetBattleInfoValueOrDefault(battleInfo, 2);
		TotalDamageDealt = GetBattleInfoValueOrDefault(battleInfo, 3);
		DamageCount = GetBattleInfoValueOrDefault(battleInfo, 4);
		CriticalCount = GetBattleInfoValueOrDefault(battleInfo, 5);
		MaxDamageDealt = GetBattleInfoValueOrDefault(battleInfo, 6);
		MinDamageDealt = GetBattleInfoValueOrDefault(battleInfo, 7);
		NormalKillCount = GetBattleInfoValueOrDefault(battleInfo, 9);
		EliteKillCount = GetBattleInfoValueOrDefault(battleInfo, 10);
		m_ElapsedSecondsBeforeCurrentSession = Mathf.Max(GetBattleInfoValueOrDefault(battleInfo, 8), 0);
		IsRecording = false;
	}

	public void StartRecording()
	{
		if (!IsRecording)
		{
			IsRecording = true;
		}
	}

	public void PauseRecording()
	{
		FreezeCurrentSession();
	}

	public void ResumeRecording()
	{
		StartRecording();
	}

	public void Clear()
	{
		m_MapDamageAccumulation.Clear();
		m_MapKillCount.Clear();
		IsRecording = false;
		m_ElapsedSecondsBeforeCurrentSession = 0f;
		TotalDamageDealt = 0;
		DamageCount = 0;
		MaxDamageDealt = 0;
		MinDamageDealt = 0;
		CriticalCount = 0;
		TotalDamageTaken = 0;
		TotalKillCount = 0;
		NormalKillCount = 0;
		EliteKillCount = 0;
	}

	public void Freeze()
	{
		FreezeCurrentSession();
	}

	public void RecordDamageTaken(int mapNodeId, int damage)
	{
		AddToMap(m_MapDamageAccumulation, mapNodeId, damage);
		TotalDamageTaken += damage;
	}

	public void RecordMonsterDeath(int mapNodeId, bool isElite)
	{
		AddToMap(m_MapKillCount, mapNodeId, 1);
		TotalKillCount++;
		if (isElite)
		{
			EliteKillCount++;
		}
		else
		{
			NormalKillCount++;
		}
	}

	public void RecordDamageDealt(int actualDamage, bool critical)
	{
		if (IsRecording && actualDamage > 0)
		{
			TotalDamageDealt += actualDamage;
			DamageCount++;
			MaxDamageDealt = Mathf.Max(MaxDamageDealt, actualDamage);
			MinDamageDealt = ((MinDamageDealt == 0) ? actualDamage : Mathf.Min(MinDamageDealt, actualDamage));
			if (critical)
			{
				CriticalCount++;
			}
		}
	}

	public float GetMapDamage(int mapNodeId)
	{
		if (!m_MapDamageAccumulation.TryGetValue(mapNodeId, out var value))
		{
			return 0f;
		}
		return value;
	}

	public Dictionary<int, int> GetAllMapDamage()
	{
		return m_MapDamageAccumulation;
	}

	public void ClearDamageTaken()
	{
		m_MapDamageAccumulation.Clear();
		TotalDamageTaken = 0;
	}

	public int GetMapKillCount(int mapNodeId)
	{
		if (!m_MapKillCount.TryGetValue(mapNodeId, out var value))
		{
			return 0;
		}
		return value;
	}

	public Dictionary<int, int> GetAllMapKillCount()
	{
		return m_MapKillCount;
	}

	public void ClearKillCount()
	{
		m_MapKillCount.Clear();
		TotalKillCount = 0;
	}

	public Dictionary<int, int> CreateBattleInfo(int magicPoints)
	{
		return new Dictionary<int, int>
		{
			[0] = magicPoints,
			[1] = TotalKillCount,
			[2] = TotalDamageTaken,
			[3] = TotalDamageDealt,
			[4] = DamageCount,
			[5] = CriticalCount,
			[6] = MaxDamageDealt,
			[7] = MinDamageDealt,
			[8] = Mathf.Max(Mathf.FloorToInt(ElapsedTime), 0),
			[9] = NormalKillCount,
			[10] = EliteKillCount
		};
	}

	public RogueDamageStatisticsSnapshot CreateSnapshot()
	{
		return new RogueDamageStatisticsSnapshot(IsRecording, TotalDamageDealt, DamageCount, MaxDamageDealt, MinDamageDealt, CriticalCount, TotalDamageTaken, TotalKillCount, NormalKillCount, EliteKillCount, ElapsedTime, DamagePerSecond);
	}

	private static void AddToMap(Dictionary<int, int> map, int mapNodeId, int value)
	{
		if (map.TryGetValue(mapNodeId, out var value2))
		{
			map[mapNodeId] = value2 + value;
		}
		else
		{
			map[mapNodeId] = value;
		}
	}

	private static int GetBattleInfoValueOrDefault(IDictionary<int, int> battleInfo, int key)
	{
		if (battleInfo == null || !battleInfo.TryGetValue(key, out var value))
		{
			return 0;
		}
		return value;
	}

	private static float GetCurrentWorldRuntime()
	{
		return Mathf.Max(Singleton<GameManager>.instance.worldManager.GetCurrentWorldRuntime(), 0f);
	}

	private void FreezeCurrentSession()
	{
		if (IsRecording)
		{
			m_ElapsedSecondsBeforeCurrentSession = ElapsedTime;
			IsRecording = false;
		}
	}
}
