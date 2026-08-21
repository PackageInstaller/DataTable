require("wave_switch_system")
_class("ClientWaveSwitchSystem_Render", WaveSwitchSystem)
ClientWaveSwitchSystem_Render = ClientWaveSwitchSystem_Render

function ClientWaveSwitchSystem_Render:_DoRenderShowSwitch(TT, waveBoard)
  self._world:EventDispatcher():Dispatch(GameEventType.WaveSwitch)
  local viewDataEntity = self._world:GetRenderBoardEntity()
  local waveDataCmpt = viewDataEntity:WaveData()
  if not waveDataCmpt:IsExitWave() then
    local taskID = TaskManager:GetInstance():CoreGameStartTask(function(TT)
      local utilStatSvc = self._world:GetService("UtilData")
      if utilStatSvc:GetStatIsAssignWaveResult() then
        local configService = self._world:GetService("Config")
        local levelConfigData = configService:GetLevelConfigData()
        local l_levelId = levelConfigData:GetLevelID()
        self._world:EventDispatcher():Dispatch(GameEventType.ShowHideWaveWarning, true, l_levelId)
        YIELD(TT, 2000)
        self._world:EventDispatcher():Dispatch(GameEventType.ShowHideWaveWarning, false)
        self._world:EventDispatcher():Dispatch(GameEventType.ShowDropCoinInfoActive)
      else
        local waveIndex = utilStatSvc:GetStatCurWaveIndex()
        if waveBoard then
          local spawnPieceServiceRender = self._world:GetService("SpawnPieceRender")
          spawnPieceServiceRender:PlayBoardShow(TT, waveBoard)
        end
        self._world:EventDispatcher():Dispatch(GameEventType.ShowWaveSwitch, true, waveIndex)
        YIELD(TT, 2000)
        self._world:EventDispatcher():Dispatch(GameEventType.ShowWaveSwitch, false)
      end
    end, self)
    while not TaskHelper:GetInstance():IsAllTaskFinished({taskID}) do
      YIELD(TT)
    end
  else
    local taskID = TaskManager:GetInstance():CoreGameStartTask(function(TT)
      local utilStatSvc = self._world:GetService("UtilData")
      if utilStatSvc:GetStatIsAssignWaveResult() then
      else
        local waveIndex = utilStatSvc:GetStatCurWaveIndex()
        if waveBoard then
          local spawnPieceServiceRender = self._world:GetService("SpawnPieceRender")
          spawnPieceServiceRender:PlayBoardShow(TT, waveBoard)
        end
      end
    end, self)
    while not TaskHelper:GetInstance():IsAllTaskFinished({taskID}) do
      YIELD(TT)
    end
  end
end

function ClientWaveSwitchSystem_Render:_DoRenderTrapState(TT, calcStateTraps)
  local trapServiceRender = self._world:GetService("TrapRender")
  trapServiceRender:RenderTrapState(TT, TrapDestroyType.DestoryByWave, calcStateTraps)
  if self._world._matchType == MatchType.MT_Conquest then
    local configService = self._world:GetService("Config")
    local score = configService:N5GetCurWaveScore()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIN5UpdateScore, score)
  end
end

function ClientWaveSwitchSystem_Render:_DoRenderAddWaveSwitchBuff(TT)
  local playBuff = self._world:GetService("PlayBuff")
  playBuff:PlayBuffView(TT, NTWaveSwitch:New())
end

function ClientWaveSwitchSystem_Render:_DoRenderRefreshPetPower(TT, petPowerStateList)
  for _, petPowerState in pairs(petPowerStateList) do
    local entityID = petPowerState.petEntityID
    local petPstID = petPowerState.petPstID
    local curPower = petPowerState.power
    local ready = petPowerState.ready
    GameGlobal.EventDispatcher():Dispatch(GameEventType.PetPowerChange, petPstID, curPower, true)
    if ready == 1 then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.PetActiveSkillGetReady, petPstID, false)
    else
      GameGlobal:EventDispatcher():Dispatch(GameEventType.PetActiveSkillCancelReady, petPstID, 0)
    end
  end
end
