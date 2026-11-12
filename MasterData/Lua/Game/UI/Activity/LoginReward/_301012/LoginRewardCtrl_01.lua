local LoginRewardCtrl_01 = class("LoginRewardCtrl_01", BaseCtrl)
LoginRewardCtrl_01._mapNodeConfig = {
  goCommon = {
    sNodeName = "---Common---"
  }
}
LoginRewardCtrl_01._mapEventConfig = {}

function LoginRewardCtrl_01:UnbindCtrl()
  if self.activityCtrl ~= nil then
    self:UnbindCtrlByNode(self.activityCtrl)
    self.activityCtrl = nil
  end
end

function LoginRewardCtrl_01:InitActData(actData)
  if self.activityCtrl == nil then
    self.activityCtrl = self:BindCtrlByNode(self._mapNode.goCommon, "Game.UI.Activity.LoginReward.LoginRewardCtrl")
  end
  self.actData = actData
  self.nActId = actData:GetActId()
  self.activityCtrl:InitActData(actData)
  self:RefreshEffect()
end

function LoginRewardCtrl_01:RefreshEffect()
  for k, v in ipairs(self.activityCtrl._mapNode.goRewardItem) do
    if v.mapReward then
      if v.mapReward.DisRare then
        local on = v._mapNode.imgPlusBg.transform:Find("mask/img").gameObject
        local off = v._mapNode.imgPlusBg.transform:Find("mask/img_lock").gameObject
        on:SetActive(v.mapReward.Status ~= 2)
        off:SetActive(v.mapReward.Status == 2)
      else
        local on = v._mapNode.imgBg.transform:Find("mask/img").gameObject
        local off = v._mapNode.imgBg.transform:Find("mask/img_lock").gameObject
        on:SetActive(v.mapReward.Status ~= 2)
        off:SetActive(v.mapReward.Status == 2)
      end
    end
  end
end

function LoginRewardCtrl_01:ClearActivity()
  self:UnbindCtrl()
end

function LoginRewardCtrl_01:OnDisable()
  self:UnbindCtrl()
end

return LoginRewardCtrl_01
