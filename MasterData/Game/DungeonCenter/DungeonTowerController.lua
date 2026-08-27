local DungeonTowerController = class("DungeonTowerController", ControllerBase)
local base = ControllerBase
local DungeonTypeTower = require("Game.DungeonCenter.Data.DungeonTypeTower")
local DungeonInterfaceData = require("Game.BattleDungeon.IData.DungeonInterfaceData")
local DungeonCenterUtil = require("Game.DungeonCenter.Util.DungeonCenterUtil")
local FmtEnum = require("Game.Formation.FmtEnum")

function DungeonTowerController:OnInit()
  self.__dunTowerNetwork = NetworkManager:GetNetwork(NetworkTypeID.DungeonTower)
end

function DungeonTowerController:ShowDungeonTowerMain(closeFunc, openFunc)
  self.__closeFunc = closeFunc
  self.__noProgressShow = false
  self._myRakDetail = nil
  self._cacheHeroPass = nil
  UIManager:ShowWindowAsync(UIWindowTypeID.DungeonTowerSelect, function(window)
    if window == nil then
      return
    end
    window:InitDungeonTowerSelect(self)
    if openFunc ~= nil then
      openFunc()
    end
  end)
end

function DungeonTowerController:DirectEnterTowerLevel(towerId, closeFunc, openFunc)
  self.__closeFunc = closeFunc
  self.__noProgressShow = true
  self._myRakDetail = nil
  self._cacheHeroPass = nil
  UIManager:ShowWindowAsync(UIWindowTypeID.DungeonTowerSelect, function(window)
    if window == nil then
      return
    end
    local towerTypeData = DungeonTypeTower.New(towerId)
    window:InitDungeonTowerSelect(self, towerTypeData:GetTowerCategory())
    local completeLevel = PlayerDataCenter.dungeonTowerSData:GetTowerCompleteLevel(towerId)
    UIManager:ShowWindowAsync(UIWindowTypeID.DungeonTowerLevel, function(window)
      if window == nil then
        return
      end
      window:InitDungeonTowerLevel(self, towerTypeData, completeLevel)
      if openFunc ~= nil then
        openFunc()
      end
    end)
  end)
end

function DungeonTowerController:GetNeedAutoShowProgress()
  return not self.__noProgressShow
end

function DungeonTowerController:GetDungonTowerAutoBattleInfo(dungeonLevelData)
  if dungeonLevelData:IsTwinTowerLevel() then
    return false, false
  end
  local towerId = dungeonLevelData:GetDungeonTowerType()
  local completeLevel = PlayerDataCenter.dungeonTowerSData:GetTowerCompleteLevel(towerId)
  local levelNum = dungeonLevelData:GetDunTowerLevelNum()
  if completeLevel >= levelNum then
    return false, false
  end
  return true, true
end

function DungeonTowerController:EnterDungeonTowerFormation(tmpDungeonLevelData, isAutoBattle)
  local towerId = tmpDungeonLevelData:GetDungeonTowerType()
  local levelNum = tmpDungeonLevelData:GetDunTowerLevelNum()
  local towerTypeData = tmpDungeonLevelData:GetLevelTowerTypeData()
  local isTwinTower = tmpDungeonLevelData:IsTwinTowerLevel()
  local fmtModule
  if isTwinTower then
    fmtModule = FmtEnum.eFmtFromModule.DungeonTwinTower
  else
    fmtModule = FmtEnum.eFmtFromModule.DungeonTower
  end
  local ruleId = towerTypeData:GetTowerFormationRuleId()
  local fmtRuleCfg
  if 0 < ruleId then
    fmtRuleCfg = ConfigData.formation_rule[ruleId]
  end
  local autoBattleCount = 0
  if isAutoBattle then
    autoBattleCount = tmpDungeonLevelData:GetTowerTypeTotalLevel() - tmpDungeonLevelData:GetDunTowerLevelNum() + 1
  end
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  
  local function enterFunc()
    if 0 < autoBattleCount then
      BattleDungeonManager.autoCtrl:EnterDungeonAutoModel(tmpDungeonLevelData:GetTowerTypeTotalLevel(), true)
      BattleDungeonManager.autoCtrl:SetStartDungeonAutoCount(autoBattleCount)
    end
    DungeonCenterUtil.EnterDungeonFormationDeal()
  end
  
  local function exitFunc(fmtId)
    if BattleDungeonManager.autoCtrl:IsEnbaleDungeonAutoMode() then
      BattleDungeonManager.autoCtrl:ExitDungeonAutoModel()
    end
    DungeonCenterUtil.ExitDungeonFormationDeal()
  end
  
  local commonBattleFunc
  
  local function nextBattleFunc(curSelectFormationData, callBack, dinterfaceData)
    if dinterfaceData == nil then
      error("dungeon interface data is null,can't to next level")
      return
    end
    local dungeonLevelData = dinterfaceData:GetIDungeonLevelData()
    if dungeonLevelData == nil then
      error("dungeon tower level data is null,can't to next level")
      return
    end
    local nextDunLevelData = dungeonLevelData:GetNextTowerLevelData()
    commonBattleFunc(curSelectFormationData, callBack, nextDunLevelData)
  end
  
  local startBattleFunc
  
  function startBattleFunc(curSelectFormationData, callBack, dinterfaceData)
    local dungeonLevelData
    if dinterfaceData ~= nil then
      dungeonLevelData = dinterfaceData:GetIDungeonLevelData()
    else
      dungeonLevelData = tmpDungeonLevelData
    end
    commonBattleFunc(curSelectFormationData, callBack, dungeonLevelData)
  end
  
  function commonBattleFunc(curSelectFormationData, callBack, dungeonLevelData)
    local needKey = dungeonLevelData:GetConsumeKeyNum()
    if needKey > PlayerDataCenter.stamina:GetCurrentStamina() then
      JumpManager:Jump(JumpManager.eJumpTarget.BuyStamina)
      return
    end
    local curSelectFormationId = curSelectFormationData.id
    local formationData = PlayerDataCenter.formationDic[curSelectFormationId]
    if formationData == nil then
      return
    end
    BattleDungeonManager:SaveFormation(formationData)
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    saveUserData:SetLastFromModuleFmtId(fmtModule, curSelectFormationId)
    PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
    BattleDungeonManager:InjectBattleExitEvent(function(isWin)
      local LastPlayData = require("Game.Sector.Data.LastPlayData")
      local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
      local lastPlayData = LastPlayData.New():SetLPDDngeonLevelType(DungeonLevelEnum.DunLevelType.Tower):SetLPDExtraData(tmpDungeonLevelData):SetLPDIsWin(isWin == true):SetLPDActSceneLoadoverCallback(function()
        local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment)
        if aftertTeatmentCtrl ~= nil then
          aftertTeatmentCtrl:BindResultAfterAction(function()
            local towerLevelWindow = UIManager:GetWindow(UIWindowTypeID.DungeonTowerLevel)
            if towerLevelWindow ~= nil then
              towerLevelWindow:InitLastTowerProgressShow()
            end
          end)
          aftertTeatmentCtrl:TeatmentBengin()
        end
      end)
      UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(2)
      PlayerDataCenter.sectorEntranceHandler:DealLeftPlayMode2Sector(lastPlayData, nil, nil)
    end)
    local dungeonTowerCtrl = ControllerManager:GetController(ControllerTypeId.DungeonTower, true)
    local towerId = dungeonLevelData:GetDungeonTowerType()
    local floorId = dungeonLevelData:GetDunTowerLevelNum()
    local interfaceData = DungeonInterfaceData.CreateDungeonTowerInterface(dungeonLevelData, fmtRuleCfg)
    if dungeonLevelData:HasNextTowerLevel() then
      local nextLevelData = dungeonLevelData:GetNextTowerLevelData()
      local nextKeyCost = nextLevelData:GetConsumeKeyNum()
      interfaceData:SetDungeonNextInfo(nextBattleFunc, nextKeyCost)
    end
    interfaceData:SetDungeonReplayInfo(startBattleFunc, dungeonLevelData:GetConsumeKeyNum())
    local firstPower, benchPower = fmtCtrl:CalculatePower(formationData)
    dungeonTowerCtrl:RequestEnterDungeonTower(interfaceData, towerId, floorId, formationData, function()
      dungeonTowerCtrl:Delete()
      ControllerManager:DeleteController(ControllerTypeId.SectorController)
      if callBack ~= nil then
        callBack()
      end
    end, firstPower, benchPower)
  end
  
  local needKey = tmpDungeonLevelData:GetConsumeKeyNum()
  local stageId = tmpDungeonLevelData:GetDungeonLevelStageId()
  local lastFmtId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLastFromModuleFmtId(fmtModule)
  fmtCtrl:ResetFmtCtrlState()
  local enterFmtData = fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(fmtModule, stageId, lastFmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetEnterBattleCostTicketNum(needKey):SetFormationRuleCfg(fmtRuleCfg)
  if isTwinTower then
    self:RequestTowerHeroPassInfo(towerId, levelNum, function(heroPassStats)
      enterFmtData:SetFmtHeroPassInfo(heroPassStats)
      fmtCtrl:EnterFormation()
    end)
  else
    fmtCtrl:EnterFormation()
  end
end

function DungeonTowerController:RequestEnterDungeonTower(interfaceData, towerId, floorId, formationData, callBack, firstPower, benchPower)
  self.__dunTowerNetwork:CS_DUNGEONTOWER_Enter(towerId, floorId, formationData, function(dataList)
    if dataList.Count == 0 then
      return
    end
    local NtfEnterMsgData = dataList[0]
    BattleDungeonManager:RealEnterDungeon(NtfEnterMsgData, nil, interfaceData)
    NetworkManager:HandleDiff(NtfEnterMsgData.syncUpdateDiff)
    if callBack ~= nil then
      callBack()
    end
  end, firstPower, benchPower)
end

function DungeonTowerController:RequestRacingRankSelfInfo(callback)
  if self._myRakDetail ~= nil then
    callback(self._myRakDetail)
    return
  end
  self.__dunTowerNetwork:CS_DUNGEONTOWER_RacingRankSelfDetail(function(dataList)
    if dataList.Count == 0 then
      return
    end
    local msg = dataList[0]
    self._myRakDetail = msg.myRank
    callback(self._myRakDetail)
  end)
end

function DungeonTowerController:RequestTowerHeroPassInfo(towerId, floorId, callback)
  if self._cacheHeroPass ~= nil and self._cacheHeroPass.towerId == towerId and self._cacheHeroPass.floorId == floorId then
    callback(self._cacheHeroPass.stats)
    return
  end
  self.__dunTowerNetwork:CS_DUNGEONTOWER_HeroPassDetail(towerId, floorId, function(dataList)
    if dataList.Count == 0 then
      return
    end
    local msg = dataList[0]
    self._cacheHeroPass = {
      towerId = towerId,
      floorId = floorId,
      stats = msg.stats
    }
    callback(self._cacheHeroPass.stats)
  end)
end

function DungeonTowerController:ExitDungeonTower(tohome)
  if self.__closeFunc ~= nil then
    self.__closeFunc(tohome)
  end
  self:Delete()
end

function DungeonTowerController:OnDelete()
  UIManager:DeleteWindow(UIWindowTypeID.DungeonTowerSelect)
  UIManager:DeleteWindow(UIWindowTypeID.DungeonTowerLevel)
  base.OnDelete(self)
end

return DungeonTowerController
