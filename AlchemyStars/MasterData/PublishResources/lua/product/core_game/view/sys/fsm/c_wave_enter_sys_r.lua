require("wave_enter_system")
_class("ClientWaveEnterSystem_Render", WaveEnterSystem)
ClientWaveEnterSystem_Render = ClientWaveEnterSystem_Render

function ClientWaveEnterSystem_Render:_DoRenderWaveInfo(TT)
  local configService = self._world:GetService("Config")
  local levelConfigData = configService:GetLevelConfigData()
  local utilStatSvc = self._world:GetService("UtilData")
  local waveNum = utilStatSvc:GetStatCurWaveIndex()
  Log.notice("EnterWave WaveNum:", waveNum)
  if levelConfigData:GetWaveCompleteConditionType(waveNum) == CompleteConditionType.KillAnyMonsterCount then
    local param = levelConfigData:GetWaveCompleteConditionParam(waveNum)
    self._world:EventDispatcher():Dispatch(GameEventType.UIInitMonsterDeadCount, param[1][1])
  elseif levelConfigData:GetWaveCompleteConditionType(waveNum) == CompleteConditionType.KillSpecificMonsterCount then
    local param = levelConfigData:GetWaveCompleteConditionParam(waveNum)
    self._world:EventDispatcher():Dispatch(GameEventType.UIInitSpecificMonsterDeadCount, param[1][1], param[1][2])
  end
  self:_PlayWaveBgm(waveNum)
  self._world:EventDispatcher():Dispatch(GameEventType.RefreshWaveInfo)
end

function ClientWaveEnterSystem_Render:_PlayWaveBgm(waveNum)
  local configService = self._world:GetService("Config")
  local levelConfigData = configService:GetLevelConfigData()
  local bgmID = levelConfigData:BGMParam(waveNum)
  if not bgmID then
    return
  end
  AudioHelperController.PlayBGMById(bgmID)
end

function ClientWaveEnterSystem_Render:_DoRenderShowWaveTraps(TT, spawnTraps)
  local trapServiceRender = self._world:GetService("TrapRender")
  local taskID = GameGlobal.TaskManager():CoreGameStartTask(trapServiceRender.ShowTraps, trapServiceRender, spawnTraps)
  return taskID
end

function ClientWaveEnterSystem_Render:_DoRenderPreShowMonster(TT)
  local utilStatSvc = self._world:GetService("UtilData")
  local isBossWave, bossIDs = utilStatSvc:GetStatBossWaveInfo()
  if isBossWave then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowHideBossComing, true, bossIDs[1])
    YIELD(TT, 2000)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowHideBossComing, false)
  end
end

function ClientWaveEnterSystem_Render:_DoRenderShowWaveMonsters(TT, spawnMonsters)
  local sMonsterShowRender = self._world:GetService("MonsterShowRender")
  local utilStatSvc = self._world:GetService("UtilData")
  local isFirstWave = utilStatSvc:GetStatIsFirstWave()
  if not isFirstWave then
    sMonsterShowRender:CreateMonsterHPEntities(spawnMonsters)
  else
    local match = GameGlobal.GetModule(MatchModule)
    local enterData = match:GetMatchEnterData()
    if enterData._match_type == MatchType.MT_Mission then
      local missionID = enterData:GetMissionCreateInfo().mission_id
      GameGlobal.UAReportForceGuideEvent("MissionRefreshMonster", {missionID})
    end
  end
  sMonsterShowRender:ShowMonsters(TT, spawnMonsters)
end

function ClientWaveEnterSystem_Render:_DoRenderWaveEnterInnerStory(TT)
  local innerStoryService = self._world:GetService("InnerStory")
  local utilStatSvc = self._world:GetService("UtilData")
  local isFirstWave = utilStatSvc:GetStatIsFirstWave()
  if isFirstWave then
    if innerStoryService:CheckStoryBanner(StoryShowType.BeginAfterMonsterShow) then
      InnerGameHelperRender:GetInstance():IsUIBannerComplete(TT)
    end
    innerStoryService:CheckStoryTips(StoryShowType.BeginAfterMonsterShow)
  end
end

function ClientWaveEnterSystem_Render:_DoRenderNotifyWaveStart(TT, waveNum)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ActiveBattlePet)
  local playBuffService = self._world:GetService("PlayBuff")
  playBuffService:PlayBuffView(TT, NTWaveTurnStart:New(waveNum))
end

function ClientWaveEnterSystem_Render:_DoRenderNotifyWaveEnter(TT, waveNum)
  local playBuffService = self._world:GetService("PlayBuff")
  playBuffService:PlayBuffView(TT, NTWaveEnter:New(waveNum))
end

function ClientWaveEnterSystem_Render:_DoRenderPlayPreMove(TT)
  local playAISvc = self._world:GetService("PlayAI")
  if playAISvc == nil then
    return
  end
  playAISvc:DoCommonRountine(TT)
end

function ClientWaveEnterSystem_Render:_DoRenderRefreshMonsterHitBackTeam(TT, hitbackResult)
  if not hitbackResult then
    return
  end
  local processHitTaskID
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local hitBackSpeed = 10
  local playSkillService = self._world:GetService("PlaySkill")
  if hitbackResult and not teamEntity:HasHitback() and not hitbackResult:GetHadPlay() then
    hitbackResult:SetHadPlay(true)
    processHitTaskID = playSkillService:ProcessHit(renderBoardEntity, teamEntity, hitbackResult, hitBackSpeed)
  end
  if processHitTaskID then
    while not TaskHelper:GetInstance():IsTaskFinished(processHitTaskID) do
      YIELD(TT)
    end
  end
  YIELD(TT)
  if hitbackResult then
    local pieceService = self._world:GetService("Piece")
    pieceService:RemovePrismAt(hitbackResult:GetPosTarget())
  end
end
