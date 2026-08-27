local ActivityExplorationFundController = class("ActivityExplorationFundController", ControllerBase)
local base = ControllerBase
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local ActivityExplorationFundData = require("Game.ActivityExplorationFund.Data.ActivityExplorationFundData")
local cs_MessageCommon = CS.MessageCommon

function ActivityExplorationFundController:OnInit()
  ConfigData:LoadDynCfg(eDynConfigData.activity_explore_main)
  ConfigData:LoadDynCfg(eDynConfigData.activity_explore_fund)
  ConfigData:LoadDynCfg(eDynConfigData.activity_explore_reward)
  self._dataDic = {}
  self._net = NetworkManager:GetNetwork(NetworkTypeID.ActivityExplorationFund)
  self._frameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  self.__OnFundExitExplorationCallback = BindCallback(self, self.__OnFundExitExploration)
  MsgCenter:AddListener(eMsgEventId.ExplorationExit, self.__OnFundExitExplorationCallback)
end

function ActivityExplorationFundController:InitExplorationFund(msg)
  local data = ActivityExplorationFundData.New()
  self._dataDic[msg.actId] = data
  data:InitExplorationFundData(msg)
  return data
end

function ActivityExplorationFundController:UpdateExplorationFund(msg)
  if self._dataDic[msg.actId] == nil then
    self:InitExplorationFund(msg)
    return
  end
  self._dataDic[msg.actId]:UpdateExplorationFundData(msg)
end

function ActivityExplorationFundController:UpdateAllExplorationFund()
  for _, data in pairs(self._dataDic) do
    data:ForceUpdateExplorationFundRewardData()
  end
end

function ActivityExplorationFundController:RemoveExplorationFundData(actId)
  self._dataDic[actId] = nil
  if table.IsEmptyTable(self._dataDic) then
    ControllerManager:DeleteController(ControllerTypeId.ActivityExplorationFund)
  end
end

function ActivityExplorationFundController:GetExplorationFundDataByActId(actId)
  return self._dataDic[actId]
end

function ActivityExplorationFundController:GetExplorationSingleFundDataByFundId(fundId)
  for _, fundData in pairs(self._dataDic) do
    local singleFundData = fundData:GetExplorationFundDataById(fundId)
    if singleFundData then
      return singleFundData
    end
  end
  return nil
end

function ActivityExplorationFundController:__OnFundExitExploration()
  self:UpdateAllExplorationFund()
end

function ActivityExplorationFundController:ReqBuyExplorationFundSenior(actId, fundId, callback)
  local explorationFundData = self:GetExplorationFundDataByActId(actId)
  local singleFundData = explorationFundData:GetExplorationFundDataById(fundId)
  if singleFundData:GetIsSingleFundDataUnlockSenior() then
    return
  end
  if not singleFundData:GetIsSingleFundDataCanBuySenior() then
    cs_MessageCommon.ShowMessageTips(singleFundData:GetSingleFundDataSeniorLockDes())
    return
  end
  self._net:CS_ActivityExploreFund_Buy(explorationFundData:GetActId(), fundId, callback)
end

function ActivityExplorationFundController:ReqTakeExplorationFundReward(actId, fundId, callback)
  local explorationFundData = self:GetExplorationFundDataByActId(actId)
  self._net:CS_ActivityExploreFund_Take(explorationFundData:GetActId(), fundId, callback)
end

function ActivityExplorationFundController:OnDelete()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_explore_main)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_explore_fund)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_explore_reward)
  MsgCenter:RemoveListener(eMsgEventId.ExplorationExit, self.__OnFundExitExplorationCallback)
end

return ActivityExplorationFundController
