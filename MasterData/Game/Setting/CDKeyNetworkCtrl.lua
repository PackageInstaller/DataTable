local CDKeyNetworkCtrl = class("CDKeyNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function CDKeyNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_CDK_Redeem, self, proto_csmsg.SC_CDK_Redeem, self.MSG_SC_CDK_Redeem)
end

function CDKeyNetworkCtrl:SendCDKRedeem(key)
  local tabMsg = {cdk = key}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_CDK_Redeem, proto_csmsg.CS_CDK_Redeem, tabMsg)
end

function CDKeyNetworkCtrl:MSG_SC_CDK_Redeem(msg)
  if msg.ret == proto_csmsg_ErrorCode.None then
    local heroIdSnapShoot = PlayerDataCenter:GetHeroIdSnapShoot()
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
    self:ShowCDKeyRewards(msg.rewards, heroIdSnapShoot)
    self:Try2ClearErrorCode()
  else
    local isShow2Player = self:Try2ShowErrorCode(msg.ret)
    if not isShow2Player then
      local err = "CDKeyNetworkCtrl:MSG_SC_CDK_Redeem Error Code" .. tostring(msg.ret)
      self:ShowSCErrorMsg(err)
    end
  end
end

function CDKeyNetworkCtrl:ShowCDKeyRewards(rewards, heroIdSnapShoot)
  local rewardIds = {}
  local rewardNums = {}
  for k, v in pairs(rewards) do
    table.insert(rewardIds, k)
    table.insert(rewardNums, v)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    if window == nil then
      return
    end
    local CommonRewardData = require("Game.CommonUI.CommonRewardData")
    local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums):SetCRHeroSnapshoot(heroIdSnapShoot)
    window:AddAndTryShowReward(CRData)
  end)
end

function CDKeyNetworkCtrl:__Try2GetCDKeyPanelUI(errorCode)
  local win = UIManager:GetWindow(UIWindowTypeID.Setting)
  if win == nil or not win.active then
    return
  end
  if win.cDKeyPanelNode == nil then
    return
  end
  return win.cDKeyPanelNode
end

function CDKeyNetworkCtrl:Try2ShowErrorCode(errorCode)
  local cDKeyPanel = self:__Try2GetCDKeyPanelUI()
  if cDKeyPanel == nil then
    return false
  end
  return cDKeyPanel:ShowErrorTips(errorCode)
end

function CDKeyNetworkCtrl:Try2ClearErrorCode(errorCode)
  local cDKeyPanel = self:__Try2GetCDKeyPanelUI()
  if cDKeyPanel == nil then
    return
  end
  cDKeyPanel:RefreshText2Empty()
end

return CDKeyNetworkCtrl
