require("main_state_sys")
_class("WaveSwitchSystem", MainStateSystem)
WaveSwitchSystem = WaveSwitchSystem

function WaveSwitchSystem:_GetMainStateID()
  return GameStateID.WaveSwitch
end

function WaveSwitchSystem:_OnMainStateEnter(TT)
  local calcStateTraps = self:_DoLogicCalcTrap()
  self:_DoRenderTrapState(TT, calcStateTraps)
  self:_DoLogicCalcBattleState()
  local waveBoard = self:_DoLogicRefreshWaveBoard()
  self:_DoRenderShowSwitch(TT, waveBoard)
  self:_DoLogicAddWaveSwitchBuff()
  self:_DoRenderAddWaveSwitchBuff(TT)
  local petPowerStateList = self:_DoLogicRefreshPetPower()
  self:_DoRenderRefreshPetPower(TT, petPowerStateList)
  self:_DoLogicSwitchToWaveEnter()
end

function WaveSwitchSystem:_DoLogicCalcTrap()
  local trapServiceLogic = self._world:GetService("TrapLogic")
  return trapServiceLogic:CalcTrapState(TrapDestroyType.DestoryByWave)
end

function WaveSwitchSystem:_DoLogicCalcBattleState()
  local boardEntity = self._world:GetBoardEntity()
  local battleStatCmpt = self._world:BattleStat()
  battleStatCmpt:MoveToNextWave()
end

function WaveSwitchSystem:_DoLogicSwitchToWaveEnter()
  self._world:EventDispatcher():Dispatch(GameEventType.WaveSwitchFinish, 1)
end

function WaveSwitchSystem:_GetWaveBoard()
  local battleStatCmpt = self._world:BattleStat()
  local waveNum = battleStatCmpt:GetCurWaveIndex()
  local waveBoard
  if self._world._matchType == MatchType.MT_Conquest or self._world._matchType == MatchType.MT_SimpleBattleField then
    local boardID = self._world.BW_WorldInfo.boardIDList[waveNum]
    if boardID then
      local cfg = Cfg.cfg_preset_board[boardID]
      if cfg then
        waveBoard = cfg.Board
      end
    end
  else
    local configService = self._world:GetService("Config")
    local levelConfigData = configService:GetLevelConfigData()
    waveBoard = levelConfigData:GetWaveBoard(waveNum)
  end
  return waveBoard
end

function WaveSwitchSystem:_DoLogicRefreshWaveBoard()
  local waveBoard = self:_GetWaveBoard()
  if not waveBoard then
    return
  end
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local triggerService = self._world:GetService("Trigger")
  local utilData = self._world:GetService("UtilData")
  local waveBoardResult = {}
  local tConvertInfo = {}
  for x, row in pairs(waveBoard) do
    for y, color in pairs(row) do
      local posWork = Vector2(x, y)
      if boardServiceLogic:GetCanConvertGridElement(posWork) then
        if not waveBoardResult[x] then
          waveBoardResult[x] = {}
        end
        waveBoardResult[x][y] = color
        local oldColor = utilData:FindPieceElement(posWork)
        boardServiceLogic:SetPieceTypeLogic(color, posWork)
        local convertInfo = NTGridConvert_ConvertInfo:New(posWork, oldColor, color)
        table.insert(tConvertInfo, convertInfo)
      end
    end
  end
  local boardEntity = self._world:GetBoardEntity()
  triggerService:Notify(NTGridConvert:New(boardEntity, tConvertInfo))
  return waveBoardResult
end

function WaveSwitchSystem:_DoLogicAddWaveSwitchBuff()
  local configService = self._world:GetService("Config")
  if self._world._matchType == MatchType.MT_Conquest or self._world._matchType == MatchType.MT_SimpleBattleField then
    local buffLogic = self._world:GetService("BuffLogic")
    local buffList
    if self._world._matchType == MatchType.MT_Conquest then
      buffList = configService:GetN5WaveBuff()
    elseif self._world._matchType == MatchType.MT_SimpleBattleField then
      buffList = configService:GetCNN5WaveBuff()
    end
    if buffList then
      for i, param in ipairs(buffList) do
        buffLogic:AddBuffByTargetType(param.BuffID, param.BuffTargetType, param.BuffTargetParam)
      end
    end
  end
  local waveIndex = self._world:BattleStat():GetCurWaveIndex()
  local triggerService = self._world:GetService("Trigger")
  triggerService:Notify(NTWaveSwitch:New(waveIndex))
end

function WaveSwitchSystem:_DoLogicRefreshPetPower()
  local petPowerStateList = {}
  local group = self._world:GetGroup(self._world.BW_WEMatchers.Pet)
  for _, e in ipairs(group:GetEntities()) do
    local tNotify = self:_LogicRefreshPetPower(e, petPowerStateList)
  end
  return petPowerStateList
end

function WaveSwitchSystem:_LogicRefreshPetPower(e, petPowerStateList)
  if e:HasPetDeadMark() then
    return
  end
  local petPstIDComponent = e:PetPstID()
  local petPstID = petPstIDComponent:GetPstID()
  local attributesComponent = e:Attributes()
  local localSkillID = e:SkillInfo():GetActiveSkillID()
  if not localSkillID then
    local petData = self._world:GetPetData(petPstID)
    localSkillID = petData:GetPetActiveSkill()
  end
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(localSkillID)
  if skillConfigData:GetSkillTriggerType() == SkillTriggerType.LegendEnergy then
  elseif skillConfigData:GetSkillTriggerType() == SkillTriggerType.BuffLayer then
    local sourceActiveSkillID = e:SkillInfo():GetActiveSkillID()
    local variantActiveSkillInfo = e:SkillInfo():GetVariantActiveSkillInfo()
    local utilDataSvc = self._world:GetService("UtilData")
    local ready = utilDataSvc:GetPetSkillReadyAttr(e, sourceActiveSkillID)
    if variantActiveSkillInfo and variantActiveSkillInfo[sourceActiveSkillID] then
      local variantList = table.clone(variantActiveSkillInfo[sourceActiveSkillID])
      table.insert(variantList, sourceActiveSkillID)
      for i, skillID in ipairs(variantList) do
        if utilDataSvc:GetPetSkillReadyAttr(e, skillID) == 1 then
          ready = 1
        end
      end
    end
    local power = attributesComponent:GetAttribute("Power")
    if not petPowerStateList[petPstID] then
      petPowerStateList[petPstID] = {}
    end
    petPowerStateList[petPstID].petEntityID = e:GetID()
    petPowerStateList[petPstID].petPstID = petPstID
    petPowerStateList[petPstID].ready = ready
    petPowerStateList[petPstID].power = power
  else
    local power = attributesComponent:GetAttribute("Power")
    local ready = attributesComponent:GetAttribute("Ready")
    if not petPowerStateList[petPstID] then
      petPowerStateList[petPstID] = {}
    end
    petPowerStateList[petPstID].petEntityID = e:GetID()
    petPowerStateList[petPstID].petPstID = petPstID
    petPowerStateList[petPstID].ready = ready
    petPowerStateList[petPstID].power = power
  end
  local battleStatComponent = self._world:BattleStat()
  local curRound = battleStatComponent:GetLevelTotalRoundCount()
  local curWaveIndex = battleStatComponent:GetCurWaveIndex()
  local lastWaveIndex = curWaveIndex - 1
  local curWaveRoundHadCastSkillList = battleStatComponent:GetPetDoActiveSkillRecord(petPstID, curRound)
  if curWaveRoundHadCastSkillList and table.count(curWaveRoundHadCastSkillList) > 0 then
    local activeSkillID = e:SkillInfo():GetActiveSkillID()
    local keyStr = "HadSaveSkillGrayWatch" .. "_Round_" .. tostring(curRound) .. "_Skill_" .. tostring(activeSkillID)
    local buffComponent = e:BuffComponent()
    buffComponent:SetBuffValue(keyStr, true)
    battleStatComponent:SetLastDoActiveSkillRound(petPstID, nil)
  end
end

function WaveSwitchSystem:_DoRenderShowSwitch(TT, waveBoard)
end

function WaveSwitchSystem:_DoRenderTrapState(TT, calcStateTraps)
end

function WaveSwitchSystem:_DoRenderAddWaveSwitchBuff(TT)
end

function WaveSwitchSystem:_DoRenderRefreshPetPower(TT, petPowerStateList)
end
