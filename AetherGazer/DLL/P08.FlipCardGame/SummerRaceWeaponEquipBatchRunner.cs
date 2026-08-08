using System;
using System.Collections;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

public sealed class SummerRaceWeaponEquipBatchRunner : MonoBehaviour
{
	[Serializable]
	private sealed class BattleCase
	{
		public string caseId = string.Empty;

		public string mode = "challenge";

		public string stageId = string.Empty;

		public string weaponKey = string.Empty;

		public string equipKey = string.Empty;
	}

	[Serializable]
	private sealed class LuaCasePayload
	{
		public string caseId = string.Empty;

		public string mode = "challenge";

		public string stageId = string.Empty;

		public string source = string.Empty;

		public string weaponKey = string.Empty;

		public string equipKey = string.Empty;
	}

	[Serializable]
	private sealed class BattleCaseListPayload
	{
		public BattleCase[] items = Array.Empty<BattleCase>();

		public string[] missing = Array.Empty<string>();
	}

	[SerializeField]
	private bool runOnStart;

	[SerializeField]
	private bool dontDestroyOnLoad = true;

	[SerializeField]
	private float waitLuaReadyTimeout = 90f;

	[SerializeField]
	private float intervalBetweenCases = 1.5f;

	[SerializeField]
	private float observeSecondsPerCase = 8f;

	[SerializeField]
	private bool autoLeaveBetweenCases = true;

	[SerializeField]
	private bool verboseLog = true;

	[SerializeField]
	private string defaultMode = "challenge";

	[SerializeField]
	private string defaultStageId = string.Empty;

	private Coroutine runRoutine;

	private bool isRunning;

	private void Awake()
	{
		if (dontDestroyOnLoad)
		{
			UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
		}
	}

	private void Start()
	{
		if (runOnStart)
		{
			StartBatch();
		}
	}

	[ContextMenu("Start SummerRace Weapon+Equip Batch")]
	public void StartBatch()
	{
		if (!isRunning)
		{
			runRoutine = StartCoroutine(RunBatchRoutine());
		}
	}

	[ContextMenu("Stop SummerRace Weapon+Equip Batch")]
	public void StopBatch()
	{
		if (runRoutine != null)
		{
			StopCoroutine(runRoutine);
			runRoutine = null;
		}
		isRunning = false;
	}

	private IEnumerator RunBatchRoutine()
	{
		isRunning = true;
		yield return WaitLuaReadyOrTimeout();
		if (!LuaHelper.IsLuaClientInited() || LuaHelper.GetLuaState() == null)
		{
			isRunning = false;
			runRoutine = null;
			yield break;
		}
		EnsureLuaDriverBootstrap();
		List<BattleCase> cases = BuildCases();
		Log("[SummerRace][BatchRunner] caseCount=" + cases.Count);
		for (int i = 0; i < cases.Count; i++)
		{
			BattleCase testCase = cases[i];
			if (!RunLuaBattleCase(testCase, i + 1, cases.Count, out var trace))
			{
				Debug.LogError("[SummerRace][BatchRunner] launch failed: " + trace);
				continue;
			}
			Log("[SummerRace][BatchRunner] launch ok: " + trace);
			yield return new WaitForSeconds(Mathf.Max(0.1f, observeSecondsPerCase));
			if (autoLeaveBetweenCases)
			{
				TryLeaveBattleToMain();
				yield return new WaitForSeconds(Mathf.Max(0.1f, intervalBetweenCases));
			}
		}
		Log("[SummerRace][BatchRunner] completed.");
		isRunning = false;
		runRoutine = null;
	}

	private IEnumerator WaitLuaReadyOrTimeout()
	{
		float deadline = Time.realtimeSinceStartup + Mathf.Max(3f, waitLuaReadyTimeout);
		while (Time.realtimeSinceStartup < deadline)
		{
			if (LuaHelper.IsLuaClientInited() && LuaHelper.GetLuaState() != null)
			{
				yield break;
			}
			yield return null;
		}
		Debug.LogError("[SummerRace][BatchRunner] Lua runtime not ready before timeout.");
	}

	private void EnsureLuaDriverBootstrap()
	{
		LuaState luaState = LuaHelper.GetLuaState();
		if (luaState == null)
		{
			throw new InvalidOperationException("[SummerRace][BatchRunner] LuaState is null.");
		}
		luaState.DoString("\nSummerRaceBatchRunnerDriver = SummerRaceBatchRunnerDriver or {}\n\nfunction SummerRaceBatchRunnerDriver.RunCase(caseJson)\n    local okJson, cjson = pcall(require, 'cjson')\n    if not okJson or type(cjson) ~= 'table' then\n        return 'ERR|cjson-missing'\n    end\n\n    local okDecode, cfg = pcall(cjson.decode, caseJson or '{}')\n    if not okDecode or type(cfg) ~= 'table' then\n        return 'ERR|decode-failed:' .. tostring(cfg)\n    end\n\n    local action = rawget(_G, 'SummerRaceAction')\n    local data = rawget(_G, 'SummerRaceData')\n    if type(action) ~= 'table' or type(action.LaunchBattle) ~= 'function' then\n        return 'ERR|action-missing'\n    end\n    if type(data) ~= 'table' or type(data.BuildBattleLaunchPayload) ~= 'function' then\n        return 'ERR|data-missing'\n    end\n\n    local request = {\n        mode = cfg.mode,\n        source = cfg.source\n    }\n    if cfg.stageId ~= nil and tostring(cfg.stageId) ~= '' then\n        request.stageId = cfg.stageId\n    end\n\n    local payload = data:BuildBattleLaunchPayload(request)\n    if type(payload) ~= 'table' then\n        return 'ERR|payload-invalid'\n    end\n\n    payload.playerConfig = type(payload.playerConfig) == 'table' and payload.playerConfig or {}\n\n    if cfg.weaponKey ~= nil and tostring(cfg.weaponKey) ~= '' then\n        local weaponKeys = type(payload.playerConfig.weaponKeys) == 'table' and payload.playerConfig.weaponKeys or {}\n        if #weaponKeys > 0 then\n            weaponKeys[1] = tostring(cfg.weaponKey)\n        else\n            weaponKeys = { tostring(cfg.weaponKey) }\n        end\n        payload.playerConfig.weaponKeys = weaponKeys\n        payload.playerConfig.weaponOverrides = {}\n    end\n\n    if cfg.equipKey ~= nil and tostring(cfg.equipKey) ~= '' then\n        local equipKeys = type(payload.playerConfig.equipKeys) == 'table' and payload.playerConfig.equipKeys or {}\n        if #equipKeys > 0 then\n            equipKeys[1] = tostring(cfg.equipKey)\n        else\n            equipKeys = { tostring(cfg.equipKey) }\n        end\n        payload.playerConfig.equipKeys = equipKeys\n    end\n\n    local okLaunch, launchResult = pcall(function()\n        return action.LaunchBattle(payload)\n    end)\n    if not okLaunch then\n        return 'ERR|launch-error:' .. tostring(launchResult)\n    end\n\n    if launchResult ~= true then\n        return 'ERR|launch-return:' .. tostring(launchResult)\n    end\n\n    return 'OK|' .. string.format('case=%s mode=%s stageId=%s weapon=%s equip=%s',\n        tostring(cfg.caseId),\n        tostring(payload.mode),\n        tostring(payload.stageId),\n        tostring(cfg.weaponKey or ''),\n        tostring(cfg.equipKey or ''))\nend\n\nfunction SummerRaceBatchRunnerDriver.LeaveBattle()\n    local action = rawget(_G, 'SummerRaceAction')\n    if type(action) ~= 'table' or type(action.LeaveBattleToMain) ~= 'function' then\n        return 'ERR|leave-handler-missing'\n    end\n\n    local okLeave, leaveResult = pcall(function()\n        return action.LeaveBattleToMain()\n    end)\n    if not okLeave then\n        return 'ERR|leave-error:' .. tostring(leaveResult)\n    end\n\n    if leaveResult == true then\n        return 'OK|leave-result:true'\n    end\n\n    return 'ERR|leave-result:' .. tostring(leaveResult)\nend\n\nfunction SummerRaceBatchRunnerDriver.BuildCaseList(caseCfgJson)\n    local okJson, cjson = pcall(require, 'cjson')\n    if not okJson or type(cjson) ~= 'table' then\n        return ''\n    end\n\n    local cfg = {}\n    if type(caseCfgJson) == 'string' and caseCfgJson ~= '' then\n        local okDecode, decoded = pcall(cjson.decode, caseCfgJson)\n        if okDecode and type(decoded) == 'table' then\n            cfg = decoded\n        end\n    end\n\n    local data = rawget(_G, 'SummerRaceData')\n    if type(data) ~= 'table' or type(data.GetWeaponDefs) ~= 'function' or type(data.GetEquipDefs) ~= 'function' then\n        return ''\n    end\n\n    local function normalizeKey(value)\n        local key = string.lower(tostring(value or ''))\n        key = string.gsub(key, '[%s_%-%./]', '')\n        return key\n    end\n\n    local function findRuntimeKeyByAlias(defs, alias)\n        local normalizedAlias = normalizeKey(alias)\n        if normalizedAlias == '' then\n            return ''\n        end\n\n        for i = 1, #(defs or {}) do\n            local def = defs[i]\n            local key = tostring(def and def.assetName or '')\n            if key ~= '' and normalizeKey(key) == normalizedAlias then\n                return key\n            end\n        end\n\n        for i = 1, #(defs or {}) do\n            local def = defs[i]\n            local key = tostring(def and def.assetName or '')\n            if key ~= '' and string.find(normalizeKey(key), normalizedAlias, 1, true) ~= nil then\n                return key\n            end\n        end\n\n        return ''\n    end\n\n    local expectedWeaponAliases = {\n        'MachineGun',\n        'LaserCannon',\n        'RocketLauncher',\n        'Boomerang',\n        'ScatterShell',\n        'Drill',\n        'RotatingSaw',\n        'Shovel'\n    }\n    local expectedEquipAliases = {\n        'ShieldGenerator',\n        'Hook',\n        'BoxingGlove',\n        'Thruster',\n        'ElectricNet'\n    }\n\n    local mode = tostring(cfg.mode or 'challenge')\n    local stageId = tostring(cfg.stageId or '')\n    local cases = {}\n    local missing = {}\n    local weaponDefs = data:GetWeaponDefs() or {}\n    local equipDefs = data:GetEquipDefs() or {}\n\n    for i = 1, #expectedWeaponAliases do\n        local alias = expectedWeaponAliases[i]\n        local key = findRuntimeKeyByAlias(weaponDefs, alias)\n        if key == '' then\n            missing[#missing + 1] = 'weapon:' .. alias\n        else\n            cases[#cases + 1] = {\n                caseId = 'weapon_' .. alias,\n                mode = mode,\n                stageId = stageId,\n                weaponKey = key,\n                equipKey = ''\n            }\n        end\n    end\n\n    for i = 1, #expectedEquipAliases do\n        local alias = expectedEquipAliases[i]\n        local key = findRuntimeKeyByAlias(equipDefs, alias)\n        if key == '' then\n            missing[#missing + 1] = 'equip:' .. alias\n        else\n            cases[#cases + 1] = {\n                caseId = 'equip_' .. alias,\n                mode = mode,\n                stageId = stageId,\n                weaponKey = '',\n                equipKey = key\n            }\n        end\n    end\n\n    return cjson.encode({\n        items = cases,\n        missing = missing\n    })\nend\n", "SummerRaceWeaponEquipBatchRunner.cs");
	}

	private List<BattleCase> BuildCases()
	{
		List<BattleCase> list = new List<BattleCase>();
		LuaState luaState = LuaHelper.GetLuaState();
		if (luaState == null)
		{
			return list;
		}
		LuaFunction function = luaState.GetFunction("SummerRaceBatchRunnerDriver.BuildCaseList");
		if (function == null)
		{
			Debug.LogError("[SummerRace][BatchRunner] lua-function-missing:SummerRaceBatchRunnerDriver.BuildCaseList");
			return list;
		}
		string arg = JsonUtility.ToJson(new LuaCasePayload
		{
			mode = (string.IsNullOrWhiteSpace(defaultMode) ? "challenge" : defaultMode),
			stageId = defaultStageId
		});
		string text = function.Invoke<string, string>(arg);
		if (string.IsNullOrWhiteSpace(text))
		{
			Debug.LogError("[SummerRace][BatchRunner] BuildCaseList returned empty payload.");
			return list;
		}
		BattleCaseListPayload battleCaseListPayload = JsonUtility.FromJson<BattleCaseListPayload>(text);
		if (battleCaseListPayload == null || battleCaseListPayload.items == null)
		{
			Debug.LogError("[SummerRace][BatchRunner] BuildCaseList payload parse failed.");
			return list;
		}
		for (int i = 0; i < battleCaseListPayload.items.Length; i++)
		{
			BattleCase battleCase = battleCaseListPayload.items[i];
			if (battleCase != null)
			{
				list.Add(battleCase);
			}
		}
		if (battleCaseListPayload.missing != null && battleCaseListPayload.missing.Length != 0)
		{
			Debug.LogWarning("[SummerRace][BatchRunner] missing aliases: " + string.Join(",", battleCaseListPayload.missing));
		}
		return list;
	}

	private bool RunLuaBattleCase(BattleCase testCase, int index, int total, out string trace)
	{
		trace = string.Empty;
		LuaState luaState = LuaHelper.GetLuaState();
		if (luaState == null)
		{
			trace = "lua-state-null";
			return false;
		}
		string arg = JsonUtility.ToJson(new LuaCasePayload
		{
			caseId = testCase.caseId,
			mode = (string.IsNullOrWhiteSpace(testCase.mode) ? defaultMode : testCase.mode),
			stageId = (string.IsNullOrWhiteSpace(testCase.stageId) ? defaultStageId : testCase.stageId),
			source = $"batchRunner_{index}_{total}",
			weaponKey = testCase.weaponKey,
			equipKey = testCase.equipKey
		});
		LuaFunction function = luaState.GetFunction("SummerRaceBatchRunnerDriver.RunCase");
		if (function == null)
		{
			trace = "lua-function-missing:SummerRaceBatchRunnerDriver.RunCase";
			return false;
		}
		string text = function.Invoke<string, string>(arg);
		bool result = text?.StartsWith("OK|", StringComparison.Ordinal) ?? false;
		trace = ((text == null) ? "trace-empty" : text.Substring(Math.Min(3, text.Length)));
		return result;
	}

	private void TryLeaveBattleToMain()
	{
		LuaState luaState = LuaHelper.GetLuaState();
		if (luaState == null)
		{
			return;
		}
		LuaFunction function = luaState.GetFunction("SummerRaceBatchRunnerDriver.LeaveBattle");
		if (!(function == null))
		{
			string text = function.Invoke<string>();
			bool num = text?.StartsWith("OK|", StringComparison.Ordinal) ?? false;
			string text2 = ((text == null) ? "leave-trace-empty" : text.Substring(Math.Min(3, text.Length)));
			if (!num)
			{
				Debug.LogWarning("[SummerRace][BatchRunner] leave failed: " + text2);
			}
			else
			{
				Log("[SummerRace][BatchRunner] leave ok: " + text2);
			}
		}
	}

	private void Log(string message)
	{
		if (verboseLog)
		{
			Debug.Log(message);
		}
	}
}
