local ActivitySaveMoneyController = class("ActivitySaveMoneyController", ControllerBase)
local base = ControllerBase
local ActivitySaveMoneyData = require("Game.ActivitySaveMoney.Data.ActivitySaveMoneyData")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")

function ActivitySaveMoneyController:OnInit()
  ConfigData:LoadDynCfg(eDynConfigData.activity_saveMoney_rewards)
  self._dataDic = {}
  self._frameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  self._ReqSaveMoneyData = BindCallback(self, self.ReqSaveMoneyData)
  self._net = NetworkManager:GetNetwork(NetworkTypeID.ActivitySaveMoney)
end

function ActivitySaveMoneyController:InitSaveMoney(msg)
  if self._dataDic[msg.actId] == nil then
    local newData = ActivitySaveMoneyData.New()
    self._dataDic[msg.actId] = newData
  end
  local data = self._dataDic[msg.actId]
  data:InitActivitySaveMoneyDataByMsg(msg)
  local nextUpdateTm = data:GetSaveMoneyNextStateChangeTm()
  if nextUpdateTm > PlayerDataCenter.timestamp and data.updateTimeDirty then
    data.updateTimeDirty = false
    self._frameCtrl:AddActivityDataUpdateTimeListen(data:GetActFrameId(), nextUpdateTm + 1, self._ReqSaveMoneyData)
  end
  return data
end

function ActivitySaveMoneyController:ReqSaveMoneyData(frameId)
  local actFrameNet = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  actFrameNet:CS_ACTIVITY_SingleConcreteInfo(frameId, function(objList)
    local msg = objList[0]
    if msg ~= nil and msg.activitySaveMoney ~= nil then
      self:InitSaveMoney(msg.activitySaveMoney)
      self:UpdateSaveMoneyUI()
    end
  end)
end

function ActivitySaveMoneyController:GetTheLatestSaveMoneyData()
  local res
  for k, v in pairs(self._dataDic) do
    if res == nil then
      res = v
    elseif v:GetActivityBornTime() > res:GetActivityBornTime() then
      res = v
    end
  end
  return res
end

function ActivitySaveMoneyController:GetSaveMoneyDataByActId(actId)
  return self._dataDic[actId]
end

function ActivitySaveMoneyController:RemoveSaveMoneyData(actId)
  self._dataDic[actId] = nil
end

function ActivitySaveMoneyController:IsHaveSaveMoneyData()
  return table.count(self._dataDic) > 0
end

function ActivitySaveMoneyController:UpdateSaveMoneyUI()
  local saveMoneyUI = UIManager:GetWindow(UIWindowTypeID.SaveMoney)
  if saveMoneyUI ~= nil then
    saveMoneyUI:RefreshSaveMoneyUI()
  end
end

function ActivitySaveMoneyController:ReqBuySaveMoney(actId, buyLevel, callback)
  self._net:CS_ACTIVITY_SaveMoney_Save(actId, buyLevel, function()
    if callback ~= nil then
      callback()
    end
    local data = self:GetSaveMoneyDataByActId(actId)
    if data ~= nil then
      self:ReqSaveMoneyData(data:GetActFrameId())
    end
  end)
end

function ActivitySaveMoneyController:ReqGetSaveMoneyReward(actId, reqStage, callback)
  self._net:CS_ACTIVITY_SaveMoney_GetReward(actId, reqStage, function()
    if callback ~= nil then
      callback()
    end
    local data = self:GetSaveMoneyDataByActId(actId)
    if data ~= nil then
      self:ReqSaveMoneyData(data:GetActFrameId())
    end
  end)
end

function ActivitySaveMoneyController:OnDelete()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_saveMoney_rewards)
end

return ActivitySaveMoneyController
