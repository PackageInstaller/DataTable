using System;
using System.Collections.Generic;
using UnityEngine;

[DefaultExecutionOrder(-10000)]
public class SummerRaceModeValidationProbe : MonoBehaviour
{
	private struct ValidationSceneCase(string caseId, string label, SummerRaceFightManager.FightMode mode)
	{
		public readonly string CaseId = caseId;

		public readonly string Label = label;

		public readonly SummerRaceFightManager.FightMode Mode = mode;

		public readonly string SceneTag = caseId;
	}

	[SerializeField]
	private bool runOnStart = true;

	[SerializeField]
	private float initialStartDelaySeconds = 2.5f;

	[SerializeField]
	private float sampleInterval = 0.5f;

	[SerializeField]
	private float modeTimeoutSeconds = 18f;

	[SerializeField]
	private float interModeDelaySeconds = 1f;

	[SerializeField]
	private bool emitValidationSceneManifest = true;

	[SerializeField]
	private bool autoClearEnemies = true;

	[SerializeField]
	private float autoClearInterval = 0.35f;

	[SerializeField]
	private float challengeForceSettleAfter = 7f;

	private SummerRaceFightManager manager;

	private readonly ValidationSceneCase[] validationSceneCases = new ValidationSceneCase[6]
	{
		new ValidationSceneCase("flat_straight", "平地直行", SummerRaceFightManager.FightMode.Championship),
		new ValidationSceneCase("head_on_collision", "正面对撞", SummerRaceFightManager.FightMode.Championship),
		new ValidationSceneCase("wedge_insertion", "楔入", SummerRaceFightManager.FightMode.OneVsTwoPractice),
		new ValidationSceneCase("rollover_landing", "翻车落地", SummerRaceFightManager.FightMode.SurvivalPractice),
		new ValidationSceneCase("front_small_back_large_or_front_large_back_small", "前小后大/前大后小", SummerRaceFightManager.FightMode.Challenge),
		new ValidationSceneCase("high_weapon_recoil", "高位武器 recoil", SummerRaceFightManager.FightMode.Challenge)
	};

	private readonly SummerRaceFightManager.FightMode[] modeOrder = new SummerRaceFightManager.FightMode[4]
	{
		(SummerRaceFightManager.FightMode)1919251553,
		(SummerRaceFightManager.FightMode)1701865808,
		(SummerRaceFightManager.FightMode)1835365449,
		(SummerRaceFightManager.FightMode)1634623821
	};

	private int currentModeIndex = -1;

	private int passedModes;

	private int finishedModes;

	private int pendingModeIndex = -1;

	private bool suiteRunning;

	private bool challengeForcedSettle;

	private bool validationSceneManifestLogged;

	private float modeStartAt;

	private float nextModeStartAt;

	private float nextSampleAt;

	private float nextAutoClearAt;

	private string lastMode = string.Empty;

	private string lastPhase = string.Empty;

	private int lastWave = -1;

	private bool validationControlRegistered;

	private bool validationGateRejectedLogged;

	private void Awake()
	{
		if (runOnStart && Application.isPlaying && EnsureStandaloneValidationGate())
		{
			manager = UnityEngine.Object.FindObjectOfType<SummerRaceFightManager>();
			if (manager == null)
			{
				Debug.LogWarning("[SummerRace][ModeProbe] manager missing.");
			}
			else
			{
				EnsureValidationCatalogSourceConfigured();
			}
		}
	}

	private void OnEnable()
	{
		if (!runOnStart || !Application.isPlaying || !EnsureStandaloneValidationGate())
		{
			return;
		}
		if (manager == null)
		{
			manager = UnityEngine.Object.FindObjectOfType<SummerRaceFightManager>();
			if (manager == null)
			{
				return;
			}
		}
		EnsureValidationCatalogSourceConfigured();
	}

	private void Start()
	{
		if (!runOnStart)
		{
			return;
		}
		if (!EnsureStandaloneValidationGate())
		{
			base.enabled = false;
			return;
		}
		manager = SummerRaceFightManager.Instance;
		if (manager == null)
		{
			manager = UnityEngine.Object.FindObjectOfType<SummerRaceFightManager>();
		}
		if (manager == null)
		{
			Debug.LogWarning("[SummerRace][ModeProbe] manager not found");
			base.enabled = false;
			return;
		}
		SummerRaceFightManager.SetValidationControlEnabled(enabled: true);
		validationControlRegistered = true;
		suiteRunning = true;
		pendingModeIndex = 0;
		nextModeStartAt = Time.unscaledTime + Mathf.Max(0.2f, initialStartDelaySeconds);
		EmitValidationSceneManifest();
	}

	private void OnDisable()
	{
		if (Application.isPlaying && validationControlRegistered)
		{
			SummerRaceFightManager.SetValidationControlEnabled(enabled: false);
			validationControlRegistered = false;
		}
	}

	private void Update()
	{
		if (!suiteRunning || manager == null)
		{
			return;
		}
		if (pendingModeIndex >= 0)
		{
			if (!(Time.unscaledTime < nextModeStartAt))
			{
				StartMode(pendingModeIndex);
				pendingModeIndex = -1;
			}
			return;
		}
		float unscaledTime = Time.unscaledTime;
		if (unscaledTime >= nextSampleAt)
		{
			nextSampleAt = unscaledTime + Mathf.Max(0.05f, sampleInterval);
			string text = ReadRuntimeMode();
			int num = ReadRuntimeWave();
			bool flag = lastMode != text || lastPhase != manager.DebugPhase || lastWave != num;
			if (flag || manager.DebugPhase == "Result")
			{
				LogSnapshot(flag ? "change" : "result");
			}
		}
		if (autoClearEnemies && manager.DebugPhase == "Battle")
		{
			TickAutoClearEnemies(unscaledTime);
			if (!challengeForcedSettle && IsRuntimeMode(ReadRuntimeMode(), SummerRaceFightManager.FightMode.Challenge) && unscaledTime - modeStartAt >= challengeForceSettleAfter)
			{
				challengeForcedSettle = true;
				manager.OnPlayerDefeated();
				Debug.Log("[SummerRace][ModeProbe] force-settle challenge via OnPlayerDefeated");
			}
		}
		if (manager.DebugPhase == "Result")
		{
			FinishCurrentMode("result");
			return;
		}
		float num2 = Mathf.Clamp(modeTimeoutSeconds, 5f, 20f);
		if (unscaledTime - modeStartAt >= num2)
		{
			Debug.LogWarning("[SummerRace][ModeProbe] timeout mode=" + ReadRuntimeMode() + " phase=" + manager.DebugPhase + " t=" + (unscaledTime - modeStartAt).ToString("F1"));
			FinishCurrentMode("timeout");
		}
	}

	[ContextMenu("Validation/Emit Scene Manifest")]
	public void EmitValidationSceneManifest()
	{
		if (!validationSceneManifestLogged && emitValidationSceneManifest)
		{
			validationSceneManifestLogged = true;
			Debug.Log("[SummerRace][ModeProbe][VALIDATE][SCENE] case-count=" + validationSceneCases.Length);
			for (int i = 0; i < validationSceneCases.Length; i++)
			{
				EmitValidationSceneCase(i);
			}
		}
	}

	[ContextMenu("Validation/Emit First Scene Case")]
	public void EmitFirstValidationSceneCase()
	{
		EmitValidationSceneCase(0);
	}

	public void EmitValidationSceneCase(int caseIndex)
	{
		if (caseIndex < 0 || caseIndex >= validationSceneCases.Length)
		{
			Debug.LogWarning("[SummerRace][ModeProbe][VALIDATE][SCENE][CASE] invalid-index=" + caseIndex + " total=" + validationSceneCases.Length);
			return;
		}
		ValidationSceneCase validationSceneCase = validationSceneCases[caseIndex];
		Debug.Log("[SummerRace][ModeProbe][VALIDATE][SCENE][CASE] index=" + (caseIndex + 1) + "/" + validationSceneCases.Length + " id=" + validationSceneCase.CaseId + " scene=" + validationSceneCase.SceneTag + " label=" + validationSceneCase.Label + " mode=" + validationSceneCase.Mode);
	}

	private bool EnsureStandaloneValidationGate()
	{
		if (SummerRaceLuaRuntimeBootstrap.IsStandaloneValidationBootstrapEnabled)
		{
			if (SummerRaceLuaRuntimeBootstrap.IsValidationOutGamePresetEnabled)
			{
				if (!validationGateRejectedLogged)
				{
					validationGateRejectedLogged = true;
					Debug.Log("[SummerRace][ModeProbe] validation outgame preset is enabled; mode suite probe will not run.");
				}
				return false;
			}
			return true;
		}
		SummerRaceLuaRuntimeBootstrap summerRaceLuaRuntimeBootstrap = UnityEngine.Object.FindObjectOfType<SummerRaceLuaRuntimeBootstrap>();
		if (summerRaceLuaRuntimeBootstrap != null && summerRaceLuaRuntimeBootstrap.StandaloneValidationBootstrapEnabledInScene)
		{
			return true;
		}
		if (!validationGateRejectedLogged)
		{
			validationGateRejectedLogged = true;
			Debug.LogWarning("[SummerRace][ModeProbe] standalone validation bootstrap is disabled; probe will not run.");
		}
		return false;
	}

	private void EnsureValidationCatalogSourceConfigured()
	{
		if (manager == null || manager.DebugHasExplicitCatalogSource())
		{
			return;
		}
		SummerRaceBuildDatabaseSO summerRaceBuildDatabaseSO = AssetManager.Load<SummerRaceBuildDatabaseSO>("SummerRaceActivity/Config/SummerRaceBuildDatabase");
		if (summerRaceBuildDatabaseSO == null)
		{
			Debug.LogWarning("[SummerRace][ModeProbe] failed to load SummerRaceBuildDatabase from AssetManager.");
			return;
		}
		string[] array = ResolveEnemyIds(summerRaceBuildDatabaseSO);
		if (array.Length == 0)
		{
			Debug.LogWarning("[SummerRace][ModeProbe] no enemy ids resolved from build database.");
			return;
		}
		SummerRaceActivityStageSourceRecord[] array2 = BuildValidationStages(array);
		if (!manager.DebugTryConfigureValidationCatalogSources("SummerRaceBuildDatabase", array2))
		{
			Debug.LogWarning("[SummerRace][ModeProbe] validation catalog source injection rejected by manager.");
		}
		else
		{
			Debug.Log("[SummerRace][ModeProbe] injected explicit validation catalog sources: stages=" + array2.Length);
		}
	}

	private static string[] ResolveEnemyIds(SummerRaceBuildDatabaseSO buildDatabase)
	{
		if (buildDatabase == null || buildDatabase.buildDefs == null || buildDatabase.buildDefs.Count == 0)
		{
			return Array.Empty<string>();
		}
		List<string> list = new List<string>(buildDatabase.buildDefs.Count);
		for (int i = 0; i < buildDatabase.buildDefs.Count; i++)
		{
			SummerRaceBuildDefSO summerRaceBuildDefSO = buildDatabase.buildDefs[i];
			if (!(summerRaceBuildDefSO == null))
			{
				string item = NormalizeId((!string.IsNullOrWhiteSpace(summerRaceBuildDefSO.buildName)) ? summerRaceBuildDefSO.buildName : summerRaceBuildDefSO.name, "build_" + i);
				if (!list.Contains(item))
				{
					list.Add(item);
				}
			}
		}
		return list.ToArray();
	}

	private static SummerRaceActivityStageSourceRecord[] BuildValidationStages(string[] enemyIds)
	{
		int cursor = 0;
		return new SummerRaceActivityStageSourceRecord[4]
		{
			new SummerRaceActivityStageSourceRecord
			{
				Id = "tank_tournament_preview",
				DisplayName = "Tournament Preview",
				Mode = SummerRaceActivityMode.Tournament,
				SortOrder = 10,
				IsMainline = true,
				Waves = BuildWaveRecords(new int[3] { 1685217635, 1835099999, 1968331877 }, 0.4f, enemyIds, ref cursor)
			},
			new SummerRaceActivityStageSourceRecord
			{
				Id = "tank_survival_preview",
				DisplayName = "Survival Preview",
				Mode = SummerRaceActivityMode.SurvivalPractice,
				SortOrder = 20,
				IsMainline = false,
				SurvivalDurationSeconds = 12,
				SurvivalRandomPool = BuildSpawnEntries(enemyIds.Length, enemyIds, ref cursor)
			},
			new SummerRaceActivityStageSourceRecord
			{
				Id = "tank_1v2_preview",
				DisplayName = "1v2 Preview",
				Mode = SummerRaceActivityMode.OneVsTwoPractice,
				SortOrder = 30,
				IsMainline = false,
				Waves = BuildRepeatedWaveRecords(1, 2, 0.4f, enemyIds, ref cursor)
			},
			new SummerRaceActivityStageSourceRecord
			{
				Id = "tank_challenge_preview",
				DisplayName = "Challenge Preview",
				Mode = SummerRaceActivityMode.Challenge,
				SortOrder = 40,
				IsMainline = false,
				ChallengePoolId = "tank_challenge_pool",
				ChallengeRandomPool = BuildSpawnEntries(enemyIds.Length, enemyIds, ref cursor)
			}
		};
	}

	private static SummerRaceActivityWaveSourceRecord[] BuildWaveRecords(int[] counts, float spawnInterval, string[] enemyIds, ref int cursor)
	{
		SummerRaceActivityWaveSourceRecord[] array = new SummerRaceActivityWaveSourceRecord[counts.Length];
		for (int i = 0; i < counts.Length; i++)
		{
			array[i] = new SummerRaceActivityWaveSourceRecord
			{
				WaveIndex = i + 1,
				SpawnIntervalSeconds = spawnInterval,
				MaxAliveEnemies = Mathf.Max(1, counts[i]),
				Enemies = BuildSpawnEntries(Mathf.Max(1, counts[i]), enemyIds, ref cursor)
			};
		}
		return array;
	}

	private static SummerRaceActivityWaveSourceRecord[] BuildRepeatedWaveRecords(int waveCount, int enemiesPerWave, float spawnInterval, string[] enemyIds, ref int cursor)
	{
		SummerRaceActivityWaveSourceRecord[] array = new SummerRaceActivityWaveSourceRecord[waveCount];
		for (int i = 0; i < waveCount; i++)
		{
			array[i] = new SummerRaceActivityWaveSourceRecord
			{
				WaveIndex = i + 1,
				SpawnIntervalSeconds = spawnInterval,
				MaxAliveEnemies = Mathf.Max(1, enemiesPerWave),
				Enemies = BuildSpawnEntries(Mathf.Max(1, enemiesPerWave), enemyIds, ref cursor)
			};
		}
		return array;
	}

	private static SummerRaceActivityEnemySpawnSourceRecord[] BuildSpawnEntries(int count, string[] enemyIds, ref int cursor)
	{
		SummerRaceActivityEnemySpawnSourceRecord[] array = new SummerRaceActivityEnemySpawnSourceRecord[Mathf.Max(1, count)];
		for (int i = 0; i < array.Length; i++)
		{
			string enemyId = enemyIds[cursor % enemyIds.Length];
			cursor++;
			array[i] = new SummerRaceActivityEnemySpawnSourceRecord
			{
				EnemyId = enemyId,
				Count = 1,
				SpawnDelaySeconds = 0f,
				Weight = 1
			};
		}
		return array;
	}

	private static string NormalizeId(string value, string fallback)
	{
		string text = (string.IsNullOrWhiteSpace(value) ? fallback : value.Trim());
		char[] array = new char[text.Length];
		int num = 0;
		for (int i = 0; i < text.Length; i++)
		{
			char c = char.ToLowerInvariant(text[i]);
			if ((c >= 'a' && c <= 'z') || (c >= '0' && c <= '9'))
			{
				array[num++] = c;
			}
			else if (num > 0 && array[num - 1] != '_')
			{
				array[num++] = '_';
			}
		}
		if (num == 0)
		{
			return fallback;
		}
		if (array[num - 1] == '_')
		{
			num--;
		}
		return new string(array, 0, num);
	}

	private SummerRaceBattleSnapshot ReadRuntimeSnapshot()
	{
		if (!(manager != null))
		{
			return null;
		}
		return manager.GetBattleRuntimeSnapshot();
	}

	private string ReadRuntimeMode()
	{
		SummerRaceBattleSnapshot summerRaceBattleSnapshot = ReadRuntimeSnapshot();
		if (summerRaceBattleSnapshot == null)
		{
			return string.Empty;
		}
		return summerRaceBattleSnapshot.mode;
	}

	private static bool IsRuntimeMode(string runtimeMode, SummerRaceFightManager.FightMode mode)
	{
		return string.Equals(runtimeMode, mode.ToString(), StringComparison.OrdinalIgnoreCase);
	}

	private int ReadRuntimeWave()
	{
		return ReadRuntimeSnapshot()?.wave ?? 0;
	}

	private float ReadRuntimeTimer()
	{
		return ReadRuntimeSnapshot()?.timer ?? 0f;
	}

	private float ReadRuntimeHp()
	{
		return ReadRuntimeSnapshot()?.hp ?? 0f;
	}

	private float ReadRuntimeEnergy()
	{
		return ReadRuntimeSnapshot()?.energy ?? 0f;
	}

	private void StartMode(int modeIndex)
	{
		if (modeIndex >= modeOrder.Length)
		{
			suiteRunning = false;
			Debug.Log("[SummerRace][ModeProbe] suite-complete pass=" + passedModes + "/" + modeOrder.Length + " finished=" + finishedModes);
			base.enabled = false;
			return;
		}
		currentModeIndex = modeIndex;
		SummerRaceFightManager.FightMode mode = modeOrder[modeIndex];
		if (!manager.DebugTryRestartModeForValidation(mode))
		{
			Debug.LogWarning("[SummerRace][ModeProbe] manager rejected validation mode restart: " + mode);
			FinishCurrentMode("rejected");
			return;
		}
		challengeForcedSettle = false;
		Time.timeScale = 1f;
		modeStartAt = Time.unscaledTime;
		nextSampleAt = modeStartAt + Mathf.Max(0.05f, sampleInterval);
		nextAutoClearAt = modeStartAt + Mathf.Max(0.1f, autoClearInterval);
		lastMode = string.Empty;
		lastPhase = string.Empty;
		lastWave = -1;
		Debug.Log("[SummerRace][ModeProbe] mode-start mode=" + mode.ToString() + " idx=" + (modeIndex + 1) + "/" + modeOrder.Length);
		LogSnapshot("start");
	}

	private void FinishCurrentMode(string reason)
	{
		bool debugResultWin = manager.DebugResultWin;
		string text = (string.IsNullOrEmpty(manager.DebugResultText) ? manager.DebugPhase : manager.DebugResultText);
		finishedModes++;
		string text2 = ReadRuntimeMode();
		if (debugResultWin || IsRuntimeMode(text2, SummerRaceFightManager.FightMode.Challenge))
		{
			passedModes++;
		}
		Debug.Log("[SummerRace][ModeProbe] mode-finish reason=" + reason + " mode=" + text2 + " win=" + debugResultWin + " result=" + text + " wave=" + ReadRuntimeWave() + " timer=" + ReadRuntimeTimer().ToString("F1"));
		pendingModeIndex = currentModeIndex + 1;
		nextModeStartAt = Time.unscaledTime + Mathf.Max(0.1f, interModeDelaySeconds);
	}

	private void LogSnapshot(string tag)
	{
		if (!(manager == null))
		{
			string text = ReadRuntimeMode();
			int num = ReadRuntimeWave();
			float num2 = ReadRuntimeTimer();
			float num3 = ReadRuntimeHp();
			float num4 = ReadRuntimeEnergy();
			lastMode = text;
			lastPhase = manager.DebugPhase;
			lastWave = num;
			Debug.Log("[SummerRace][ModeProbe] " + tag + " mode=" + text + " phase=" + manager.DebugPhase + " wave=" + num + " timer=" + num2.ToString("F1") + " hp=" + num3.ToString("F1") + " energy=" + num4.ToString("F1"));
		}
	}

	private void TickAutoClearEnemies(float now)
	{
		if (now < nextAutoClearAt)
		{
			return;
		}
		nextAutoClearAt = now + Mathf.Max(0.1f, autoClearInterval);
		SummerRaceEnemy[] array = UnityEngine.Object.FindObjectsOfType<SummerRaceEnemy>();
		int num = 0;
		foreach (SummerRaceEnemy summerRaceEnemy in array)
		{
			if (!(summerRaceEnemy == null))
			{
				summerRaceEnemy.TakeDamage(9999);
				num++;
			}
		}
		if (num > 0)
		{
			Debug.Log("[SummerRace][ModeProbe] auto-clear enemies=" + num + " mode=" + ReadRuntimeMode() + " wave=" + ReadRuntimeWave());
		}
	}
}
