WarChessSeasonManager = {}
local WarChessSeasonCtrl = require("Game.WarChessSeason.WarChessSeasonCtrl")
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
local WarChessSeasonSettleHanlder = require("Game.WarChessSeason.WarChessSeasonSettleHanlder")
local cs_MessageCommon = CS.MessageCommon

function WarChessSeasonManager:ctor()
  self.__wcSeasonCtrl = nil
  self.__wcNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.WarChess)
  self.__isHaveUncompleteWCS = false
  self.__uncompleteWCSData = nil
  self.__wcsSavingDataDic = nil
  self.__WCSLevelNameStr = nil
  self.__WCSLevelIndexStr = nil
  self.__enterNextFloorFormInfo = nil
  self._settleHandler = WarChessSeasonSettleHanlder.New()
  self.__passedWarChessSeasonDic = nil
end

function WarChessSeasonManager:GetIsInWCSeason()
  return self.__isInWCSeason
end

function WarChessSeasonManager:GetIsInWCSeasonNotFirstLevel()
  return self.__isInWCSeason and not self.__wcSeasonCtrl.isInFirstLobby
end

function WarChessSeasonManager:GetIsInWCSeasonIsInLobby()
  return self.__isInWCSeason and self.__wcSeasonCtrl.isInLobby
end

function WarChessSeasonManager:InitWCSeasonCtrl(seasonId, towerId, envId)
  self.__isInWCSeason = true
  self.__wcSeasonCtrl = WarChessSeasonCtrl.New(seasonId, towerId, envId)
end

function WarChessSeasonManager:GiveUpLastWarchessSeason()
  local rewardList
  rewardList = self.__uncompleteWCSData ~= nil and self.__uncompleteWCSData.strengthWinReward
  self._stageId = self.__uncompleteData ~= nil and self.__uncompleteData.sectorStageId
  WarChessManager:OpenWCRewardBagSelect(rewardList, function(pickInfo)
    self._stageId = nil
    self.__wcNetworkCtrl:CS_WarChess_Quit(pickInfo, function(args)
      local warChessSettleData = args[0].data
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8706))
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
        if window ~= nil then
          local CommonRewardData = require("Game.CommonUI.CommonRewardData")
          local CRData = CommonRewardData.CreateCRDataUseDic(warChessSettleData.rewards.stmStorePickRewards):SetCRNotHandledGreat(true)
          window:AddAndTryShowReward(CRData)
        end
      end)
    end)
  end)
end

function WarChessSeasonManager:ExitWarChessClean()
  self.__isInWCSeason = nil
  self.__isHaveUncompleteWCS = nil
  self.__uncompleteWCSData = nil
  self._addtionData = nil
  if self.__wcSeasonCtrl ~= nil then
    self.__wcSeasonCtrl:Delete()
    self.__wcSeasonCtrl = nil
  end
  self._techOpenFunc = nil
  self._techRedShowFunc = nil
  MsgCenter:Broadcast(eMsgEventId.WCS_ExitAndClear)
end

function WarChessSeasonManager:EnterWarChessSeasonBySeasonGroupId(seasonId, towerId, envId)
  self:InitWCSeasonCtrl(seasonId, towerId, envId)
  self.__wcNetworkCtrl:CS_WarChess_EnterWarChessLobby(seasonId, towerId, true, envId, function(argList)
    if argList.Count ~= 1 then
      error("argList.Count error:" .. tostring(argList.Count))
      return
    end
    local lobbyMessage = argList[0]
    self._isFirstEnter = true
    self:CleanOrtherWhenEnter()
    self.__wcSeasonCtrl:EnterWCSeasonLobbyByMsg(lobbyMessage)
  end)
end

function WarChessSeasonManager:CleanOrtherWhenEnter()
  self.__wcSeasonCtrl.WCS3DUINode = nil
  UIManager:DeleteAllWindow()
  ControllerManager:DeleteController(ControllerTypeId.SectorController)
end

function WarChessSeasonManager:GetWCSCtrl()
  return self.__wcSeasonCtrl
end

function WarChessSeasonManager:GetWCSSeasonTowerID()
  if self.__uncompleteWCSData ~= nil then
    return self.__uncompleteWCSData.towerId
  end
  return self.__wcSeasonCtrl:GetWCSTowerId()
end

function WarChessSeasonManager:IsInWCS()
  return self.__wcSeasonCtrl ~= nil
end

function WarChessSeasonManager:GetWCSSeasonCfg()
  return self.__wcSeasonCtrl:GetWCSSeasonCfg()
end

function WarChessSeasonManager:GetWCSSeasonId()
  return self.__wcSeasonCtrl:GetWCSSeasonId()
end

function WarChessSeasonManager:GetWCHighesScore()
  if self._addtionData == nil then
    return 0
  end
  return self._addtionData:GetSeasonHighesScore()
end

function WarChessSeasonManager:GetWCSRecommendPower()
  if self._addtionData == nil then
    return 0
  end
  return self._addtionData:GetSeasonRecommendPower()
end

function WarChessSeasonManager:SetWCSEnterNextFloorTeamInfo(info)
  self.__enterNextFloorFormInfo = info
end

function WarChessSeasonManager:GetWCSEnterNextFloorTeamInfo()
  return self.__enterNextFloorFormInfo
end

function WarChessSeasonManager:SetWarChessSeasonName(name, indexStr)
  self.__WCSLevelNameStr = name
  self.__WCSLevelIndexStr = indexStr
end

function WarChessSeasonManager:SetOutSideInfo2WCManager()
  local floorIndex = self.__wcSeasonCtrl:WCSGetFloor()
  local indexStr
  if self.__WCSLevelIndexStr ~= nil then
    string.format(self.__WCSLevelIndexStr, tostring(floorIndex))
  else
    indexStr = "Level " .. tostring(floorIndex)
  end
  WarChessManager:SetLevelNameAndIndex(self.__WCSLevelNameStr or "???", indexStr)
  WarChessManager:SetWCRecommendPower(self:GetWCSRecommendPower())
end

function WarChessSeasonManager:WarChessSeasonEnterDoor(wcLevelId, envBuffData, levelPressAddNum)
  local function SingleStart()
    self._isFirstEnter = false
    
    local warChessType = eWarChessEnum.eBriefDetailType.season
    self.__wcNetworkCtrl:CS_WarChess_SingleStart(wcLevelId, nil, nil, warChessType, function(argList)
      if argList.Count ~= 1 then
        error("argList.Count error:" .. tostring(argList.Count))
        return
      end
      local warChessMsg = argList[0]
      WarChessManager:ExitWarChessClean()
      self.__wcSeasonCtrl.__formMsg = warChessMsg.forms
      self.__wcSeasonCtrl.warChessSeasonFloor = warChessMsg.warChessSeasonFloor
      UIManager:ShowWindow(UIWindowTypeID.CommonMask):InitCommonMask(Color.black):CommonMaskFadeIn(0.3, function()
        self:CleanOrtherWhenEnter()
        self.__wcSeasonCtrl:WCSSetSurWCSRoomData(warChessMsg.RoomData)
        WarChessSeasonManager:SetOutSideInfo2WCManager()
        self:SetWCSEnterNextFloorTeamInfo(warChessMsg.forms)
        WarChessManager:EnterWarChessByOutMsg(warChessMsg)
        local wcCtrl = WarChessManager:GetWarChessCtrl()
        wcCtrl.palySquCtrl:SetWCSLevelBuff(envBuffData)
        wcCtrl.palySquCtrl:SetWCSLevelPressAdd(levelPressAddNum)
        self.__wcSeasonCtrl.isInLobby = false
        self.__wcSeasonCtrl.isInFirstLobby = false
      end)
    end)
  end
  
  if self:GetIsInWCSeasonIsInLobby() then
    self.__wcNetworkCtrl:CS_WarChess_Settle(nil, function()
      SingleStart()
    end)
    return
  end
  SingleStart()
end

function WarChessSeasonManager:WarChessSeasonEnterLobby()
  local wcSeasonId = self.__wcSeasonCtrl:GetWCSSeasonId()
  local wcTowerId = self.__wcSeasonCtrl:GetWCSTowerId()
  local envId = self.__wcSeasonCtrl:GetWCEnvId()
  self.__wcNetworkCtrl:CS_WarChess_EnterWarChessLobby(wcSeasonId, wcTowerId, false, envId, function(argList)
    if argList.Count ~= 1 then
      error("argList.Count error:" .. tostring(argList.Count))
      return
    end
    local lobbyMessage = argList[0]
    self:CleanOrtherWhenEnter()
    WarChessManager:ExitWarChessClean()
    WarChessSeasonManager:SetWCSEnterNextFloorTeamInfo(lobbyMessage.backLobbyReMainData.forms)
    UIManager:ShowWindow(UIWindowTypeID.CommonMask):InitCommonMask(Color.black):CommonMaskFadeIn(0.3, function()
      self.__wcSeasonCtrl:EnterWCSeasonLobbyByMsg(lobbyMessage)
      self.__wcSeasonCtrl.isInLobby = true
    end)
  end)
end

function WarChessSeasonManager:OnWCSceneLoadOver()
  if self:GetIsInWCSeasonNotFirstLevel() then
    local wcCtrl = WarChessManager:GetWarChessCtrl()
    if wcCtrl.state == eWarChessEnum.eWarChessState.deploy then
      wcCtrl.curState:WCAutoDeploy()
      wcCtrl.curState:WCStartPlay()
    end
  end
end

function WarChessSeasonManager:OnWCEnterPlayState()
  if self.__wcSeasonCtrl ~= nil and self.__wcSeasonCtrl.__formMsg ~= nil then
    local wcCtrl = WarChessManager:GetWarChessCtrl()
    wcCtrl.teamCtrl:WCReaddAllChipData(self.__wcSeasonCtrl.__formMsg)
    local BattlePlayerDiff = {}
    local teamStateDic = {}
    local formExtraDiffMsg = {}
    for _, fInfo in pairs(self.__wcSeasonCtrl.__formMsg) do
      local isDead = fInfo.teamState & eWarChessEnum.eWCTeamState.Die > 0
      if not isDead then
        BattlePlayerDiff[fInfo.teamUid] = fInfo.player
      end
      teamStateDic[fInfo.teamUid] = fInfo.teamState
      formExtraDiffMsg[fInfo.teamUid] = fInfo.fairy
    end
    wcCtrl.teamCtrl:WCUpdateTeamState(teamStateDic)
    wcCtrl.teamCtrl:UpdateWCCommander(BattlePlayerDiff)
    wcCtrl.teamCtrl:UpdateTeamExtraData(formExtraDiffMsg)
    self.__wcSeasonCtrl.__formMsg = nil
  end
end

function WarChessSeasonManager:SetUncompleteWCSData(isHave, briefMsg)
  self.__isHaveUncompleteWCS = isHave
  if isHave then
    if briefMsg == nil then
      self.__isHaveUncompleteWCS = false
      return
    end
    local seasonId = briefMsg.seasonId
    local towerId = briefMsg.towerId
    local levelId = briefMsg.warchessId
    local floorId = briefMsg.floorId
    local isInWarChessLobby = briefMsg.isInWarChessLobby
    local strengthWinReward = briefMsg.strengthWinReward
    if self.__uncompleteWCSData == nil then
      self.__uncompleteWCSData = {}
    end
    self.__uncompleteWCSData.seasonId = seasonId
    self.__uncompleteWCSData.towerId = towerId
    self.__uncompleteWCSData.levelId = levelId
    self.__uncompleteWCSData.floorId = floorId
    self.__uncompleteWCSData.isInWarChessLobby = isInWarChessLobby
    self.__uncompleteWCSData.strengthWinReward = strengthWinReward
  else
    self.__uncompleteWCSData = nil
  end
end

function WarChessSeasonManager:GetUncompleteWCSData()
  return self.__isHaveUncompleteWCS, self.__uncompleteWCSData
end

function WarChessSeasonManager:WCSReconnect()
  local warChessType = eWarChessEnum.eBriefDetailType.season
  self.__wcNetworkCtrl:CS_WarChess_Detail(warChessType, function(argList)
    if argList.Count ~= 1 then
      error("argList.Count error:" .. tostring(argList.Count))
      return
    end
    local warChessMsg = argList[0]
    local wcSeasonId = self.__uncompleteWCSData.seasonId
    local wcTowerId = self.__uncompleteWCSData.towerId
    local envId = warChessMsg.data.seasonEnvId
    self:InitWCSeasonCtrl(wcSeasonId, wcTowerId, envId)
    self.__wcSeasonCtrl.isInFirstLobby = self.__uncompleteWCSData.floorId == 1 and self.__uncompleteWCSData.isInWarChessLobby
    self.__wcSeasonCtrl.isInLobby = self.__uncompleteWCSData.isInWarChessLobby
    self.__wcSeasonCtrl.warChessSeasonFloor = self.__uncompleteWCSData.floorId
    self:CleanOrtherWhenEnter()
    self._isFirstEnter = true
    if self.__wcSeasonCtrl.isInLobby then
      local lobbyMessage = {
        RoomData = warChessMsg.data.NextRoomData,
        backLobbyReMainData = warChessMsg.data
      }
      self.__wcSeasonCtrl:WCSSetSurWCSRoomData(nil)
      self.__wcSeasonCtrl:EnterWCSeasonLobbyByMsg(lobbyMessage, true)
    else
      self.__wcSeasonCtrl:WCSSetSurWCSRoomData(warChessMsg.data.RoomData)
      WarChessSeasonManager:SetOutSideInfo2WCManager()
      WarChessManager:EnterWarChessByOutMsg(warChessMsg.data, true)
    end
    self:SetUncompleteWCSData(false)
  end)
end

function WarChessSeasonManager:WCSSettle(isWin, settleMsg, WCResultFunc)
  local nextWarChessLobby = settleMsg.nextWarChessLobby
  local nextRooms = settleMsg.RoomData
  local seasonSettle = nextWarChessLobby or nextRooms ~= nil and 0 < #nextRooms
  if seasonSettle then
    self._settleHandler:EnterWarchessLevel(isWin, settleMsg, WCResultFunc)
  else
    self._settleHandler:EnterWarchessSeason(isWin, settleMsg, WCResultFunc)
  end
end

function WarChessSeasonManager:SyncWCSSavingData(callback)
  self.__wcNetworkCtrl:CS_WarChess_GetSeasonBackup(function(args)
    if args.Count == 0 then
      error("args.Count == 0")
      return
    end
    local saveMsgDatas = args[0]
    self.__wcsSavingDataDic = {}
    for _, WarChessSeasonElem in pairs(saveMsgDatas) do
      local index = WarChessSeasonElem.warChessSeasonbackUpId
      self.__wcsSavingDataDic[index] = WarChessSeasonElem
    end
    if callback ~= nil then
      callback()
    end
  end)
end

function WarChessSeasonManager:GetWCSSavingData()
  return self.__wcsSavingDataDic
end

function WarChessSeasonManager:SaveWCSSavingData(index, callback)
  self.__wcNetworkCtrl:CS_WarChess_SetSeasonBackup(index, function()
    if callback ~= nil then
      callback()
    end
    if isGameDev then
      print("<color=green>SAVE COMPLETE</color>")
    end
    self:SyncWCSSavingData(function()
      MsgCenter:Broadcast(eMsgEventId.WCS_SavingDataRefresh)
    end)
  end)
end

function WarChessSeasonManager:ReadWCSSavingData(index)
  local savingData = self.__wcsSavingDataDic[index]
  if savingData == nil then
    error("saving data not exist")
    return
  end
  self.__wcNetworkCtrl:CS_WarChess_SeasonBackupChoice(index, function(args)
    if args.Count == 0 then
      error("args.Count == 0")
      return
    end
    local warChessMsg = args[0]
    local inWarChessLobby = savingData.inWarChessLobby
    local floorId = savingData.warChessSeasonFloor
    local seasonId = savingData.warChessSeasonId
    local towerId = savingData.warChessTowerId
    local envId = warChessMsg.seasonEnvId
    self:InitWCSeasonCtrl(seasonId, towerId, envId)
    self.__wcSeasonCtrl.isInFirstLobby = floorId == 1 and inWarChessLobby
    self.__wcSeasonCtrl.isInLobby = inWarChessLobby
    self.__wcSeasonCtrl.warChessSeasonFloor = floorId
    self:CleanOrtherWhenEnter()
    if self.__wcSeasonCtrl.isInLobby then
      local lobbyMessage = {
        RoomData = warChessMsg.NextRoomData,
        backLobbyReMainData = warChessMsg
      }
      self.__wcSeasonCtrl:WCSSetSurWCSRoomData(nil)
      self.__wcSeasonCtrl:EnterWCSeasonLobbyByMsg(lobbyMessage, true)
    else
      self.__wcSeasonCtrl:WCSSetSurWCSRoomData(warChessMsg.RoomData)
      WarChessSeasonManager:SetOutSideInfo2WCManager()
      WarChessManager:EnterWarChessByOutMsg(warChessMsg, true)
    end
    self:SetUncompleteWCSData(false)
  end)
end

function WarChessSeasonManager:SetSeasonAddtionData(seasonAddtionData)
  self._addtionData = seasonAddtionData
end

function WarChessSeasonManager:GetSeasonAddtionData()
  return self._addtionData
end

function WarChessSeasonManager:IsFirstSeasonEnter()
  return self._isFirstEnter
end

function WarChessSeasonManager:GetWCSEnvCfgList(seasonId)
  local wcsCfg = ConfigData.warchess_season[seasonId]
  local envCfgList = {}
  if wcsCfg == nil then
    error("wcsCfg not exist,seasonId:" .. tostring(seasonId))
    return nil
  end
  for _, envId in ipairs(wcsCfg.env_id) do
    local envCfg = ConfigData.warchess_season_general_env[envId]
    if envCfg == nil then
      error("wcs envCfg not exist, envId:" .. tostring(envId))
    else
      table.insert(envCfgList, envCfg)
    end
  end
  return envCfgList
end

function WarChessSeasonManager:GetWCSCfg(seasonId)
  local wcsCfg = ConfigData.warchess_season[seasonId]
  if wcsCfg == nil then
    error("Cant get warchess_season cfg, seasonId:" .. tostring(seasonId))
    return
  end
  return wcsCfg
end

function WarChessSeasonManager:IsWCSUnlock(seasonId)
  local wcsCfg = self:GetWCSCfg(seasonId)
  if wcsCfg == nil then
    return false
  end
  return CheckCondition.CheckLua(wcsCfg.pre_condition, wcsCfg.pre_para1, wcsCfg.pre_para2)
end

function WarChessSeasonManager:GetWCSUnlockDes(seasonId)
  local wcsCfg = self:GetWCSCfg(seasonId)
  if wcsCfg == nil then
    return nil
  end
  return CheckCondition.GetUnlockInfoLua(wcsCfg.pre_condition, wcsCfg.pre_para1, wcsCfg.pre_para2)
end

function WarChessSeasonManager:GetEnvCfgBySeasonAndDiff(seasonId, diffId)
  local envCfg
  local envCfgList = WarChessSeasonManager:GetWCSEnvCfgList(seasonId)
  for _, _envCfg in ipairs(envCfgList) do
    if table.contain(_envCfg.difficulty_id, diffId) then
      envCfg = _envCfg
      break
    end
  end
  return envCfg
end

function WarChessSeasonManager:GetWCSEnvIsUnlock(envId)
  if self._tempEnvUnlockEncDic ~= nil and self._tempEnvUnlockEncDic[envId] then
    return true
  end
  local envCfg = ConfigData.warchess_season_general_env[envId]
  if envCfg == nil then
    return false
  end
  if envCfg.preConditionsNum == 0 then
    if self._tempEnvUnlockEncDic == nil then
      self._tempEnvUnlockEncDic = {}
    end
    self._tempEnvUnlockEncDic[envId] = true
    return true
  end
  for i, v in ipairs(envCfg.preConditions) do
    if CheckCondition.CheckLua(v[1], v[2], v[3]) then
      if self._tempEnvUnlockEncDic == nil then
        self._tempEnvUnlockEncDic = {}
      end
      self._tempEnvUnlockEncDic[envId] = true
      return true
    end
  end
  return false
end

function WarChessSeasonManager:GetWCSTowerList(seasonId, envId)
  if envId == nil or envId == 0 then
    return ConfigData.warchess_season_stage_info[seasonId]
  end
  local envCfg = ConfigData.warchess_season_general_env[envId]
  local difficulty_id = envCfg.difficulty_id
  local stageInfoCfgs = {}
  local all_stageInfoCfgs = ConfigData.warchess_season_stage_info[seasonId]
  for _, diffId in ipairs(difficulty_id) do
    local cfg = all_stageInfoCfgs[diffId]
    if all_stageInfoCfgs[diffId] ~= nil then
      table.insert(stageInfoCfgs, cfg)
    end
  end
  return stageInfoCfgs
end

function WarChessSeasonManager:GetWCSStageInfoByDiffId(seasonId, diffId)
  local stageInfoCfgs = WarChessSeasonManager:GetWCSTowerList(seasonId)
  local stageInfoCfg = stageInfoCfgs[diffId]
  if stageInfoCfg ~= nil then
    return stageInfoCfg
  end
  return nil
end

function WarChessSeasonManager:GetWCSStageInfoByTowerId(seasonId, towerId)
  local stageInfoCfgs = WarChessSeasonManager:GetWCSTowerList(seasonId)
  for diff, stageInfoCfg in pairs(stageInfoCfgs) do
    if stageInfoCfg.season_id == towerId then
      return stageInfoCfg
    end
  end
  return nil
end

function WarChessSeasonManager:TryWcSsBuffSelect()
  if not self:IsInWCS() then
    return
  end
  local towerId = self.__wcSeasonCtrl:GetWCSTowerId()
  local seasonId = self.__wcSeasonCtrl:GetWCSSeasonId()
  local stageInfoCfg = self:GetWCSStageInfoByTowerId(seasonId, towerId)
  if stageInfoCfg == nil then
    return
  end
  local unlockBuffIdDic = self.__wcSeasonCtrl:GetWCSInitUnlockDic()
  if table.IsEmptyTable(unlockBuffIdDic) then
    return
  end
  local buffList = {}
  local WarChessBuffData = require("Game.WarChess.Data.WarChessBuffData")
  for _, buffId in pairs(stageInfoCfg.initial_protocol_all) do
    local wcsBuffData = WarChessBuffData.CrearteBuffById(buffId)
    table.insert(buffList, wcsBuffData)
  end
  if #buffList <= 0 then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.EpBuffDesc, function(win)
    win:InitEpBuffSelect(buffList, unlockBuffIdDic)
  end)
end

function WarChessSeasonManager:GetWCSEnvIdByTowerId(seasonId, towerId)
  local stageInfoCfg = WarChessSeasonManager:GetWCSStageInfoByTowerId(seasonId, towerId)
  if stageInfoCfg == nil then
    return nil
  end
  local diffId = stageInfoCfg.difficulty_id
  local envCfg = WarChessSeasonManager:GetEnvCfgBySeasonAndDiff(seasonId, diffId)
  return envCfg
end

function WarChessSeasonManager:GetWCSTowerIsUnlock(seasonId, diffId)
  local stageInfoCfgs = WarChessSeasonManager:GetWCSTowerList(seasonId)
  local stageInfoCfg = stageInfoCfgs[diffId]
  if stageInfoCfg == nil then
    return false
  end
  if stageInfoCfg.preConditionsNum == 0 then
    return true
  end
  for i, v in ipairs(stageInfoCfg.preConditions) do
    if CheckCondition.CheckLua(v[1], v[2], v[3]) then
      return true
    end
  end
  return false
end

function WarChessSeasonManager:GetWCSSaveNum(seasonId)
  local wcsCfg = ConfigData.warchess_season[seasonId]
  if wcsCfg == nil then
    error("wcsCfg not exist,seasonId:" .. tostring(seasonId))
    return 0
  end
  return wcsCfg.max_save
end

function WarChessSeasonManager:GetWCSPassedTower()
  if self.__passedWarChessSeasonDic == nil then
    self.__passedWarChessSeasonDic = {}
  end
  return self.__passedWarChessSeasonDic
end

function WarChessSeasonManager:GetWCSPassedEnvMaxNum(seasonId, envId)
  local towerRecord = self:GetWCSPassedTower()
  local seasonRecord = towerRecord and towerRecord[seasonId] or {}
  local maxNum = seasonRecord.envRecord and seasonRecord.envRecord[envId] and seasonRecord.envRecord[envId].high or 0
  return maxNum
end

function WarChessSeasonManager:RefreshWCSPassedTowerData(seasonId)
  self.__wcNetworkCtrl:CS_WarChessSeasonRecord(seasonId, function(args)
    if args.Count == 0 then
      error("RefreshWCSPassedTowerData error")
      return
    end
    local msg = args[0]
    local seasonRecord = msg.seasonRecord
    self.__passedWarChessSeasonDic = {}
    if seasonRecord ~= nil then
      self.__passedWarChessSeasonDic[seasonRecord.seasonId] = seasonRecord
      MsgCenter:Broadcast(eMsgEventId.WCS_WarChessSeasonRecord, seasonRecord.seasonId)
    end
  end)
end

function WarChessSeasonManager:GetWcSSpItemByLogicType(spcialLogicType)
  local wcSSpItemCfg = self:GetWcSSpItemConfigByLogicType()
  if wcSSpItemCfg == nil then
    return nil, nil
  end
  if spcialLogicType ~= nil and wcSSpItemCfg.logic_type ~= spcialLogicType then
    return nil, nil
  end
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  local itemId = wcSSpItemCfg.param[4]
  local parm = wcSSpItemCfg.param[3]
  local itemCount = wcCtrl.backPackCtrl:GetWCItemNum(itemId)
  return itemId, itemCount, parm
end

function WarChessSeasonManager:GetWcSSpItemConfigByLogicType(spcialLogicType)
  if not self:IsInWCS() then
    return nil, nil
  end
  local wcSeasonCfg = self.__wcSeasonCtrl:GetWCSSeasonCfg()
  if wcSeasonCfg.warchess_item == nil then
    return nil, nil
  end
  return ConfigData.warchess_season_item[wcSeasonCfg.warchess_item]
end

function WarChessSeasonManager:SetSeasonTechJumpFunc(func, redShowFunc)
  self._techOpenFunc = func
  self._techRedShowFunc = redShowFunc
end

function WarChessSeasonManager:GetSeasonTechJumpFunc()
  return self._techOpenFunc, self._techRedShowFunc
end

function WarChessSeasonManager:ReConnectDelete()
  local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  if sectorCtrl ~= nil then
    sectorCtrl:ExitSectorCtrl()
    sectorCtrl:Delete()
  end
  local actLobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if actLobbyCtrl ~= nil then
    actLobbyCtrl:Delete()
  end
end

function WarChessSeasonManager:ContinueWarChessSeasonCommon()
  local isUnComplete, wcsdata = self:GetUncompleteWCSData()
  if not isUnComplete then
    return
  end
  local towerId = wcsdata.towerId
  local seasonId = wcsdata.seasonId
  local stageInfoCfg = self:GetWCSStageInfoByTowerId(seasonId, towerId)
  local envCfg = self:GetWCSEnvIdByTowerId(seasonId, towerId)
  if stageInfoCfg ~= nil then
    self:ReConnectDelete()
    self:WCSReconnect()
    self:__SetWarChessSeasonAddtionData(stageInfoCfg, seasonId, envCfg.id)
  end
end

function WarChessSeasonManager:__SetWarChessSeasonAddtionData(stageInfoCfg, seasonId, envId)
  local WarChessSeasonAddtionData = require("Game.WarChessSeason.WarChessSeasonAddtionData")
  local addtionData = WarChessSeasonAddtionData.New()
  addtionData:SetSeasonCompleteFloor(stageInfoCfg.floor_id)
  addtionData:SetSeasonRecommendPower(stageInfoCfg.combat)
  addtionData:SetSeasonCompleteFloorTip(ConfigData:GetTipContent(8701))
  if seasonId and envId then
    local maxNum = self:GetWCSPassedEnvMaxNum(seasonId, envId)
    addtionData:SetSeasonHighesScore(maxNum)
  end
  self:SetSeasonAddtionData(addtionData)
  self:SetWarChessSeasonName(LanguageUtil.GetLocaleText(stageInfoCfg.difficulty_name))
end

return WarChessSeasonManager
