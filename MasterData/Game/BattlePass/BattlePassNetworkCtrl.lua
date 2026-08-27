local BattlePassNetworkCtrl = class("BattlePassNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")

function BattlePassNetworkCtrl:ctor()
  self.__sendBattlePassTake = {}
  self.__sendBattlePassBuy = {}
  self.__sendBattlePassBuyExp = {}
end

function BattlePassNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLEPASS_Detail, self, proto_csmsg.SC_BATTLEPASS_Detail, self.SC_BATTLEPASS_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLEPASS_Take, self, proto_csmsg.SC_BATTLEPASS_Take, self.SC_BATTLEPASS_Take)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLEPASS_SyncDiff, self, proto_csmsg.SC_BATTLEPASS_SyncDiff, self.SC_BATTLEPASS_SyncDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLEPASS_Buy, self, proto_csmsg.SC_BATTLEPASS_Buy, self.SC_BATTLEPASS_Buy)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLEPASS_Buy_Exp, self, proto_csmsg.SC_BATTLEPASS_Buy_Exp, self.SC_BATTLEPASS_Buy_Exp)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLEPASS_Changed_Ntf, self, proto_csmsg.SC_BATTLEPASS_Changed_Ntf, self.SC_BATTLEPASS_Changed_Ntf)
end

function BattlePassNetworkCtrl:CS_BATTLEPASS_Detail()
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLEPASS_Detail, proto_csmsg.CS_BATTLEPASS_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartOrAddWait(proto_csmsg_MSG_ID.MSG_CS_BATTLEPASS_Detail, proto_csmsg_MSG_ID.MSG_SC_BATTLEPASS_Detail)
end

function BattlePassNetworkCtrl:SC_BATTLEPASS_Detail(msg)
  if msg.data ~= nil then
    PlayerDataCenter.battlepassData:InitAllBattlePass(msg.data)
  end
end

function BattlePassNetworkCtrl:CS_BATTLEPASS_Take(id, level, takeway)
  self.__sendBattlePassTake.id = id
  self.__sendBattlePassTake.lv = level
  self.__sendBattlePassTake.way = takeway
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLEPASS_Take, proto_csmsg.CS_BATTLEPASS_Take, self.__sendBattlePassTake)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BATTLEPASS_Take, proto_csmsg_MSG_ID.MSG_SC_BATTLEPASS_Take)
end

function BattlePassNetworkCtrl:SC_BATTLEPASS_Take(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "BattlePassNetworkCtrl:SC_BATTLEPASS_Take error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BATTLEPASS_Take)
  else
    local idTable = {}
    local numTable = {}
    for i, v in ipairs(msg.reward.data) do
      table.insert(idTable, v.id)
      table.insert(numTable, v.num)
    end
    if 0 < #idTable then
      do
        local passInfo = PlayerDataCenter.battlepassData:GetBattlePass(self.__sendBattlePassTake.id)
        local passInfoCfg = passInfo:GetPassCfg()
        local havePickImp = false
        if passInfoCfg.purpose_type == BattlePassEnum.PurposeType.Common then
          for _, lv in pairs(ConfigData.game_config.bpImportantLvs) do
            local takenReward = passInfo.taken[lv]
            if lv <= passInfo.level and (takenReward == nil or not takenReward.base) then
              havePickImp = true
            end
          end
        else
          havePickImp = true
        end
        if passInfo ~= nil and passInfo:IsBattleType() and not passInfo:GetBattlePassUnlockSenior() and havePickImp then
          local item_ids, item_nums = passInfo:GetPassLevelReward(1, passInfo.level, false, true, passInfoCfg.purpose_type == BattlePassEnum.PurposeType.Common)
          CommonUtil.DefaultItemsSortList(item_ids, item_nums)
          UIManager:ShowWindowAsync(UIWindowTypeID.BpSpReward, function(window)
            if window == nil then
              return
            end
            local CRData = CommonRewardData.CreateCRDataUseList(idTable, numTable)
            CRData:SetBpSpRewardPreview(item_ids, item_nums):SetCRShowOverBuyFunc(function()
              PlayerClickCollectManager:BtnClickNumCollect(1003)
              if passInfoCfg.purpose_type == BattlePassEnum.PurposeType.Activity then
                local hasBuy = passInfo.unlockSenior
                if not hasBuy then
                  local battlepassCtrl = ControllerManager:GetController(ControllerTypeId.BattlePass, true)
                  battlepassCtrl:BuyBattlePass(passInfoCfg.id, BattlePassEnum.BuyQuality.Senior)
                end
              else
                UIManager:ShowWindowAsync(UIWindowTypeID.EventBattlePassPurchase, function(purchaseWindow)
                  if purchaseWindow == nil then
                    return
                  end
                  purchaseWindow:InitBattlePassPurchaseUI(passInfo)
                end)
              end
            end)
            if passInfoCfg.purpose_type == BattlePassEnum.PurposeType.Activity then
              CRData:SetCRBattlePassTip(1, LanguageUtil.GetLocaleText(passInfoCfg.name))
              CRData:SetCRBattlePassBuy(1)
            else
              CRData:SetCRBattlePassTip(0)
              CRData:SetCRBattlePassBuy(0)
            end
            window:AddAndTryShowReward(CRData)
          end)
        else
          UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
            if window == nil then
              return
            end
            local CRData = CommonRewardData.CreateCRDataUseList(idTable, numTable)
            window:AddAndTryShowReward(CRData)
          end)
        end
      end
    end
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function BattlePassNetworkCtrl:CS_BATTLEPASS_Buy(payId, callback)
  self.__sendBattlePassBuy.payId = payId
  self.__buyCallback = callback
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLEPASS_Buy, proto_csmsg.CS_BATTLEPASS_Buy, self.__sendBattlePassBuy)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BATTLEPASS_Buy, proto_csmsg_MSG_ID.MSG_SC_BATTLEPASS_Buy)
end

function BattlePassNetworkCtrl:SC_BATTLEPASS_Buy(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "BattlePassNetworkCtrl:SC_BATTLEPASS_Buy error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BATTLEPASS_Buy)
  else
    local payCtr = ControllerManager:GetController(ControllerTypeId.Pay)
    payCtr:ReqPay(self.__sendBattlePassBuy.payId, 1, nil, nil, self.__buyCallback)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  self.__buyCallback = nil
end

function BattlePassNetworkCtrl:CS_BATTLEPASS_Buy_Exp(id, num, callback)
  self.__sendBattlePassBuyExp.id = id
  self.__sendBattlePassBuyExp.num = num
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLEPASS_Buy_Exp, proto_csmsg.CS_BATTLEPASS_Buy_Exp, self.__sendBattlePassBuyExp)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BATTLEPASS_Buy_Exp, callback, proto_csmsg_MSG_ID.MSG_SC_BATTLEPASS_Buy_Exp)
end

function BattlePassNetworkCtrl:SC_BATTLEPASS_Buy_Exp(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "BattlePassNetworkCtrl:SC_BATTLEPASS_Buy_Exp error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BATTLEPASS_Buy_Exp)
  else
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function BattlePassNetworkCtrl:SC_BATTLEPASS_Changed_Ntf(msg)
  if msg ~= nil then
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
    MsgCenter:Broadcast(eMsgEventId.BattlePassBuy)
  end
end

function BattlePassNetworkCtrl:SC_BATTLEPASS_SyncDiff(msg)
  PlayerDataCenter.battlepassData:UpdateAllBattlePass(msg.update)
end

function BattlePassNetworkCtrl:Reset()
  self.__buyCallback = nil
end

return BattlePassNetworkCtrl
