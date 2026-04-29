require("round_result_system")
_class("ClientRoundResultSystem_Render", RoundResultSystem)
ClientRoundResultSystem_Render = ClientRoundResultSystem_Render

function ClientRoundResultSystem_Render:_DoRenderShowRoundEnd(TT, battleCalcResult)
  local utilStatSvc = self._world:GetService("UtilData")
  local l_role_module = GameGlobal.GetModule(RoleModule)
  if not l_role_module:CheckModuleUnlock(GameModuleID.MD_ForceGuideEnd) then
    local attrGroup = self._world:GetGroup(self._world.BW_WEMatchers.Attributes)
    local l_strTemp = ""
    for i, e in ipairs(attrGroup:GetEntities()) do
      local l_ePetMonster
      local l_templateId = 0
      if e:HasMonsterID() then
        l_ePetMonster = "monster"
        l_templateId = e:MonsterID():GetMonsterID()
      elseif e:HasTeam() then
        l_ePetMonster = "team"
        l_templateId = 0
      end
      if l_ePetMonster ~= nil then
        local val = utilStatSvc:GetCurrentLogicHP(e)
        if val then
          l_strTemp = l_strTemp .. "{" .. l_ePetMonster .. ": " .. l_templateId .. " , hp: " .. val .. "},"
        end
      end
    end
    local curRound = utilStatSvc:GetStatCurWaveRoundNum()
    GameGlobal.UAReportForceGuideEvent("FightRoundInfo", {curRound, l_strTemp}, false, true)
  end
  if battleCalcResult then
    return
  end
  local configService = self._world:GetService("Config")
  local levelConfigData = configService:GetLevelConfigData()
  if utilStatSvc:GetStatIsRealZeroRound() and not utilStatSvc:GetStatLevelCompleteLimitAllRoundCount() and self._world:MatchType(GetMatchTypeType.WorldBossBattle) ~= MatchType.MT_WorldBoss and levelConfigData:GetOutOfRoundType() == 0 then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowZeroRoundWarning, true)
    YIELD(TT, 2000)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowZeroRoundWarning, false)
  end
end

function ClientRoundResultSystem_Render:_DoRenderNotifyRoundResultStart(TT, teamEntity)
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayBuffView(TT, NTRoundResultStart:New(teamEntity))
end

function ClientRoundResultSystem_Render:_DoRenderNotifyRoundTurnEnd(TT, teamEntity)
  local svc = self._world:GetService("PlayBuff")
  svc:PlayBuffView(TT, NTRoundTurnEnd:New())
  svc:PlayBuffView(TT, NTEnemyTurnEnd:New(teamEntity))
end

function ClientRoundResultSystem_Render:_DoRenderInWave(TT, traps, monsters)
  local sMonsterShowRender = self._world:GetService("MonsterShowRender")
  sMonsterShowRender:PlaySpawnInWave(TT, traps, monsters)
end

function ClientRoundResultSystem_Render:_DoRenderTrapAction(TT)
  local playAISvc = self._world:GetService("PlayAI")
  if playAISvc == nil then
    return
  end
  playAISvc:DoCommonRountine(TT)
end

function ClientRoundResultSystem_Render:_DoRenderRefreshCombinedWaveInfoOnRoundResult(TT)
  self._world:EventDispatcher():Dispatch(GameEventType.BattleUIRefreshCombinedWaveInfoOnRoundResult)
end

function ClientRoundResultSystem_Render:_DoRenderCalcTrapStateNonFightClub(TT, calcStateTraps)
  local trapServiceRender = self._world:GetService("TrapRender")
  trapServiceRender:RenderTrapState(TT, TrapDestroyType.DestroyAtRoundResult, calcStateTraps)
end

function ClientRoundResultSystem_Render:_UpdateTrapGridRound(TT)
  local svc = self._world:GetService("TrapRender")
  svc:UpdateTrapGridRound()
end

function ClientRoundResultSystem_Render:_DoRenderBuffBeforeTrapRoundCount(TT, teamEntity)
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayBuffView(TT, NTMonsterRoundBeforeTrapRoundCount:New(teamEntity))
end

function ClientRoundResultSystem_Render:_DoSaveDetailMatchLogger(TT)
  self._world:GetDetailMatchLogger():SaveDetailMatchLog()
end
