local ActivityDivergentController = class("ActivityDivergentController", ControllerBase)
local base = ControllerBase
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local ActivityDivergentData = require("Game.ActivityDivergent.Data.ActivityDivergentData")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")

function ActivityDivergentController:OnInit()
  ConfigData:LoadDynCfg(eDynConfigData.activity_divergent_main)
  ConfigData:LoadDynCfg(eDynConfigData.activity_divergent_task_group)
  ConfigData:LoadDynCfg(eDynConfigData.activity_divergent_hero)
  ConfigData:LoadDynCfg(eDynConfigData.activity_divergent_reward_group)
  ConfigData:LoadDynCfg(eDynConfigData.activity_divergent_ui_config)
  self._dataDic = {}
  self._net = NetworkManager:GetNetwork(NetworkTypeID.ActivityDivergent)
  self._frameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  self._ItemCheckDic = {}
  self.__OnItemChangeFunc = BindCallback(self, self.__ItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnItemChangeFunc)
  self.__TaskUpdateCallback = BindCallback(self, self.__DivergentTaskUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskUpdateCallback)
end

function ActivityDivergentController:InitDivergent(msg)
  local data = ActivityDivergentData.New()
  self._dataDic[msg.actId] = data
  data:InitDivergentData(msg)
  return data
end

function ActivityDivergentController:UpdateDivergent(msg)
  if self._dataDic[msg.actId] == nil then
    self:InitDivergent(msg)
    return
  end
  self._dataDic[msg.actId]:UpdateDivergentData(msg)
end

function ActivityDivergentController:UpdateAllDivergent()
  for _, data in pairs(self._dataDic) do
    data:ForceUpdateDivergentTaskData()
  end
end

function ActivityDivergentController:GetIsDivergentUnlock()
  return true
end

function ActivityDivergentController:GetDivergentDataByActId(actId)
  return self._dataDic[actId]
end

function ActivityDivergentController:OpenDivergentMain(actId, enterSectorFunc, backCallback, selectSector, windowLoadedcallback)
  if not self:GetIsDivergentUnlock() then
    return
  end
  local divergentData = self:GetDivergentDataByActId(actId)
  if divergentData == nil then
    return
  end
  if selectSector ~= nil then
    local divergentHeroId = divergentData:GetDivergentHeroIdBySectorId(selectSector)
    if divergentHeroId == 0 then
      selectSector = nil
    elseif not SectorStageDetailHelper.IsSectorNoCollide(selectSector) then
      selectSector = nil
    elseif not divergentData:IsActivityRunning() then
      selectSector = nil
    end
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.ActivityDivergentMain, function(window)
    if window == nil then
      return
    end
    window:InitDivergentMain(divergentData, enterSectorFunc, backCallback)
    if selectSector ~= nil then
      window:UseDivergentHero()
    end
    if windowLoadedcallback ~= nil then
      windowLoadedcallback()
    end
  end)
end

function ActivityDivergentController:AddDivergentItemCheck(itemId)
  self._ItemCheckDic[itemId] = true
end

function ActivityDivergentController:RemoveDivergentItemCheck()
  self._ItemCheckDic = {}
end

function ActivityDivergentController:__ItemUpdate(itemDic)
  for k, _ in pairs(self._ItemCheckDic) do
    if itemDic[k] ~= nil then
      self:UpdateAllDivergent()
      return
    end
  end
end

function ActivityDivergentController:__DivergentTaskUpdate(taskData)
  for _, divergentData in pairs(self._dataDic) do
    if divergentData:GetDivergentTaskById(taskData.id) ~= nil then
      divergentData:ForceUpdateDivergentTaskData()
    end
  end
end

function ActivityDivergentController:ReqRefreshDivergentQuest(actId, questId, callback)
  local divergentData = self:GetDivergentDataByActId(actId)
  self._net:CS_ActivityHeroDivergent_RefreshQuest(divergentData:GetActId(), questId, callback)
end

function ActivityDivergentController:ReqBuyDivergentQuest(actId, callback)
  local divergentData = self:GetDivergentDataByActId(actId)
  self._net:CS_ActivityHeroDivergent_BuyQuest(divergentData:GetActId(), callback)
end

function ActivityDivergentController:ReqSwitchDivergentHero(actId, heroId, callback)
  local divergentData = self:GetDivergentDataByActId(actId)
  self._net:CS_ActivityHeroDivergent_HeroSwitch(divergentData:GetActId(), heroId, callback)
end

function ActivityDivergentController:OnDelete()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_divergent_main)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_divergent_task_group)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_divergent_hero)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_divergent_reward_group)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_divergent_ui_config)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnItemChangeFunc)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskUpdateCallback)
end

return ActivityDivergentController
