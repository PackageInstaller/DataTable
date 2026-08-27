local DunSixHeroCtrl = class("DunSixHeroCtrl", ControllerBase)
local base = ControllerBase
local FmtEnum = require("Game.Formation.FmtEnum")
local DungeonCenterUtil = require("Game.DungeonCenter.Util.DungeonCenterUtil")
local DungeonInterfaceData = require("Game.BattleDungeon.IData.DungeonInterfaceData")

function DunSixHeroCtrl:OnInit()
  self.__OnDayTimePass = BindCallback(self, self.OnDayTimePass)
  MsgCenter:AddListener(eMsgEventId.OnCommonDayPass, self.__OnDayTimePass)
end

function DunSixHeroCtrl:ShowHexaTower(closeFunc, openfunc, lastTowerId)
  UIManager:ShowWindowAsync(UIWindowTypeID.DungeonHexaTower, function(window)
    if window == nil then
      return
    end
    window:InitHexaTower(self, closeFunc, lastTowerId)
    if openfunc ~= nil then
      openfunc()
    end
  end)
end

function DunSixHeroCtrl:GetCurrentTimeLimitTower()
  local limitTowwerIdList = {}
  local timestamp = PlayerDataCenter.timestamp
  for id, cfg in pairs(ConfigData.env_dungeon_tower) do
    if cfg.start_time ~= nil and cfg.start_time ~= 0 and timestamp > cfg.start_time and timestamp < cfg.end_time then
      table.insert(limitTowwerIdList, id)
    end
  end
  table.sort(limitTowwerIdList)
  return limitTowwerIdList
end

function DunSixHeroCtrl:GetCurrentNormalTower()
  local normalTowwerIdList = {}
  for id, cfg in pairs(ConfigData.env_dungeon_tower) do
    if cfg.start_time == nil or cfg.start_time == 0 then
      table.insert(normalTowwerIdList, id)
    end
  end
  table.sort(normalTowwerIdList)
  return normalTowwerIdList
end

function DunSixHeroCtrl:GetProgressByTowerList(Towerlist)
  local cn = 0
  local tn = 0
  for _, towerId in pairs(Towerlist) do
    local cpNum, totalNum = self:GetProgressByTowerId(towerId)
    cn = cn + cpNum
    tn = tn + totalNum
  end
  return tn, cn
end

function DunSixHeroCtrl:GetProgressByTowerId(towerId)
  local cn = PlayerDataCenter.dungeonTowerSData:GetTowerCompleteLevel(towerId)
  local tn = #ConfigData.env_dungeon_tower_dungeon_detail.tower2DunDic[towerId]
  return cn, tn
end

function DunSixHeroCtrl:GetCurrentPeriodicEndtime(limitTowwerIdList)
  local et
  for _, towerId in pairs(limitTowwerIdList) do
    local endTime = ConfigData.env_dungeon_tower[towerId].end_time
    if et == nil then
      et = endTime
    elseif et ~= endTime then
      warn("six hero tower Periodic mode towers not have a same endTime pls check it!")
    end
  end
  return et
end

function DunSixHeroCtrl:OnDayTimePass()
  if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.DungeonHexaTower) then
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.DungeonHexaTower)
    local win = UIManager:GetWindow(UIWindowTypeID.DungeonHexaTower)
    win:DunHexaTowerAllRefresh()
  end
end

function DunSixHeroCtrl:EnterSixHeroDunTowerFormation(tmpDungeonLevelData, isAutoBattle)
  local towerId = tmpDungeonLevelData:GetDungeonTowerType()
  local levelNum = tmpDungeonLevelData:GetDunTowerLevelNum()
  local towerTypeData = tmpDungeonLevelData:GetLevelTowerTypeData()
  local fmtModule = FmtEnum.eFmtFromModule.SixHeroTower
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
      local lastPlayData = LastPlayData.New():SetLPDDngeonLevelType(DungeonLevelEnum.DunLevelType.SixHeroTower):SetLPDExtraData(tmpDungeonLevelData):SetLPDIsWin(isWin == true):SetLPDActSceneLoadoverCallback(function()
        local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment)
        if aftertTeatmentCtrl ~= nil then
          aftertTeatmentCtrl:BindResultAfterAction(function()
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
  fmtCtrl:EnterFormation()
end

function DunSixHeroCtrl:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnCommonDayPass, self.__OnDayTimePass)
end

return DunSixHeroCtrl
