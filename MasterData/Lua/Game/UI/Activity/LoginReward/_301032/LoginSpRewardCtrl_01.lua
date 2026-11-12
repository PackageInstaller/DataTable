local LoginSpRewardCtrl_01 = class("LoginSpRewardCtrl_01", BaseCtrl)
LoginSpRewardCtrl_01._mapNodeConfig = {
  goCommon = {
    sNodeName = "---Common---"
  }
}
LoginSpRewardCtrl_01._mapEventConfig = {}

function LoginSpRewardCtrl_01:UnbindCtrl()
  if self.activityCtrl ~= nil then
    self:UnbindCtrlByNode(self.activityCtrl)
    self.activityCtrl = nil
  end
end

function LoginSpRewardCtrl_01:InitActData(actData)
  if self.activityCtrl == nil then
    self.activityCtrl = self:BindCtrlByNode(self._mapNode.goCommon, "Game.UI.Activity.LoginReward.LoginSpRewardCtrl_List")
  end
  self.actData = actData
  self.nActId = actData:GetActId()
  self.activityCtrl:InitActData(actData)
end

function LoginSpRewardCtrl_01:ClearActivity()
  self:UnbindCtrl()
end

function LoginSpRewardCtrl_01:OnDisable()
  self:UnbindCtrl()
end

return LoginSpRewardCtrl_01
