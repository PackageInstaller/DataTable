local ExplorationOverclockCtrl = class("ExplorationOverclockCtrl", ExplorationCtrlBase)

function ExplorationOverclockCtrl:ctor(epCtrl)
  self.__getUnlokChipSet = BindCallback(self, self.GetUnlokChipSet)
  MsgCenter:AddListener(eMsgEventId.SectorChipSet, self.__getUnlokChipSet)
  self.__SyncOverclockData = BindCallback(self, self.SyncOverclockData)
  MsgCenter:AddListener(eMsgEventId.OnEpOverclockDiff, self.__SyncOverclockData)
end

function ExplorationOverclockCtrl:InitEpOverclockCtrl(overclockData)
  local moduleId = ExplorationManager:GetEpModuleId()
  local dungeonId = ExplorationManager:GetEpDungeonId()
  local isUnlock = false
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    isUnlock = true
    if ConfigData.reinforce_exploration_main ~= nil then
      local stageCfg = ConfigData.sector_stage[dungeonId]
      for actId, cfg in pairs(ConfigData.reinforce_exploration_main) do
        if stageCfg.sector == cfg.continue_sector then
          isUnlock = false
          break
        end
      end
    end
  elseif moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
    isUnlock = true
  end
  isUnlock = isUnlock and FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_OverClock)
  if not isUnlock or overclockData == nil then
    self.__hasOverclock = false
    return
  end
  self.__hasOverclock = true
  self.__dungeonId = dungeonId
  self.__unlockChipSetTable = {}
  self.__curAssembleNum = 0
  local maxCountAddtion = PlayerDataCenter.playerBonus:GetOverClockCountAddtion()
  self.__maxAssembleNum = ConfigData.game_config.OverclockLimtNum + maxCountAddtion
  self:__GetStageAllChips(moduleId)
  self:__GenOverClockOptionDatas()
  self:SyncOverclockData(overclockData)
end

function ExplorationOverclockCtrl:SyncOverclockData(overclockData)
  self.__clockData = overclockData
  if overclockData.overclock ~= nil then
    self.__useOverclockList = overclockData.overclock.data
  else
    self.__useOverclockList = {}
  end
  self.__curAssembleNum = table.count(self.__useOverclockList)
  MsgCenter:Broadcast(eMsgEventId.UpdateEpOverclock)
end

function ExplorationOverclockCtrl:ShowEpOverclockUI(showMoney)
  UIManager:ShowWindowAsync(UIWindowTypeID.OverClock, function(clockWindow)
    if clockWindow == nil then
      return
    end
    clockWindow:InitOverclockUI(self, showMoney)
  end)
end

function ExplorationOverclockCtrl:UseOverclockOption(clockId, level)
  self.epCtrl.epNetwork:CS_EXPLORATION_OVERCLOCK_BUY(clockId, level)
end

function ExplorationOverclockCtrl:UseOverclockOptionWithChipId(clockId, level, chipId)
  self.epCtrl.epNetwork:CS_EXPLORATION_OVERCLOCK_BUY(clockId, level, chipId)
end

function ExplorationOverclockCtrl:IsLevelHasOverclock()
  return self.__hasOverclock
end

function ExplorationOverclockCtrl:GetIsHaveFree()
  return self.__clockData.freeCnt > 0
end

function ExplorationOverclockCtrl:GetLastFreeNum()
  return self.__clockData.freeCnt
end

function ExplorationOverclockCtrl:GetClockAssembleNum()
  return self.__curAssembleNum, self.__maxAssembleNum
end

function ExplorationOverclockCtrl:IsUseClockLimit()
  return self.__curAssembleNum >= self.__maxAssembleNum
end

function ExplorationOverclockCtrl:IsUseOverclockOption(clockId)
  return self.__useOverclockList[clockId] ~= nil
end

function ExplorationOverclockCtrl:__GenOverClockOptionDatas()
  self.__clockOptionDatas = {}
  local OCDatas = {}
  for overclockId, cfgs in pairs(ConfigData.overclock) do
    local lv1Cfg = cfgs[1]
    local data = {}
    data.overclockId = overclockId
    data.isUnlock = CheckCondition.CheckLua(lv1Cfg.pre_condition, lv1Cfg.pre_para1, lv1Cfg.pre_para2)
    if data.isUnlock then
      data.overclockLevel = PlayerDataCenter.playerBonus:GetOverClock(overclockId)
      if data.overclockLevel <= 0 then
        error("overclock option level blow 0, pls check common logic init.")
      end
    else
      data.unlockDes = CheckCondition.GetUnlockInfoLua(lv1Cfg.pre_condition, lv1Cfg.pre_para1, lv1Cfg.pre_para2)
    end
    table.insert(OCDatas, data)
  end
  table.sort(OCDatas, function(a, b)
    if a.isUnlock ~= b.isUnlock then
      return a.isUnlock
    end
    return a.overclockId < b.overclockId
  end)
  self.__clockOptionDatas = OCDatas
end

function ExplorationOverclockCtrl:GetOverclockOptions()
  return self.__clockOptionDatas
end

function ExplorationOverclockCtrl:__GetStageAllChips(fromModule)
  self.__levelchipDic = {}
  if fromModule == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    local sectorStageCfg = ConfigData.sector_stage[self.__dungeonId]
    if sectorStageCfg == nil then
      return
    end
    for _, epId in pairs(sectorStageCfg.exploration_list) do
      local epCfg = ConfigData.exploration[epId]
      if epCfg ~= nil then
        for _, poolId in pairs(epCfg.chip_pool) do
          local funcPoolCfg = ConfigData.ep_function_pool[poolId]
          if funcPoolCfg ~= nil then
            for _, chipId in pairs(funcPoolCfg.function_pool) do
              self.__levelchipDic[chipId] = true
            end
          end
        end
      end
    end
  elseif fromModule == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
    local endlessLevel = ConfigData.endless.levelDic[self.__dungeonId]
    if endlessLevel == nil then
      return
    end
    local endlessCfg = ConfigData.endless[endlessLevel.sectorId][endlessLevel.index]
    if endlessCfg == nil then
      return
    end
    local chips = endlessCfg.chip
    if chips == nil then
      return
    end
    for _, chipId in ipairs(chips) do
      self.__levelchipDic[chipId] = true
    end
  end
end

function ExplorationOverclockCtrl:GetClockAllChipDic()
  return self.__levelchipDic
end

function ExplorationOverclockCtrl:GetUnlokChipSet(chipSetTab)
  self.__unlockChipSetTable = chipSetTab
end

function ExplorationOverclockCtrl:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.SectorChipSet, self.__getUnlokChipSet)
  MsgCenter:RemoveListener(eMsgEventId.OnEpOverclockDiff, self.__SyncOverclockData)
end

return ExplorationOverclockCtrl
