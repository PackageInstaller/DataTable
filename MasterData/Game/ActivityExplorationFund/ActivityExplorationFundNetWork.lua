local ActivityExplorationFundNetWork = class("ActivityExplorationFundNetWork", NetworkCtrlBase)
local base = NetworkCtrlBase
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance
local CommonRewardData = require("Game.CommonUI.CommonRewardData")

function ActivityExplorationFundNetWork:ctor()
  self._buyFundTable = {}
  self._getRewardTable = {}
end

function ActivityExplorationFundNetWork:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ActivityExploreFund_Buy, self, proto_csmsg.SC_ActivityExploreFund_Buy, self.SC_ActivityExploreFund_Buy)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ActivityExploreFund_Take, self, proto_csmsg.SC_ActivityExploreFund_Take, self.SC_ActivityExploreFund_Take)
end

function ActivityExplorationFundNetWork:CS_ActivityExploreFund_Buy(actId, fundId, callback)
  self._buyFundTable.actId = actId
  self._buyFundTable.fundId = fundId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ActivityExploreFund_Buy, proto_csmsg.CS_ActivityExploreFund_Buy, self._buyFundTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ActivityExploreFund_Buy, callback, proto_csmsg_MSG_ID.MSG_SC_ActivityExploreFund_Buy)
end

function ActivityExplorationFundNetWork:SC_ActivityExploreFund_Buy(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ActivityExploreFund_Buy error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ActivityExploreFund_Buy)
    return
  end
  local explorationFundCtrl = ControllerManager:GetController(ControllerTypeId.ActivityExplorationFund)
  if explorationFundCtrl == nil then
    return
  end
  local explorationFundData = explorationFundCtrl:GetExplorationFundDataByActId(self._buyFundTable.actId)
  if explorationFundData == nil then
    return
  end
  local singleFundData = explorationFundData:GetExplorationFundDataById(self._buyFundTable.fundId)
  if singleFundData == nil then
    return
  end
  local payCtr = ControllerManager:GetController(ControllerTypeId.Pay)
  payCtr:ReqPay(singleFundData:GetSingleFundDataFundCfg().senior_price, 1)
end

function ActivityExplorationFundNetWork:CS_ActivityExploreFund_Take(actId, fundId, callback)
  self._getRewardTable.actId = actId
  self._getRewardTable.fundId = fundId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ActivityExploreFund_Take, proto_csmsg.CS_ActivityExploreFund_Take, self._getRewardTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ActivityExploreFund_Take, callback, proto_csmsg_MSG_ID.MSG_SC_ActivityExploreFund_Take)
end

function ActivityExplorationFundNetWork:SC_ActivityExploreFund_Take(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ActivityExploreFund_Take error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ActivityExploreFund_Take)
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
    return
  end
  if table.IsEmptyTable(msg.rewards) then
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
    return
  end
  local explorationFundCtrl = ControllerManager:GetController(ControllerTypeId.ActivityExplorationFund)
  if explorationFundCtrl == nil then
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
    return
  end
  local explorationFundData = explorationFundCtrl:GetExplorationFundDataByActId(self._getRewardTable.actId)
  if explorationFundData == nil then
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
    return
  end
  local singleFundData = explorationFundData:GetExplorationFundDataById(self._getRewardTable.fundId)
  if singleFundData == nil then
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
    return
  end
  if self._getRewardTable.fundId == 1 and not singleFundData:GetIsSingleFundDataUnlockSenior() then
    local item_ids, item_nums = singleFundData:GetSingleFundDataSeniorRewardCanPick()
    CommonUtil.DefaultItemsSortList(item_ids, item_nums)
    UIManager:ShowWindowAsync(UIWindowTypeID.BpSpReward, function(window)
      if window == nil then
        return
      end
      local CRData = CommonRewardData.CreateCRDataUseDic(msg.rewards)
      CRData:SetBpSpRewardPreview(item_ids, item_nums):SetCRShowOverBuyFunc(function()
        local hasBuy = singleFundData:GetIsSingleFundDataUnlockSenior()
        if not hasBuy and explorationFundCtrl ~= nil then
          explorationFundCtrl:ReqBuyExplorationFundSenior(self._getRewardTable.actId, self._getRewardTable.fundId)
        end
      end)
      CRData:SetCRBattlePassTip(2, LanguageUtil.GetLocaleText(singleFundData:GetSingleFundDataFundCfg().name))
      CRData:SetCRBattlePassBuy(2, singleFundData:GetSingleFundDataSeniorPrice())
      window:AddAndTryShowReward(CRData)
    end)
  else
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local CRData = CommonRewardData.CreateCRDataUseDic(msg.rewards)
      window:AddAndTryShowReward(CRData)
    end)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

return ActivityExplorationFundNetWork
