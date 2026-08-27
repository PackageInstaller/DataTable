local BattlePassController = class("BattlePassController", ControllerBase)
local base = ControllerBase
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local eActivityState = ActivityFrameEnum.eActivityState

function BattlePassController:OnInit()
  self.network = NetworkManager:GetNetwork(NetworkTypeID.BattlePass)
  self.__TaskUpdateCallback = BindCallback(self, self.__BattlePassTaskUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskUpdateCallback)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__TaskUpdateCallback)
  self.__TaskDeleteCallback = BindCallback(self, self.__BattlePassTaskDelete)
  MsgCenter:AddListener(eMsgEventId.TaskDelete, self.__TaskDeleteCallback)
end

function BattlePassController:__IsBattlePassFinished(passId)
  local passInfo = PlayerDataCenter.battlepassData.passInfos[passId]
  if passInfo == nil or not passInfo:IsBattlePassValid() then
    local showingWindow = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    showingWindow:ShowTextBoxWithConfirm(ConfigData:GetTipContent(323), function()
      if UIManager:GetWindow(UIWindowTypeID.EventBattlePass) ~= nil then
        UIUtil.ReturnHome()
      end
    end)
    return true
  end
  return false
end

function BattlePassController:GetBattlePassBuyLevelup(passId)
  local passInfo = PlayerDataCenter.battlepassData.passInfos[passId]
  if passInfo == nil then
    return 0, 0
  end
  local levelup = passInfo:TryGetExpUpgradeLevel(passInfo.passCfg.ultimate_expadd)
  return levelup, passInfo.level
end

function BattlePassController:BuyBattlePass(passId, purchaseType)
  if self:__IsBattlePassFinished(passId) then
    return
  end
  local passCfg = ConfigData.battlepass_type[passId]
  local payId = BattlePassEnum.GetPassPayId(purchaseType, passCfg)
  local levelup = 0
  local oldlevel = 0
  if purchaseType == BattlePassEnum.BuyQuality.Ultimate or purchaseType == BattlePassEnum.BuyQuality.SupplyUltimate then
    levelup, oldlevel = self:GetBattlePassBuyLevelup(passId)
  end
  self.network:CS_BATTLEPASS_Buy(payId, function()
    local window = UIManager:GetWindow(UIWindowTypeID.EventBattlePassPurchase)
    if window ~= nil then
      window:OnBtnCloseClick()
    end
    local v2Win = UIManager:GetWindow(UIWindowTypeID.EventBattlePassV2)
    if v2Win ~= nil then
      v2Win:CompleteBpV2SkinUpdate()
    end
    if 0 < levelup then
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonUpgradeTips, function(window)
        if window == nil then
          return
        end
        window:InitBattlePassLevelUp(oldlevel, oldlevel + levelup)
      end)
    end
  end)
end

function BattlePassController:TakeBattlePassReward(id, level, takeway)
  if self:__IsBattlePassFinished(id) then
    return
  end
  self.network:CS_BATTLEPASS_Take(id, level, takeway)
end

function BattlePassController:BuyBattlePassExp(id, num, callback)
  if self:__IsBattlePassFinished(id) then
    return
  end
  self.network:CS_BATTLEPASS_Buy_Exp(id, num, callback)
end

function BattlePassController:__BattlePassTaskUpdate(taskData)
  PlayerDataCenter.battlepassData:OnBattlePassTaskChange(taskData.id)
end

function BattlePassController:__BattlePassTaskDelete(taskId)
  PlayerDataCenter.battlepassData:OnBattlePassTaskChange(taskId)
end

function BattlePassController:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskUpdateCallback)
  MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self.__TaskUpdateCallback)
  MsgCenter:RemoveListener(eMsgEventId.TaskDelete, self.__TaskDeleteCallback)
  base.OnDelete(self)
end

return BattlePassController
