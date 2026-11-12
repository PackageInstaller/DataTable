local ActMailBindCtrl = class("ActMailBindCtrl", BaseCtrl)
local SDKManager = CS.SDKManager.Instance
ActMailBindCtrl._mapNodeConfig = {
  txtDesc = {sComponentName = "TMP_Text"},
  btnGo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Go"
  },
  txtBtnGo = {
    sComponentName = "TMP_Text",
    sLanguageId = "MailBind_Go"
  },
  btnGoLock = {},
  txtBtnGoLock = {
    sComponentName = "TMP_Text",
    sLanguageId = "MailBind_GoLock"
  }
}
ActMailBindCtrl._mapEventConfig = {
  MailBind_RequestUpdate = "OnEvent_RequestUpdate"
}
ActMailBindCtrl._mapRedDotConfig = {}

function ActMailBindCtrl:InitActData(actData)
  self.actData = actData
  self.nActId = self.actData:GetActId()
  local config = ConfigTable.GetData("ActivityMailBindControl", self.nActId)
  if config == nil then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtDesc, config.Desc)
  local itemCfg = ConfigTable.GetData("Item", config.Reward1Tid)
  if itemCfg == nil then
    return
  end
  self:SetPngSprite(self._mapNode.imgItem, itemCfg.Icon)
  NovaAPI.SetTMPText(self._mapNode.txtCount, config.Reward1Qty)
  self:InitRewardStatus()
end

function ActMailBindCtrl:InitRewardStatus()
  local bGettedReward = self.actData:GetRewardData()
  self._mapNode.btnGo.gameObject:SetActive(not bGettedReward)
  self._mapNode.btnGoLock.gameObject:SetActive(bGettedReward)
end

function ActMailBindCtrl:OnBtnClick_Go()
  local bRequestState = self.actData:GetRequestState()
  if bRequestState then
    return
  end
  local bGettedReward = self.actData:GetRewardData()
  if bGettedReward then
    self:InitRewardStatus()
    return
  end
  if not SDKManager:IsSDKInit() then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
    return
  end
  self.actData:RequestReward()
end

function ActMailBindCtrl:OnEvent_RequestUpdate()
  self:InitRewardStatus()
end

return ActMailBindCtrl
