require("pop_star_wave_enter_system")
_class("PopStarWaveEnterSystem_Render", PopStarWaveEnterSystem)
PopStarWaveEnterSystem_Render = PopStarWaveEnterSystem_Render

function PopStarWaveEnterSystem_Render:_DoRenderWaveInfo(TT)
  local utilStatSvc = self._world:GetService("UtilData")
  local waveNum = utilStatSvc:GetStatCurWaveIndex()
  self:_PlayWaveBgm(waveNum)
end

function PopStarWaveEnterSystem_Render:_PlayWaveBgm(waveNum)
  local configService = self._world:GetService("Config")
  local levelConfigData = configService:GetLevelConfigData()
  local bgmID = levelConfigData:BGMParam(waveNum)
  if not bgmID then
    return
  end
  AudioHelperController.PlayBGMById(bgmID)
end

function PopStarWaveEnterSystem_Render:_DoRenderShowWaveTraps(TT, spawnTraps)
  local trapRSvc = self._world:GetService("TrapRender")
  return GameGlobal.TaskManager():CoreGameStartTask(trapRSvc.ShowTraps, trapRSvc, spawnTraps)
end

function PopStarWaveEnterSystem_Render:_DoRenderPlayPreMove(TT)
  local playAISvc = self._world:GetService("PlayAI")
  if playAISvc == nil then
    return
  end
  playAISvc:DoCommonRountine(TT)
end

function PopStarWaveEnterSystem_Render:_DoRenderShowUIBattleStart(TT)
  if not GuideHelper.DontShowThreeMission() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowBonusInfo, true)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowHideUIBattle, true)
  HelperProxy:GetInstance():SetGameTimeScale(BattleConst.TimeSpeedList[BattleConst.Speed2Index])
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ActiveBattlePet)
end

function PopStarWaveEnterSystem_Render:_DoRenderAutoAddBuff(TT, buffSeqList)
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayBuffSeqs(TT, buffSeqList)
  playBuffSvc:PlayAutoAddBuff(TT)
  playBuffSvc:PlayBuffView(TT, NTGameStart:New())
end

function PopStarWaveEnterSystem_Render:_DoRenderDestroyBattleEnterResource(TT)
  self:UnloadEffect(GameResourceConst.EffRuchangBlackboard)
  self:UnloadEffect(GameResourceConst.EffBoardShowLine)
end

function PopStarWaveEnterSystem_Render:UnloadEffect(effID)
  local poolSvc = self._world:GetService("ResourcesPool")
  local effSvc = self._world:GetService("Effect")
  local effResPath = effSvc:GetEffectResPath(effID)
  if effResPath then
    poolSvc:DestroyCache(effResPath)
  end
end
