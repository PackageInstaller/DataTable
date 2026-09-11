using System;
using System.Collections;
using LuaInterface;
using UnityEngine;

public class SummerRaceLuaUiRouteProbe : MonoBehaviour
{
	[SerializeField]
	private bool runOnStart;

	[SerializeField]
	private bool runOnce = true;

	[SerializeField]
	private bool includePopupRoutes;

	[SerializeField]
	private bool verboseLog = true;

	[SerializeField]
	private int retryCount = 8;

	[SerializeField]
	private float retryIntervalSeconds = 1f;

	private bool hasRun;

	private bool probeRoutineStarted;

	private bool disabledLogEmitted;

	private Coroutine probeRoutine;

	private void OnEnable()
	{
		if (Application.isPlaying)
		{
			StopProbeRoutineIfRunning();
			hasRun = false;
			probeRoutineStarted = false;
			disabledLogEmitted = false;
			if (runOnStart)
			{
				TryStartProbe("OnEnable");
			}
		}
	}

	private void Start()
	{
		if (runOnStart)
		{
			TryStartProbe("Start");
		}
	}

	[ContextMenu("Run SummerRace Route Probe")]
	public void RunSummerRaceRouteProbe()
	{
		TryStartProbe("External");
	}

	private void OnDisable()
	{
		StopProbeRoutineIfRunning();
	}

	private void StopProbeRoutineIfRunning()
	{
		if (probeRoutine != null)
		{
			StopCoroutine(probeRoutine);
			probeRoutine = null;
		}
		probeRoutineStarted = false;
	}

	private void Update()
	{
		if (Application.isPlaying && runOnStart && !probeRoutineStarted)
		{
			TryStartProbe("UpdateFallback");
		}
	}

	private void TryStartProbe(string source)
	{
		if (!SummerRaceLuaRuntimeBootstrap.IsStandaloneValidationBootstrapEnabled)
		{
			if (verboseLog && !disabledLogEmitted)
			{
				Debug.Log("[SummerRace][UIRouteProbe] standalone validation bootstrap disabled; skip route probe");
				disabledLogEmitted = true;
			}
		}
		else if (SummerRaceLuaRuntimeBootstrap.IsValidationOutGamePresetEnabled)
		{
			if (verboseLog && !disabledLogEmitted)
			{
				Debug.Log("[SummerRace][UIRouteProbe] validation outgame preset is enabled; skip auto route probe");
				disabledLogEmitted = true;
			}
		}
		else if (!probeRoutineStarted && probeRoutine == null)
		{
			probeRoutineStarted = true;
			probeRoutine = StartCoroutine(RunProbeRoutine(source));
		}
	}

	private IEnumerator RunProbeRoutine(string source)
	{
		if (!SummerRaceLuaRuntimeBootstrap.IsStandaloneValidationBootstrapEnabled)
		{
			probeRoutine = null;
			probeRoutineStarted = false;
			yield break;
		}
		int maxTry = Mathf.Max(1, retryCount);
		bool success = false;
		for (int i = 1; i <= maxTry; i++)
		{
			if (RunProbeOnce(source, i))
			{
				probeRoutine = null;
				probeRoutineStarted = false;
				yield break;
			}
			yield return new WaitForSeconds(Mathf.Max(0.1f, retryIntervalSeconds));
		}
		if (!success)
		{
			Debug.LogWarning($"[SummerRace][UIRouteProbe] exhausted retries; source={source} maxTry={maxTry}");
		}
		probeRoutine = null;
		probeRoutineStarted = false;
	}

	private bool RunProbeOnce(string source, int attempt)
	{
		if (runOnce && hasRun)
		{
			return true;
		}
		if (!SummerRaceLuaRuntimeBootstrap.IsLuaUiContextReady)
		{
			if (verboseLog)
			{
				Debug.Log($"[SummerRace][UIRouteProbe] waiting bootstrap context; source={source} attempt={attempt}");
			}
			return false;
		}
		LuaState luaState = LuaHelper.GetLuaState();
		if (luaState == null)
		{
			Debug.LogWarning($"[SummerRace][UIRouteProbe] LuaState is null; source={source} attempt={attempt}");
			return false;
		}
		try
		{
			luaState.DoString("\nSummerRaceRouteProbe = SummerRaceRouteProbe or {}\n\nfunction SummerRaceRouteProbe.RunProbe(includePopups, bridgeOnly)\n    if gameContext and gameContext.SetSystemLayer then\n        pcall(function()\n            gameContext:SetSystemLayer('home')\n        end)\n    end\n\n    local okBridge, bridge = pcall(import, 'game.bridge.SummerRaceBridge')\n    local params = {\n        mode = 'normal',\n        wave = 1,\n        hp = 100,\n        energy = 12,\n        skillReady = true\n    }\n    local bridgeEnterOk = false\n    if okBridge and type(bridge) == 'table' and type(bridge.EnterPlay) == 'function' then\n        local okEnter, enterResult = pcall(function()\n            return bridge:EnterPlay(params)\n        end)\n        bridgeEnterOk = okEnter and enterResult ~= false\n    end\n\n    local ok, jumpTools = pcall(dofile, 'game/tools/JumpTools.lua')\n    if (not ok) or type(jumpTools) ~= 'table' then\n        jumpTools = import('game.tools.JumpTools')\n    end\n\n    local traces = {}\n    traces[#traces + 1] = string.format('bridgeEnterOk=%s', tostring(bridgeEnterOk))\n    local function getRouterStateTag()\n        local state = 'nil'\n        local cmdCount = -1\n        local linkFree = 'nil'\n        if gameContext ~= nil then\n            if gameContext.GetCmdEnqueueCount then\n                cmdCount = tonumber(gameContext:GetCmdEnqueueCount()) or -1\n            end\n            if gameContext.curLinkMethod_ ~= nil and gameContext.curLinkMethod_.IsFree then\n                local okLink, isFree = pcall(function()\n                    return gameContext.curLinkMethod_:IsFree()\n                end)\n                if okLink then\n                    linkFree = tostring(isFree)\n                end\n            end\n            if gameContext.fsm_ ~= nil and gameContext.fsm_.GetCurState then\n                local okState, stateName = pcall(function()\n                    local cur = gameContext.fsm_:GetCurState()\n                    if cur and cur.GetStateName then\n                        return cur:GetStateName()\n                    end\n                    return 'nil'\n                end)\n                if okState then\n                    state = tostring(stateName)\n                end\n            end\n        end\n        return string.format('router(state=%s cmd=%s linkFree=%s)', tostring(state), tostring(cmdCount), tostring(linkFree))\n    end\n\n    local function ensureRouteComponent(routeName, modulePath)\n        if gameContext == nil or gameContext.GetRouteCfgFromRouteName == nil then\n            traces[#traces + 1] = string.format('routeCfg[%s]=noGameContext', tostring(routeName))\n            return\n        end\n\n        local cfg = gameContext:GetRouteCfgFromRouteName(routeName)\n        if cfg == nil then\n            traces[#traces + 1] = string.format('routeCfg[%s]=missing', tostring(routeName))\n            return\n        end\n\n        if cfg.component ~= nil then\n            traces[#traces + 1] = string.format('routeCfg[%s].component=ok', tostring(routeName))\n            return\n        end\n\n        local okImport, comp = pcall(import, modulePath)\n        if okImport and comp ~= nil then\n            cfg.component = comp\n            traces[#traces + 1] = string.format('routeCfg[%s].component=rebound', tostring(routeName))\n        else\n            traces[#traces + 1] = string.format('routeCfg[%s].component=missing(%s)', tostring(routeName), tostring(comp))\n        end\n    end\n\n    local function tryRecoverRouterIfStuck()\n        if gameContext == nil then\n            return\n        end\n\n        local recovered = false\n        local stateName = 'nil'\n        if gameContext.fsm_ ~= nil and gameContext.fsm_.GetCurState then\n            local okState, value = pcall(function()\n                local cur = gameContext.fsm_:GetCurState()\n                if cur and cur.GetStateName then\n                    return cur:GetStateName()\n                end\n                return 'nil'\n            end)\n            if okState then\n                stateName = tostring(value)\n            end\n        end\n\n        local linkBusy = false\n        if gameContext.curLinkMethod_ ~= nil and gameContext.curLinkMethod_.IsFree then\n            local okLink, isFree = pcall(function()\n                return gameContext.curLinkMethod_:IsFree()\n            end)\n            if okLink then\n                linkBusy = not isFree\n            end\n        end\n\n        if linkBusy and gameContext.curLinkMethod_.Stop then\n            local okStop = pcall(function()\n                gameContext.curLinkMethod_:Stop()\n            end)\n            recovered = recovered or okStop\n        end\n\n        if stateName ~= 'wait' and gameContext.fsm_ ~= nil and gameContext.fsm_.Trigger then\n            local okTrigger = pcall(function()\n                gameContext.fsm_:Trigger('wait')\n            end)\n            recovered = recovered or okTrigger\n        end\n\n        traces[#traces + 1] = string.format('routerRecover=%s before=%s after=%s', tostring(recovered), tostring(stateName), getRouterStateTag())\n    end\n\n    ensureRouteComponent('summerRaceBattleView', 'game.views.activity.Submodule.SummerRace.SummerRaceBattleView')\n    ensureRouteComponent('summerRaceBattleInfoPopView', 'game.views.activity.Submodule.SummerRace.SummerRaceBattleInfoPopView')\n    ensureRouteComponent('summerRaceBattleResultView', 'game.views.activity.Submodule.SummerRace.SummerRaceBattleResultView')\n    ensureRouteComponent('summerRaceChallengeResultView', 'game.views.activity.Submodule.SummerRace.SummerRaceChallengeResultView')\n    ensureRouteComponent('summerRacePopView', 'game.views.activity.Submodule.SummerRace.SummerRacePopView')\n    traces[#traces + 1] = getRouterStateTag()\n    tryRecoverRouterIfStuck()\n\n    local function mark(tag, route)\n        local page = gameContext and gameContext:GetLastOpenPage() or 'nil'\n        traces[#traces + 1] = string.format('%s[%s]=>%s', tag, tostring(route), tostring(page))\n    end\n\n    local function safeOpen(tag, route, params)\n        local okOpen, errOpen = pcall(function()\n            jumpTools.OpenPageByJump(route, params)\n        end)\n\n        if okOpen then\n            mark(tag, route)\n            return\n        end\n\n        local routePath = string.sub(route, 1, 1) == '/' and route or ('/' .. route)\n        local okGo, errGo = pcall(function()\n            if gameContext then\n                if gameContext.SetSystemLayer then\n                    gameContext:SetSystemLayer('home')\n                end\n                gameContext:Go(routePath, params, true, true)\n            end\n        end)\n\n        local page = gameContext and gameContext:GetLastOpenPage() or 'nil'\n        traces[#traces + 1] = string.format('%s=>fallback(%s|%s)=>%s', tag, tostring(errOpen), tostring(okGo and 'go_ok' or errGo), tostring(page))\n    end\n\n    if bridgeEnterOk and bridgeOnly then\n        mark('SummerRaceBridge', 'summerRaceBattleView')\n    else\n        safeOpen('SummerRace', 'summerRaceBattleView', params)\n    end\n\n    if includePopups then\n        safeOpen('SummerRaceInfoPop', 'summerRaceBattleInfoPopView', {\n            mode = 'normal',\n            wave = 1,\n            hp = 100,\n            energy = 12,\n            skillReady = true\n        })\n\n        safeOpen('BattleResultUI', 'summerRaceBattleResultView', {\n            victory = true,\n            score = 1234\n        })\n\n        safeOpen('ChallengeResultUI', 'summerRaceChallengeResultView', {\n            victory = true,\n            score = 5678\n        })\n\n        safeOpen('SummerRacePop', 'summerRacePopView', {\n            title = 'probe',\n            content = 'probe'\n        })\n    end\n\n    local battleHandlerByName = gameContext and gameContext:GetOpenPageHandler('summerRaceBattleView')\n    local battleHandlerBySlash = gameContext and gameContext:GetOpenPageHandler('/summerRaceBattleView')\n    local battleHandlerFromMap = gameContext and gameContext.recordMap_ and gameContext.recordMap_['summerRaceBattleView']\n    local recordCount = 0\n    if gameContext and gameContext.recordMap_ then\n        for _, _ in pairs(gameContext.recordMap_) do\n            recordCount = recordCount + 1\n        end\n    end\n    local battleHandler = battleHandlerByName or battleHandlerBySlash\n    local topPage = gameContext and gameContext:GetLastOpenPage() or 'nil'\n    local ctxReady = tostring(gameContext ~= nil)\n    traces[#traces + 1] = string.format('handlerByName=%s handlerBySlash=%s handlerByMap=%s recordCount=%s', tostring(battleHandlerByName ~= nil), tostring(battleHandlerBySlash ~= nil), tostring(battleHandlerFromMap ~= nil), tostring(recordCount))\n    traces[#traces + 1] = getRouterStateTag()\n    return table.concat(traces, '|'), tostring(battleHandler ~= nil), tostring(topPage), ctxReady\nend\n", "SummerRaceLuaUiRouteProbe.Define");
			object[] array = LuaHelper.CallFunction("SummerRaceRouteProbe.RunProbe", includePopupRoutes, true);
			string text = ((array == null || array.Length == 0) ? "nil" : array[0]?.ToString());
			string text2 = ((array == null || array.Length <= 1) ? "nil" : array[1]?.ToString());
			string text3 = ((array == null || array.Length <= 2) ? "nil" : array[2]?.ToString());
			string text4 = ((array == null || array.Length <= 3) ? "nil" : array[3]?.ToString());
			bool flag = string.Equals(text4, "true", StringComparison.OrdinalIgnoreCase);
			bool flag2 = !string.Equals(text3, "nil", StringComparison.OrdinalIgnoreCase);
			bool flag3 = string.Equals(text2, "true", StringComparison.OrdinalIgnoreCase);
			if (verboseLog)
			{
				Debug.Log($"[SummerRace][UIRouteProbe] source={source} attempt={attempt} ctx={text4} trace={text} battleHandler={text2} top={text3}");
			}
			else if (!flag3 && attempt == Mathf.Max(1, retryCount))
			{
				Debug.LogWarning($"[SummerRace][UIRouteProbe] source={source} attempt={attempt} ctx={text4} battleHandler={text2} top={text3}");
			}
			if (flag & flag2 & flag3)
			{
				Debug.LogWarning($"[SummerRace][UIRouteProbe][Evidence] source={source} attempt={attempt} ctx={text4} battleHandler={text2} top={text3} trace={text}");
				hasRun = true;
				return true;
			}
			return false;
		}
		catch (Exception arg)
		{
			Debug.LogError($"[SummerRace][UIRouteProbe] exception: {arg}");
			return false;
		}
	}
}
